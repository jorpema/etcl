-- ============================================================
-- 03_olap_dw_compras.sql
-- DATA MART / MODELO OLAP DE COMPRAS
-- PostgreSQL 15
-- ============================================================

DROP SCHEMA IF EXISTS dw_compras CASCADE;
CREATE SCHEMA dw_compras;

-- ============================================================
-- DIMENSIÓN TIEMPO
-- ============================================================

CREATE TABLE dw_compras.dim_tiempo (
    sk_tiempo       SERIAL PRIMARY KEY,

    fecha           DATE NOT NULL UNIQUE,

    dia             SMALLINT NOT NULL,
    mes             SMALLINT NOT NULL,
    nombre_mes      VARCHAR(20) NOT NULL,
    trimestre       SMALLINT NOT NULL,
    anio            SMALLINT NOT NULL,
    dia_semana      SMALLINT,
    nombre_dia      VARCHAR(20)
);

-- ============================================================
-- DIMENSIÓN PROVEEDOR
-- ============================================================

CREATE TABLE dw_compras.dim_proveedor (
    sk_proveedor        SERIAL PRIMARY KEY,

    -- Business Key procedente del OLTP
    id_proveedor_oltp   INTEGER NOT NULL UNIQUE,

    codigo              VARCHAR(20),
    denominacion        VARCHAR(150),
    tipo_proveedor      VARCHAR(100),

    ciudad              VARCHAR(100),
    provincia           VARCHAR(100),
    pais                VARCHAR(100),

    situacion_fiscal    VARCHAR(50)
);

-- ============================================================
-- DIMENSIÓN PRODUCTO
-- ============================================================

CREATE TABLE dw_compras.dim_producto (
    sk_producto       SERIAL PRIMARY KEY,

    id_producto_oltp INTEGER NOT NULL UNIQUE,

    codigo            VARCHAR(20),
    descripcion       VARCHAR(150),

    categoria         VARCHAR(100),
    subcategoria      VARCHAR(100),
    unidad            VARCHAR(20)
);

-- ============================================================
-- DIMENSIÓN FORMA DE PAGO
-- ============================================================

CREATE TABLE dw_compras.dim_forma_pago (
    sk_forma_pago       SERIAL PRIMARY KEY,

    id_forma_pago_oltp  INTEGER NOT NULL UNIQUE,

    codigo              VARCHAR(20),
    descripcion         VARCHAR(100)
);

-- ============================================================
-- DIMENSIÓN PLAZO DE ENTREGA
-- ============================================================

CREATE TABLE dw_compras.dim_plazo_entrega (
    sk_plazo_entrega       SERIAL PRIMARY KEY,

    id_plazo_entrega_oltp  INTEGER NOT NULL UNIQUE,

    codigo                 VARCHAR(20),
    descripcion            VARCHAR(100),
    dias                   INTEGER
);

-- ============================================================
-- HECHO COMPRAS
--
-- GRANULARIDAD:
-- Una fila = un producto incluido en una factura.
-- ============================================================

CREATE TABLE dw_compras.hecho_compras (
    id_hecho            BIGSERIAL PRIMARY KEY,

    sk_tiempo           INTEGER NOT NULL
        REFERENCES dw_compras.dim_tiempo(sk_tiempo),

    sk_proveedor        INTEGER NOT NULL
        REFERENCES dw_compras.dim_proveedor(sk_proveedor),

    sk_producto         INTEGER NOT NULL
        REFERENCES dw_compras.dim_producto(sk_producto),

    sk_forma_pago       INTEGER
        REFERENCES dw_compras.dim_forma_pago(sk_forma_pago),

    sk_plazo_entrega    INTEGER
        REFERENCES dw_compras.dim_plazo_entrega(sk_plazo_entrega),

    -- Dimensión degenerada
    numero_factura      VARCHAR(30),

    -- Medidas
    cantidad            NUMERIC(12,2) NOT NULL,

    precio_unitario     NUMERIC(12,2) NOT NULL,

    descuento           NUMERIC(12,2) NOT NULL DEFAULT 0,

    importe_bruto       NUMERIC(14,2) NOT NULL,

    importe_total       NUMERIC(14,2) NOT NULL,

    alicuota_iva        NUMERIC(5,2),

    alicuota_ib         NUMERIC(5,2)
);

-- ============================================================
-- ÍNDICES DEL HECHO 
-- ============================================================

CREATE INDEX idx_hc_tiempo
    ON dw_compras.hecho_compras(sk_tiempo);

CREATE INDEX idx_hc_proveedor
    ON dw_compras.hecho_compras(sk_proveedor);

CREATE INDEX idx_hc_producto
    ON dw_compras.hecho_compras(sk_producto);

CREATE INDEX idx_hc_forma_pago
    ON dw_compras.hecho_compras(sk_forma_pago);

-- ============================================================
-- COMPROBACIÓN
-- ============================================================

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'dw_compras'
ORDER BY table_name;