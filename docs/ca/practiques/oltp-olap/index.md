# Del model OLTP al model OLAP

<div class="sessio-meta" markdown>
<span><strong>Sessions</strong> S05 → S09 (09/11 – 14/12)</span>
<span><span class="tag p1">Jorge · dilluns</span></span>
<span><strong>RA·CA</strong> <span class="ra">RA3 a–g</span> <span class="ra">RA2 c</span> <span class="ra">RA2 d</span> <span class="ra">RA2 e</span></span>
<span><strong>Lliurament</strong> dl 14/12/2026</span>
</div>

!!! abstract "Repte"
    L'empresa té les compres en un **OLTP normalitzat** en PostgreSQL. Has de construir el **data mart de compres** (`dw_compras`) en estrella, carregar-lo, demostrar que conté **exactament** la mateixa informació que l'origen, protegir-lo amb rols i comparar el rendiment de les dues bases de dades quan el volum creix fins a 100.000 línies.

## Descàrrega

[:material-download: Scripts SQL de la pràctica (compras_sql.zip)](compras_sql.zip){ .md-button .md-button--primary }

| Fitxer | Què fa | Sessió |
|---|---|---|
| `01_oltp_compras.sql` | Crea l'esquema OLTP `compras` | [S05](../../p1/s05-practica-ddl.md) |
| `02_populate_oltp.sql` | Pobla l'OLTP (≈1.260 línies de factura, 2024-2026) | [S05](../../p1/s05-practica-ddl.md) |
| `03_olap_dw_compras.sql` | Crea l'esquema en estrella `dw_compras` | [S05](../../p1/s05-practica-ddl.md) |
| `04_load_olap.sql` | Carrega dimensions i fet, valida i reconcilia | [S06](../../p1/s06-practica-carrega.md) |
| `05_queries_oltp.sql` | Consultes d'anàlisi sobre l'OLTP amb `EXPLAIN` | [S09](../../p1/s09-practica-benchmark.md) |
| `06_queries_olap.sql` | Les mateixes consultes sobre l'estrella | [S09](../../p1/s09-practica-benchmark.md) |
| `07_scale_100k.sql` | Fa créixer l'OLTP fins a 100.000 línies | [S08](../../p1/s08-practica-copy.md) |
| `08_scd1_merge.sql` | SCD tipus 1 amb `MERGE` | [S07](../../p1/s07-practica-scd-dcl.md) |
| `09_dcl_rols.sql` | Rols, permisos i *Row Level Security* | [S07](../../p1/s07-practica-scd-dcl.md) |
| `10_copy_massiva.sql` | `COPY` i `\copy` davant d'`INSERT` | [S08](../../p1/s08-practica-copy.md) |
| `11_carrega_paralela.sh` | Taula particionada i càrrega en paral·lel | [S09](../../p1/s09-practica-benchmark.md) |

!!! warning "Executa els scripts amb `psql`"
    Alguns scripts usen ordres de `psql` (`\timing`, `\copy`, `\echo`) que no funcionen en editors gràfics com DBeaver o l'editor web de Supabase.

## Els dos models

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

**Grànul:** una fila de `hecho_compras` és una línia de producte d'una factura de compra.

## L'algorisme que aplicaràs

1. Triar el procés de negoci.
2. Definir el **grànul**.
3. Identificar **mesures** i **dimensions**.
4. Desnormalitzar els atributs descriptius quan simplifique.
5. Crear les **SK** en les dimensions i conservar la clau d'origen per al *lookup*.
6. Carregar **primer les dimensions**.
7. **Comprovar els *lookups*** abans de carregar el fet.
8. Carregar el fet **substituint les claus OLTP per SK**.
9. Calcular les mesures derivades.
10. **Reconciliar**: quantitats i imports han de coincidir amb l'OLTP.
11. `ANALYZE` i consultes de BI o benchmark.

## Què has de lliurar (dl 14/12)

Un repositori Git o un ZIP amb:

- [ ] Tots els scripts que has executat, **en ordre**, que funcionen des d'una base de dades buida.
- [ ] Captura de la **reconciliació** OLTP = OLAP amb el dataset inicial i amb 100.000 línies.
- [ ] Captura de la **validació de *lookups*** amb resultat 0.
- [ ] Prova de **SCD tipus 1**: abans i després del `MERGE`.
- [ ] Prova dels **rols**: què veu cada rol i l'error en intentar llegir l'OLTP.
- [ ] Taula de temps de **càrrega massiva**: `\copy`, `INSERT … SELECT` i fila a fila (extrapolat a 100.000).
- [ ] **Benchmark** OLTP vs OLAP: mediana de 5 execucions, nombre de JOIN, tipus d'ordenació (*quicksort* o *external merge*) i *workers* paral·lels.
- [ ] Temps de **càrrega seqüencial vs paral·lela**.
- [ ] Un **informe breu** (1-2 pàgines) amb les conclusions: quan és millor l'OLAP i quan no.

## Rúbrica

| Criteri | RA·CA | Pes |
|---|---|---|
| DDL: esquema en estrella amb claus, FK i índexs coherents amb el grànul | RA3.a | 15 % |
| DML: càrrega de dimensions i fet, SCD1 amb `MERGE` | RA3.b | 15 % |
| Justificació OLTP vs OLAP i del grànul | RA3.c | 10 % |
| ELT dins la mateixa BD i reconciliació correcta | RA3.d | 15 % |
| Rols, permisos i RLS que funcionen | RA3.e | 10 % |
| Càrrega massiva amb `COPY` i mesura de temps | RA3.f | 10 % |
| Càrrega paral·lela i anàlisi | RA3.g | 10 % |
| Consultes: filtres en origen, JOIN i lectura d'`EXPLAIN` | RA2.c–e | 15 % |

!!! info "Pesos orientatius"
    El professorat pot ajustar els pesos. Els publicarà a Aules abans de començar la pràctica.
