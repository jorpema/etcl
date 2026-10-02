-- ============================================================
-- 04_load_olap.sql
-- CÀRREGA DEL DATA MART dw_compras DES DE L'OLTP compras
-- PostgreSQL 15+  ·  Executar amb psql:  \i 04_load_olap.sql
--
-- Ordre: 1) dimensions  2) validació de lookups  3) fet
--        4) reconciliació OLTP = OLAP  5) ANALYZE
-- Script re-executable: les dimensions usen ON CONFLICT i el fet
-- es buida abans de carregar-lo.
-- ============================================================

\timing on
\set ON_ERROR_STOP on

-- ------------------------------------------------------------
-- 1. DIMENSIÓ TEMPS: una fila per dia entre la primera i l'última factura
-- ------------------------------------------------------------
INSERT INTO dw_compras.dim_tiempo
       (fecha, dia, mes, nombre_mes, trimestre, anio, dia_semana, nombre_dia)
SELECT f::date,
       EXTRACT(DAY     FROM f)::smallint,
       EXTRACT(MONTH   FROM f)::smallint,
       (ARRAY['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio',
              'Agosto','Septiembre','Octubre','Noviembre','Diciembre'])
              [EXTRACT(MONTH FROM f)::int],
       EXTRACT(QUARTER FROM f)::smallint,
       EXTRACT(YEAR    FROM f)::smallint,
       EXTRACT(ISODOW  FROM f)::smallint,                 -- 1 = dilluns ... 7 = diumenge
       (ARRAY['Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo'])
              [EXTRACT(ISODOW FROM f)::int]
FROM generate_series((SELECT MIN(fecha_factura) FROM compras.factura_compra),
                     (SELECT MAX(fecha_factura) FROM compras.factura_compra),
                     INTERVAL '1 day') AS f
ON CONFLICT (fecha) DO NOTHING;

-- ------------------------------------------------------------
-- 2. DIMENSIÓ PROVEÏDOR: desnormalitzem tipo_proveedor
-- ------------------------------------------------------------
INSERT INTO dw_compras.dim_proveedor
       (id_proveedor_oltp, codigo, denominacion, tipo_proveedor,
        ciudad, provincia, pais, situacion_fiscal)
SELECT p.id_proveedor, p.codigo, p.denominacion, tp.descripcion,
       p.ciudad, p.provincia, p.pais, p.situacion_fiscal
FROM compras.proveedor p
LEFT JOIN compras.tipo_proveedor tp ON tp.id_tipo_proveedor = p.id_tipo_proveedor
ON CONFLICT (id_proveedor_oltp) DO NOTHING;

-- ------------------------------------------------------------
-- 3. DIMENSIÓ PRODUCTE
-- ------------------------------------------------------------
INSERT INTO dw_compras.dim_producto
       (id_producto_oltp, codigo, descripcion, categoria, subcategoria, unidad)
SELECT id_producto, codigo, descripcion, categoria, subcategoria, unidad
FROM compras.producto
ON CONFLICT (id_producto_oltp) DO NOTHING;

-- ------------------------------------------------------------
-- 4. DIMENSIONS FORMA DE PAGAMENT I TERMINI D'ENTREGA
-- ------------------------------------------------------------
INSERT INTO dw_compras.dim_forma_pago (id_forma_pago_oltp, codigo, descripcion)
SELECT id_forma_pago, codigo, descripcion
FROM compras.forma_de_pago
ON CONFLICT (id_forma_pago_oltp) DO NOTHING;

INSERT INTO dw_compras.dim_plazo_entrega (id_plazo_entrega_oltp, codigo, descripcion, dias)
SELECT id_plazo_entrega, codigo, descripcion, dias
FROM compras.plazo_entrega
ON CONFLICT (id_plazo_entrega_oltp) DO NOTHING;

