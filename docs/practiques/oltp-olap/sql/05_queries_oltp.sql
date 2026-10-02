-- 05_queries_oltp.sql
-- Benchmark docente OLTP - Compras - PostgreSQL 15
-- Ejecutar desde psql para utilizar \timing.

\echo '=== BENCHMARK OLTP COMPRAS ==='
\timing on

ANALYZE compras.tipo_proveedor;
ANALYZE compras.proveedor;
ANALYZE compras.producto;
ANALYZE compras.forma_de_pago;
ANALYZE compras.plazo_entrega;
ANALYZE compras.pedido;
ANALYZE compras.producto_pedido;
ANALYZE compras.factura_compra;
ANALYZE compras.factura_producto;

-- CONTROL 0: volumen
SELECT 'proveedores' tabla, COUNT(*) filas FROM compras.proveedor
UNION ALL SELECT 'productos', COUNT(*) FROM compras.producto
UNION ALL SELECT 'pedidos', COUNT(*) FROM compras.pedido
UNION ALL SELECT 'lineas_pedido', COUNT(*) FROM compras.producto_pedido
UNION ALL SELECT 'facturas', COUNT(*) FROM compras.factura_compra
UNION ALL SELECT 'lineas_factura', COUNT(*) FROM compras.factura_producto
ORDER BY tabla;

-- CONSULTA 1: gasto total (0 JOIN)
SELECT ROUND(SUM(fp.cantidad * fp.precio_unitario - fp.descuento),2) AS gasto_total
FROM compras.factura_producto fp;

-- CONSULTA 2: gasto por año (1 JOIN)
SELECT EXTRACT(YEAR FROM fc.fecha_factura)::integer AS anio,
       ROUND(SUM(fp.cantidad * fp.precio_unitario - fp.descuento),2) AS gasto_total
FROM compras.factura_producto fp
JOIN compras.factura_compra fc ON fc.id_factura=fp.id_factura
GROUP BY EXTRACT(YEAR FROM fc.fecha_factura)
ORDER BY anio;

-- CONSULTA 3: gasto por proveedor en 2025 (2 JOIN)
SELECT p.denominacion AS proveedor,
       ROUND(SUM(fp.cantidad * fp.precio_unitario - fp.descuento),2) AS gasto_total
FROM compras.factura_producto fp
JOIN compras.factura_compra fc ON fc.id_factura=fp.id_factura
JOIN compras.proveedor p ON p.id_proveedor=fc.id_proveedor
WHERE fc.fecha_factura >= DATE '2025-01-01'
  AND fc.fecha_factura < DATE '2026-01-01'
GROUP BY p.denominacion
ORDER BY gasto_total DESC;

-- CONSULTA 4: gasto por categoria y año (2 JOIN)
SELECT EXTRACT(YEAR FROM fc.fecha_factura)::integer AS anio,
       p.categoria,
       ROUND(SUM(fp.cantidad * fp.precio_unitario - fp.descuento),2) AS gasto_total
FROM compras.factura_producto fp
JOIN compras.factura_compra fc ON fc.id_factura=fp.id_factura
JOIN compras.producto p ON p.id_producto=fp.id_producto
GROUP BY EXTRACT(YEAR FROM fc.fecha_factura), p.categoria
ORDER BY anio, gasto_total DESC;

-- CONSULTA 5: descuento por proveedor (2 JOIN)
SELECT p.denominacion AS proveedor,
       ROUND(SUM(fp.cantidad * fp.precio_unitario),2) AS importe_bruto,
       ROUND(SUM(fp.descuento),2) AS descuento_total,
       ROUND(100.0*SUM(fp.descuento)/
             NULLIF(SUM(fp.cantidad*fp.precio_unitario),0),2) AS porcentaje_descuento
FROM compras.factura_producto fp
JOIN compras.factura_compra fc ON fc.id_factura=fp.id_factura
JOIN compras.proveedor p ON p.id_proveedor=fc.id_proveedor
GROUP BY p.denominacion
ORDER BY porcentaje_descuento DESC;

-- CONSULTA 6: analisis multidimensional completo (7 JOIN)
SELECT EXTRACT(YEAR FROM fc.fecha_factura)::integer AS anio,
       pr.denominacion AS proveedor,
       tp.descripcion AS tipo_proveedor,
       prod.categoria,
       prod.subcategoria,
       fdp.descripcion AS forma_pago,
       pe.descripcion AS plazo_entrega,
       SUM(fp.cantidad) AS unidades,
       ROUND(SUM(fp.cantidad*fp.precio_unitario),2) AS importe_bruto,
       ROUND(SUM(fp.descuento),2) AS descuento_total,
       ROUND(SUM(fp.cantidad*fp.precio_unitario-fp.descuento),2) AS importe_total
