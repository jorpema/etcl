# Dimecres · Prof. 2

Apache NiFi des de zero, l'extracció i l'escriptura de fitxers, les bases de dades des de NiFi, les API REST, l'IoT, la web semàntica i el Big Data (HDFS i Spark).

**Resultats d'aprenentatge:** RA2 (a, b, f, g), RA5 a, RA6, RA7 i RA8.

<div class="grid cards" markdown>

-   :material-progress-pencil:{ .lg .middle } __D01 · NiFi: arquitectura i instal·lació__

    ---

    dc 07/10/2026 · RA6 a, RA6 b

    Què és NiFi, arquitectura (FlowFile, Processor, Connection, repositoris), interfície i instal·lació de NiFi 2.x amb Docker (HTTPS 8443).

    [:octicons-arrow-right-24: Obri la sessió](d01-nifi-intro.md)

-   :material-progress-pencil:{ .lg .middle } __D02 · NiFi: primer flux i FlowFiles__

    ---

    dc 14/10/2026 · RA6 a, RA7 a, RA7 b

    Primer flux GetFile → PutFile. FlowFiles: atributs i contingut.

    [:octicons-arrow-right-24: Obri la sessió](d02-nifi-flowfiles.md)

-   :material-progress-pencil:{ .lg .middle } __D03 · NiFi: processors i connexions__

    ---

    dc 21/10/2026 · RA6 d

    Processors i Expression Language, enrutament. Connections: backpressure i prioritzadors. Process groups i funnels.

    [:octicons-arrow-right-24: Obri la sessió](d03-nifi-processors.md)

-   :material-progress-pencil:{ .lg .middle } __D04 · NiFi: controller services i records__

    ---

    dc 28/10/2026 · RA6 c, RA6 d, RA7 c

    Controller Services: Record Readers i Writers. ConvertRecord (CSV ↔ JSON ↔ XML) i QueryRecord. Parameter Contexts.

    [:octicons-arrow-right-24: Obri la sessió](d04-nifi-controllers.md)

-   :material-progress-pencil:{ .lg .middle } __D05 · JSON i XML a fons__

    ---

    dc 04/11/2026 · RA6 c, RA6 d

    Aplanament de JSON (JoltTransformJSON, FlattenJson), XPath, XSLT i validació amb JSON Schema i XSD. Lectura amb Python des de NiFi.

    [:octicons-arrow-right-24: Obri la sessió](d05-json-xml.md)

-   :material-progress-pencil:{ .lg .middle } __D06 · Escriure i modificar fitxers__

    ---

    dc 11/11/2026 · RA7 c, RA7 d

    Generar, modificar i esborrar registres en fitxers (UpdateRecord, QueryRecord, PartitionRecord, MergeRecord) i amb un script Python.

    [:octicons-arrow-right-24: Obri la sessió](d06-fitxers-escriptura.md)

-   :material-progress-pencil:{ .lg .middle } __D07 · NiFi i bases de dades__

    ---

    dc 18/11/2026 · RA2 a, RA2 b

    DBCPConnectionPool amb PostgreSQL local i al núvol. ExecuteSQLRecord i QueryDatabaseTable incremental sobre l'OLTP de compres.

    [:octicons-arrow-right-24: Obri la sessió](d07-nifi-bd.md)

-   :material-progress-pencil:{ .lg .middle } __D08 · Diverses fonts alhora__

    ---

    dc 25/11/2026 · RA2 f

    Diverses fonts i destins alhora (PostgreSQL, CSV i API), LookupRecord i taules intermèdies. Demo d'ODI.

    [:octicons-arrow-right-24: Obri la sessió](d08-multifont.md)

-   :material-progress-pencil:{ .lg .middle } __D09 · API REST__

    ---

    dc 02/12/2026 · RA8 a, RA8 b

    InvokeHTTP, paginació, límits de peticions, reintents i Jolt. Open-Meteo, el-tiempo.net i Open Data GVA.

    [:octicons-arrow-right-24: Obri la sessió](d09-api-rest.md)

-   :material-progress-pencil:{ .lg .middle } __D10 · Confidencialitat__

    ---

    dc 09/12/2026 · RA7 e

    Xifratge (EncryptContentAge o EncryptContentPGP), hash i pseudonimització, RGPD i provenance. Lliurament RA6 + RA7.

    [:octicons-arrow-right-24: Obri la sessió](d10-confidencialitat.md)

-   :material-progress-pencil:{ .lg .middle } __D11 · HDFS__

    ---

    dc 16/12/2026 · RA6 e, RA7 f

    Escriptura distribuïda des de NiFi (PutHDFS i FetchHDFS) i particionat.

    [:octicons-arrow-right-24: Obri la sessió](d11-hdfs.md)

-   :material-progress-pencil:{ .lg .middle } __D12 · IoT i sensòrica__

    ---

    dc 13/01/2027 · RA8 e, RA8 f, RA1 b

    Raspberry Pi → MQTT (Mosquitto) → NiFi ConsumeMQTT → filtratge → PostgreSQL o fitxer. Alternatives: OPC UA simulat o una opció combinada.

    [:octicons-arrow-right-24: Obri la sessió](d12-iot.md)

-   :material-progress-pencil:{ .lg .middle } __D13 · NiFi cap a NoSQL__

    ---

    dc 20/01/2027 · RA5 a, RA4 a

    PutMongoRecord i PutElasticsearchRecord, amb càrrega periòdica.

    [:octicons-arrow-right-24: Obri la sessió](d13-nifi-nosql.md)

-   :material-progress-pencil:{ .lg .middle } __D14 · Web semàntica i SPARQL__

    ---

    dc 27/01/2027 · RA8 c, RA8 d

    RDF, OWL, SPARQL a Wikidata o DBpedia amb filtres en origen, des de NiFi i des de Python.

    [:octicons-arrow-right-24: Obri la sessió](d14-sparql.md)

-   :material-progress-pencil:{ .lg .middle } __D15 · Spark__

    ---

    dc 03/02/2027 · RA2 g, RA6 e, RA7 f, RA8 g

    PySpark: lectura JDBC particionada, CSV i JSON en paral·lel, Parquet particionat, WordCount o logs.

    [:octicons-arrow-right-24: Obri la sessió](d15-spark.md)

-   :material-progress-pencil:{ .lg .middle } __D16 · Integració i governança__

    ---

    dc 10/02/2027 · RA6 a, RA7 a

    Pipeline extrem a extrem: Parameter Contexts, NiFi Registry, tolerància a fallades i backpressure. Lliurament RA8.

    [:octicons-arrow-right-24: Obri la sessió](d16-integracio.md)

-   :material-progress-pencil:{ .lg .middle } __D17 · Prova final__

    ---

    dc 17/02/2027 · RA2 a,b,f,g, RA6, RA7, RA8

    Prova pràctica final de la part de Prof. 2.

    [:octicons-arrow-right-24: Obri la sessió](d17-prova.md)

</div>
