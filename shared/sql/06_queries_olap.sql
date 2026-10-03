-- 06_queries_olap.sql
-- Benchmark docente OLAP - Compras - PostgreSQL 15
-- Ejecutar desde psql para utilizar \timing.

\echo '=== BENCHMARK OLAP DW_COMPRAS ==='
\timing on

ANALYZE dw_compras.dim_tiempo;
ANALYZE dw_compras.dim_proveedor;
ANALYZE dw_compras.dim_producto;
ANALYZE dw_compras.dim_forma_pago;
ANALYZE dw_compras.dim_plazo_entrega;
ANALYZE dw_compras.hecho_compras;

-- CONTROL 0: volumen
SELECT 'dim_tiempo' tabla, COUNT(*) filas FROM dw_compras.dim_tiempo
UNION ALL SELECT 'dim_proveedor', COUNT(*) FROM dw_compras.dim_proveedor
UNION ALL SELECT 'dim_producto', COUNT(*) FROM dw_compras.dim_producto
UNION ALL SELECT 'dim_forma_pago', COUNT(*) FROM dw_compras.dim_forma_pago
UNION ALL SELECT 'dim_plazo_entrega', COUNT(*) FROM dw_compras.dim_plazo_entrega
UNION ALL SELECT 'hecho_compras', COUNT(*) FROM dw_compras.hecho_compras
ORDER BY tabla;

-- CONSULTA 1: gasto total (0 JOIN)
SELECT ROUND(SUM(h.importe_total),2) AS gasto_total
FROM dw_compras.hecho_compras h;

-- CONSULTA 2: gasto por año (1 JOIN)
SELECT dt.anio, ROUND(SUM(h.importe_total),2) AS gasto_total
FROM dw_compras.hecho_compras h
JOIN dw_compras.dim_tiempo dt ON dt.sk_tiempo=h.sk_tiempo
GROUP BY dt.anio ORDER BY dt.anio;

-- CONSULTA 3: gasto por proveedor en 2025 (2 JOIN)
SELECT dp.denominacion AS proveedor,
       ROUND(SUM(h.importe_total),2) AS gasto_total
FROM dw_compras.hecho_compras h
JOIN dw_compras.dim_proveedor dp ON dp.sk_proveedor=h.sk_proveedor
JOIN dw_compras.dim_tiempo dt ON dt.sk_tiempo=h.sk_tiempo
WHERE dt.anio=2025
GROUP BY dp.denominacion
ORDER BY gasto_total DESC;

-- CONSULTA 4: gasto por categoria y año (2 JOIN)
SELECT dt.anio, dp.categoria,
       ROUND(SUM(h.importe_total),2) AS gasto_total
FROM dw_compras.hecho_compras h
JOIN dw_compras.dim_tiempo dt ON dt.sk_tiempo=h.sk_tiempo
JOIN dw_compras.dim_producto dp ON dp.sk_producto=h.sk_producto
GROUP BY dt.anio,dp.categoria
ORDER BY dt.anio,gasto_total DESC;

-- CONSULTA 5: descuento por proveedor (1 JOIN)
SELECT dp.denominacion AS proveedor,
       ROUND(SUM(h.importe_bruto),2) AS importe_bruto,
       ROUND(SUM(h.descuento),2) AS descuento_total,
       ROUND(100.0*SUM(h.descuento)/NULLIF(SUM(h.importe_bruto),0),2)
           AS porcentaje_descuento
FROM dw_compras.hecho_compras h
JOIN dw_compras.dim_proveedor dp ON dp.sk_proveedor=h.sk_proveedor
GROUP BY dp.denominacion
ORDER BY porcentaje_descuento DESC;

-- CONSULTA 6: analisis multidimensional completo (5 JOIN)
-- Equivalente a la consulta OLTP de 7 JOIN.
SELECT dt.anio,
       dpr.denominacion AS proveedor,
       dpr.tipo_proveedor,
       dprod.categoria,
       dprod.subcategoria,
       dfp.descripcion AS forma_pago,
       dpe.descripcion AS plazo_entrega,
       SUM(h.cantidad) AS unidades,
       ROUND(SUM(h.importe_bruto),2) AS importe_bruto,
       ROUND(SUM(h.descuento),2) AS descuento_total,
       ROUND(SUM(h.importe_total),2) AS importe_total
