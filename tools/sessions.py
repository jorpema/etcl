"""Dades del calendari del mòdul 5104 · font única per a les dues llengües.

Cada sessió té camps comuns i un bloc per idioma ("ca" i "es").
Executa `python tools/genera.py` per regenerar calendari, índexs, RA/CA
i les fitxes que encara no existeixen (en totes dues llengües).
"""

W = "https://alapvi.github.io/sbd/"

PROFES = {
    "p1": {"nom": "Jorge Penalba Mateu", "curt": "Jorge", "dia": {"ca": "dilluns", "es": "lunes"}},
    "p2": {"nom": "Rafa Vidal Semper", "curt": "Rafa", "dia": {"ca": "dimecres", "es": "miércoles"}},
}


def S(file, date, ras, web=(), estat="plantilla", **lang):
    return dict(file=file, date=date, ras=list(ras), web=list(web), estat=estat, **lang)


def L(title, cont, prac="", aules=(), nou=()):
    return dict(title=title, cont=cont, prac=prac, aules=list(aules), nou=list(nou))


P1 = [
    S("s01-tipus-dades", "2026-10-05", ["RA1 a", "RA1 b"],
      [("Introducción a BI · Visión general", "ingenieria-datos/ud1-introduccion/"), ("Tipos de datos", "ingenieria-datos/ud1-introduccion/tipos-de-datos/")],
      "redactada",
      ca=L("Tipus de dades i fonts", "Presentació. Fonts de dades segons l'origen, la naturalesa, la formalitat, la ubicació i la distribució física.", "Classificació de fonts reals i exercicis del tema."),
      es=L("Tipos de datos y fuentes", "Presentación. Fuentes de datos según su origen, naturaleza, formalidad, ubicación y distribución física.", "Clasificación de fuentes reales y ejercicios del tema.")),
    S("s02-gestors-formats", "2026-10-19", ["RA1 c", "RA1 d", "RA1 e", "RA1 f"],
      [("NoSQL", "nosql/nosql/"), ("Modelos de datos", "nosql/moddatos/"), ("Consistencia", "nosql/consistencia/")], "redactada",
      ca=L("Gestors i formats", "SGBD SQL i NoSQL, teorema CAP. Formats d'intercanvi (CSV, JSON, XML, Parquet). Dades no estructurades i web semàntica. Dades SCADA/IoT.", "Conversió de formats i exercicis del tema."),
      es=L("Gestores y formatos", "SGBD SQL y NoSQL, teorema CAP. Formatos de intercambio (CSV, JSON, XML, Parquet). Datos no estructurados y web semántica. Datos SCADA/IoT.", "Conversión de formatos y ejercicios del tema.")),
    S("s03-entorns-arquitectures", "2026-10-26", ["RA1 g", "RA1 h", "RA3 c"],
      [("Tipos de entornos y arquitectura de datos", "ingenieria-datos/tipos-entornos-arquitecturas/"), ("Big Data", "ingenieria-datos/bigdata/")], "redactada",
      ca=L("Entorns i arquitectures", "On-premise i núvol. Staging, ODS, DW, data mart, data lake i arquitectura medallion. SMP, MPP i edge computing. OLTP vs OLAP.", "Decisions d'arquitectura i exercicis del tema."),
      es=L("Entornos y arquitecturas", "On-premise y nube. Staging, ODS, DW, data mart, data lake y arquitectura medallion. SMP, MPP y edge computing. OLTP vs OLAP.", "Decisiones de arquitectura y ejercicios del tema.")),
    S("s04-model-multidimensional", "2026-11-02", ["RA3 c"],
      [("Modelos multidimensionales", "ingenieria-datos/modelos-multidimensionales/")], "redactada",
      ca=L("Model multidimensional", "Prova curta del RA1. Procés de negoci, grànul, fets, mesures, dimensions i claus subrogades.", "Disseny en paper del model de compres."),
      es=L("Modelo multidimensional", "Prueba corta del RA1. Proceso de negocio, grano, hechos, medidas, dimensiones y claves subrogadas.", "Diseño en papel del modelo de compras.")),
    S("s05-practica-ddl", "2026-11-09", ["RA3 a"], [], "redactada",
      ca=L("Pràctica: OLTP i DDL", "Muntar l'OLTP de compres i crear l'estrella dw_compras amb DDL."),
      es=L("Práctica: OLTP y DDL", "Montar el OLTP de compras y crear la estrella dw_compras con DDL.")),
    S("s06-practica-carrega", "2026-11-16", ["RA3 b", "RA3 d"], [], "redactada",
      ca=L("Pràctica: càrrega del DW", "Càrrega de dimensions, validació de lookups, càrrega del fet i reconciliació."),
      es=L("Práctica: carga del DW", "Carga de dimensiones, validación de lookups, carga del hecho y conciliación.")),
    S("s07-practica-scd-dcl", "2026-11-23", ["RA3 b", "RA3 e"], [], "redactada",
      ca=L("Pràctica: SCD1 i DCL", "MERGE i SCD tipus 1. Rols, permisos i Row Level Security."),
      es=L("Práctica: SCD1 y DCL", "MERGE y SCD tipo 1. Roles, permisos y Row Level Security.")),
    S("s08-practica-copy", "2026-11-30", ["RA3 f", "RA2 c"], [], "redactada",
      ca=L("Pràctica: càrrega massiva", "Escalat a 100.000 línies. COPY i \\copy davant d'INSERT. SQL embegut en Python."),
      es=L("Práctica: carga masiva", "Escalado a 100.000 líneas. COPY y \\copy frente a INSERT. SQL embebido en Python.")),
    S("s09-practica-benchmark", "2026-12-14", ["RA2 d", "RA2 e", "RA3 g"], [], "redactada",
      ca=L("Pràctica: benchmark i paral·lelisme", "Filtres en origen, JOINs i EXPLAIN. Taula particionada i càrrega paral·lela. Lliurament del RA3."),
      es=L("Práctica: benchmark y paralelismo", "Filtros en origen, JOINs y EXPLAIN. Tabla particionada y carga paralela. Entrega del RA3.")),
    S("s10-mongodb-1", "2026-12-21", ["RA4 a", "RA4 b", "RA4 c", "RA5 b"],
      [("Introducción a MongoDB", "mongodb/intromongo/"), ("MongoDB", "mongodb/mongodb/"), ("Instalación", "mongodb/instalacion/"), ("Primeros pasos", "mongodb/basicsmongo/")],
      ca=L("MongoDB I", "MongoDB local i a Atlas (núvol). Accés amb mongosh, Compass i pymongo.", "Connexió local i al núvol, i consultes find amb filtres i projeccions.", ["MongoDB.pptx", "Presentacio_Intro_noSQL.pptx"]),
      es=L("MongoDB I", "MongoDB local y en Atlas (nube). Acceso con mongosh, Compass y pymongo.", "Conexión local y en la nube, y consultas find con filtros y proyecciones.", ["MongoDB.pptx", "Presentacio_Intro_noSQL.pptx"])),
    S("s11-mongodb-2", "2027-01-11", ["RA4 d", "RA5 c", "RA5 d"],
      [("Operaciones CRUD", "mongodb/mongodbcrud/"), ("Consulta de datos", "mongodb/mongodbdatos/"), ("Diseño de modelado", "mongodb/modelado/")],
      ca=L("MongoDB II", "CRUD, aggregation pipeline, validació d'esquema, índexs i càrrega massiva (insertMany, bulkWrite, mongoimport).", "Carregar un dataset i fer consultes d'agregació.", ["MongoDB.pptx"]),
      es=L("MongoDB II", "CRUD, aggregation pipeline, validación de esquema, índices y carga masiva (insertMany, bulkWrite, mongoimport).", "Cargar un dataset y hacer consultas de agregación.", ["MongoDB.pptx"])),
    S("s12-elasticsearch", "2027-01-18", ["RA4 c", "RA4 d", "RA5 c", "RA5 d"],
      [("Elastic · Introducción", "elastic/elastic_intro/"), ("Elastic · Operaciones", "elastic/elastic_ops/")],
      ca=L("Elasticsearch", "Índexs, mappings, Query DSL, agregacions i API _bulk. Demo: NiFi vs Logstash vs Filebeat.", "Indexar un CSV amb _bulk i fer cerques de text complet.", ["Elasticsearch.pptx", "Explorar Elasticsearch.docx", "Pràctica ElasticSearch.docx", "CheatSheet ElasticSearch.docx"]),
      es=L("Elasticsearch", "Índices, mappings, Query DSL, agregaciones y API _bulk. Demo: NiFi vs Logstash vs Filebeat.", "Indexar un CSV con _bulk y hacer búsquedas de texto completo.", ["Elasticsearch.pptx", "Explorar Elasticsearch.docx", "Pràctica ElasticSearch.docx", "CheatSheet ElasticSearch.docx"])),
    S("s13-nosql-seguretat", "2027-01-25", ["RA4 e", "RA5 e", "RA5 f"], [("Elastic · Ampliación", "elastic/ampliacion/")],
      ca=L("Seguretat i paral·lelisme NoSQL", "Seguretat en Elastic (xpack, rols, API keys) i en MongoDB (autenticació, rols). Shards, rèpliques i _bulk en paral·lel. Prova RA4 + RA5.", "Crear rols de només lectura i mesurar càrregues paral·leles.", [], ["Guió de seguretat NoSQL"]),
      es=L("Seguridad y paralelismo NoSQL", "Seguridad en Elastic (xpack, roles, API keys) y en MongoDB (autenticación, roles). Shards, réplicas y _bulk en paralelo. Prueba RA4 + RA5.", "Crear roles de solo lectura y medir cargas paralelas.", [], ["Guion de seguridad NoSQL"])),
    S("s14-kibana", "2027-02-01", ["Ampliació"], [("Kibana", "elastic/kibana/"), ("Caso de uso", "elastic/caso_uso/"), ("Dashboards Covid", "elastic/dashboards/")],
      ca=L("Kibana", "Data views, Lens i dashboards.", "Dashboard sobre un índex propi."),
      es=L("Kibana", "Data views, Lens y dashboards.", "Dashboard sobre un índice propio.")),
    S("s15-powerbi", "2027-02-08", ["Ampliació"], [],
      ca=L("Power BI", "Power BI connectat a dw_compras: Import vs DirectQuery, model estrella i mesures.", "Informe de compres.", ["Power BI ( Jorge ).pptx", "Power BI.pptx", "BigData - Power BI.pdf", "Visualitzacions.pptx"]),
      es=L("Power BI", "Power BI conectado a dw_compras: Import vs DirectQuery, modelo estrella y medidas.", "Informe de compras.", ["Power BI ( Jorge ).pptx", "Power BI.pptx", "BigData - Power BI.pdf", "Visualitzacions.pptx"])),
    S("s16-prova", "2027-02-15", ["RA1", "RA2 c-e", "RA3", "RA4", "RA5"], [],
      ca=L("Prova final", "Prova pràctica final de la part de Jorge.", "", [], ["Enunciat i rúbrica"]),
      es=L("Prueba final", "Prueba práctica final de la parte de Jorge.", "", [], ["Enunciado y rúbrica"])),
]

