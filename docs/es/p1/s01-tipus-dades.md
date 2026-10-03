# S01 · Tipos de datos y fuentes

<div class="sessio-meta" markdown>
<span><strong>Fecha</strong> lu 05/10/2026</span>
<span><strong>Duración</strong> 3 h 40 min</span>
<span><span class="tag p1">Jorge · lunes</span></span>
<span><strong>RA·CA</strong> <span class="ra">RA1 a</span> <span class="ra">RA1 b</span></span>
</div>

!!! abstract "Qué trabajaremos"
    Antes de conectarnos a ninguna fuente tenemos que saber **qué tenemos delante**: de dónde viene el dato, qué naturaleza tiene, si es fiable, dónde está guardado y cómo está repartido. Todas las decisiones de una ETL (qué herramienta, qué conector, qué formato de destino, cuánta limpieza hará falta) dependen de estas respuestas.

## Objetivos

- **RA1.a** · Determinar la ubicación de las fuentes de datos, clasificando el formato en que se encuentran almacenadas, la ubicación (local o nube) y su distribución física.
- **RA1.b** · Clasificar las fuentes según su origen (sistemas gestores, IoT, streaming, API…), según su naturaleza (estructuradas o no) y según sean formales o no formales (audios, imágenes o textos de redes sociales).

## Por qué importa conocer las fuentes

En aprendizaje automático hay una regla que no falla: **un modelo es tan bueno como los datos con los que se entrena** (*garbage in, garbage out*). Antes de aplicar cualquier algoritmo hay que analizar a fondo las fuentes de datos: dónde residen, en qué formato están y qué naturaleza tienen.

Conocer la tipología de una fuente permite diseñar **procesos ETL eficientes**: elegir el conector adecuado, prever cuánta limpieza necesitará y minimizar el ruido para maximizar la información útil para el entrenamiento.

## 1. Dato, información y conocimiento

Un **dato** es un valor sin contexto: `38,2`. Cuando le añadimos contexto se convierte en **información**: «la temperatura del sensor 4 a las 10:00 es de 38,2 °C». Cuando la relacionamos con otras informaciones y nos permite decidir, hablamos de **conocimiento**: «el sensor 4 supera los 38 °C cada día a la misma hora; hay que revisar la refrigeración».

Un proceso ETL trabaja con datos, pero su objetivo es hacer posible que alguien (una persona o un modelo de aprendizaje automático) extraiga información y conocimiento.

## 2. Cinco preguntas para clasificar cualquier fuente

Ante cualquier fuente de datos, hazte siempre estas cinco preguntas. Las desarrollamos una a una en los apartados siguientes.

<div class="grid cards" markdown>

-   :material-source-branch:{ .lg .middle } __1 · ¿De dónde viene?__

    ---

    **Origen**: SGBD, ficheros, API, sensores IoT, *streaming*, logs, SIG, redes sociales…

-   :material-shape-outline:{ .lg .middle } __2 · ¿Qué naturaleza tiene?__

    ---

    **Estructurada**, **semiestructurada** o **no estructurada**.

-   :material-check-decagram-outline:{ .lg .middle } __3 · ¿Es fiable?__

    ---

    **Formal** (sistemas oficiales, validada) o **no formal** (generada por personas).

-   :material-map-marker-outline:{ .lg .middle } __4 · ¿Dónde está?__

    ---

    **Local** (*on-premise*), **nube** o **híbrido**.

-   :material-server-network:{ .lg .middle } __5 · ¿Cómo está repartida?__

    ---

    **Monolítica** (un solo nodo) o **distribuida** (particionada, replicada).

</div>

## 3. Según el origen

El **origen** es la procedencia inmediata de la información. No es lo mismo extraer datos de un sistema transaccional que de un sensor que envía lecturas en tiempo real: cambian el conector, la frecuencia y el volumen.