FROM dw_compras.hecho_compras h
JOIN dw_compras.dim_tiempo dt ON dt.sk_tiempo=h.sk_tiempo
JOIN dw_compras.dim_proveedor dpr ON dpr.sk_proveedor=h.sk_proveedor
JOIN dw_compras.dim_producto dprod ON dprod.sk_producto=h.sk_producto
JOIN dw_compras.dim_forma_pago dfp ON dfp.sk_forma_pago=h.sk_forma_pago
JOIN dw_compras.dim_plazo_entrega dpe ON dpe.sk_plazo_entrega=h.sk_plazo_entrega
WHERE dt.anio=2025
GROUP BY dt.anio,dpr.denominacion,dpr.tipo_proveedor,
         dprod.categoria,dprod.subcategoria,
         dfp.descripcion,dpe.descripcion
ORDER BY importe_total DESC;

-- CONSULTA 7: evolucion mensual (1 JOIN)
SELECT dt.anio,dt.mes,dt.nombre_mes,
       ROUND(SUM(h.importe_total),2) AS gasto_total
FROM dw_compras.hecho_compras h
JOIN dw_compras.dim_tiempo dt ON dt.sk_tiempo=h.sk_tiempo
GROUP BY dt.anio,dt.mes,dt.nombre_mes
ORDER BY dt.anio,dt.mes;

-- CONSULTA 8: top 10 productos por gasto (1 JOIN)
SELECT dp.descripcion AS producto,dp.categoria,
       SUM(h.cantidad) AS unidades,
       ROUND(SUM(h.importe_total),2) AS gasto_total
FROM dw_compras.hecho_compras h
JOIN dw_compras.dim_producto dp ON dp.sk_producto=h.sk_producto
GROUP BY dp.descripcion,dp.categoria
ORDER BY gasto_total DESC LIMIT 10;

-- BENCHMARK A: gasto/proveedor 2025
EXPLAIN (ANALYZE, BUFFERS)
SELECT dp.denominacion,SUM(h.importe_total) AS gasto_total
FROM dw_compras.hecho_compras h
JOIN dw_compras.dim_proveedor dp ON dp.sk_proveedor=h.sk_proveedor
JOIN dw_compras.dim_tiempo dt ON dt.sk_tiempo=h.sk_tiempo
WHERE dt.anio=2025
GROUP BY dp.denominacion
ORDER BY gasto_total DESC;

-- BENCHMARK B: consulta multidimensional completa
EXPLAIN (ANALYZE, BUFFERS)
SELECT dpr.denominacion,dpr.tipo_proveedor,
       dprod.categoria,dprod.subcategoria,
       dfp.descripcion AS forma_pago,dpe.descripcion AS plazo_entrega,
       SUM(h.cantidad) AS unidades,
       SUM(h.importe_bruto) AS importe_bruto,
       SUM(h.descuento) AS descuento_total,
       SUM(h.importe_total) AS importe_total
FROM dw_compras.hecho_compras h
JOIN dw_compras.dim_tiempo dt ON dt.sk_tiempo=h.sk_tiempo
JOIN dw_compras.dim_proveedor dpr ON dpr.sk_proveedor=h.sk_proveedor
JOIN dw_compras.dim_producto dprod ON dprod.sk_producto=h.sk_producto
JOIN dw_compras.dim_forma_pago dfp ON dfp.sk_forma_pago=h.sk_forma_pago
JOIN dw_compras.dim_plazo_entrega dpe ON dpe.sk_plazo_entrega=h.sk_plazo_entrega
WHERE dt.anio=2025
GROUP BY dpr.denominacion,dpr.tipo_proveedor,dprod.categoria,
         dprod.subcategoria,dfp.descripcion,dpe.descripcion
ORDER BY importe_total DESC;

-- VALIDACION: los totales OLTP y OLAP deben coincidir
SELECT 'OLTP' AS modelo,COUNT(*) AS lineas,
       ROUND(SUM(fp.cantidad*fp.precio_unitario),2) AS importe_bruto,
       ROUND(SUM(fp.descuento),2) AS descuento,
       ROUND(SUM(fp.cantidad*fp.precio_unitario-fp.descuento),2) AS importe_total
FROM compras.factura_producto fp
UNION ALL
SELECT 'OLAP',COUNT(*),
       ROUND(SUM(h.importe_bruto),2),
       ROUND(SUM(h.descuento),2),
       ROUND(SUM(h.importe_total),2)
FROM dw_compras.hecho_compras h;

\echo '=== FIN BENCHMARK OLAP ==='
\echo 'Comparar con 04_queries_oltp.sql: JOIN, complejidad, Planning Time,'
\echo 'Execution Time, buffers y estrategia del plan.'
\echo 'Con este volumen pequeno los tiempos pueden ser muy similares.'
