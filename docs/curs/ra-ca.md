# Resultats d'aprenentatge i criteris d'avaluació

Mòdul professional **5104 · Extracció, transformació i càrrega de dades des de fonts múltiples** (Reial decret 183/2026, de 11 de març; BOE-A-2026-5869). 115 hores · 13 ECTS.

Un **resultat d'aprenentatge (RA)** és el que has de saber fer en acabar el mòdul. Els **criteris d'avaluació (CA)** concreten com es comprova. Cada criteri enllaça amb les sessions on es treballa.

!!! note "Traducció"
    El text oficial del BOE està en castellà; ací en tens una traducció fidel al valencià.

## RA1

> Reconeix la tipologia de les fonts o orígens de dades, identificant-ne les característiques i aplicacions usuals, avantatges i inconvenients.

| CA | Criteri | Sessions |
|:--:|---|---|
| **a** | S'ha determinat la ubicació de les fonts de dades, classificant el format en què estan emmagatzemades, la ubicació (local o núvol) i la seua distribució física. | [S01](../p1/s01-tipus-dades.md), [S16](../p1/s16-prova.md) |
| **b** | S'han classificat les fonts de dades i coneixement segons l'origen (sistemes gestors de dades, sistemes IoT, plataformes de dades en streaming, integració amb API o altres), segons la naturalesa (estructurades, no estructurades) i segons siguen formals o no formals (àudios, imatges o textos de xarxes socials). | [S01](../p1/s01-tipus-dades.md), [D12](../p2/d12-iot.md), [S16](../p1/s16-prova.md) |
| **c** | S'han identificat les característiques de les fonts de dades no estructurades, valorant-ne la diversitat organitzativa i reconeixent l'ecosistema d'Internet com a origen d'informació a partir de tecnologies de web semàntica i linked data. | [S02](../p1/s02-gestors-formats.md), [S16](../p1/s16-prova.md) |
| **d** | S'han descrit els sistemes gestors de dades SQL i NoSQL, diferenciant-ne les estructures, els models i les aplicacions actuals. | [S02](../p1/s02-gestors-formats.md), [S16](../p1/s16-prova.md) |
| **e** | S'han analitzat els formats de text estructurats per a l'intercanvi de dades, com ara fitxers plans, XML i JSON. | [S02](../p1/s02-gestors-formats.md), [S16](../p1/s16-prova.md) |
| **f** | S'han determinat el format i la utilitat de les dades procedents de sistemes SCADA aplicats en IoT. | [S02](../p1/s02-gestors-formats.md), [S16](../p1/s16-prova.md) |
| **g** | S'han descrit plataformes locals o en el núvol, monolítiques i distribuïdes, que faciliten el processament massiu de dades mitjançant paral·lelització, com ara SMP i MPP. | [S03](../p1/s03-entorns-arquitectures.md), [S16](../p1/s16-prova.md) |
| **h** | S'han descrit procediments de maneig de dades massives i de millora dels temps de procés, com ara el processament prop de les fonts en el cas de fonts de dades distribuïdes. | [S03](../p1/s03-entorns-arquitectures.md), [S16](../p1/s16-prova.md) |

## RA2

> Aplica les operacions d'accés, extracció i transformació de dades des de bases de dades relacionals, usant els llenguatges propis de cada sistema gestor i eines de programari.

