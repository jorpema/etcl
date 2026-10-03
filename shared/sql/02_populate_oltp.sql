-- ============================================================
-- 02_populate_oltp.sql
-- POBLACIÓN DEL MODELO OLTP DE COMPRAS
-- PostgreSQL 15
--
-- Objetivo:
-- Crear un conjunto de datos suficientemente amplio para:
--   1. Analizar directamente el OLTP
--   2. Transformarlo posteriormente a OLAP
--   3. Comparar consultas OLTP vs OLAP
--   4. Construir dashboards en Power BI
--
-- Periodo: 2024 - 2026
-- ============================================================

BEGIN;

SET search_path TO compras, public;

-- ============================================================
-- 0. LIMPIEZA
-- Permite volver a ejecutar el script.
-- ============================================================

TRUNCATE TABLE
    compras.factura_producto,
    compras.factura_compra,
    compras.producto_pedido,
    compras.pedido,
    compras.producto,
    compras.proveedor,
    compras.tipo_proveedor,
    compras.forma_de_pago,
    compras.plazo_entrega
RESTART IDENTITY CASCADE;


-- ============================================================
-- 1. TIPOS DE PROVEEDOR
-- ============================================================

INSERT INTO compras.tipo_proveedor (codigo, descripcion)
VALUES
    ('FAB', 'Fabricante'),
    ('DIS', 'Distribuidor'),
    ('MAY', 'Mayorista'),
    ('SER', 'Servicios'),
    ('IMP', 'Importador');


-- ============================================================
-- 2. FORMAS DE PAGO
-- ============================================================

INSERT INTO compras.forma_de_pago (codigo, descripcion)
VALUES
    ('TRANS', 'Transferencia bancaria'),
    ('CONT',  'Contado'),
    ('30D',   'Pago a 30 días'),
    ('60D',   'Pago a 60 días'),
    ('90D',   'Pago a 90 días');


-- ============================================================
-- 3. PLAZOS DE ENTREGA
-- ============================================================

INSERT INTO compras.plazo_entrega (codigo, descripcion, dias)
VALUES
    ('INM', 'Entrega inmediata', 0),
    ('24H', 'Entrega en 24 horas', 1),
    ('3D',  'Entrega en 3 días', 3),
    ('7D',  'Entrega en una semana', 7),
    ('15D', 'Entrega en 15 días', 15);


-- ============================================================
-- 4. PROVEEDORES
-- 20 proveedores
-- ============================================================

INSERT INTO compras.proveedor
(
    codigo,
    denominacion,
    cif,
    domicilio,
    ciudad,
    provincia,
    pais,
    situacion_fiscal,
    id_tipo_proveedor
)
VALUES
('PRV001','TechNova Distribuciones','B46000001','Av. Tecnología 10','Valencia','Valencia','España','General',2),
('PRV002','Iberia Hardware','B46000002','C/ Colón 22','Valencia','Valencia','España','General',1),
('PRV003','Mediterránea Informática','B46000003','Av. Alicante 35','Gandia','Valencia','España','General',2),
('PRV004','Levante Office','B46000004','C/ Mayor 18','Sagunto','Valencia','España','General',3),
('PRV005','Cloud Systems España','B46000005','Av. Europa 7','Valencia','Valencia','España','General',4),

('PRV006','Redes Profesionales SL','B46000006','C/ Industria 15','Paterna','Valencia','España','General',1),
('PRV007','Global Components','B46000007','C/ Puerto 44','Valencia','Valencia','España','General',5),
('PRV008','DataStorage Iberia','B46000008','Av. Innovación 23','Alicante','Alicante','España','General',2),
('PRV009','Oficina Total','B46000009','C/ Comercio 8','Xàtiva','Valencia','España','General',3),
('PRV010','SecureNet Solutions','B46000010','Av. Seguridad 5','Valencia','Valencia','España','General',4),

('PRV011','Digital Market Pro','B46000011','C/ Central 19','Castellón','Castellón','España','General',3),
('PRV012','Electrónica Levante','B46000012','Av. Mediterráneo 12','Valencia','Valencia','España','General',1),
('PRV013','Infraestructura IT','B46000013','C/ Servidores 3','Paterna','Valencia','España','General',2),
('PRV014','Suministros Escolares','B46000014','C/ Educación 17','Alzira','Valencia','España','General',3),
('PRV015','Network World','B46000015','Av. Redes 31','Valencia','Valencia','España','General',5),