| Origen | Qué es | Ejemplo | Cómo accederemos en el curso |
|---|---|---|---|
| **Bases de datos transaccionales (OLTP)** | Sistemas que registran las operaciones del día a día (ventas, altas de usuarios). Los datos son muy estructurados y coherentes, ideales para modelos predictivos basados en el histórico. | El programa de facturación guarda las compras en PostgreSQL | SQL, Python y NiFi con JDBC |
| **Bases de datos NoSQL** | Gestores no relacionales pensados para volumen y flexibilidad. | Catálogo de productos en MongoDB | mongosh, pymongo, NiFi |
| **Ficheros** | Exportaciones o intercambios entre aplicaciones. | CSV del ERP, JSON de una aplicación, Excel de ventas | Python, NiFi |
| **API** | Servicios web que devuelven datos cuando se les hace una petición. | Previsión meteorológica de Open-Meteo | Peticiones HTTP desde NiFi o Python |
| **Sensores IoT** | Dispositivos que capturan magnitudes físicas (temperatura, humedad) y generan flujos continuos de valores numéricos con marca de tiempo. | Sensores de temperatura del taller | MQTT, NiFi |
| **Plataformas de *streaming*** | Sistemas como Kafka que transportan eventos en tiempo real. Los datos llegan en secuencia y requieren procesamiento inmediato. | Clics de una web | NiFi, Spark |
| **Logs de servidores** | Registros de eventos de aplicaciones o infraestructuras. Suelen ser semiestructurados o texto plano, con mucho volumen pero poca estructura inicial. | Accesos a un servidor web | NiFi, Elasticsearch |
| **Sistemas de información geográfica (SIG)** | Almacenan datos espaciales: combinan atributos tabulares con geometrías complejas (puntos, líneas, polígonos). | Mapa de parcelas del Catastro | API, ficheros GeoJSON |
| **Web y redes sociales** | Contenido generado en Internet. | Comentarios, imágenes, páginas de la Wikipedia | API, SPARQL, *scraping* |

### 3.1 Servicios de datos: cómo «nos hablan» las fuentes

Saber el origen no es suficiente: también hay que saber **qué servicio** nos da el dato y qué necesitamos para conectarnos.

=== "SGBD relacionales"

    - **Ejemplos:** MySQL, MariaDB, PostgreSQL, SQL Server, Oracle.
    - Dan el servicio en un **puerto** de red (PostgreSQL, el 5432) y se accede con un **cliente** (`psql`, DBeaver…).
    - Cada programa que se conecta necesita un ***driver*** para su protocolo (JDBC en Java y NiFi, psycopg en Python).
    - Utilizan **SQL** para consultas y modificaciones.
    - Pueden estar en **local** o en **remoto** (otro servidor o la nube).

=== "Bases de datos NoSQL"

    - **Ejemplos:** MongoDB, Elasticsearch, DynamoDB, Firebase, Cosmos DB.
    - Suelen usar **JSON** (o una variante, como BSON) para comunicarse.
    - Muchas ofrecen una **API REST**, además de sus propios lenguajes de consulta, a menudo basados en JSON.
    - Son muy **escalables** y rápidas en lectura y escritura.

=== "API"

    - Devuelven la información en **CSV, JSON o XML**.
    - Usan protocolos estándar para las consultas: **REST** (el más habitual), **GraphQL**, **SOAP** o **gRPC**.
    - Algunas piden una **clave de acceso** (*API key*) o un **SDK**: una librería del proveedor para usarla desde tu lenguaje.

=== "Web scraping"

    - Cuando una web **no tiene API**, se puede **simular la navegación** de una persona: se descarga el HTML, se localizan los datos y se extraen.
    - Los datos extraídos se transforman en formatos más útiles (CSV, JSON).
    - Es lo que hacen los robots de los buscadores.
    - :warning: **No todas las prácticas son legales** ni respetan las condiciones de uso de las webs. Consulta siempre el fichero `robots.txt`, las condiciones del servicio y el RGPD si hay datos personales.

## 4. Según la naturaleza

La **naturaleza** clasifica los datos según su **grado de organización**. Es la clasificación más importante para una ETL, porque determina **cómo hay que almacenarlos, procesarlos y preprocesarlos**.

### 4.1 Datos estructurados

**Qué son.** Son los datos que siguen un **formato fijo y bien definido**, normalmente almacenados en **tablas con filas y columnas**. Cada elemento de información ocupa un campo concreto y tiene un tipo de dato predeterminado (entero, fecha, texto de 50 caracteres…). La estructura, el **esquema**, se define **antes** de guardar ningún dato.

**Características**

- Organización rígida y bien definida.
- Fácil acceso mediante **SQL** u otros lenguajes estructurados.
- **Alta calidad y fiabilidad**, ya que suelen provenir de sistemas transaccionales.
- Fáciles de validar y procesar automáticamente.

