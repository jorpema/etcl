-- =====================================================================
-- 07_scale_100k.sql
-- Escalado del modelo OLTP de Compras hasta ~100.000 lineas de factura
-- PostgreSQL 15
--
-- OBJETIVO
--   Aumentar SOLO el volumen transaccional del OLTP manteniendo:
--     - integridad referencial
--     - proveedores/productos maestros existentes
--     - distribucion temporal 2024-2026
--     - pedidos -> facturas -> lineas coherentes
--
-- IMPORTANTE
--   1. Ejecutar DESPUES del dataset inicial (~1.260 lineas).
--   2. Este script NO carga dw_compras.
--   3. Tras ejecutarlo, recargar el OLAP desde el OLTP y repetir benchmark.
--   4. El script es incremental: calcula cuantas lineas faltan aproximadamente.
--
-- Suposicion del modelo usado en la practica:
--   pedido(id_pedido, numero_pedido, fecha_pedido, id_proveedor,
--          id_forma_pago, id_plazo_entrega)
--   factura_compra(id_factura, numero_factura, fecha_factura,
--                  id_proveedor, id_pedido)
--   factura_producto(id_factura, id_producto, cantidad, precio_unitario,
--                    descuento, alicuota_iva, alicuota_ib)
-- =====================================================================

\echo ''
\echo '============================================================'
\echo ' ESCALADO OLTP A ~100.000 LINEAS DE FACTURA'
\echo '============================================================'
\timing on

-- ---------------------------------------------------------------------
-- 0. ESTADO INICIAL
-- ---------------------------------------------------------------------
\echo ''
\echo '--- Estado inicial ---'

SELECT
    (SELECT COUNT(*) FROM compras.pedido) AS pedidos,
    (SELECT COUNT(*) FROM compras.factura_compra) AS facturas,
    (SELECT COUNT(*) FROM compras.factura_producto) AS lineas_factura;

-- ---------------------------------------------------------------------
-- 1. PARAMETROS DE ESCALADO
--
-- Generaremos 5 lineas por nueva factura.
-- Calculamos el numero de facturas necesarias para acercarnos a 100.000.
-- Cada nueva factura tendra su propio pedido.
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS tmp_scale_config;

CREATE TEMP TABLE tmp_scale_config AS
SELECT
    COUNT(*)::bigint AS lineas_actuales,
    GREATEST(0, 100000 - COUNT(*))::bigint AS lineas_faltantes,
    CEIL(
        GREATEST(0, 100000 - COUNT(*))::numeric / 5
    )::bigint AS nuevas_facturas
FROM compras.factura_producto;

\echo ''
\echo '--- Plan de escalado ---'
SELECT *,
       nuevas_facturas * 5 AS nuevas_lineas_previstas,
       lineas_actuales + nuevas_facturas * 5 AS total_previsto
FROM tmp_scale_config;

-- Guardamos los máximos actuales para construir claves/numeraciones nuevas.
DROP TABLE IF EXISTS tmp_scale_base;

CREATE TEMP TABLE tmp_scale_base AS
SELECT
    COALESCE((SELECT MAX(id_pedido) FROM compras.pedido),0) AS max_pedido,
    COALESCE((SELECT MAX(id_factura) FROM compras.factura_compra),0) AS max_factura;

-- ---------------------------------------------------------------------
-- 2. GENERAR NUEVOS PEDIDOS
--
-- Distribucion:
--   - fechas pseudoaleatorias deterministas entre 2024-01-01 y 2026-12-15
--   - proveedores 1..20
--   - formas de pago 1..5
--   - plazos 1..5
--
-- Se utiliza un prefijo SCALE para distinguir estos registros.
-- ---------------------------------------------------------------------
\echo ''
\echo '--- Generando pedidos ---'

INSERT INTO compras.pedido
(
    numero_pedido,
    fecha_pedido,
    id_proveedor,
    id_forma_pago,
    id_plazo_entrega
)
SELECT
    'SCALE-PED-' || LPAD((b.max_pedido + g)::text, 8, '0'),

    DATE '2024-01-01'
      + (((g * 17) % 1079)::integer),

    CASE
        -- mantenemos algo de concentracion en proveedores concretos
        WHEN g % 10 IN (0,1) THEN 1
        WHEN g % 10 = 2 THEN 2
        WHEN g % 10 = 3 THEN 6
        ELSE ((g * 7) % 20) + 1
    END,

    ((g * 3) % 5) + 1,
    ((g * 7) % 5) + 1