('PRV016','ByteStore','B46000016','C/ Informática 6','Torrent','Valencia','España','General',2),
('PRV017','ProSystems Europe','B46000017','Av. Europa 45','Madrid','Madrid','España','General',5),
('PRV018','Componentes Express','B46000018','C/ Logística 11','Valencia','Valencia','España','General',3),
('PRV019','SmartOffice','B46000019','Av. Empresa 20','Alicante','Alicante','España','General',2),
('PRV020','Enterprise Solutions','B46000020','C/ Tecnología 99','Madrid','Madrid','España','General',4);


-- ============================================================
-- 5. PRODUCTOS
-- 50 productos
--
-- Las categorías permitirán posteriormente análisis interesantes.
-- ============================================================

INSERT INTO compras.producto
(codigo, descripcion, categoria, subcategoria, unidad)
VALUES

-- ORDENADORES
('P001','Portátil Profesional 14"','Informática','Ordenadores','ud'),
('P002','Portátil Profesional 16"','Informática','Ordenadores','ud'),
('P003','PC Sobremesa i5','Informática','Ordenadores','ud'),
('P004','PC Sobremesa i7','Informática','Ordenadores','ud'),
('P005','Mini PC Profesional','Informática','Ordenadores','ud'),

-- MONITORES
('P006','Monitor 24 pulgadas','Informática','Monitores','ud'),
('P007','Monitor 27 pulgadas','Informática','Monitores','ud'),
('P008','Monitor 32 pulgadas','Informática','Monitores','ud'),

-- REDES
('P009','Switch 24 puertos Gigabit','Redes','Switching','ud'),
('P010','Switch 48 puertos Gigabit','Redes','Switching','ud'),
('P011','Switch 10GbE','Redes','Switching','ud'),
('P012','Router empresarial','Redes','Routing','ud'),
('P013','Punto de acceso WiFi 6','Redes','WiFi','ud'),
('P014','Punto de acceso WiFi 7','Redes','WiFi','ud'),
('P015','Firewall empresarial','Redes','Seguridad','ud'),

-- SERVIDORES
('P016','Servidor Rack 1U','Infraestructura','Servidores','ud'),
('P017','Servidor Rack 2U','Infraestructura','Servidores','ud'),
('P018','Servidor GPU','Infraestructura','Servidores','ud'),
('P019','Memoria RAM servidor 64GB','Infraestructura','Componentes','ud'),
('P020','SSD Enterprise 3.84TB','Infraestructura','Almacenamiento','ud'),

-- ALMACENAMIENTO
('P021','NAS 4 bahías','Almacenamiento','NAS','ud'),
('P022','NAS 8 bahías','Almacenamiento','NAS','ud'),
('P023','Disco HDD 8TB','Almacenamiento','Discos','ud'),
('P024','Disco HDD 16TB','Almacenamiento','Discos','ud'),
('P025','SSD NVMe 2TB','Almacenamiento','SSD','ud'),

-- PERIFÉRICOS
('P026','Teclado USB','Periféricos','Teclados','ud'),
('P027','Ratón óptico','Periféricos','Ratones','ud'),
('P028','Webcam Full HD','Periféricos','Webcams','ud'),
('P029','Auriculares USB','Periféricos','Audio','ud'),
('P030','Docking Station USB-C','Periféricos','Docking','ud'),

-- IMPRESIÓN
('P031','Impresora láser monocromo','Impresión','Impresoras','ud'),
('P032','Impresora láser color','Impresión','Impresoras','ud'),
('P033','Tóner negro','Impresión','Consumibles','ud'),
('P034','Tóner color','Impresión','Consumibles','ud'),
('P035','Escáner documental','Impresión','Escáneres','ud'),

-- OFICINA
('P036','Papel A4 500 hojas','Oficina','Papel','paquete'),
('P037','Carpeta archivadora','Oficina','Archivo','ud'),
('P038','Bolígrafos caja 50','Oficina','Escritura','caja'),
('P039','Cuaderno A4','Oficina','Papelería','ud'),
('P040','Etiquetas adhesivas','Oficina','Papelería','paquete'),