**Ventajas:** almacenamiento eficiente gracias a su estructura fija, búsquedas y análisis muy rápidos, y facilidad para aplicar reglas de validación.
**Desventajas:** poca flexibilidad ante cambios en el modelo (añadir un campo obliga a modificar el esquema) y no son adecuados para información compleja o de formato variable.

**Dónde los encontramos:** bases de datos relacionales (MySQL, PostgreSQL, Oracle), ERP, registros de ventas o facturas, hojas de cálculo y algunos CSV.

!!! example "Ejemplo"
    Una tabla de facturas. Todas las filas tienen exactamente las mismas columnas y cada columna, su tipo:

    | id | fecha | proveedor | importe |
    |---:|---|---|---:|
    | 1 | 2026-10-05 | ACME S.L. | 120,50 |
    | 2 | 2026-10-05 | Hierros Xàtiva | 89,00 |

### 4.2 Datos semiestructurados

**Qué son.** Contienen información **organizada**, pero **no siguen una estructura rígida** como la de una tabla. No hay un esquema fijo definido de antemano: la estructura va **dentro del propio dato**, en forma de **etiquetas**, **claves** o **delimitadores** (metadatos) que describen cada valor. Dos registros pueden tener campos diferentes y pueden contener estructuras **anidadas** (un dato dentro de otro) y **listas**.

!!! note "Definición"
    Los datos semiestructurados permiten **flexibilidad en el esquema** y facilitan la integración de fuentes heterogéneas, pero requieren ***parsers*** (analizadores) específicos para leerlos.

**Características**

- Estructura flexible y adaptable.
- Uso de **metadatos** (etiquetas o claves) para describir la información.
- Más complejos de procesar que los estructurados, pero más manejables que los no estructurados.
- Muy comunes en entornos **web** y aplicaciones modernas.

**Ventajas:** flexibilidad, facilidad de integración entre sistemas y posibilidad de evolucionar sin cambios drásticos en el modelo.
**Desventajas:** análisis más complejo, necesidad de herramientas de transformación y normalización (hay que **aplanarlos** para cargarlos en una tabla) y riesgo de **inconsistencias** si no se gestionan bien.

**Dónde los encontramos:** JSON, XML, HTML, logs con campos dinámicos, respuestas de API, lecturas de sensores IoT, paquetes de red TCP/IP.

!!! example "Ejemplo"
    La misma factura en JSON. Fíjate en que las líneas están **anidadas** dentro de la factura y en que el proveedor tiene una **lista** de teléfonos; otro proveedor podría no tener ninguno, y el JSON seguiría siendo válido:

    ```json
    {"id": 1, "fecha": "2026-10-05",
     "proveedor": {"nombre": "ACME S.L.", "telefonos": ["961 000 000", "962 000 000"]},
     "lineas": [{"producto": "P-01", "cantidad": 3, "precio": 40.17}]}
    ```

### 4.3 Datos no estructurados

**Qué son.** No siguen ningún modelo predefinido ni tienen una organización que un programa pueda interpretar directamente. Cada fichero o documento puede tener un formato diferente. Representan **la mayor parte de la información** que se genera hoy, especialmente en entornos digitales y redes sociales.

**Características**

- Sin esquema: cada documento puede ser diferente.
- Gran **variedad de formatos**: texto libre, imágenes, audio, vídeo, PDF…
- Difíciles de procesar y analizar automáticamente.
- Necesitan técnicas avanzadas para extraer valor: **procesamiento del lenguaje natural** (NLP) para el texto, **visión por computador** para imágenes y vídeos, **transcripción** para el audio.

**Ventajas:** son la información más abundante y rica en contexto, y la fuente clave de la analítica predictiva y la inteligencia artificial.
**Desventajas:** difíciles de almacenar y procesar con herramientas tradicionales, necesitan mucha capacidad de cómputo y almacenamiento, y la limpieza y preparación cuestan mucho tiempo.

**Dónde los encontramos:** imágenes y vídeos (fotografías, cámaras de seguridad), documentos de texto libre (Word, PDF, correos), publicaciones en redes sociales, grabaciones de audio, datos de sensores en bruto.

