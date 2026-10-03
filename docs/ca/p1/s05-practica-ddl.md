# S05 · Pràctica: OLTP i DDL

<div class="sessio-meta" markdown>
<span><strong>Data</strong> dl 09/11/2026</span>
<span><strong>Durada</strong> 3 h 40 min</span>
<span><span class="tag p1">Jorge · dilluns</span></span>
<span><strong>RA·CA</strong> <span class="ra">RA3 a</span></span>
<span><strong>Pràctica</strong> [OLTP → OLAP, part 1](../practiques/oltp-olap/index.md)</span>
</div>

!!! abstract "Què treballarem"
    Muntarem l'entorn, crearem i poblarem l'OLTP de compres i implementarem amb **DDL** l'estrella que vam dissenyar a [S04](s04-model-multidimensional.md).

## Objectiu

- **RA3.a** · Usar llenguatges de definició de dades (DDL) per a crear estructures d'emmagatzematge, relacions i índexs.

## 1. Arrancar PostgreSQL

Segueix l'apartat 2 de l'[entorn de treball](../curs/entorn.md). Descomprimeix [`compras_sql.zip`](../practiques/oltp-olap/compras_sql.zip) dins de la carpeta `sql` del teu projecte i entra a `psql`:

```bash
docker compose up -d postgres
docker compose exec postgres psql -U postgres
```

Dins de `psql`, situa't a la carpeta dels scripts:

```sql
\cd /sql
\timing on
```

## 2. Crear i poblar l'OLTP

```sql
\i 01_oltp_compras.sql
\i 02_populate_oltp.sql
```

Explora el que acabes de crear:

```sql
\dn                       -- esquemes
\dt compras.*             -- taules de l'OLTP
\d compras.factura_producto
SELECT COUNT(*) FROM compras.factura_producto;   -- ≈ 1.260
```

!!! question "Pregunta 1"
    Quina és la **clau primària** de `factura_producto`? Per què és composta? Què impedeix?

## 3. DDL: crear l'estrella

Obri `03_olap_dw_compras.sql` **abans d'executar-lo** i llig-lo amb calma. Fixa't en:

```sql title="03_olap_dw_compras.sql (fragment)"
CREATE TABLE dw_compras.dim_proveedor (
    sk_proveedor        SERIAL PRIMARY KEY,           -- (1)!
    id_proveedor_oltp   INTEGER NOT NULL UNIQUE,      -- (2)!
    codigo              VARCHAR(20),
    denominacion        VARCHAR(150),
    tipo_proveedor      VARCHAR(100),                 -- (3)!
    ...
);
```

1. **Clau subrogada**: la genera el DW i és la que usarà el fet.
2. **Clau de negoci** de l'origen. `UNIQUE` garanteix que un proveïdor de l'OLTP no s'insereix dues vegades, i fa possible `ON CONFLICT`.
3. Atribut **desnormalitzat**: a l'OLTP era la taula `tipo_proveedor`.

Executa'l i comprova'l:

```sql
\i 03_olap_dw_compras.sql
\dt dw_compras.*
\d dw_compras.hecho_compras
\di dw_compras.*          -- índexs
```

!!! question "Pregunta 2"
    `sk_forma_pago` i `sk_plazo_entrega` admeten `NULL` en el fet, però `sk_tiempo`, `sk_proveedor` i `sk_producto` no. Mira l'OLTP: per què creus que s'ha decidit així?

!!! question "Pregunta 3"
    Hi ha índexs sobre les FK del fet (`idx_hc_tiempo`, `idx_hc_proveedor`…). Quin en falta? Afig-lo amb un `CREATE INDEX`.

## 4. Compara amb el teu disseny

Agafa el diagrama que vas fer a [S04](s04-model-multidimensional.md) i compara'l amb l'estrella creada:

- Coincideixen el **grànul**, les **dimensions** i les **mesures**?
- Hi ha algun atribut que tu havies posat i que ací falta, o al revés?
- `dim_tiempo` té `dia_semana` i `nombre_dia`. Proposa i afig **una columna nova** que tinga sentit en el teu context (per exemple, `es_festiu` o `es_cap_de_setmana`) amb `ALTER TABLE`.

## 5. Abans d'eixir

- [ ] Tinc l'OLTP creat i poblat (≈1.260 línies).
- [ ] Tinc l'esquema `dw_compras` creat amb les 6 taules.
- [ ] He respost les preguntes 1, 2 i 3.
- [ ] He guardat en un fitxer `05_alter_propi.sql` els meus `ALTER TABLE` i `CREATE INDEX`.