FROM tmp_scale_config c
CROSS JOIN tmp_scale_base b
CROSS JOIN LATERAL generate_series(1, c.nuevas_facturas) AS g;

-- ---------------------------------------------------------------------
-- 3. GENERAR UNA FACTURA POR CADA NUEVO PEDIDO
--
-- fecha_factura = fecha_pedido + 2..16 dias
-- ---------------------------------------------------------------------
\echo ''
\echo '--- Generando facturas ---'

INSERT INTO compras.factura_compra
(
    numero_factura,
    fecha_factura,
    id_proveedor,
    id_pedido
)
SELECT
    'SCALE-FAC-' || LPAD(p.id_pedido::text, 8, '0'),
    p.fecha_pedido + ((p.id_pedido % 15) + 2),
    p.id_proveedor,
    p.id_pedido
FROM compras.pedido p
WHERE p.numero_pedido LIKE 'SCALE-PED-%'
  AND NOT EXISTS (
      SELECT 1
      FROM compras.factura_compra fc
      WHERE fc.id_pedido = p.id_pedido
  );

-- ---------------------------------------------------------------------
-- 4. GENERAR 5 LINEAS POR FACTURA
--
-- Los precios reproducen patrones del dataset inicial:
--   servidores > ordenadores > redes > oficina
-- y una ligera evolucion temporal de precios.
--
-- Se evita repetir el mismo producto dentro de una factura mediante
-- una formula que genera cinco ids diferentes.
-- ---------------------------------------------------------------------
\echo ''
\echo '--- Generando lineas de factura ---'

INSERT INTO compras.factura_producto
(
    id_factura,
    id_producto,
    cantidad,
    precio_unitario,
    descuento,
    alicuota_iva,
    alicuota_ib
)
SELECT
    fc.id_factura,

    ((fc.id_factura * 7 + linea * 11) % 50) + 1 AS id_producto,

    CASE
        WHEN ((fc.id_factura + linea) % 10) < 7
            THEN ((fc.id_factura + linea) % 8) + 1
        ELSE ((fc.id_factura + linea) % 30) + 10
    END AS cantidad,

    ROUND(
        (
            CASE
                WHEN ((fc.id_factura * 7 + linea * 11) % 50) + 1
                     BETWEEN 16 AND 18
                    THEN 2500 + (((fc.id_factura + linea) % 10) * 350)

                WHEN ((fc.id_factura * 7 + linea * 11) % 50) + 1
                     BETWEEN 1 AND 5
                    THEN 600 + (((fc.id_factura + linea) % 8) * 100)

                WHEN ((fc.id_factura * 7 + linea * 11) % 50) + 1
                     BETWEEN 9 AND 15
                    THEN 200 + (((fc.id_factura + linea) % 10) * 90)

                WHEN ((fc.id_factura * 7 + linea * 11) % 50) + 1
                     BETWEEN 36 AND 40
                    THEN 5 + (((fc.id_factura + linea) % 8) * 3)

                ELSE 50 + (((fc.id_factura + linea) % 20) * 25)
            END

            * CASE
                WHEN EXTRACT(YEAR FROM fc.fecha_factura) = 2024 THEN 1.00
                WHEN EXTRACT(YEAR FROM fc.fecha_factura) = 2025 THEN 1.05
                ELSE 1.15
              END

            -- pequena variacion de precio real
            * (0.98 + ((fc.id_factura + linea) % 9) / 100.0)
        )::numeric,
        2
    ) AS precio_unitario,

    -- Descuento monetario coherente con proveedor.
    ROUND(
        (
            CASE
                WHEN fc.id_proveedor IN (3,8,16) THEN 0.10
                WHEN fc.id_proveedor IN (1,2,6) THEN 0.05
                WHEN fc.id_factura % 4 = 0 THEN 0.03
                ELSE 0
            END
            *
            CASE
                WHEN ((fc.id_factura + linea) % 10) < 7
                    THEN ((fc.id_factura + linea) % 8) + 1
                ELSE ((fc.id_factura + linea) % 30) + 10
            END
            *
            (
                CASE
                    WHEN ((fc.id_factura * 7 + linea * 11) % 50) + 1
                         BETWEEN 16 AND 18
                        THEN 2500 + (((fc.id_factura + linea) % 10) * 350)
                    WHEN ((fc.id_factura * 7 + linea * 11) % 50) + 1
                         BETWEEN 1 AND 5
                        THEN 600 + (((fc.id_factura + linea) % 8) * 100)
                    WHEN ((fc.id_factura * 7 + linea * 11) % 50) + 1
                         BETWEEN 9 AND 15
                        THEN 200 + (((fc.id_factura + linea) % 10) * 90)
                    WHEN ((fc.id_factura * 7 + linea * 11) % 50) + 1
                         BETWEEN 36 AND 40
                        THEN 5 + (((fc.id_factura + linea) % 8) * 3)
                    ELSE 50 + (((fc.id_factura + linea) % 20) * 25)
                END
                *
                CASE
                    WHEN EXTRACT(YEAR FROM fc.fecha_factura) = 2024 THEN 1.00
                    WHEN EXTRACT(YEAR FROM fc.fecha_factura) = 2025 THEN 1.05
                    ELSE 1.15
                END
                *
                (0.98 + ((fc.id_factura + linea) % 9) / 100.0)
            )
        )::numeric,
        2
    ) AS descuento,

    21.00,
    0.00