!!! example "Ejemplo"
    La misma factura escaneada en PDF. Para una persona tiene estructura (cabecera, líneas, totales), pero para un programa solo es una imagen o un conjunto de posiciones de texto. Hace falta **OCR** o un analizador de documentos para convertirla en datos estructurados.

### 4.4 Comparativa

| Característica | Estructurados | Semiestructurados | No estructurados |
|---|---|---|---|
| **Esquema fijo** | Sí | Parcial | No |
| **Facilidad de análisis** | Alta | Media | Baja |
| **Flexibilidad** | Baja | Media | Alta |
| **Herramientas comunes** | SQL, SGBD relacionales | JSON, XML, API, NoSQL | Big Data, NLP, IA |
| **Ejemplo típico** | Tabla de clientes | Archivo JSON de logs | Vídeo de una cámara |
| **Volumen actual (aprox.)** | Menos del 10 % | Alrededor del 20 % | Más del 70 % |

### 4.5 Dónde se guarda cada tipo

- **Estructurados:** bases de datos relacionales (SQL) y *data warehouses* para el análisis.
- **Semiestructurados:** bases de datos **NoSQL** (MongoDB, Cassandra) y herramientas de integración (ETL/ELT).
- **No estructurados:** sistemas de ficheros distribuidos como **HDFS**, ***data lakes*** y algoritmos de IA para el análisis.

