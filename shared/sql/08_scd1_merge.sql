-- ============================================================
-- 08_scd1_merge.sql
-- SCD TIPUS 1 AMB MERGE (PostgreSQL 15+)
-- Problema: ON CONFLICT DO NOTHING NO actualitza els atributs que
-- canvien a l'OLTP. Una SCD de tipus 1 SOBREESCRIU el valor antic.
-- ============================================================

\set ON_ERROR_STOP on

-- 1. Simulem un canvi a l'origen (OLTP): un proveïdor es trasllada
UPDATE compras.proveedor
SET ciudad = 'Xàtiva', provincia = 'Valencia'
WHERE id_proveedor = 1;

-- 2. Comprovem que el DW encara té el valor antic
SELECT id_proveedor_oltp, ciudad, provincia
FROM dw_compras.dim_proveedor WHERE id_proveedor_oltp = 1;

-- 3. MERGE: insereix els nous i actualitza els que han canviat
MERGE INTO dw_compras.dim_proveedor AS d
USING (
    SELECT p.id_proveedor, p.codigo, p.denominacion, tp.descripcion AS tipo_proveedor,
           p.ciudad, p.provincia, p.pais, p.situacion_fiscal
    FROM compras.proveedor p
    LEFT JOIN compras.tipo_proveedor tp ON tp.id_tipo_proveedor = p.id_tipo_proveedor
) AS o
ON d.id_proveedor_oltp = o.id_proveedor
WHEN MATCHED AND (d.ciudad, d.provincia, d.denominacion, d.situacion_fiscal, d.tipo_proveedor)
             IS DISTINCT FROM
                 (o.ciudad, o.provincia, o.denominacion, o.situacion_fiscal, o.tipo_proveedor)
THEN UPDATE SET codigo = o.codigo, denominacion = o.denominacion,
                tipo_proveedor = o.tipo_proveedor, ciudad = o.ciudad,
                provincia = o.provincia, pais = o.pais,
                situacion_fiscal = o.situacion_fiscal
WHEN NOT MATCHED
THEN INSERT (id_proveedor_oltp, codigo, denominacion, tipo_proveedor,
             ciudad, provincia, pais, situacion_fiscal)
     VALUES (o.id_proveedor, o.codigo, o.denominacion, o.tipo_proveedor,
             o.ciudad, o.provincia, o.pais, o.situacion_fiscal);

-- 4. Ara el DW reflecteix el valor nou (i hem perdut l'antic: això és SCD1)
SELECT id_proveedor_oltp, ciudad, provincia
FROM dw_compras.dim_proveedor WHERE id_proveedor_oltp = 1;

-- 5. DELETE en un DW: normalment NO s'esborren dimensions referenciades pel fet.
--    Prova-ho i interpreta l'error de clau forana:
-- DELETE FROM dw_compras.dim_proveedor WHERE id_proveedor_oltp = 1;