FROM compras.factura_producto fp
JOIN compras.factura_compra fc ON fc.id_factura=fp.id_factura
JOIN compras.proveedor pr ON pr.id_proveedor=fc.id_proveedor
JOIN compras.tipo_proveedor tp ON tp.id_tipo_proveedor=pr.id_tipo_proveedor
JOIN compras.producto prod ON prod.id_producto=fp.id_producto
JOIN compras.pedido ped ON ped.id_pedido=fc.id_pedido
JOIN compras.forma_de_pago fdp ON fdp.id_forma_pago=ped.id_forma_pago
JOIN compras.plazo_entrega pe ON pe.id_plazo_entrega=ped.id_plazo_entrega
WHERE fc.fecha_factura >= DATE '2025-01-01'
  AND fc.fecha_factura < DATE '2026-01-01'
GROUP BY EXTRACT(YEAR FROM fc.fecha_factura), pr.denominacion, tp.descripcion,
         prod.categoria, prod.subcategoria, fdp.descripcion, pe.descripcion
ORDER BY importe_total DESC;

-- CONSULTA 7: evolucion mensual (1 JOIN)
SELECT EXTRACT(YEAR FROM fc.fecha_factura)::integer AS anio,
       EXTRACT(MONTH FROM fc.fecha_factura)::integer AS mes,
       ROUND(SUM(fp.cantidad*fp.precio_unitario-fp.descuento),2) AS gasto_total
FROM compras.factura_producto fp
JOIN compras.factura_compra fc ON fc.id_factura=fp.id_factura
GROUP BY EXTRACT(YEAR FROM fc.fecha_factura), EXTRACT(MONTH FROM fc.fecha_factura)
ORDER BY anio, mes;

-- CONSULTA 8: top 10 productos por gasto (1 JOIN)
SELECT p.descripcion AS producto, p.categoria,
       SUM(fp.cantidad) AS unidades,
       ROUND(SUM(fp.cantidad*fp.precio_unitario-fp.descuento),2) AS gasto_total
FROM compras.factura_producto fp
JOIN compras.producto p ON p.id_producto=fp.id_producto
GROUP BY p.descripcion,p.categoria
ORDER BY gasto_total DESC
LIMIT 10;

-- BENCHMARK A: EXPLAIN ANALYZE gasto/proveedor 2025
EXPLAIN (ANALYZE, BUFFERS)
SELECT p.denominacion,
       SUM(fp.cantidad*fp.precio_unitario-fp.descuento) AS gasto_total
FROM compras.factura_producto fp
JOIN compras.factura_compra fc ON fc.id_factura=fp.id_factura
JOIN compras.proveedor p ON p.id_proveedor=fc.id_proveedor
WHERE fc.fecha_factura >= DATE '2025-01-01'
  AND fc.fecha_factura < DATE '2026-01-01'
GROUP BY p.denominacion
ORDER BY gasto_total DESC;

-- BENCHMARK B: EXPLAIN ANALYZE consulta multidimensional completa
EXPLAIN (ANALYZE, BUFFERS)
SELECT pr.denominacion, tp.descripcion AS tipo_proveedor,
       prod.categoria, prod.subcategoria,
       fdp.descripcion AS forma_pago, pe.descripcion AS plazo_entrega,
       SUM(fp.cantidad) AS unidades,
       SUM(fp.cantidad*fp.precio_unitario) AS importe_bruto,
       SUM(fp.descuento) AS descuento_total,
       SUM(fp.cantidad*fp.precio_unitario-fp.descuento) AS importe_total
FROM compras.factura_producto fp
JOIN compras.factura_compra fc ON fc.id_factura=fp.id_factura
JOIN compras.proveedor pr ON pr.id_proveedor=fc.id_proveedor
JOIN compras.tipo_proveedor tp ON tp.id_tipo_proveedor=pr.id_tipo_proveedor
JOIN compras.producto prod ON prod.id_producto=fp.id_producto
JOIN compras.pedido ped ON ped.id_pedido=fc.id_pedido
JOIN compras.forma_de_pago fdp ON fdp.id_forma_pago=ped.id_forma_pago
JOIN compras.plazo_entrega pe ON pe.id_plazo_entrega=ped.id_plazo_entrega
WHERE fc.fecha_factura >= DATE '2025-01-01'
  AND fc.fecha_factura < DATE '2026-01-01'
GROUP BY pr.denominacion,tp.descripcion,prod.categoria,prod.subcategoria,
         fdp.descripcion,pe.descripcion
ORDER BY importe_total DESC;

\echo '=== FIN BENCHMARK OLTP ==='
\echo 'Registrar: JOIN, Planning Time, Execution Time y plan de ejecucion.'
\echo 'Con pocos datos, el objetivo principal es comparar complejidad;'
\echo 'el benchmark de rendimiento sera mas representativo al escalar el volumen.'
