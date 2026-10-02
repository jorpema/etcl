# Glossari

Els termes marcats amb :material-dots-horizontal: a qualsevol pàgina de la web mostren aquesta definició si hi passes el ratolí.

## Procés ETL

ETL
:   *Extract, Transform, Load*. Procés que extrau dades de les fonts, les transforma i les carrega en un destí.

ELT
:   Variant en què primer es carreguen les dades en el destí i la transformació es fa allí, normalment amb SQL.

Staging (àrea intermèdia)
:   Zona on es deixen les dades tal com arriben de la font, abans de transformar-les.

Pipeline
:   Cadena de passos automatitzats per on circulen les dades, des de la font fins al destí.

Provenance (procedència)
:   Registre de per on ha passat cada dada i què se li ha fet. NiFi el guarda automàticament.

## Bases de dades i modelatge

OLTP
:   Base de dades operacional, normalitzada, pensada per a moltes transaccions xicotetes (altes, modificacions). Exemple: el programa de facturació.

OLAP
:   Model orientat a l'anàlisi: poques escriptures i consultes que agreguen molts registres.

Data warehouse (DW)
:   Magatzem de dades integrat i històric, pensat per a l'anàlisi.

Data mart
:   Subconjunt del DW d'un sol departament o procés (per exemple, compres).

Fet (taula de fets)
:   Taula central del model en estrella. Cada fila és un esdeveniment mesurable i té les **mesures** (quantitat, import…).

Dimensió
:   Taula que dona context al fet: qui, què, quan, on, com.

Grànul
:   Què representa **exactament** una fila de la taula de fets. Exemple: «una línia de producte d'una factura».

Clau subrogada (SK)
:   Identificador intern del DW, independent de la clau de l'origen. Permet integrar diverses fonts i guardar l'històric.

Clau de negoci
:   Identificador que ve del sistema origen (per exemple, `id_proveedor` de l'OLTP).

SCD
:   *Slowly Changing Dimension*. Estratègia per a quan canvia un atribut d'una dimensió. **Tipus 1:** se sobreescriu. **Tipus 2:** es crea una fila nova i es guarda l'històric.

Esquema en estrella / en floc de neu
:   En estrella, les dimensions estan desnormalitzades i connecten directament amb el fet. En floc de neu, les dimensions es normalitzen en diverses taules.

## Llenguatges SQL

DDL · DML · DCL · DQL
:   Definició (`CREATE`, `ALTER`), manipulació (`INSERT`, `UPDATE`, `DELETE`, `MERGE`), control de permisos (`GRANT`, `REVOKE`) i consulta (`SELECT`).

## Fonts i formats

Dades estructurades / semiestructurades / no estructurades
:   Amb un esquema fix (taules), amb una estructura flexible (JSON, XML) o sense estructura predefinida (text lliure, imatges, àudio).

CSV · JSON · XML
:   Formats de text per a intercanviar dades: taula plana, objectes niats i etiquetes niades.

Parquet
:   Format binari **columnar** i comprimit, molt usat en Big Data: llegeix només les columnes que necessites.

API REST
:   Servei web que torna dades (normalment en JSON) quan li fas una petició HTTP a una URL.

SCADA
:   Sistema industrial que supervisa sensors i màquines i en guarda les lectures.

MQTT
:   Protocol lleuger de missatgeria (publicar/subscriure) molt usat en IoT.

## Paral·lelisme i Big Data

SMP
:   Diversos processadors en **un sol servidor** que comparteixen la memòria.

MPP
:   **Molts servidors** (nodes) independents que es reparteixen les dades i treballen en paral·lel.

Data locality (processar prop de les dades)
:   Enviar el càlcul on estan les dades, en lloc de moure les dades on està el càlcul.

HDFS
:   Sistema de fitxers distribuït de Hadoop: divideix els fitxers en blocs i els replica en diversos nodes.
