# Del modelo OLTP al modelo OLAP

<div class="sessio-meta" markdown>
<span><strong>Sesiones</strong> S05 → S09 (09/11 – 14/12)</span>
<span><span class="tag p1">Jorge · lunes</span></span>
<span><strong>RA·CA</strong> <span class="ra">RA3 a–g</span> <span class="ra">RA2 c</span> <span class="ra">RA2 d</span> <span class="ra">RA2 e</span></span>
<span><strong>Entrega</strong> lu 14/12/2026</span>
</div>

!!! abstract "Reto"
    La empresa tiene las compras en un **OLTP normalizado** en PostgreSQL. Tienes que construir el **data mart de compras** (`dw_compras`) en estrella, cargarlo, demostrar que contiene **exactamente** la misma información que el origen, protegerlo con roles y comparar el rendimiento de las dos bases de datos cuando el volumen crece hasta 100.000 líneas.

## Descarga

[:material-download: Scripts SQL de la práctica (compras_sql.zip)](compras_sql.zip){ .md-button .md-button--primary }

| Fichero | Qué hace | Sesión |
|---|---|---|
| `01_oltp_compras.sql` | Crea el esquema OLTP `compras` | [S05](../../p1/s05-practica-ddl.md) |
| `02_populate_oltp.sql` | Puebla el OLTP (≈1.260 líneas de factura, 2024-2026) | [S05](../../p1/s05-practica-ddl.md) |
| `03_olap_dw_compras.sql` | Crea el esquema en estrella `dw_compras` | [S05](../../p1/s05-practica-ddl.md) |
| `04_load_olap.sql` | Carga dimensiones y hecho, valida y concilia | [S06](../../p1/s06-practica-carrega.md) |
| `05_queries_oltp.sql` | Consultas de análisis sobre el OLTP con `EXPLAIN` | [S09](../../p1/s09-practica-benchmark.md) |
| `06_queries_olap.sql` | Las mismas consultas sobre la estrella | [S09](../../p1/s09-practica-benchmark.md) |
| `07_scale_100k.sql` | Hace crecer el OLTP hasta 100.000 líneas | [S08](../../p1/s08-practica-copy.md) |
| `08_scd1_merge.sql` | SCD tipo 1 con `MERGE` | [S07](../../p1/s07-practica-scd-dcl.md) |
| `09_dcl_rols.sql` | Roles, permisos y *Row Level Security* | [S07](../../p1/s07-practica-scd-dcl.md) |
| `10_copy_massiva.sql` | `COPY` y `\copy` frente a `INSERT` | [S08](../../p1/s08-practica-copy.md) |
| `11_carrega_paralela.sh` | Tabla particionada y carga en paralelo | [S09](../../p1/s09-practica-benchmark.md) |

!!! warning "Ejecuta los scripts con `psql`"
    Algunos scripts usan órdenes de `psql` (`\timing`, `\copy`, `\echo`) que no funcionan en editores gráficos como DBeaver o el editor web de Supabase.

!!! note "Idioma de los scripts"
    Los nombres de tablas y columnas están en castellano. Los comentarios de los scripts 04 y 08 a 11 están en valenciano.

## Los dos modelos

=== "OLTP · `compras`"

    ```mermaid
    erDiagram
        TIPO_PROVEEDOR ||--o{ PROVEEDOR : ""
        PROVEEDOR ||--o{ PEDIDO : ""
        PROVEEDOR ||--o{ FACTURA_COMPRA : ""
        FORMA_DE_PAGO ||--o{ PEDIDO : ""
        PLAZO_ENTREGA ||--o{ PEDIDO : ""
        PEDIDO ||--o{ PRODUCTO_PEDIDO : ""
        PEDIDO ||--o| FACTURA_COMPRA : ""
        FACTURA_COMPRA ||--|{ FACTURA_PRODUCTO : ""
        PRODUCTO ||--o{ FACTURA_PRODUCTO : ""
        PRODUCTO ||--o{ PRODUCTO_PEDIDO : ""
    ```

=== "OLAP · `dw_compras`"

    ```mermaid
    erDiagram
        DIM_TIEMPO ||--o{ HECHO_COMPRAS : ""
        DIM_PROVEEDOR ||--o{ HECHO_COMPRAS : ""
        DIM_PRODUCTO ||--o{ HECHO_COMPRAS : ""
        DIM_FORMA_PAGO ||--o{ HECHO_COMPRAS : ""
        DIM_PLAZO_ENTREGA ||--o{ HECHO_COMPRAS : ""
    ```

**Grano:** una fila de `hecho_compras` es una línea de producto de una factura de compra.

## El algoritmo que aplicarás

1. Elegir el proceso de negocio.
2. Definir el **grano**.
3. Identificar **medidas** y **dimensiones**.
4. Desnormalizar los atributos descriptivos cuando simplifique.
5. Crear las **SK** en las dimensiones y conservar la clave de origen para el *lookup*.
6. Cargar **primero las dimensiones**.
7. **Comprobar los *lookups*** antes de cargar el hecho.
8. Cargar el hecho **sustituyendo las claves OLTP por SK**.
9. Calcular las medidas derivadas.
10. **Conciliar**: cantidades e importes deben coincidir con el OLTP.
11. `ANALYZE` y consultas de BI o benchmark.

## Qué tienes que entregar (lu 14/12)

Un repositorio Git o un ZIP con:

- [ ] Todos los scripts que has ejecutado, **en orden**, que funcionan desde una base de datos vacía.
- [ ] Captura de la **conciliación** OLTP = OLAP con el dataset inicial y con 100.000 líneas.
- [ ] Captura de la **validación de *lookups*** con resultado 0.
- [ ] Prueba de **SCD tipo 1**: antes y después del `MERGE`.
- [ ] Prueba de los **roles**: qué ve cada rol y el error al intentar leer el OLTP.
- [ ] Tabla de tiempos de **carga masiva**: `\copy`, `INSERT … SELECT` y fila a fila (extrapolado a 100.000).
- [ ] **Benchmark** OLTP vs OLAP: mediana de 5 ejecuciones, número de JOIN, tipo de ordenación (*quicksort* o *external merge*) y *workers* paralelos.
- [ ] Tiempos de **carga secuencial vs paralela**.
- [ ] Un **informe breve** (1-2 páginas) con las conclusiones: cuándo es mejor el OLAP y cuándo no.

## Rúbrica

| Criterio | RA·CA | Peso |
|---|---|---|
| DDL: esquema en estrella con claves, FK e índices coherentes con el grano | RA3.a | 15 % |
| DML: carga de dimensiones y hecho, SCD1 con `MERGE` | RA3.b | 15 % |
| Justificación OLTP vs OLAP y del grano | RA3.c | 10 % |
| ELT dentro de la misma BD y conciliación correcta | RA3.d | 15 % |
| Roles, permisos y RLS que funcionan | RA3.e | 10 % |
| Carga masiva con `COPY` y medida de tiempos | RA3.f | 10 % |
| Carga paralela y análisis | RA3.g | 10 % |
| Consultas: filtros en origen, JOIN y lectura de `EXPLAIN` | RA2.c–e | 15 % |

!!! info "Pesos orientativos"
    El profesorado puede ajustar los pesos. Los publicará en Aules antes de empezar la práctica.
