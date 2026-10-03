# Resultados de aprendizaje y criterios de evaluación

Módulo profesional **5104 · Extracción, transformación y carga de datos desde fuentes múltiples** (Real Decreto 183/2026, de 11 de marzo; BOE-A-2026-5869). 115 horas · 13 ECTS.

Un **resultado de aprendizaje (RA)** es lo que debes saber hacer al terminar el módulo. Los **criterios de evaluación (CA)** concretan cómo se comprueba. Cada criterio enlaza con las sesiones donde se trabaja.

!!! note "Texto oficial"
    Texto literal del BOE-A-2026-5869 (incluida la errata «OLAT», que debe leerse OLTP).

## RA1

> Reconoce la tipología de las fuentes u orígenes de datos, identificando sus características y aplicaciones usuales, ventajas e inconvenientes.

| CA | Criterio | Sesiones |
|:--:|---|---|
| **a** | Se ha determinado la ubicación de las fuentes de datos, clasificando el formato en que se encuentran almacenadas y la ubicación (en local o nube) y su distribución física. | [S01](../p1/s01-tipus-dades.md), [S16](../p1/s16-prova.md) |
| **b** | Se han clasificado las fuentes de datos y conocimiento según su origen, (sistemas gestores de datos, sistemas IoT, plataformas de datos en streaming, integración con APIs u otro), según su naturaleza (estructuradas, no estructuradas), según sean formales o no formales (audios, imágenes o textos de redes sociales). | [S01](../p1/s01-tipus-dades.md), [D12](../p2/d12-iot.md), [S16](../p1/s16-prova.md) |
| **c** | Se han identificado las características de las fuentes de datos no estructuradas, valorando su diversidad organizativa y reconociendo el ecosistema de Internet como origen de información a partir de tecnologías de Web semántica y linked data. | [S02](../p1/s02-gestors-formats.md), [S16](../p1/s16-prova.md) |
| **d** | Se han descrito los sistemas gestores de datos SQL y no SQL, diferenciando sus estructuras, modelos y aplicaciones actuales. | [S02](../p1/s02-gestors-formats.md), [S16](../p1/s16-prova.md) |
| **e** | Se han analizado los formatos de texto estructurados para el intercambio de datos, tales como ficheros planos, XML y JSON. | [S02](../p1/s02-gestors-formats.md), [S16](../p1/s16-prova.md) |
| **f** | Se han determinado el formato y la utilidad de los datos procedentes de sistemas SCADA aplicados en IoT. | [S02](../p1/s02-gestors-formats.md), [S16](../p1/s16-prova.md) |
| **g** | Se han descrito plataformas locales o en la nube, monolíticas y distribuidas que facilitan el procesamiento masivo de datos mediante paralelización tales como SMP, MPP. | [S03](../p1/s03-entorns-arquitectures.md), [S16](../p1/s16-prova.md) |
| **h** | Se han descrito procedimientos de manejo de datos masivos y de mejora de tiempos de proceso de los mismos, tales como el proceso cercano a las fuentes en el caso de fuentes de datos distribuidas. | [S03](../p1/s03-entorns-arquitectures.md), [S16](../p1/s16-prova.md) |

## RA2

> Aplica las operaciones de acceso, extracción y transformación de datos desde bases de datos relacionales, usando los lenguajes propios de cada sistema gestor y herramientas software.