-- SEGURIDAD
('P041','Cámara IP','Seguridad','Videovigilancia','ud'),
('P042','Grabador NVR','Seguridad','Videovigilancia','ud'),
('P043','Sensor de acceso','Seguridad','Control acceso','ud'),
('P044','Lector RFID','Seguridad','Control acceso','ud'),
('P045','SAI 1500VA','Seguridad','Alimentación','ud'),

-- SOFTWARE / SERVICIOS
('P046','Licencia Backup anual','Software','Backup','licencia'),
('P047','Licencia Antivirus anual','Software','Seguridad','licencia'),
('P048','Soporte técnico anual','Servicios','Soporte','servicio'),
('P049','Mantenimiento infraestructura','Servicios','Mantenimiento','servicio'),
('P050','Consultoría técnica','Servicios','Consultoría','hora');


-- ============================================================
-- 6. GENERACIÓN DE PEDIDOS
--
-- 450 pedidos:
--   150 en 2024
--   150 en 2025
--   150 en 2026
--
-- Patrón:
-- 2025 incrementa actividad.
-- 2026 mantiene actividad pero posteriormente aumentaremos precios.
-- ============================================================

INSERT INTO compras.pedido
(
    numero_pedido,
    fecha_pedido,
    id_proveedor,
    id_forma_pago,
    id_plazo_entrega
)
SELECT
    'PED-' || TO_CHAR(anio,'FM0000') || '-' ||
    LPAD(n::text,4,'0'),

    make_date(
        anio,
        ((n * 7) % 12) + 1,
        ((n * 11) % 27) + 1
    ),

    -- PRV001, PRV002 y PRV006 recibirán ligeramente más pedidos
    CASE
        WHEN n % 10 IN (0,1) THEN 1
        WHEN n % 10 = 2 THEN 2
        WHEN n % 10 = 3 THEN 6
        ELSE ((n * 7) % 20) + 1
    END,

    ((n * 3) % 5) + 1,

    ((n * 7) % 5) + 1

FROM generate_series(2024,2026) AS anio
CROSS JOIN generate_series(1,150) AS n;


-- ============================================================
-- 7. LÍNEAS DE PEDIDO
--
-- Cada pedido tendrá entre 2 y 5 productos.
-- ============================================================

INSERT INTO compras.producto_pedido
(
    id_pedido,
    id_producto,
    cantidad,
    precio_unitario_estimado
)
SELECT
    p.id_pedido,

    ((p.id_pedido * 7 + linea * 11) % 50) + 1,

    CASE
        WHEN ((p.id_pedido + linea) % 10) < 7
            THEN ((p.id_pedido + linea) % 8) + 1
        ELSE
            ((p.id_pedido + linea) % 30) + 10
    END,

    ROUND(
        (
            CASE
                -- Productos caros
                WHEN ((p.id_pedido * 7 + linea * 11) % 50) + 1
                     BETWEEN 16 AND 18
                    THEN 2500 + (((p.id_pedido + linea) % 10) * 350)

                -- Ordenadores
                WHEN ((p.id_pedido * 7 + linea * 11) % 50) + 1
                     BETWEEN 1 AND 5
                    THEN 600 + (((p.id_pedido + linea) % 8) * 100)

                -- Redes
                WHEN ((p.id_pedido * 7 + linea * 11) % 50) + 1
                     BETWEEN 9 AND 15
                    THEN 200 + (((p.id_pedido + linea) % 10) * 90)

                -- Oficina barata
                WHEN ((p.id_pedido * 7 + linea * 11) % 50) + 1
                     BETWEEN 36 AND 40
                    THEN 5 + (((p.id_pedido + linea) % 8) * 3)

                ELSE
                    50 + (((p.id_pedido + linea) % 20) * 25)
            END

            *

            -- incremento aproximado de precios
            CASE
                WHEN EXTRACT(YEAR FROM p.fecha_pedido) = 2024 THEN 1.00
                WHEN EXTRACT(YEAR FROM p.fecha_pedido) = 2025 THEN 1.05
                ELSE 1.15
            END
        )::numeric,
        2
    )