-- ------------------------------------------------------------
-- 5. VALIDACIÓ DE LOOKUPS (resultat esperat: 0)
--    Si no és 0, NO es carrega el fet: falten membres de dimensió.
-- ------------------------------------------------------------
SELECT COUNT(*) AS registres_problematics
FROM compras.factura_producto fp
JOIN compras.factura_compra fc        ON fc.id_factura = fp.id_factura
LEFT JOIN compras.pedido ped          ON ped.id_pedido = fc.id_pedido
LEFT JOIN dw_compras.dim_tiempo dt    ON dt.fecha = fc.fecha_factura
LEFT JOIN dw_compras.dim_proveedor dpr ON dpr.id_proveedor_oltp = fc.id_proveedor
LEFT JOIN dw_compras.dim_producto dprod ON dprod.id_producto_oltp = fp.id_producto
LEFT JOIN dw_compras.dim_forma_pago dfp ON dfp.id_forma_pago_oltp = ped.id_forma_pago
LEFT JOIN dw_compras.dim_plazo_entrega dpe ON dpe.id_plazo_entrega_oltp = ped.id_plazo_entrega
WHERE dt.sk_tiempo IS NULL OR dpr.sk_proveedor IS NULL OR dprod.sk_producto IS NULL
   OR dfp.sk_forma_pago IS NULL OR dpe.sk_plazo_entrega IS NULL;

-- ------------------------------------------------------------
-- 6. FET: substituïm les PK de l'OLTP per les SK del DW
-- ------------------------------------------------------------
TRUNCATE TABLE dw_compras.hecho_compras RESTART IDENTITY;

INSERT INTO dw_compras.hecho_compras
       (sk_tiempo, sk_proveedor, sk_producto, sk_forma_pago, sk_plazo_entrega,
        numero_factura, cantidad, precio_unitario, descuento,
        importe_bruto, importe_total, alicuota_iva, alicuota_ib)
SELECT dt.sk_tiempo, dpr.sk_proveedor, dprod.sk_producto, dfp.sk_forma_pago, dpe.sk_plazo_entrega,
       fc.numero_factura, fp.cantidad, fp.precio_unitario, fp.descuento,
       ROUND(fp.cantidad * fp.precio_unitario, 2),
       ROUND(fp.cantidad * fp.precio_unitario - fp.descuento, 2),
       fp.alicuota_iva, fp.alicuota_ib
FROM compras.factura_producto fp
JOIN compras.factura_compra fc          ON fc.id_factura = fp.id_factura
LEFT JOIN compras.pedido ped            ON ped.id_pedido = fc.id_pedido
JOIN dw_compras.dim_tiempo dt           ON dt.fecha = fc.fecha_factura
JOIN dw_compras.dim_proveedor dpr       ON dpr.id_proveedor_oltp = fc.id_proveedor
JOIN dw_compras.dim_producto dprod      ON dprod.id_producto_oltp = fp.id_producto
LEFT JOIN dw_compras.dim_forma_pago dfp ON dfp.id_forma_pago_oltp = ped.id_forma_pago
LEFT JOIN dw_compras.dim_plazo_entrega dpe ON dpe.id_plazo_entrega_oltp = ped.id_plazo_entrega;

-- ------------------------------------------------------------
-- 7. RECONCILIACIÓ: OLTP i OLAP han de tindre les mateixes xifres
-- ------------------------------------------------------------
SELECT 'OLTP' AS model, COUNT(*) AS linies,
       ROUND(SUM(cantidad * precio_unitario), 2)            AS import_brut,
       ROUND(SUM(descuento), 2)                             AS descompte,
       ROUND(SUM(cantidad * precio_unitario - descuento), 2) AS import_total
FROM compras.factura_producto
UNION ALL
SELECT 'OLAP', COUNT(*), ROUND(SUM(importe_bruto), 2),
       ROUND(SUM(descuento), 2), ROUND(SUM(importe_total), 2)
FROM dw_compras.hecho_compras;

SELECT dt.anio, COUNT(*) AS linies, SUM(h.importe_total) AS total
FROM dw_compras.hecho_compras h
JOIN dw_compras.dim_tiempo dt ON dt.sk_tiempo = h.sk_tiempo
GROUP BY dt.anio ORDER BY dt.anio;

-- ------------------------------------------------------------
-- 8. ESTADÍSTIQUES per a l'optimitzador
-- ------------------------------------------------------------
ANALYZE dw_compras.dim_tiempo;
ANALYZE dw_compras.dim_proveedor;
ANALYZE dw_compras.dim_producto;
ANALYZE dw_compras.dim_forma_pago;
ANALYZE dw_compras.dim_plazo_entrega;
ANALYZE dw_compras.hecho_compras;