| CA | Criterio | Sesiones |
|:--:|---|---|
| **a** | Se han configurado pasarelas, conectores o herramientas de acceso a cada uno de los sistemas contenedores de datos, automatizando la captura de información y su proceso. | [D07](../p2/d07-nifi-bd.md), [D17](../p2/d17-prova.md) |
| **b** | Se ha determinado la ubicación de las fuentes de datos, confirmando el formato en que se encuentran almacenadas y la ubicación (en local o nube) y su distribución física y lógica. | [D07](../p2/d07-nifi-bd.md), [D17](../p2/d17-prova.md) |
| **c** | Se ha accedido a las bases de datos origen, ejecutando consultas, usando lenguajes de acceso y consulta relacionales (DQL) en local y en la nube, usando instrucciones ad hoc, programación embebida en lenguajes huésped (host) y herramientas de extracción. | [S08](../p1/s08-practica-copy.md), [S16](../p1/s16-prova.md) |
| **d** | Se han aplicado filtros y transformaciones en origen a los datos, tales como proyecciones, selecciones, agregaciones y ordenaciones, usando lenguajes de acceso y consulta relacionales (DQL) en local y en la nube, embebidos o no en lenguajes huésped (host). | [S09](../p1/s09-practica-benchmark.md), [S16](../p1/s16-prova.md) |
| **e** | Se han utilizado operaciones complejas de transformación tales como cruce de datos (join), subconsultas, uniones, diferencia y funciones de agregación, cálculo o transformación. | [S09](../p1/s09-practica-benchmark.md), [S16](../p1/s16-prova.md) |
| **f** | Se han utilizado las funcionalidades de un lenguaje huésped (host) o herramientas gráficas aplicando transformaciones programáticas complejas tales como lectura y carga de varias fuentes y destinos simultáneos, carga en memoria directa o en estructuras de datos de árbol o grafos y uso de tablas intermedias, entre otras. | [D08](../p2/d08-multifont.md), [D17](../p2/d17-prova.md) |
| **g** | Se ha paralelizado el acceso, filtro y transformación en los orígenes de datos, en función de los sistemas y utilidades disponibles, sistemas distribuidos, MPP o SMP. | [D15](../p2/d15-spark.md), [D17](../p2/d17-prova.md) |

## RA3

> Se han efectuado operaciones para la creación de tablas y vistas destino o intermedias de los datos y para la carga masiva de información en sistemas de bases de datos relacionales, usando los lenguajes propios de cada sistema gestor y herramientas software.

| CA | Criterio | Sesiones |
|:--:|---|---|
| **a** | Se han usado lenguajes de definición de datos (DDL) para la creación de estructuras de almacenamiento de datos, relaciones e índices en sistemas de bases de datos relacionales, usando instrucciones ad hoc, programación embebida en lenguajes huésped (host) y herramientas gráficas. | [S05](../p1/s05-practica-ddl.md), [S16](../p1/s16-prova.md) |
| **b** | Se han usado lenguajes de manejo de datos (DML) para la carga, actualización y borrado de datos en bases de datos relacionales, usando instrucciones ad hoc, programación embebida en lenguajes huésped (host) y herramientas gráficas. | [S06](../p1/s06-practica-carrega.md), [S07](../p1/s07-practica-scd-dcl.md), [S16](../p1/s16-prova.md) |
| **c** | Se han descrito modelos de datos de las bases de datos destino en función del objetivo de uso, diferenciando bases de datos OLAT y OLAP. | [S03](../p1/s03-entorns-arquitectures.md), [S04](../p1/s04-model-multidimensional.md), [S16](../p1/s16-prova.md) |
| **d** | Se han combinado instrucciones de consulta, transformación y carga para fuentes y destinos ubicados en una misma base de datos. | [S06](../p1/s06-practica-carrega.md), [S16](../p1/s16-prova.md) |
| **e** | Se han usado lenguajes de control de datos (DCL), configurando roles y permisos para garantizar la confidencialidad de la información en el acceso y manipulación de datos en bases de datos relacionales. | [S07](../p1/s07-practica-scd-dcl.md), [S16](../p1/s16-prova.md) |
| **f** | Se han usado herramientas de carga masiva de datos propia de un sistema de bases de datos relacionales desde ficheros planos u otras fuentes externas. | [S08](../p1/s08-practica-copy.md), [S16](../p1/s16-prova.md) |
| **g** | Se han paralelizado las operaciones de carga, actualización y borrado de datos, en función de los sistemas y utilidades disponibles, sistemas distribuidos, MPP o SMP. | [S09](../p1/s09-practica-benchmark.md), [S16](../p1/s16-prova.md) |

## RA4

> Se han efectuado operaciones de acceso, extracción y transformación desde bases de datos noSQL, usando los lenguajes propios de cada sistema gestor y herramientas software.

