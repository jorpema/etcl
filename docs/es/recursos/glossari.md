# Glosario

Los términos marcados con :material-dots-horizontal: en cualquier página de la web muestran esta definición si pasas el ratón por encima.

## Proceso ETL

ETL
:   *Extract, Transform, Load*. Proceso que extrae datos de las fuentes, los transforma y los carga en un destino.

ELT
:   Variante en la que primero se cargan los datos en el destino y la transformación se hace allí, normalmente con SQL.

Staging (área intermedia)
:   Zona donde se dejan los datos tal como llegan de la fuente, antes de transformarlos.

Pipeline
:   Cadena de pasos automatizados por donde circulan los datos, desde la fuente hasta el destino.

Provenance (procedencia)
:   Registro de por dónde ha pasado cada dato y qué se le ha hecho. NiFi lo guarda automáticamente.

## Bases de datos y modelado

OLTP
:   Base de datos operacional, normalizada, pensada para muchas transacciones pequeñas (altas, modificaciones). Ejemplo: el programa de facturación.

OLAP
:   Modelo orientado al análisis: pocas escrituras y consultas que agregan muchos registros.

Data warehouse (DW)
:   Almacén de datos integrado e histórico, pensado para el análisis.

Data mart
:   Subconjunto del DW de un solo departamento o proceso (por ejemplo, compras).

Data lake
:   Repositorio que guarda datos en crudo, en su formato original, a bajo coste.

Hecho (tabla de hechos)
:   Tabla central del modelo en estrella. Cada fila es un evento medible y contiene las **medidas** (cantidad, importe…).

Dimensión
:   Tabla que da contexto al hecho: quién, qué, cuándo, dónde, cómo.

Grano
:   Qué representa **exactamente** una fila de la tabla de hechos. Ejemplo: «una línea de producto de una factura».

Clave subrogada (SK)
:   Identificador interno del DW, independiente de la clave del origen. Permite integrar varias fuentes y guardar el histórico.

Clave de negocio
:   Identificador que viene del sistema origen (por ejemplo, `id_proveedor` del OLTP).

SCD
:   *Slowly Changing Dimension*. Estrategia para cuando cambia un atributo de una dimensión. **Tipo 1:** se sobrescribe. **Tipo 2:** se crea una fila nueva y se guarda el histórico.

Esquema en estrella / en copo de nieve
:   En estrella, las dimensiones están desnormalizadas y conectan directamente con el hecho. En copo de nieve, las dimensiones se normalizan en varias tablas.

ACID
:   Garantías de las transacciones: atomicidad, consistencia, aislamiento y durabilidad.

Teorema CAP
:   En un sistema distribuido solo se pueden garantizar dos de estas tres propiedades: consistencia, disponibilidad y tolerancia a particiones.

## Lenguajes SQL

DDL · DML · DCL · DQL
:   Definición (`CREATE`, `ALTER`), manipulación (`INSERT`, `UPDATE`, `DELETE`, `MERGE`), control de permisos (`GRANT`, `REVOKE`) y consulta (`SELECT`).

## Fuentes y formatos

Datos estructurados / semiestructurados / no estructurados
:   Con un esquema fijo (tablas), con una estructura flexible (JSON, XML) o sin estructura predefinida (texto libre, imágenes, audio).

Datos formales / no formales
:   Generados por sistemas oficiales con validación estricta, o generados por personas sin control (tuits, comentarios, fotos).

CSV · JSON · XML
:   Formatos de texto para intercambiar datos: tabla plana, objetos anidados y etiquetas anidadas.

Parquet
:   Formato binario **columnar** y comprimido, muy usado en Big Data: lee solo las columnas que necesitas.

API REST
:   Servicio web que devuelve datos (normalmente en JSON) cuando le haces una petición HTTP a una URL.

SCADA
:   Sistema industrial que supervisa sensores y máquinas y guarda sus lecturas.

MQTT
:   Protocolo ligero de mensajería (publicar/suscribir) muy usado en IoT.

## Paralelismo y Big Data

SMP
:   Varios procesadores en **un solo servidor** que comparten la memoria.

MPP
:   **Muchos servidores** (nodos) independientes que se reparten los datos y trabajan en paralelo.

Data locality (procesar cerca de los datos)
:   Enviar el cálculo donde están los datos, en lugar de mover los datos donde está el cálculo.

Edge computing
:   Procesar, filtrar o agregar los datos en el propio dispositivo o en un *gateway* local antes de enviarlos a la nube.

HDFS
:   Sistema de ficheros distribuido de Hadoop: divide los ficheros en bloques y los replica en varios nodos.