FROM compras.factura_compra fc
CROSS JOIN generate_series(1,5) AS linea
WHERE fc.numero_factura LIKE 'SCALE-FAC-%'
  AND NOT EXISTS (
      SELECT 1
      FROM compras.factura_producto fp
      WHERE fp.id_factura = fc.id_factura
  );

-- ---------------------------------------------------------------------
-- 5. ACTUALIZAR ESTADISTICAS
-- ---------------------------------------------------------------------
\echo ''
\echo '--- ANALYZE ---'

ANALYZE compras.pedido;
ANALYZE compras.factura_compra;
ANALYZE compras.factura_producto;

-- ---------------------------------------------------------------------
-- 6. VALIDACIONES
-- ---------------------------------------------------------------------
\echo ''
\echo '--- Volumen final ---'

SELECT
    (SELECT COUNT(*) FROM compras.pedido) AS pedidos,
    (SELECT COUNT(*) FROM compras.factura_compra) AS facturas,
    (SELECT COUNT(*) FROM compras.factura_producto) AS lineas_factura;

\echo ''
\echo '--- Distribucion de lineas por año ---'

SELECT
    EXTRACT(YEAR FROM fc.fecha_factura)::integer AS anio,
    COUNT(*) AS lineas,
    ROUND(
        SUM(fp.cantidad * fp.precio_unitario - fp.descuento),
        2
    ) AS importe_total
FROM compras.factura_producto fp
JOIN compras.factura_compra fc
    ON fc.id_factura = fp.id_factura
GROUP BY 1
ORDER BY 1;

\echo ''
\echo '--- Integridad: lineas sin factura (debe ser 0) ---'

SELECT COUNT(*) AS lineas_huerfanas
FROM compras.factura_producto fp
LEFT JOIN compras.factura_compra fc
    ON fc.id_factura = fp.id_factura
WHERE fc.id_factura IS NULL;

\echo ''
\echo '--- Integridad: facturas SCALE sin 5 lineas (debe ser 0) ---'

SELECT COUNT(*) AS facturas_incompletas
FROM (
    SELECT fc.id_factura
    FROM compras.factura_compra fc
    LEFT JOIN compras.factura_producto fp
        ON fp.id_factura = fc.id_factura
    WHERE fc.numero_factura LIKE 'SCALE-FAC-%'
    GROUP BY fc.id_factura
    HAVING COUNT(fp.id_producto) <> 5
) x;

\echo ''
\echo '============================================================'
\echo ' ESCALADO FINALIZADO'
\echo ' Siguiente paso: recargar dw_compras desde el OLTP.'
\echo ' Despues repetir EXACTAMENTE los benchmarks OLTP y OLAP.'
\echo '============================================================'