| CA | Criterio | Sesiones |
|:--:|---|---|
| **a** | Se han configurado pasarelas, conectores o herramientas de acceso a cada uno de los sistemas contenedores de datos, configurándolos para automatizar la captura de información y su proceso. | [S10](../p1/s10-mongodb-1.md), [D13](../p2/d13-nifi-nosql.md), [S16](../p1/s16-prova.md) |
| **b** | Se ha determinado la ubicación de las fuentes de datos, confirmando el formato en que se encuentran almacenadas y la ubicación (en local o nube) y su distribución física y lógica. | [S10](../p1/s10-mongodb-1.md), [S16](../p1/s16-prova.md) |
| **c** | Se ha accedido a datos con origen en bases de datos noSQL, usando lenguajes de acceso y/o API disponibles para cada una. | [S10](../p1/s10-mongodb-1.md), [S12](../p1/s12-elasticsearch.md), [S16](../p1/s16-prova.md) |
| **d** | Se han aplicado transformaciones y filtros a los datos con origen en bases de datos noSQL, tales como proyecciones, selecciones, agregaciones y ordenaciones, usando lenguajes de acceso propios de las mismas, en local y en la nube. | [S11](../p1/s11-mongodb-2.md), [S12](../p1/s12-elasticsearch.md), [S16](../p1/s16-prova.md) |
| **e** | Se ha paralelizado el acceso, filtro y transformación en los orígenes de datos, en función de los sistemas y utilidades disponibles, sistemas distribuidos, MPP o SMP. | [S13](../p1/s13-nosql-seguretat.md), [S16](../p1/s16-prova.md) |

## RA5

> Se han utilizado lenguajes para la carga y transformación de información en sistemas de bases de datos noSQL, mediante el uso de métodos que ejecutan las operaciones al efecto.

| CA | Criterio | Sesiones |
|:--:|---|---|
| **a** | Se han configurado pasarelas, conectores o herramientas de acceso a cada uno de los sistemas destino de los datos, configurándolos para automatizar la captura de información y su proceso. | [D13](../p2/d13-nifi-nosql.md), [S16](../p1/s16-prova.md) |
| **b** | Se ha determinado la ubicación de los destinos de los datos, confirmando el formato en que se encuentran almacenadas y la ubicación (en local o nube) y su distribución física y lógica. | [S10](../p1/s10-mongodb-1.md), [S16](../p1/s16-prova.md) |
| **c** | Se han usado métodos de definición de datos para la creación de estructuras de almacenamiento en sistemas de bases de datos noSQL. | [S11](../p1/s11-mongodb-2.md), [S12](../p1/s12-elasticsearch.md), [S16](../p1/s16-prova.md) |
| **d** | Se han usado métodos para la carga, actualización y borrado de datos en bases de datos noSQL, ordinarios y masivos. | [S11](../p1/s11-mongodb-2.md), [S12](../p1/s12-elasticsearch.md), [S16](../p1/s16-prova.md) |
| **e** | Se han usado métodos relacionados con la seguridad en bases de datos noSQL, relativos a la confidencialidad de la información. | [S13](../p1/s13-nosql-seguretat.md), [S16](../p1/s16-prova.md) |
| **f** | Se han paralelizado las operaciones de carga, actualización y borrado de datos, en función de los sistemas y utilidades disponibles, sistemas distribuidos, MPP o SMP. | [S13](../p1/s13-nosql-seguretat.md), [S16](../p1/s16-prova.md) |

## RA6

> Se han efectuado operaciones de acceso, extracción y transformación desde archivos en formato de texto para el intercambio de datos tales como ficheros planos de diversos tipos, XML y JSON, usando lenguajes de programación.

| CA | Criterio | Sesiones |
|:--:|---|---|
| **a** | Se han configurado pasarelas, conectores o herramientas de acceso a cada uno de los sistemas contenedores de datos, configurándolos para automatizar la captura de información y su proceso. | [D01](../p2/d01-nifi-intro.md), [D02](../p2/d02-nifi-flowfiles.md), [D16](../p2/d16-integracio.md), [D17](../p2/d17-prova.md) |
| **b** | Se ha determinado la ubicación de las fuentes de datos, confirmando el formato en que se encuentran almacenadas y la ubicación (en local o nube) y su distribución física y lógica. | [D01](../p2/d01-nifi-intro.md), [D17](../p2/d17-prova.md) |
| **c** | Se ha accedido a datos con origen en formatos texto para el intercambio de datos, usando métodos de lectura en un lenguaje de programación. | [D04](../p2/d04-nifi-controllers.md), [D05](../p2/d05-json-xml.md), [D17](../p2/d17-prova.md) |
| **d** | Se han aplicado transformaciones y filtros a los datos con origen en formatos texto para el intercambio de datos, tales como proyecciones, selecciones, agregaciones, ordenaciones, uniones, divisiones o diferencias. | [D03](../p2/d03-nifi-processors.md), [D04](../p2/d04-nifi-controllers.md), [D05](../p2/d05-json-xml.md), [D17](../p2/d17-prova.md) |
| **e** | Se ha paralelizado el acceso, filtro y transformación en los orígenes de datos, en función de los sistemas y utilidades disponibles, sistemas distribuidos, MPP o SMP para el manejo de grandes cantidades de datos. | [D11](../p2/d11-hdfs.md), [D15](../p2/d15-spark.md), [D17](../p2/d17-prova.md) |