| CA | Criteri | Sessions |
|:--:|---|---|
| **a** | S'han configurat passarel·les, connectors o eines d'accés a cada un dels sistemes contenidors de dades, automatitzant la captura d'informació i el seu procés. | [D07](../p2/d07-nifi-bd.md), [D17](../p2/d17-prova.md) |
| **b** | S'ha determinat la ubicació de les fonts de dades, confirmant el format en què estan emmagatzemades, la ubicació (local o núvol) i la distribució física i lògica. | [D07](../p2/d07-nifi-bd.md), [D17](../p2/d17-prova.md) |
| **c** | S'ha accedit a les bases de dades origen executant consultes amb llenguatges d'accés i consulta relacionals (DQL), en local i en el núvol, amb instruccions ad hoc, programació embeguda en llenguatges amfitrió (host) i eines d'extracció. | [S08](../p1/s08-practica-copy.md), [S16](../p1/s16-prova.md) |
| **d** | S'han aplicat filtres i transformacions en origen, com ara projeccions, seleccions, agregacions i ordenacions, amb DQL en local i en el núvol, embegut o no en un llenguatge amfitrió. | [S09](../p1/s09-practica-benchmark.md), [S16](../p1/s16-prova.md) |
| **e** | S'han utilitzat operacions complexes de transformació com ara creuament de dades (join), subconsultes, unions, diferència i funcions d'agregació, càlcul o transformació. | [S09](../p1/s09-practica-benchmark.md), [S16](../p1/s16-prova.md) |
| **f** | S'han utilitzat les funcionalitats d'un llenguatge amfitrió o d'eines gràfiques aplicant transformacions programàtiques complexes, com ara lectura i càrrega de diverses fonts i destins simultanis, càrrega en memòria o en estructures d'arbre o graf i ús de taules intermèdies. | [D08](../p2/d08-multifont.md), [D17](../p2/d17-prova.md) |
| **g** | S'ha paral·lelitzat l'accés, el filtre i la transformació en els orígens de dades, en funció dels sistemes i utilitats disponibles: sistemes distribuïts, MPP o SMP. | [D15](../p2/d15-spark.md), [D17](../p2/d17-prova.md) |

## RA3

> Efectua operacions per a la creació de taules i vistes destí o intermèdies i per a la càrrega massiva d'informació en sistemes de bases de dades relacionals, usant els llenguatges propis de cada sistema gestor i eines de programari.

| CA | Criteri | Sessions |
|:--:|---|---|
| **a** | S'han usat llenguatges de definició de dades (DDL) per a crear estructures d'emmagatzematge, relacions i índexs en bases de dades relacionals, amb instruccions ad hoc, programació embeguda i eines gràfiques. | [S05](../p1/s05-practica-ddl.md), [S16](../p1/s16-prova.md) |
| **b** | S'han usat llenguatges de manipulació de dades (DML) per a la càrrega, l'actualització i l'esborrat de dades en bases de dades relacionals, amb instruccions ad hoc, programació embeguda i eines gràfiques. | [S06](../p1/s06-practica-carrega.md), [S07](../p1/s07-practica-scd-dcl.md), [S16](../p1/s16-prova.md) |
| **c** | S'han descrit models de dades de les bases de dades destí en funció de l'objectiu d'ús, diferenciant bases de dades OLTP i OLAP. | [S03](../p1/s03-entorns-arquitectures.md), [S04](../p1/s04-model-multidimensional.md), [S16](../p1/s16-prova.md) |
| **d** | S'han combinat instruccions de consulta, transformació i càrrega per a fonts i destins ubicats en una mateixa base de dades. | [S06](../p1/s06-practica-carrega.md), [S16](../p1/s16-prova.md) |
| **e** | S'han usat llenguatges de control de dades (DCL), configurant rols i permisos per a garantir la confidencialitat de la informació en l'accés i la manipulació de dades. | [S07](../p1/s07-practica-scd-dcl.md), [S16](../p1/s16-prova.md) |
| **f** | S'han usat eines de càrrega massiva de dades pròpies d'un sistema de bases de dades relacionals des de fitxers plans o altres fonts externes. | [S08](../p1/s08-practica-copy.md), [S16](../p1/s16-prova.md) |
| **g** | S'han paral·lelitzat les operacions de càrrega, actualització i esborrat de dades, en funció dels sistemes i utilitats disponibles: sistemes distribuïts, MPP o SMP. | [S09](../p1/s09-practica-benchmark.md), [S16](../p1/s16-prova.md) |

## RA4

> Efectua operacions d'accés, extracció i transformació des de bases de dades NoSQL, usant els llenguatges propis de cada sistema gestor i eines de programari.