!!! quote "Fuente"
    Los apartados 4.1 a 4.5 (características, ventajas, desventajas, comparativa y almacenamiento) están tomados y adaptados de [«Tipos de datos»](https://alapvi.github.io/sbd/ingenieria-datos/ud1-introduccion/tipos-de-datos/), de los apuntes de *Sistemas de Big Data* de **Alberto Aparicio Vila** (IES Lluís Simarro). Las definiciones, la nota sobre *parsers* y los ejemplos son de elaboración propia y del tema *Tipología de fuentes de datos*.

## 5. Según la formalidad

La **formalidad** indica lo **fiable** que es un dato y, por tanto, cuánto preprocesamiento necesitará.

Datos formales
:   Los generan sistemas oficiales o automatizados con **validación estricta**: registros bancarios, datos meteorológicos oficiales, el programa de facturación. Tienen alta calidad y metadatos claros.

Datos no formales
:   Los generan personas o dispositivos personales sin ningún control: tuits, comentarios en foros, fotos subidas a redes sociales, notas de voz. Suelen tener **ruido**, faltas de ortografía, **sesgos** y falta de contexto.

!!! warning "Atención"
    Los datos no formales requieren fases de **limpieza y normalización** mucho más intensas. En aprendizaje automático, un exceso de ruido puede degradar el rendimiento del modelo si no se gestiona bien.

## 6. Según la ubicación

La ubicación determina **la estrategia de acceso y los costes**.

**Local (*on-premise*)**
:   Los datos están en discos de servidores propios, en las instalaciones de la organización. Hay **control total** y poca latencia para el acceso interno, pero la escalabilidad es limitada y hay que mantener el hardware y hacer las copias de seguridad.

**Nube**
:   Servicios gestionados por proveedores externos (AWS, Azure, Google Cloud, Supabase, MongoDB Atlas…). Accedemos por Internet, normalmente con credenciales y cifrado. Hay tres tipos de almacenamiento:

    - **De objetos:** ideal para grandes volúmenes de datos no estructurados (imágenes, logs). Ejemplos: Amazon S3, Azure Blob Storage.
    - **De bloques:** discos virtuales para bases de datos o aplicaciones.
    - **De ficheros:** sistemas de ficheros compartidos.

    La nube permite **escalar de forma elástica** y pagar solo por lo que se consume, pero crea dependencia de la conectividad y obliga a tener en cuenta la seguridad y la privacidad.

**Híbrido**
:   Una parte en local y otra en la nube. Es el caso más habitual en empresas.

!!! question "¿Por qué te importa como ingeniero o ingeniera de datos?"
    Si la fuente está en la nube, quizá tu ETL tendrá **latencia** y **costes de transferencia**. Si es un fichero local del departamento de compras, quizá llegará por correo o por una carpeta compartida. La ubicación condiciona el **conector** que necesitarás.

## 7. Según la distribución física

Por último, hay que analizar cómo están **repartidos** los datos.

**Monolítica**
:   Todos los datos están en un único nodo o ubicación centralizada. Simplifica la gestión, pero crea **cuellos de botella** y un **punto único de fallo**: si cae el servidor, cae todo.

**Distribuida**
:   Los datos se reparten entre varios nodos, quizá en lugares geográficos diferentes. Hay dos técnicas, que a menudo se combinan:

    - ***Sharding*** **(particionado):** cada nodo guarda **una parte** de los datos (por ejemplo, un año de facturas cada uno) para mejorar el rendimiento.
    - **Replicación:** se **copian** los datos en varios nodos para tener alta disponibilidad y lecturas más rápidas.

La distribución afecta directamente a la **latencia** (cuánto se tarda en acceder al dato) y a la **coherencia** (que todos los nodos tengan la misma versión del dato). En arquitecturas distribuidas es clave el principio de **procesar cerca de los datos**, para reducir el tráfico de red. Lo veremos a fondo en [S03](s03-entorns-arquitectures.md).

## 8. Ejemplo resuelto

!!! example "Una empresa de logística"
    Una empresa de logística tiene sensores en los camiones que envían las coordenadas GPS cada minuto. Aplicamos las cinco preguntas:

    | Pregunta | Respuesta | Por qué |
    |---|---|---|
    | ¿De dónde viene? | **IoT** | Dispositivos físicos conectados |
    | ¿Qué naturaleza tiene? | **Semiestructurada** | JSON con latitud, longitud y *timestamp* |
    | ¿Es fiable? | **No formal** | Puede tener errores de señal (puntos fuera de la carretera, saltos) |
    | ¿Dónde está? | **Nube** | Se guarda en Amazon S3 |
    | ¿Cómo está repartida? | **Distribuida** | S3 reparte y replica los objetos |

    **Consecuencia para la ETL:** antes de alimentar un modelo de optimización de rutas habrá que **limpiar** las lecturas erróneas y **aplanar** el JSON.

## Material

- :material-file-document-outline: *Tipología de fuentes de datos y sistemas de gestión* (tema completo, en Aules)
- :material-file-document-outline: *Tipus de dades.pdf* (Aules)
- :material-web: [Introducción a BI · Visión general](https://alapvi.github.io/sbd/ingenieria-datos/ud1-introduccion/) y [Tipos de datos](https://alapvi.github.io/sbd/ingenieria-datos/ud1-introduccion/tipos-de-datos/) (Alberto Aparicio Vila)
- :material-cloud-outline: Nube de conceptos inicial (Mentimeter) e infografía de BI para el debate inicial

## Ejercicios

### Ejercicio 1 · Ficha de clasificación de fuentes

**Duración:** 1 h aprox. · **En parejas**

Para cada una de estas fuentes, rellena una fila de la tabla de abajo:

1. La base de datos PostgreSQL del programa de compras de una empresa.
2. Las lecturas de los sensores de temperatura del taller del centro.
3. La API de Open-Meteo con la previsión para Xàtiva.
4. Un Excel que el departamento de ventas envía cada viernes por correo.
5. Los comentarios que dejan los clientes en Google Maps.
6. Las grabaciones de las llamadas de atención al cliente.
7. El catálogo de productos de una tienda en línea guardado en MongoDB Atlas.
8. Los registros (*logs*) de un servidor web.
9. Wikidata.
10. Una fuente de tu elección de tu ciclo o de tu empresa de prácticas.

| Fuente | Origen | Naturaleza | ¿Formal? | Formato | Ubicación | Distribución | ¿Cómo te conectarías? |
|---|---|---|---|---|---|---|---|
| 1 | | | | | | | |

!!! success "Qué tienes que entregar"
    La tabla completada y, para **dos** de las fuentes, un párrafo que justifique qué dificultad principal tendría extraerla.

### Ejercicio 2 · Fuentes para un proyecto de predicción de ventas

Un supermercado de Valencia quiere desarrollar un modelo de aprendizaje automático para predecir las ventas diarias de productos frescos. Ha identificado cuatro fuentes de datos:

1. **Base de datos interna (TPV):** registros de transacciones de los últimos 5 años almacenados en un servidor local del supermercado. Contiene campos como `fecha`, `producto_id`, `cantidad`, `precio_unitario` y `cliente_id`. Formato: CSV.
2. **Sensores IoT de las cámaras frigoríficas:** datos de temperatura y humedad de las cámaras de almacenamiento, enviados cada 5 minutos a una plataforma en la nube (AWS IoT). Formato: JSON.
3. **Redes sociales (Instagram):** comentarios y publicaciones de usuarios locales que mencionan el supermercado, extraídos mediante una API oficial. Formato: texto plano (UTF-8).
4. **API de meteorología (AEMET):** temperatura máxima, mínima y precipitación de la ciudad, obtenidas mediante una API REST. Formato: XML.

**Tarea:** clasifica cada fuente según su **naturaleza**, **origen**, **ubicación física** y **formalidad**. Justifica brevemente cada clasificación.

??? tip "Orientación"
    Los datos estructurados tienen un esquema fijo (filas y columnas); los no estructurados no tienen un formato predefinido para máquinas (como el texto libre). La ubicación física se refiere a **dónde están almacenados los datos originales**, no a dónde se procesan. La formalidad depende de si los datos los generan procesos oficiales o usuarios espontáneos.

??? success "Solución"
    **1. Base de datos interna (TPV)**

    - **Naturaleza:** estructurada. Tiene un esquema fijo definido por columnas y tipos de datos.
    - **Origen:** sistema gestor de datos (SGBD). Es el sistema central del negocio.
    - **Ubicación:** local. El enunciado dice «servidor local».
    - **Formalidad:** formal. Son registros oficiales de transacciones comerciales.

    **2. Sensores IoT de las cámaras frigoríficas**

    - **Naturaleza:** semiestructurada. El JSON tiene claves, pero puede variar o anidarse; no es una tabla plana fija.
    - **Origen:** IoT. Provienen de dispositivos físicos conectados.
    - **Ubicación:** nube (plataforma AWS IoT).
    - **Formalidad:** formal. Son datos técnicos generados por un sistema de control automatizado.

    **3. Redes sociales (Instagram)**

    - **Naturaleza:** no estructurada. El texto libre no tiene un esquema interpretable directamente sin NLP.
    - **Origen:** API / redes sociales.
    - **Ubicación:** nube. Los datos están en los servidores de Meta.
    - **Formalidad:** no formal. Son opiniones espontáneas de usuarios.

    **4. API de meteorología (AEMET)**

    - **Naturaleza:** semiestructurada. El XML tiene una estructura jerárquica con etiquetas, pero no es una tabla plana.
    - **Origen:** API de terceros.
    - **Ubicación:** nube o centro de datos externo de AEMET.
    - **Formalidad:** formal. Es información oficial de un organismo público.

    | Fuente | Naturaleza | Origen | Ubicación | Formalidad |
    |---|---|---|---|---|
    | TPV | Estructurada | SGBD | Local | Formal |
    | Cámaras IoT | Semiestructurada | IoT | Nube | Formal |
    | Instagram | No estructurada | API / red social | Nube | No formal |
    | AEMET | Semiestructurada | API | Nube | Formal |

!!! info "Más ejercicios del tema"
    El resto de ejercicios del tema *Tipología de fuentes de datos y sistemas de gestión* están en la sesión donde se trabaja la teoría correspondiente: SQL vs NoSQL, conversión de formatos, SCADA y redes sociales en [S02](s02-gestors-formats.md); arquitecturas de procesamiento, diagrama de ingesta y *edge computing* en [S03](s03-entorns-arquitectures.md).

## Para repasar

??? question "¿Una factura en PDF es un dato estructurado?"
    Para una persona tiene estructura (cabecera, líneas, totales), pero para un ordenador es **no estructurado**: el PDF guarda posiciones de texto, no campos. Hay que extraerla (con un analizador de PDF u OCR) para convertirla en datos estructurados.

??? question "¿Un JSON siempre es semiestructurado?"
    Sí, por el formato. Pero si todas las respuestas de una API tienen siempre los mismos campos y sin niveles anidados, convertirlo en una tabla es trivial: en la práctica se comporta casi como un dato estructurado.

??? question "¿Un CSV es siempre estructurado?"
    Normalmente sí, pero solo si todas las filas tienen las mismas columnas y los valores respetan el tipo esperado. Un CSV con columnas que cambian, separadores mezclados o texto libre dentro de un campo (como una descripción con comas) puede dar muchos problemas. El CSV **no guarda el tipo** de cada columna: hay que validarlo en la ingesta.
