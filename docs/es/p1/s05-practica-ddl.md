# S05 · Práctica: OLTP y DDL

<div class="sessio-meta" markdown>
<span><strong>Fecha</strong> lu 09/11/2026</span>
<span><strong>Duración</strong> 3 h 40 min</span>
<span><span class="tag p1">Jorge · lunes</span></span>
<span><strong>RA·CA</strong> <span class="ra">RA3 a</span></span>
<span><strong>Práctica</strong> [OLTP → OLAP, parte 1](../practiques/oltp-olap/index.md)</span>
</div>

!!! abstract "Qué trabajaremos"
    Montaremos el entorno, crearemos y poblaremos el OLTP de compras e implementaremos con **DDL** la estrella que diseñamos en [S04](s04-model-multidimensional.md).

## Objetivo

- **RA3.a** · Usar lenguajes de definición de datos (DDL) para crear estructuras de almacenamiento, relaciones e índices.

## 1. Arrancar PostgreSQL

Sigue el apartado 2 del [entorno de trabajo](../curs/entorn.md). Descomprime [`compras_sql.zip`](../practiques/oltp-olap/compras_sql.zip) dentro de la carpeta `sql` de tu proyecto y entra en `psql`:

```bash
docker compose up -d postgres
docker compose exec postgres psql -U postgres
```

Dentro de `psql`, sitúate en la carpeta de los scripts:

```sql
\cd /sql
\timing on
```

## 2. Crear y poblar el OLTP

```sql
\i 01_oltp_compras.sql
\i 02_populate_oltp.sql
```

Explora lo que acabas de crear:

```sql
\dn                       -- esquemas
\dt compras.*             -- tablas del OLTP
\d compras.factura_producto
SELECT COUNT(*) FROM compras.factura_producto;   -- ≈ 1.260
```

!!! question "Pregunta 1"
    ¿Cuál es la **clave primaria** de `factura_producto`? ¿Por qué es compuesta? ¿Qué impide?

## 3. DDL: crear la estrella

Abre `03_olap_dw_compras.sql` **antes de ejecutarlo** y léelo con calma. Fíjate en:

```sql title="03_olap_dw_compras.sql (fragmento)"
CREATE TABLE dw_compras.dim_proveedor (
    sk_proveedor        SERIAL PRIMARY KEY,           -- (1)!
    id_proveedor_oltp   INTEGER NOT NULL UNIQUE,      -- (2)!
    codigo              VARCHAR(20),
    denominacion        VARCHAR(150),
    tipo_proveedor      VARCHAR(100),                 -- (3)!
    ...
);
```

1. **Clave subrogada**: la genera el DW y es la que usará el hecho.
2. **Clave de negocio** del origen. `UNIQUE` garantiza que un proveedor del OLTP no se inserta dos veces, y hace posible `ON CONFLICT`.
3. Atributo **desnormalizado**: en el OLTP era la tabla `tipo_proveedor`.

Ejecútalo y compruébalo:

```sql
\i 03_olap_dw_compras.sql
\dt dw_compras.*
\d dw_compras.hecho_compras
\di dw_compras.*          -- índices
```

!!! question "Pregunta 2"
    `sk_forma_pago` y `sk_plazo_entrega` admiten `NULL` en el hecho, pero `sk_tiempo`, `sk_proveedor` y `sk_producto` no. Mira el OLTP: ¿por qué crees que se ha decidido así?

!!! question "Pregunta 3"
    Hay índices sobre las FK del hecho (`idx_hc_tiempo`, `idx_hc_proveedor`…). ¿Cuál falta? Añádelo con un `CREATE INDEX`.

## 4. Compara con tu diseño

Coge el diagrama que hiciste en [S04](s04-model-multidimensional.md) y compáralo con la estrella creada:

- ¿Coinciden el **grano**, las **dimensiones** y las **medidas**?
- ¿Hay algún atributo que tú habías puesto y que aquí falta, o al revés?
- `dim_tiempo` tiene `dia_semana` y `nombre_dia`. Propón y añade **una columna nueva** que tenga sentido en tu contexto (por ejemplo, `es_festivo` o `es_fin_de_semana`) con `ALTER TABLE`.

## 5. Antes de salir

- [ ] Tengo el OLTP creado y poblado (≈1.260 líneas).
- [ ] Tengo el esquema `dw_compras` creado con las 6 tablas.
- [ ] He respondido las preguntas 1, 2 y 3.
- [ ] He guardado en un fichero `05_alter_propio.sql` mis `ALTER TABLE` y `CREATE INDEX`.