## RA7

> Se han utilizado lenguajes para el almacenaje de información en archivos de texto estructurados para el intercambio de datos, tales como ficheros planos, XML y JSON, invocando los métodos que ejecutan cada operación al efecto.

| CA | Criterio | Sesiones |
|:--:|---|---|
| **a** | Se han configurado pasarelas, conectores o herramientas de acceso a cada uno de los sistemas contenedores de datos, configurándolos para automatizar la captura de información y su proceso. | [D02](../p2/d02-nifi-flowfiles.md), [D16](../p2/d16-integracio.md), [D17](../p2/d17-prova.md) |
| **b** | Se ha determinado la ubicación de las fuentes de datos, confirmando el formato en que se encuentran almacenadas y la ubicación (en local o nube) y su distribución física y lógica. | [D02](../p2/d02-nifi-flowfiles.md), [D17](../p2/d17-prova.md) |
| **c** | Se han usado métodos e instrucciones para la generación de archivos de texto estructurados para el intercambio de datos. | [D04](../p2/d04-nifi-controllers.md), [D06](../p2/d06-fitxers-escriptura.md), [D17](../p2/d17-prova.md) |
| **d** | Se han usado métodos para la modificación y borrado de datos en archivos de texto estructurados para el intercambio de datos. | [D06](../p2/d06-fitxers-escriptura.md), [D17](../p2/d17-prova.md) |
| **e** | Se han usado mecanismos, garantizando la confidencialidad de la información en los datos generados. | [D10](../p2/d10-confidencialitat.md), [D17](../p2/d17-prova.md) |
| **f** | Se han paralelizado las operaciones de creación, modificación y borrado de datos, en función de los sistemas y utilidades disponibles, sistemas distribuidos, MPP o SMP para el manejo de grandes cantidades de datos (big data). | [D11](../p2/d11-hdfs.md), [D15](../p2/d15-spark.md), [D17](../p2/d17-prova.md) |

## RA8

> Aplica las operaciones de acceso, extracción y transformación de datos procedentes de otras fuentes de datos, tales como fuentes de datos no estructurados, diferenciando según el tipo de fuente extraída.

| CA | Criterio | Sesiones |
|:--:|---|---|
| **a** | Se han configurado pasarelas, conectores o herramientas de acceso a cada uno de los sistemas contenedores de datos, configurándolos para automatizar la captura de información y su proceso. | [D09](../p2/d09-api-rest.md), [D17](../p2/d17-prova.md) |
| **b** | Se ha determinado la ubicación de las fuentes de datos, confirmando el formato en que se encuentran almacenadas y la ubicación (en local o nube) y su distribución física y lógica. | [D09](../p2/d09-api-rest.md), [D17](../p2/d17-prova.md) |
| **c** | Se ha accedido a datos con origen en Internet, a partir de las ontologías descritas en metadatos con formatos OWL tal como RDF. | [D14](../p2/d14-sparql.md), [D17](../p2/d17-prova.md) |
| **d** | Se han aplicado filtros y transformaciones en origen a los datos con origen en Internet accedidos a partir de su metadata, usando lenguajes como SPARQL. | [D14](../p2/d14-sparql.md), [D17](../p2/d17-prova.md) |
| **e** | Se ha accedido a datos con origen en dispositivos IoT mediante sistemas SCADA, conectándose y consultado los datos almacenados en ellos. | [D12](../p2/d12-iot.md), [D17](../p2/d17-prova.md) |
| **f** | Se han aplicado filtros y transformaciones en origen a los datos con origen en dispositivos IoT mediante sistemas SCADA, usando lenguajes de programación y API de acceso propios de estos sistemas. | [D12](../p2/d12-iot.md), [D17](../p2/d17-prova.md) |
| **g** | Se han paralelizado las operaciones de extracción y transformación de datos, en función de los sistemas y utilidades disponibles, sistemas distribuidos, MPP o SMP para el manejo de grandes cantidades de datos (big data). | [D15](../p2/d15-spark.md), [D17](../p2/d17-prova.md) |
