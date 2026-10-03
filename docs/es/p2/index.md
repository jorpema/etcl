# Miércoles · Rafa Vidal Semper

Apache NiFi desde cero, la extracción y escritura de ficheros, las bases de datos desde NiFi, las API REST, el IoT, la web semántica y el Big Data (HDFS y Spark).

**Resultados de aprendizaje:** RA2 (a, b, f, g), RA5 a, RA6, RA7 y RA8.

<div class="grid cards" markdown>

-   :material-progress-pencil:{ .lg .middle } __D01 · NiFi: arquitectura e instalación__

    ---

    mi 07/10/2026 · RA6 a, RA6 b

    Qué es NiFi, arquitectura (FlowFile, Processor, Connection, repositorios), interfaz e instalación de NiFi 2.x con Docker (HTTPS 8443).

    [:octicons-arrow-right-24: Abrir la sesión](d01-nifi-intro.md)

-   :material-progress-pencil:{ .lg .middle } __D02 · NiFi: primer flujo y FlowFiles__

    ---

    mi 14/10/2026 · RA6 a, RA7 a, RA7 b

    Primer flujo GetFile → PutFile. FlowFiles: atributos y contenido.

    [:octicons-arrow-right-24: Abrir la sesión](d02-nifi-flowfiles.md)

-   :material-progress-pencil:{ .lg .middle } __D03 · NiFi: processors y conexiones__

    ---

    mi 21/10/2026 · RA6 d

    Processors y Expression Language, enrutamiento. Connections: backpressure y priorizadores. Process groups y funnels.

    [:octicons-arrow-right-24: Abrir la sesión](d03-nifi-processors.md)

-   :material-progress-pencil:{ .lg .middle } __D04 · NiFi: controller services y records__

    ---

    mi 28/10/2026 · RA6 c, RA6 d, RA7 c

    Controller Services: Record Readers y Writers. ConvertRecord (CSV ↔ JSON ↔ XML) y QueryRecord. Parameter Contexts.

    [:octicons-arrow-right-24: Abrir la sesión](d04-nifi-controllers.md)

-   :material-progress-pencil:{ .lg .middle } __D05 · JSON y XML a fondo__

    ---

    mi 04/11/2026 · RA6 c, RA6 d

    Aplanamiento de JSON (JoltTransformJSON, FlattenJson), XPath, XSLT y validación con JSON Schema y XSD. Lectura con Python desde NiFi.

    [:octicons-arrow-right-24: Abrir la sesión](d05-json-xml.md)

-   :material-progress-pencil:{ .lg .middle } __D06 · Escribir y modificar ficheros__

    ---

    mi 11/11/2026 · RA7 c, RA7 d

    Generar, modificar y borrar registros en ficheros (UpdateRecord, QueryRecord, PartitionRecord, MergeRecord) y con un script Python.

    [:octicons-arrow-right-24: Abrir la sesión](d06-fitxers-escriptura.md)

-   :material-progress-pencil:{ .lg .middle } __D07 · NiFi y bases de datos__

    ---

    mi 18/11/2026 · RA2 a, RA2 b

    DBCPConnectionPool con PostgreSQL local y en la nube. ExecuteSQLRecord y QueryDatabaseTable incremental sobre el OLTP de compras.

    [:octicons-arrow-right-24: Abrir la sesión](d07-nifi-bd.md)

-   :material-progress-pencil:{ .lg .middle } __D08 · Varias fuentes a la vez__

    ---

    mi 25/11/2026 · RA2 f

    Varias fuentes y destinos a la vez (PostgreSQL, CSV y API), LookupRecord y tablas intermedias. Demo de ODI.

    [:octicons-arrow-right-24: Abrir la sesión](d08-multifont.md)

-   :material-progress-pencil:{ .lg .middle } __D09 · API REST__

    ---

    mi 02/12/2026 · RA8 a, RA8 b

    InvokeHTTP, paginación, límites de peticiones, reintentos y Jolt. Open-Meteo, el-tiempo.net y Open Data GVA.

    [:octicons-arrow-right-24: Abrir la sesión](d09-api-rest.md)

-   :material-progress-pencil:{ .lg .middle } __D10 · Confidencialidad__

    ---

    mi 09/12/2026 · RA7 e

    Cifrado (EncryptContentAge o EncryptContentPGP), hash y seudonimización, RGPD y provenance. Entrega RA6 + RA7.

    [:octicons-arrow-right-24: Abrir la sesión](d10-confidencialitat.md)

-   :material-progress-pencil:{ .lg .middle } __D11 · HDFS__

    ---

    mi 16/12/2026 · RA6 e, RA7 f

    Escritura distribuida desde NiFi (PutHDFS y FetchHDFS) y particionado.

    [:octicons-arrow-right-24: Abrir la sesión](d11-hdfs.md)

-   :material-progress-pencil:{ .lg .middle } __D12 · IoT y sensórica__

    ---

    mi 13/01/2027 · RA8 e, RA8 f, RA1 b

    Raspberry Pi → MQTT (Mosquitto) → NiFi ConsumeMQTT → filtrado → PostgreSQL o fichero. Alternativas: OPC UA simulado o una opción combinada.

    [:octicons-arrow-right-24: Abrir la sesión](d12-iot.md)

-   :material-progress-pencil:{ .lg .middle } __D13 · NiFi hacia NoSQL__

    ---

    mi 20/01/2027 · RA5 a, RA4 a

    PutMongoRecord y PutElasticsearchRecord, con carga periódica.

    [:octicons-arrow-right-24: Abrir la sesión](d13-nifi-nosql.md)

-   :material-progress-pencil:{ .lg .middle } __D14 · Web semántica y SPARQL__

    ---

    mi 27/01/2027 · RA8 c, RA8 d

    RDF, OWL, SPARQL en Wikidata o DBpedia con filtros en origen, desde NiFi y desde Python.

    [:octicons-arrow-right-24: Abrir la sesión](d14-sparql.md)

-   :material-progress-pencil:{ .lg .middle } __D15 · Spark__

    ---

    mi 03/02/2027 · RA2 g, RA6 e, RA7 f, RA8 g

    PySpark: lectura JDBC particionada, CSV y JSON en paralelo, Parquet particionado, WordCount o logs.

    [:octicons-arrow-right-24: Abrir la sesión](d15-spark.md)

-   :material-progress-pencil:{ .lg .middle } __D16 · Integración y gobernanza__

    ---

    mi 10/02/2027 · RA6 a, RA7 a

    Pipeline de extremo a extremo: Parameter Contexts, NiFi Registry, tolerancia a fallos y backpressure. Entrega RA8.

    [:octicons-arrow-right-24: Abrir la sesión](d16-integracio.md)

-   :material-progress-pencil:{ .lg .middle } __D17 · Prueba final__

    ---

    mi 17/02/2027 · RA2 a,b,f,g, RA6, RA7, RA8

    Prueba práctica final de la parte de Rafa.

    [:octicons-arrow-right-24: Abrir la sesión](d17-prova.md)

</div>
