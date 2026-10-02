-- ============================================================
-- 01_oltp_compras.sql
-- MODELO TRANSACCIONAL OLTP - COMPRAS
-- PostgreSQL 15
-- ============================================================

DROP SCHEMA IF EXISTS compras CASCADE;
CREATE SCHEMA compras;

-- ------------------------------------------------------------
-- TIPO DE PROVEEDOR
-- ------------------------------------------------------------

CREATE TABLE compras.tipo_proveedor (
    id_tipo_proveedor SERIAL PRIMARY KEY,
    codigo             VARCHAR(10) NOT NULL UNIQUE,
    descripcion        VARCHAR(100) NOT NULL
);

-- ------------------------------------------------------------
-- PROVEEDOR
-- ------------------------------------------------------------

CREATE TABLE compras.proveedor (
    id_proveedor       SERIAL PRIMARY KEY,
    codigo             VARCHAR(20) NOT NULL UNIQUE,
    denominacion       VARCHAR(150) NOT NULL,
    cif                VARCHAR(20),
    domicilio          VARCHAR(200),
    ciudad             VARCHAR(100),
    provincia          VARCHAR(100),
    pais               VARCHAR(100) DEFAULT 'España',
    situacion_fiscal   VARCHAR(50),

    id_tipo_proveedor  INTEGER
        REFERENCES compras.tipo_proveedor(id_tipo_proveedor)
);

-- ------------------------------------------------------------
-- PRODUCTO
-- ------------------------------------------------------------

CREATE TABLE compras.producto (
    id_producto        SERIAL PRIMARY KEY,
    codigo             VARCHAR(20) NOT NULL UNIQUE,
    descripcion        VARCHAR(150) NOT NULL,
    categoria          VARCHAR(100),
    subcategoria       VARCHAR(100),
    unidad             VARCHAR(20)
);

-- ------------------------------------------------------------
-- FORMA DE PAGO
-- ------------------------------------------------------------

CREATE TABLE compras.forma_de_pago (
    id_forma_pago      SERIAL PRIMARY KEY,
    codigo             VARCHAR(20) NOT NULL UNIQUE,
    descripcion        VARCHAR(100) NOT NULL
);

-- ------------------------------------------------------------
-- PLAZO DE ENTREGA
-- ------------------------------------------------------------

CREATE TABLE compras.plazo_entrega (
    id_plazo_entrega   SERIAL PRIMARY KEY,
    codigo             VARCHAR(20) NOT NULL UNIQUE,
    descripcion        VARCHAR(100),
    dias               INTEGER CHECK (dias >= 0)
);

-- ------------------------------------------------------------
-- PEDIDO (CABECERA)
-- ------------------------------------------------------------

CREATE TABLE compras.pedido (
    id_pedido          SERIAL PRIMARY KEY,
    numero_pedido      VARCHAR(30) NOT NULL UNIQUE,
    fecha_pedido       DATE NOT NULL,

    id_proveedor       INTEGER NOT NULL
        REFERENCES compras.proveedor(id_proveedor),

    id_forma_pago      INTEGER
        REFERENCES compras.forma_de_pago(id_forma_pago),

    id_plazo_entrega   INTEGER
        REFERENCES compras.plazo_entrega(id_plazo_entrega)
);

-- ------------------------------------------------------------
-- PRODUCTO_PEDIDO (DETALLE)
-- Resuelve N:M PEDIDO <-> PRODUCTO
-- ------------------------------------------------------------

CREATE TABLE compras.producto_pedido (
    id_pedido              INTEGER NOT NULL
        REFERENCES compras.pedido(id_pedido),

    id_producto            INTEGER NOT NULL
        REFERENCES compras.producto(id_producto),

    cantidad               NUMERIC(12,2) NOT NULL
        CHECK (cantidad > 0),

    precio_unitario_estimado NUMERIC(12,2)
        CHECK (precio_unitario_estimado >= 0),

    PRIMARY KEY (id_pedido, id_producto)
);

-- ------------------------------------------------------------
-- FACTURA DE COMPRA (CABECERA)
-- ------------------------------------------------------------

CREATE TABLE compras.factura_compra (
    id_factura         SERIAL PRIMARY KEY,
    numero_factura     VARCHAR(30) NOT NULL,
    fecha_factura      DATE NOT NULL,

    id_proveedor       INTEGER NOT NULL
        REFERENCES compras.proveedor(id_proveedor),

    id_pedido          INTEGER
        REFERENCES compras.pedido(id_pedido),

    UNIQUE (numero_factura, id_proveedor)
);

-- ------------------------------------------------------------
-- FACTURA_PRODUCTO (DETALLE)
-- Resuelve N:M FACTURA <-> PRODUCTO
-- ------------------------------------------------------------

CREATE TABLE compras.factura_producto (
    id_factura         INTEGER NOT NULL
        REFERENCES compras.factura_compra(id_factura),

    id_producto        INTEGER NOT NULL
        REFERENCES compras.producto(id_producto),

    cantidad           NUMERIC(12,2) NOT NULL
        CHECK (cantidad > 0),

    precio_unitario    NUMERIC(12,2) NOT NULL
        CHECK (precio_unitario >= 0),

    descuento          NUMERIC(12,2) NOT NULL DEFAULT 0
        CHECK (descuento >= 0),

    alicuota_iva       NUMERIC(5,2) NOT NULL DEFAULT 21,
    alicuota_ib        NUMERIC(5,2) NOT NULL DEFAULT 0,

    PRIMARY KEY (id_factura, id_producto)
);

-- ------------------------------------------------------------
-- ÍNDICES
-- ------------------------------------------------------------

CREATE INDEX idx_pedido_fecha
    ON compras.pedido(fecha_pedido);

CREATE INDEX idx_pedido_proveedor
    ON compras.pedido(id_proveedor);

CREATE INDEX idx_factura_fecha
    ON compras.factura_compra(fecha_factura);

CREATE INDEX idx_factura_proveedor
    ON compras.factura_compra(id_proveedor);

CREATE INDEX idx_factura_pedido
    ON compras.factura_compra(id_pedido);

CREATE INDEX idx_factura_producto_producto
    ON compras.factura_producto(id_producto);

-- ------------------------------------------------------------
-- COMPROBACIÓN
-- ------------------------------------------------------------

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'compras'
ORDER BY table_name;