P2 = [
    S("d01-nifi-intro", "2026-10-07", ["RA6 a", "RA6 b"],
      [("Introducción", "nifi/introduccion_nifi/"), ("Arquitectura", "nifi/arquitectura/"), ("Interfaz gráfica", "nifi/interfaz/"), ("Instalación y despliegue", "nifi/instalacion/")],
      ca=L("NiFi: arquitectura i instal·lació", "Què és NiFi, arquitectura (FlowFile, Processor, Connection, repositoris), interfície i instal·lació de NiFi 2.x amb Docker (HTTPS 8443).", "Instal·lar NiFi i entrar a la interfície.", ["NiFi.pptx (cal passar-lo a NiFi 2.x)"]),
      es=L("NiFi: arquitectura e instalación", "Qué es NiFi, arquitectura (FlowFile, Processor, Connection, repositorios), interfaz e instalación de NiFi 2.x con Docker (HTTPS 8443).", "Instalar NiFi y entrar en la interfaz.", ["NiFi.pptx (hay que pasarlo a NiFi 2.x)"])),
    S("d02-nifi-flowfiles", "2026-10-14", ["RA6 a", "RA7 a", "RA7 b"],
      [("Primer flujo de datos", "nifi/primerflujo/"), ("Flowfiles", "nifi/flowfiles/")],
      ca=L("NiFi: primer flux i FlowFiles", "Primer flux GetFile → PutFile. FlowFiles: atributs i contingut.", "Moure fitxers d'un origen a un destí.", ["BigData - NiFi - Práctica 1", "BigData - NiFi - Práctica 2"]),
      es=L("NiFi: primer flujo y FlowFiles", "Primer flujo GetFile → PutFile. FlowFiles: atributos y contenido.", "Mover ficheros de un origen a un destino.", ["BigData - NiFi - Práctica 1", "BigData - NiFi - Práctica 2"])),
    S("d03-nifi-processors", "2026-10-21", ["RA6 d"], [("Processors", "nifi/processors/"), ("Connections", "nifi/connections/")],
      ca=L("NiFi: processors i connexions", "Processors i Expression Language, enrutament. Connections: backpressure i prioritzadors. Process groups i funnels.", "Filtrar i enrutar fitxers segons els atributs i el contingut.", ["BigData - NiFi - Práctica 3", "BigData - NiFi - Práctica 4", "BigData - NiFi - Práctica 6"]),
      es=L("NiFi: processors y conexiones", "Processors y Expression Language, enrutamiento. Connections: backpressure y priorizadores. Process groups y funnels.", "Filtrar y enrutar ficheros según los atributos y el contenido.", ["BigData - NiFi - Práctica 3", "BigData - NiFi - Práctica 4", "BigData - NiFi - Práctica 6"])),
    S("d04-nifi-controllers", "2026-10-28", ["RA6 c", "RA6 d", "RA7 c"],
      [("Controllers · Introducción", "nifi/controllers/01-introduccion/"), ("Controllers · Configuración", "nifi/controllers/02-configuracion/"), ("Controllers · Servicios", "nifi/controllers/03-principales-controller-services/")],
      ca=L("NiFi: controller services i records", "Controller Services: Record Readers i Writers. ConvertRecord (CSV ↔ JSON ↔ XML) i QueryRecord. Parameter Contexts.", "Convertir formats i fer consultes SQL sobre records.", ["BigData - NiFi - Práctica 7", "P10. Transformant dades amb Nifi"]),
      es=L("NiFi: controller services y records", "Controller Services: Record Readers y Writers. ConvertRecord (CSV ↔ JSON ↔ XML) y QueryRecord. Parameter Contexts.", "Convertir formatos y hacer consultas SQL sobre records.", ["BigData - NiFi - Práctica 7", "P10. Transformant dades amb Nifi"])),
    S("d05-json-xml", "2026-11-04", ["RA6 c", "RA6 d"], [],
      ca=L("JSON i XML a fons", "Aplanament de JSON (JoltTransformJSON, FlattenJson), XPath, XSLT i validació amb JSON Schema i XSD. Lectura amb Python des de NiFi.", "Aplanar estructures niades i validar-les.", [], ["Material nou"]),
      es=L("JSON y XML a fondo", "Aplanamiento de JSON (JoltTransformJSON, FlattenJson), XPath, XSLT y validación con JSON Schema y XSD. Lectura con Python desde NiFi.", "Aplanar estructuras anidadas y validarlas.", [], ["Material nuevo"])),
    S("d06-fitxers-escriptura", "2026-11-11", ["RA7 c", "RA7 d"], [],
      ca=L("Escriure i modificar fitxers", "Generar, modificar i esborrar registres en fitxers (UpdateRecord, QueryRecord, PartitionRecord, MergeRecord) i amb un script Python.", "Mantindre un fitxer mestre actualitzat.", [], ["Material nou"]),
      es=L("Escribir y modificar ficheros", "Generar, modificar y borrar registros en ficheros (UpdateRecord, QueryRecord, PartitionRecord, MergeRecord) y con un script Python.", "Mantener un fichero maestro actualizado.", [], ["Material nuevo"])),
    S("d07-nifi-bd", "2026-11-18", ["RA2 a", "RA2 b"], [("Controllers · Arquitecturas", "nifi/controllers/04-arquitecturas/"), ("Casos de uso (Lab 1)", "nifi/casos_de_uso/")],
      ca=L("NiFi i bases de dades", "DBCPConnectionPool amb PostgreSQL local i al núvol. ExecuteSQLRecord i QueryDatabaseTable incremental sobre l'OLTP de compres.", "Extracció incremental de l'OLTP.", ["nifiCasoUsoPostgreSQL", "PostgreSQL per a Big Data.docx", "P11. Cas d'ús ETL amb NiFi"]),
      es=L("NiFi y bases de datos", "DBCPConnectionPool con PostgreSQL local y en la nube. ExecuteSQLRecord y QueryDatabaseTable incremental sobre el OLTP de compras.", "Extracción incremental del OLTP.", ["nifiCasoUsoPostgreSQL", "PostgreSQL per a Big Data.docx", "P11. Cas d'ús ETL amb NiFi"])),
    S("d08-multifont", "2026-11-25", ["RA2 f"], [],
      ca=L("Diverses fonts alhora", "Diverses fonts i destins alhora (PostgreSQL, CSV i API), LookupRecord i taules intermèdies. Demo d'ODI.", "Pipeline amb enriquiment i staging.", ["P12. el-tiempo.net", "Oracle Data Integrator.pptx"]),
      es=L("Varias fuentes a la vez", "Varias fuentes y destinos a la vez (PostgreSQL, CSV y API), LookupRecord y tablas intermedias. Demo de ODI.", "Pipeline con enriquecimiento y staging.", ["P12. el-tiempo.net", "Oracle Data Integrator.pptx"])),
    S("d09-api-rest", "2026-12-02", ["RA8 a", "RA8 b"], [],
      ca=L("API REST", "InvokeHTTP, paginació, límits de peticions, reintents i Jolt. Open-Meteo, el-tiempo.net i Open Data GVA.", "Ingesta periòdica d'una API.", ["nifiCasoUsoAPI", "nifiCasoUsoMeteo", "Consulta d'una API amb Nifi.docx", "Exercici de consulta d'una API.docx"]),
      es=L("API REST", "InvokeHTTP, paginación, límites de peticiones, reintentos y Jolt. Open-Meteo, el-tiempo.net y Open Data GVA.", "Ingesta periódica de una API.", ["nifiCasoUsoAPI", "nifiCasoUsoMeteo", "Consulta d'una API amb Nifi.docx", "Exercici de consulta d'una API.docx"])),
    S("d10-confidencialitat", "2026-12-09", ["RA7 e"], [],
      ca=L("Confidencialitat", "Xifratge (EncryptContentAge o EncryptContentPGP), hash i pseudonimització, RGPD i provenance. Lliurament RA6 + RA7.", "Pseudonimitzar dades personals en un pipeline.", [], ["Material nou"]),
      es=L("Confidencialidad", "Cifrado (EncryptContentAge o EncryptContentPGP), hash y seudonimización, RGPD y provenance. Entrega RA6 + RA7.", "Seudonimizar datos personales en un pipeline.", [], ["Material nuevo"])),
    S("d11-hdfs", "2026-12-16", ["RA6 e", "RA7 f"], [],
      ca=L("HDFS", "Escriptura distribuïda des de NiFi (PutHDFS i FetchHDFS) i particionat.", "Bolcat de fitxers a HDFS i retorn.", ["nifiCasoUsoHadoop", "NiFi - Lectura fitxers filesystem i volcat a hdfs.docx", "Big Data Aplicat P1–P5"]),
      es=L("HDFS", "Escritura distribuida desde NiFi (PutHDFS y FetchHDFS) y particionado.", "Volcado de ficheros a HDFS y vuelta.", ["nifiCasoUsoHadoop", "NiFi - Lectura fitxers filesystem i volcat a hdfs.docx", "Big Data Aplicat P1–P5"])),
    S("d12-iot", "2027-01-13", ["RA8 e", "RA8 f", "RA1 b"], [],
      ca=L("IoT i sensòrica", "Raspberry Pi → MQTT (Mosquitto) → NiFi ConsumeMQTT → filtratge → PostgreSQL o fitxer. Alternatives: OPC UA simulat o una opció combinada.", "Captura de la sensòrica del centre.", ["Big Data Aplicat · Azure, pràctiques 2.1–2.4"], ["Material nou"]),
      es=L("IoT y sensórica", "Raspberry Pi → MQTT (Mosquitto) → NiFi ConsumeMQTT → filtrado → PostgreSQL o fichero. Alternativas: OPC UA simulado o una opción combinada.", "Captura de la sensórica del centro.", ["Big Data Aplicat · Azure, prácticas 2.1–2.4"], ["Material nuevo"])),
    S("d13-nifi-nosql", "2027-01-20", ["RA5 a", "RA4 a"], [("Casos de uso (Lab 2)", "nifi/casos_de_uso/")],
      ca=L("NiFi cap a NoSQL", "PutMongoRecord i PutElasticsearchRecord, amb càrrega periòdica.", "Open-Meteo → MongoDB i Elasticsearch.", ["nifiCasoUsoMongoDB"]),
      es=L("NiFi hacia NoSQL", "PutMongoRecord y PutElasticsearchRecord, con carga periódica.", "Open-Meteo → MongoDB y Elasticsearch.", ["nifiCasoUsoMongoDB"])),
    S("d14-sparql", "2027-01-27", ["RA8 c", "RA8 d"], [],
      ca=L("Web semàntica i SPARQL", "RDF, OWL, SPARQL a Wikidata o DBpedia amb filtres en origen, des de NiFi i des de Python.", "Consultes SPARQL exportades a CSV.", [], ["Material nou"]),
      es=L("Web semántica y SPARQL", "RDF, OWL, SPARQL en Wikidata o DBpedia con filtros en origen, desde NiFi y desde Python.", "Consultas SPARQL exportadas a CSV.", [], ["Material nuevo"])),
    S("d15-spark", "2027-02-03", ["RA2 g", "RA6 e", "RA7 f", "RA8 g"], [],
      ca=L("Spark", "PySpark: lectura JDBC particionada, CSV i JSON en paral·lel, Parquet particionat, WordCount o logs.", "Pipeline paral·lel sobre compres.", ["Big Data Aplicat: 6. SPARK, P14, P15"]),
      es=L("Spark", "PySpark: lectura JDBC particionada, CSV y JSON en paralelo, Parquet particionado, WordCount o logs.", "Pipeline paralelo sobre compras.", ["Big Data Aplicat: 6. SPARK, P14, P15"])),
    S("d16-integracio", "2027-02-10", ["RA6 a", "RA7 a"], [("Controllers · Arquitecturas", "nifi/controllers/04-arquitecturas/")],
      ca=L("Integració i governança", "Pipeline extrem a extrem: Parameter Contexts, NiFi Registry, tolerància a fallades i backpressure. Lliurament RA8.", "Pipeline complet versionat."),
      es=L("Integración y gobernanza", "Pipeline de extremo a extremo: Parameter Contexts, NiFi Registry, tolerancia a fallos y backpressure. Entrega RA8.", "Pipeline completo versionado.")),
    S("d17-prova", "2027-02-17", ["RA2 a,b,f,g", "RA6", "RA7", "RA8"], [],
      ca=L("Prova final", "Prova pràctica final de la part de Rafa.", "", [], ["Enunciat i rúbrica"]),
      es=L("Prueba final", "Prueba práctica final de la parte de Rafa.", "", [], ["Enunciado y rúbrica"])),
]

FESTIUS = [
    ("2026-10-12", {"ca": "Festa Nacional d'Espanya", "es": "Fiesta Nacional de España"}),
    ("2026-12-07", {"ca": "Pont de la Constitució", "es": "Puente de la Constitución"}),
    ("2026-12-23", {"ca": "Vacances de Nadal", "es": "Vacaciones de Navidad"}),
    ("2026-12-28", {"ca": "Vacances de Nadal", "es": "Vacaciones de Navidad"}),
    ("2026-12-30", {"ca": "Vacances de Nadal", "es": "Vacaciones de Navidad"}),
    ("2027-01-04", {"ca": "Vacances de Nadal", "es": "Vacaciones de Navidad"}),
    ("2027-01-06", {"ca": "Reis", "es": "Reyes"}),
]