| CA | Criteri | Sessions |
|:--:|---|---|
| **a** | S'han configurat passarel·les, connectors o eines d'accés a cada un dels sistemes contenidors de dades per a automatitzar la captura d'informació i el seu procés. | [S10](../p1/s10-mongodb-1.md), [D13](../p2/d13-nifi-nosql.md), [S16](../p1/s16-prova.md) |
| **b** | S'ha determinat la ubicació de les fonts de dades, confirmant-ne el format, la ubicació (local o núvol) i la distribució física i lògica. | [S10](../p1/s10-mongodb-1.md), [S16](../p1/s16-prova.md) |
| **c** | S'ha accedit a dades amb origen en bases de dades NoSQL usant els llenguatges d'accés o les API disponibles per a cada una. | [S10](../p1/s10-mongodb-1.md), [S12](../p1/s12-elasticsearch.md), [S16](../p1/s16-prova.md) |
| **d** | S'han aplicat transformacions i filtres a dades NoSQL, com ara projeccions, seleccions, agregacions i ordenacions, amb els llenguatges propis, en local i en el núvol. | [S11](../p1/s11-mongodb-2.md), [S12](../p1/s12-elasticsearch.md), [S16](../p1/s16-prova.md) |
| **e** | S'ha paral·lelitzat l'accés, el filtre i la transformació en els orígens de dades, en funció dels sistemes i utilitats disponibles: sistemes distribuïts, MPP o SMP. | [S13](../p1/s13-nosql-seguretat.md), [S16](../p1/s16-prova.md) |

## RA5

> Utilitza llenguatges per a la càrrega i transformació d'informació en sistemes de bases de dades NoSQL, mitjançant mètodes que executen les operacions corresponents.

| CA | Criteri | Sessions |
|:--:|---|---|
| **a** | S'han configurat passarel·les, connectors o eines d'accés als sistemes destí de les dades per a automatitzar la captura d'informació i el seu procés. | [D13](../p2/d13-nifi-nosql.md), [S16](../p1/s16-prova.md) |
| **b** | S'ha determinat la ubicació dels destins de les dades, confirmant-ne el format, la ubicació (local o núvol) i la distribució física i lògica. | [S10](../p1/s10-mongodb-1.md), [S16](../p1/s16-prova.md) |
| **c** | S'han usat mètodes de definició de dades per a crear estructures d'emmagatzematge en bases de dades NoSQL. | [S11](../p1/s11-mongodb-2.md), [S12](../p1/s12-elasticsearch.md), [S16](../p1/s16-prova.md) |
| **d** | S'han usat mètodes per a la càrrega, l'actualització i l'esborrat de dades en bases de dades NoSQL, ordinaris i massius. | [S11](../p1/s11-mongodb-2.md), [S12](../p1/s12-elasticsearch.md), [S16](../p1/s16-prova.md) |
| **e** | S'han usat mètodes relacionats amb la seguretat en bases de dades NoSQL, relatius a la confidencialitat de la informació. | [S13](../p1/s13-nosql-seguretat.md), [S16](../p1/s16-prova.md) |
| **f** | S'han paral·lelitzat les operacions de càrrega, actualització i esborrat de dades, en funció dels sistemes i utilitats disponibles: sistemes distribuïts, MPP o SMP. | [S13](../p1/s13-nosql-seguretat.md), [S16](../p1/s16-prova.md) |

## RA6

> Efectua operacions d'accés, extracció i transformació des de fitxers de text per a l'intercanvi de dades (fitxers plans de diversos tipus, XML i JSON) usant llenguatges de programació.

| CA | Criteri | Sessions |
|:--:|---|---|
| **a** | S'han configurat passarel·les, connectors o eines d'accés als sistemes contenidors de dades per a automatitzar la captura d'informació i el seu procés. | [D01](../p2/d01-nifi-intro.md), [D02](../p2/d02-nifi-flowfiles.md), [D16](../p2/d16-integracio.md), [D17](../p2/d17-prova.md) |
| **b** | S'ha determinat la ubicació de les fonts de dades, confirmant-ne el format, la ubicació (local o núvol) i la distribució física i lògica. | [D01](../p2/d01-nifi-intro.md), [D17](../p2/d17-prova.md) |
| **c** | S'ha accedit a dades en formats de text per a l'intercanvi de dades usant mètodes de lectura d'un llenguatge de programació. | [D04](../p2/d04-nifi-controllers.md), [D05](../p2/d05-json-xml.md), [D17](../p2/d17-prova.md) |
| **d** | S'han aplicat transformacions i filtres a dades en formats de text, com ara projeccions, seleccions, agregacions, ordenacions, unions, divisions o diferències. | [D03](../p2/d03-nifi-processors.md), [D04](../p2/d04-nifi-controllers.md), [D05](../p2/d05-json-xml.md), [D17](../p2/d17-prova.md) |
| **e** | S'ha paral·lelitzat l'accés, el filtre i la transformació en els orígens de dades, en funció dels sistemes disponibles (distribuïts, MPP o SMP) per al maneig de grans quantitats de dades. | [D11](../p2/d11-hdfs.md), [D15](../p2/d15-spark.md), [D17](../p2/d17-prova.md) |