FROM compras.pedido p
CROSS JOIN LATERAL
     generate_series(1, 2 + (p.id_pedido % 4)) AS linea;


-- ============================================================
-- 8. FACTURAS
--
-- Aproximadamente el 80% de los pedidos se factura.
--
-- Esto será interesante posteriormente:
-- PEDIDOS != FACTURACIÓN
-- ============================================================

INSERT INTO compras.factura_compra
(
    numero_factura,
    fecha_factura,
    id_proveedor,
    id_pedido
)
SELECT
    'FAC-' ||
    EXTRACT(YEAR FROM p.fecha_pedido)::integer ||
    '-' ||
    LPAD(p.id_pedido::text,5,'0'),

    p.fecha_pedido + ((p.id_pedido % 20) + 2),

    p.id_proveedor,

    p.id_pedido

FROM compras.pedido p
WHERE p.id_pedido % 5 <> 0;


-- ============================================================
-- 9. LÍNEAS DE FACTURA
--
-- Partimos de las líneas del pedido.
-- El precio real puede variar respecto al estimado.
-- ============================================================

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
    pp.id_producto,

    -- Normalmente se factura lo pedido.
    pp.cantidad,

    -- Precio real entre aproximadamente -2% y +6%
    ROUND(
        (
            pp.precio_unitario_estimado *
            (
                0.98 +
                ((fc.id_factura + pp.id_producto) % 9) / 100.0
            )
        )::numeric,
        2
    ),

    -- Algunos proveedores ofrecen mejores descuentos.
    ROUND(
        (
            pp.cantidad *
            pp.precio_unitario_estimado *

            CASE
                WHEN fc.id_proveedor IN (3,8,16)
                    THEN 0.10
                WHEN fc.id_proveedor IN (1,2,6)
                    THEN 0.05
                WHEN fc.id_factura % 4 = 0
                    THEN 0.03
                ELSE 0
            END
        )::numeric,
        2
    ),

    21.00,
    0.00

FROM compras.factura_compra fc

JOIN compras.producto_pedido pp
    ON pp.id_pedido = fc.id_pedido;


-- ============================================================
-- 10. ANALYZE
-- ============================================================

ANALYZE compras.tipo_proveedor;
ANALYZE compras.proveedor;
ANALYZE compras.producto;
ANALYZE compras.forma_de_pago;
ANALYZE compras.plazo_entrega;
ANALYZE compras.pedido;
ANALYZE compras.producto_pedido;
ANALYZE compras.factura_compra;
ANALYZE compras.factura_producto;

COMMIT;


-- ============================================================
-- 11. COMPROBACIÓN DEL VOLUMEN
-- ============================================================

SELECT 'Tipos proveedor' AS tabla, COUNT(*) AS registros
FROM compras.tipo_proveedor

UNION ALL

SELECT 'Proveedores', COUNT(*)
FROM compras.proveedor

UNION ALL

SELECT 'Productos', COUNT(*)
FROM compras.producto

UNION ALL

SELECT 'Pedidos', COUNT(*)
FROM compras.pedido

UNION ALL

SELECT 'Lineas pedido', COUNT(*)
FROM compras.producto_pedido

UNION ALL

SELECT 'Facturas', COUNT(*)
FROM compras.factura_compra

UNION ALL

SELECT 'Lineas factura', COUNT(*)
FROM compras.factura_producto;


-- ============================================================
-- 12. COMPROBAR DISTRIBUCIÓN TEMPORAL
-- ============================================================

SELECT
    EXTRACT(YEAR FROM fecha_pedido)::integer AS anio,
    COUNT(*) AS pedidos
FROM compras.pedido
GROUP BY 1
ORDER BY 1;


SELECT
    EXTRACT(YEAR FROM fecha_factura)::integer AS anio,
    COUNT(*) AS facturas
FROM compras.factura_compra
GROUP BY 1
ORDER BY 1;


-- ============================================================
-- 13. COMPROBAR PERIODO DE DATOS
-- ============================================================

SELECT
    MIN(fecha_pedido) AS primer_pedido,
    MAX(fecha_pedido) AS ultimo_pedido
FROM compras.pedido;


SELECT
    MIN(fecha_factura) AS primera_factura,
    MAX(fecha_factura) AS ultima_factura
FROM compras.factura_compra;