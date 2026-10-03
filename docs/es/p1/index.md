# Lunes · Jorge Penalba Mateu

Fuentes y tipos de datos, el modelo relacional (con la práctica **del modelo OLTP al modelo OLAP**), las bases de datos NoSQL (MongoDB y Elasticsearch) y, como ampliación, la visualización con Kibana y Power BI.

**Resultados de aprendizaje:** RA1, RA2 (c, d, e), RA3, RA4 y RA5 (b–f).

<div class="grid cards" markdown>

-   :material-book-open-variant:{ .lg .middle } __S01 · Tipos de datos y fuentes__

    ---

    lu 05/10/2026 · RA1 a, RA1 b

    Presentación. Fuentes de datos según su origen, naturaleza, formalidad, ubicación y distribución física.

    [:octicons-arrow-right-24: Abrir la sesión](s01-tipus-dades.md)

-   :material-book-open-variant:{ .lg .middle } __S02 · Gestores y formatos__

    ---

    lu 19/10/2026 · RA1 c, RA1 d, RA1 e, RA1 f

    SGBD SQL y NoSQL, teorema CAP. Formatos de intercambio (CSV, JSON, XML, Parquet). Datos no estructurados y web semántica. Datos SCADA/IoT.

    [:octicons-arrow-right-24: Abrir la sesión](s02-gestors-formats.md)

-   :material-book-open-variant:{ .lg .middle } __S03 · Entornos y arquitecturas__

    ---

    lu 26/10/2026 · RA1 g, RA1 h, RA3 c

    On-premise y nube. Staging, ODS, DW, data mart, data lake y arquitectura medallion. SMP, MPP y edge computing. OLTP vs OLAP.

    [:octicons-arrow-right-24: Abrir la sesión](s03-entorns-arquitectures.md)

-   :material-book-open-variant:{ .lg .middle } __S04 · Modelo multidimensional__

    ---

    lu 02/11/2026 · RA3 c

    Prueba corta del RA1. Proceso de negocio, grano, hechos, medidas, dimensiones y claves subrogadas.

    [:octicons-arrow-right-24: Abrir la sesión](s04-model-multidimensional.md)

-   :material-book-open-variant:{ .lg .middle } __S05 · Práctica: OLTP y DDL__

    ---

    lu 09/11/2026 · RA3 a

    Montar el OLTP de compras y crear la estrella dw_compras con DDL.

    [:octicons-arrow-right-24: Abrir la sesión](s05-practica-ddl.md)

-   :material-book-open-variant:{ .lg .middle } __S06 · Práctica: carga del DW__

    ---

    lu 16/11/2026 · RA3 b, RA3 d

    Carga de dimensiones, validación de lookups, carga del hecho y conciliación.

    [:octicons-arrow-right-24: Abrir la sesión](s06-practica-carrega.md)

-   :material-book-open-variant:{ .lg .middle } __S07 · Práctica: SCD1 y DCL__

    ---

    lu 23/11/2026 · RA3 b, RA3 e

    MERGE y SCD tipo 1. Roles, permisos y Row Level Security.

    [:octicons-arrow-right-24: Abrir la sesión](s07-practica-scd-dcl.md)

-   :material-book-open-variant:{ .lg .middle } __S08 · Práctica: carga masiva__

    ---

    lu 30/11/2026 · RA3 f, RA2 c

    Escalado a 100.000 líneas. COPY y \copy frente a INSERT. SQL embebido en Python.

    [:octicons-arrow-right-24: Abrir la sesión](s08-practica-copy.md)

-   :material-book-open-variant:{ .lg .middle } __S09 · Práctica: benchmark y paralelismo__

    ---

    lu 14/12/2026 · RA2 d, RA2 e, RA3 g

    Filtros en origen, JOINs y EXPLAIN. Tabla particionada y carga paralela. Entrega del RA3.

    [:octicons-arrow-right-24: Abrir la sesión](s09-practica-benchmark.md)

-   :material-progress-pencil:{ .lg .middle } __S10 · MongoDB I__

    ---

    lu 21/12/2026 · RA4 a, RA4 b, RA4 c, RA5 b

    MongoDB local y en Atlas (nube). Acceso con mongosh, Compass y pymongo.

    [:octicons-arrow-right-24: Abrir la sesión](s10-mongodb-1.md)

-   :material-progress-pencil:{ .lg .middle } __S11 · MongoDB II__

    ---

    lu 11/01/2027 · RA4 d, RA5 c, RA5 d

    CRUD, aggregation pipeline, validación de esquema, índices y carga masiva (insertMany, bulkWrite, mongoimport).

    [:octicons-arrow-right-24: Abrir la sesión](s11-mongodb-2.md)

-   :material-progress-pencil:{ .lg .middle } __S12 · Elasticsearch__

    ---

    lu 18/01/2027 · RA4 c, RA4 d, RA5 c, RA5 d

    Índices, mappings, Query DSL, agregaciones y API _bulk. Demo: NiFi vs Logstash vs Filebeat.

    [:octicons-arrow-right-24: Abrir la sesión](s12-elasticsearch.md)

-   :material-progress-pencil:{ .lg .middle } __S13 · Seguridad y paralelismo NoSQL__

    ---

    lu 25/01/2027 · RA4 e, RA5 e, RA5 f

    Seguridad en Elastic (xpack, roles, API keys) y en MongoDB (autenticación, roles). Shards, réplicas y _bulk en paralelo. Prueba RA4 + RA5.

    [:octicons-arrow-right-24: Abrir la sesión](s13-nosql-seguretat.md)

-   :material-progress-pencil:{ .lg .middle } __S14 · Kibana__

    ---

    lu 01/02/2027 · Ampliación

    Data views, Lens y dashboards.

    [:octicons-arrow-right-24: Abrir la sesión](s14-kibana.md)

-   :material-progress-pencil:{ .lg .middle } __S15 · Power BI__

    ---

    lu 08/02/2027 · Ampliación

    Power BI conectado a dw_compras: Import vs DirectQuery, modelo estrella y medidas.

    [:octicons-arrow-right-24: Abrir la sesión](s15-powerbi.md)

-   :material-progress-pencil:{ .lg .middle } __S16 · Prueba final__

    ---

    lu 15/02/2027 · RA1, RA2 c-e, RA3, RA4, RA5

    Prueba práctica final de la parte de Jorge.

    [:octicons-arrow-right-24: Abrir la sesión](s16-prova.md)

</div>
