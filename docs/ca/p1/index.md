# Dilluns · Jorge Penalba Mateu

Fonts i tipus de dades, el model relacional (amb la pràctica **del model OLTP al model OLAP**), les bases de dades NoSQL (MongoDB i Elasticsearch) i, com a ampliació, la visualització amb Kibana i Power BI.

**Resultats d'aprenentatge:** RA1, RA2 (c, d, e), RA3, RA4 i RA5 (b–f).

<div class="grid cards" markdown>

-   :material-book-open-variant:{ .lg .middle } __S01 · Tipus de dades i fonts__

    ---

    dl 05/10/2026 · RA1 a, RA1 b

    Presentació. Fonts de dades segons l'origen, la naturalesa, la formalitat, la ubicació i la distribució física.

    [:octicons-arrow-right-24: Obri la sessió](s01-tipus-dades.md)

-   :material-book-open-variant:{ .lg .middle } __S02 · Gestors i formats__

    ---

    dl 19/10/2026 · RA1 c, RA1 d, RA1 e, RA1 f

    SGBD SQL i NoSQL, teorema CAP. Formats d'intercanvi (CSV, JSON, XML, Parquet). Dades no estructurades i web semàntica. Dades SCADA/IoT.

    [:octicons-arrow-right-24: Obri la sessió](s02-gestors-formats.md)

-   :material-book-open-variant:{ .lg .middle } __S03 · Entorns i arquitectures__

    ---

    dl 26/10/2026 · RA1 g, RA1 h, RA3 c

    On-premise i núvol. Staging, ODS, DW, data mart, data lake i arquitectura medallion. SMP, MPP i edge computing. OLTP vs OLAP.

    [:octicons-arrow-right-24: Obri la sessió](s03-entorns-arquitectures.md)

-   :material-book-open-variant:{ .lg .middle } __S04 · Model multidimensional__

    ---

    dl 02/11/2026 · RA3 c

    Prova curta del RA1. Procés de negoci, grànul, fets, mesures, dimensions i claus subrogades.

    [:octicons-arrow-right-24: Obri la sessió](s04-model-multidimensional.md)

-   :material-book-open-variant:{ .lg .middle } __S05 · Pràctica: OLTP i DDL__

    ---

    dl 09/11/2026 · RA3 a

    Muntar l'OLTP de compres i crear l'estrella dw_compras amb DDL.

    [:octicons-arrow-right-24: Obri la sessió](s05-practica-ddl.md)

-   :material-book-open-variant:{ .lg .middle } __S06 · Pràctica: càrrega del DW__

    ---

    dl 16/11/2026 · RA3 b, RA3 d

    Càrrega de dimensions, validació de lookups, càrrega del fet i reconciliació.

    [:octicons-arrow-right-24: Obri la sessió](s06-practica-carrega.md)

-   :material-book-open-variant:{ .lg .middle } __S07 · Pràctica: SCD1 i DCL__

    ---

    dl 23/11/2026 · RA3 b, RA3 e

    MERGE i SCD tipus 1. Rols, permisos i Row Level Security.

    [:octicons-arrow-right-24: Obri la sessió](s07-practica-scd-dcl.md)

-   :material-book-open-variant:{ .lg .middle } __S08 · Pràctica: càrrega massiva__

    ---

    dl 30/11/2026 · RA3 f, RA2 c

    Escalat a 100.000 línies. COPY i \copy davant d'INSERT. SQL embegut en Python.

    [:octicons-arrow-right-24: Obri la sessió](s08-practica-copy.md)

-   :material-book-open-variant:{ .lg .middle } __S09 · Pràctica: benchmark i paral·lelisme__

    ---

    dl 14/12/2026 · RA2 d, RA2 e, RA3 g

    Filtres en origen, JOINs i EXPLAIN. Taula particionada i càrrega paral·lela. Lliurament del RA3.

    [:octicons-arrow-right-24: Obri la sessió](s09-practica-benchmark.md)

-   :material-progress-pencil:{ .lg .middle } __S10 · MongoDB I__

    ---

    dl 21/12/2026 · RA4 a, RA4 b, RA4 c, RA5 b

    MongoDB local i a Atlas (núvol). Accés amb mongosh, Compass i pymongo.

    [:octicons-arrow-right-24: Obri la sessió](s10-mongodb-1.md)

-   :material-progress-pencil:{ .lg .middle } __S11 · MongoDB II__

    ---

    dl 11/01/2027 · RA4 d, RA5 c, RA5 d

    CRUD, aggregation pipeline, validació d'esquema, índexs i càrrega massiva (insertMany, bulkWrite, mongoimport).

    [:octicons-arrow-right-24: Obri la sessió](s11-mongodb-2.md)

-   :material-progress-pencil:{ .lg .middle } __S12 · Elasticsearch__

    ---

    dl 18/01/2027 · RA4 c, RA4 d, RA5 c, RA5 d

    Índexs, mappings, Query DSL, agregacions i API _bulk. Demo: NiFi vs Logstash vs Filebeat.

    [:octicons-arrow-right-24: Obri la sessió](s12-elasticsearch.md)

-   :material-progress-pencil:{ .lg .middle } __S13 · Seguretat i paral·lelisme NoSQL__

    ---

    dl 25/01/2027 · RA4 e, RA5 e, RA5 f

    Seguretat en Elastic (xpack, rols, API keys) i en MongoDB (autenticació, rols). Shards, rèpliques i _bulk en paral·lel. Prova RA4 + RA5.

    [:octicons-arrow-right-24: Obri la sessió](s13-nosql-seguretat.md)

-   :material-progress-pencil:{ .lg .middle } __S14 · Kibana__

    ---

    dl 01/02/2027 · Ampliació

    Data views, Lens i dashboards.

    [:octicons-arrow-right-24: Obri la sessió](s14-kibana.md)

-   :material-progress-pencil:{ .lg .middle } __S15 · Power BI__

    ---

    dl 08/02/2027 · Ampliació

    Power BI connectat a dw_compras: Import vs DirectQuery, model estrella i mesures.

    [:octicons-arrow-right-24: Obri la sessió](s15-powerbi.md)

-   :material-progress-pencil:{ .lg .middle } __S16 · Prova final__

    ---

    dl 15/02/2027 · RA1, RA2 c-e, RA3, RA4, RA5

    Prova pràctica final de la part de Jorge.

    [:octicons-arrow-right-24: Obri la sessió](s16-prova.md)

</div>