## RA7

> Utilitza llenguatges per a l'emmagatzematge d'informació en fitxers de text estructurats per a l'intercanvi de dades (fitxers plans, XML i JSON), invocant els mètodes que executen cada operació.

| CA | Criteri | Sessions |
|:--:|---|---|
| **a** | S'han configurat passarel·les, connectors o eines d'accés als sistemes contenidors de dades per a automatitzar la captura d'informació i el seu procés. | [D02](../p2/d02-nifi-flowfiles.md), [D16](../p2/d16-integracio.md), [D17](../p2/d17-prova.md) |
| **b** | S'ha determinat la ubicació de les fonts de dades, confirmant-ne el format, la ubicació (local o núvol) i la distribució física i lògica. | [D02](../p2/d02-nifi-flowfiles.md), [D17](../p2/d17-prova.md) |
| **c** | S'han usat mètodes i instruccions per a generar fitxers de text estructurats per a l'intercanvi de dades. | [D04](../p2/d04-nifi-controllers.md), [D06](../p2/d06-fitxers-escriptura.md), [D17](../p2/d17-prova.md) |
| **d** | S'han usat mètodes per a la modificació i l'esborrat de dades en fitxers de text estructurats. | [D06](../p2/d06-fitxers-escriptura.md), [D17](../p2/d17-prova.md) |
| **e** | S'han usat mecanismes que garantisquen la confidencialitat de la informació en les dades generades. | [D10](../p2/d10-confidencialitat.md), [D17](../p2/d17-prova.md) |
| **f** | S'han paral·lelitzat les operacions de creació, modificació i esborrat de dades, en funció dels sistemes disponibles (distribuïts, MPP o SMP) per al maneig de grans quantitats de dades (big data). | [D11](../p2/d11-hdfs.md), [D15](../p2/d15-spark.md), [D17](../p2/d17-prova.md) |

## RA8

> Aplica les operacions d'accés, extracció i transformació de dades procedents d'altres fonts, com ara fonts de dades no estructurades, diferenciant segons el tipus de font.

| CA | Criteri | Sessions |
|:--:|---|---|
| **a** | S'han configurat passarel·les, connectors o eines d'accés als sistemes contenidors de dades per a automatitzar la captura d'informació i el seu procés. | [D09](../p2/d09-api-rest.md), [D17](../p2/d17-prova.md) |
| **b** | S'ha determinat la ubicació de les fonts de dades, confirmant-ne el format, la ubicació (local o núvol) i la distribució física i lògica. | [D09](../p2/d09-api-rest.md), [D17](../p2/d17-prova.md) |
| **c** | S'ha accedit a dades amb origen a Internet a partir de les ontologies descrites en metadades amb formats OWL com ara RDF. | [D14](../p2/d14-sparql.md), [D17](../p2/d17-prova.md) |
| **d** | S'han aplicat filtres i transformacions en origen a dades d'Internet accedides a partir de les seues metadades, usant llenguatges com SPARQL. | [D14](../p2/d14-sparql.md), [D17](../p2/d17-prova.md) |
| **e** | S'ha accedit a dades amb origen en dispositius IoT mitjançant sistemes SCADA, connectant-s'hi i consultant les dades que emmagatzemen. | [D12](../p2/d12-iot.md), [D17](../p2/d17-prova.md) |
| **f** | S'han aplicat filtres i transformacions en origen a dades de dispositius IoT mitjançant sistemes SCADA, usant llenguatges de programació i les API d'accés pròpies d'aquests sistemes. | [D12](../p2/d12-iot.md), [D17](../p2/d17-prova.md) |
| **g** | S'han paral·lelitzat les operacions d'extracció i transformació de dades, en funció dels sistemes disponibles (distribuïts, MPP o SMP) per al maneig de grans quantitats de dades (big data). | [D15](../p2/d15-spark.md), [D17](../p2/d17-prova.md) |
