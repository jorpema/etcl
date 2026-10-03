# S01 · Tipus de dades i fonts

<div class="sessio-meta" markdown>
<span><strong>Data</strong> dl 05/10/2026</span>
<span><strong>Durada</strong> 3 h 40 min</span>
<span><span class="tag p1">Jorge · dilluns</span></span>
<span><strong>RA·CA</strong> <span class="ra">RA1 a</span> <span class="ra">RA1 b</span></span>
</div>

!!! abstract "Què treballarem"
    Abans de connectar-nos a cap font hem de saber **què tenim davant**: d'on ve la dada, quina naturalesa té, si és fiable, on està guardada i com està repartida. Totes les decisions d'una ETL (quina eina, quin connector, quin format de destí, quanta neteja caldrà) depenen d'aquestes respostes.

## Objectius

- **RA1.a** · Determinar la ubicació de les fonts de dades, classificant el format en què estan emmagatzemades, la ubicació (local o núvol) i la seua distribució física.
- **RA1.b** · Classificar les fonts segons l'origen (sistemes gestors, IoT, streaming, API…), segons la naturalesa (estructurades o no) i segons siguen formals o no formals (àudios, imatges o textos de xarxes socials).

## Per què importa conéixer les fonts

En aprenentatge automàtic hi ha una regla que no falla: **un model és tan bo com les dades amb què s'entrena** (*garbage in, garbage out*). Abans d'aplicar cap algorisme cal analitzar a fons les fonts de dades: on són, en quin format estan i quina naturalesa tenen.

Conéixer la tipologia d'una font permet dissenyar **processos ETL eficients**: triar el connector adequat, preveure quanta neteja necessitarà i minimitzar el soroll per a maximitzar la informació útil per a l'entrenament.

## 1. Dada, informació i coneixement

Una **dada** és un valor sense context: `38,2`. Quan li afegim context es converteix en **informació**: «la temperatura del sensor 4 a les 10:00 és de 38,2 °C». Quan la relacionem amb altres informacions i ens permet decidir, parlem de **coneixement**: «el sensor 4 supera els 38 °C cada dia a la mateixa hora; cal revisar la refrigeració».

Un procés ETL treballa amb dades, però el seu objectiu és fer possible que algú (una persona o un model d'aprenentatge automàtic) n'extraga informació i coneixement.

## 2. Cinc preguntes per a classificar qualsevol font

Davant de qualsevol font de dades, fes-te sempre aquestes cinc preguntes. Les desenvolupem una a una en els apartats següents.

<div class="grid cards" markdown>

-   :material-source-branch:{ .lg .middle } __1 · D'on ve?__

    ---

    **Origen**: SGBD, fitxers, API, sensors IoT, *streaming*, logs, SIG, xarxes socials…

-   :material-shape-outline:{ .lg .middle } __2 · Quina naturalesa té?__

    ---

    **Estructurada**, **semiestructurada** o **no estructurada**.

-   :material-check-decagram-outline:{ .lg .middle } __3 · És fiable?__

    ---

    **Formal** (sistemes oficials, validada) o **no formal** (generada per persones).

-   :material-map-marker-outline:{ .lg .middle } __4 · On està?__

    ---

    **Local** (*on-premise*), **núvol** o **híbrid**.

-   :material-server-network:{ .lg .middle } __5 · Com està repartida?__

    ---

    **Monolítica** (un sol node) o **distribuïda** (particionada, replicada).

</div>

## 3. Segons l'origen

L'**origen** és la procedència immediata de la informació. No és el mateix extraure dades d'un sistema transaccional que d'un sensor que envia lectures en temps real: canvia el connector, la freqüència i el volum.

| Origen | Què és | Exemple | Com hi accedirem en el curs |
|---|---|---|---|
| **Bases de dades transaccionals (OLTP)** | Sistemes que registren les operacions del dia a dia (vendes, altes d'usuaris). Les dades són molt estructurades i coherents, ideals per a models predictius basats en l'històric. | El programa de facturació guarda les compres en PostgreSQL | SQL, Python i NiFi amb JDBC |
| **Bases de dades NoSQL** | Gestors no relacionals pensats per a volum i flexibilitat. | Catàleg de productes en MongoDB | mongosh, pymongo, NiFi |
| **Fitxers** | Exportacions o intercanvis entre aplicacions. | CSV de l'ERP, JSON d'una aplicació, Excel de vendes | Python, NiFi |
| **API** | Serveis web que tornen dades quan se'ls fa una petició. | Previsió meteorològica d'Open-Meteo | Peticions HTTP des de NiFi o Python |
| **Sensors IoT** | Dispositius que capturen magnituds físiques (temperatura, humitat) i generen fluxos continus de valors numèrics amb marca de temps. | Sensors de temperatura del taller | MQTT, NiFi |
| **Plataformes de *streaming*** | Sistemes com Kafka que transporten esdeveniments en temps real. Les dades arriben en seqüència i demanen processament immediat. | Clics d'una web | NiFi, Spark |
| **Logs de servidors** | Registres d'esdeveniments d'aplicacions o infraestructures. Solen ser semiestructurats o text pla, amb molt de volum però poca estructura inicial. | Accessos a un servidor web | NiFi, Elasticsearch |
| **Sistemes d'informació geogràfica (SIG)** | Guarden dades espacials: combinen atributs en taula amb geometries complexes (punts, línies, polígons). | Mapa de parcel·les del Cadastre | API, fitxers GeoJSON |
| **Web i xarxes socials** | Contingut generat a Internet. | Comentaris, imatges, pàgines de la Wikipedia | API, SPARQL, *scraping* |

### 3.1 Serveis de dades: com «ens parlen» les fonts

Saber l'origen no és suficient: també cal saber **quin servei** ens dona la dada i què necessitem per a connectar-nos-hi.

=== "SGBD relacionals"

    - **Exemples:** MySQL, MariaDB, PostgreSQL, SQL Server, Oracle.
    - Donen el servei en un **port** de xarxa (PostgreSQL, el 5432) i s'hi accedeix amb un **client** (`psql`, DBeaver…).
    - Cada programa que s'hi connecta necessita un ***driver*** per al seu protocol (JDBC en Java i NiFi, psycopg en Python).
    - Utilitzen **SQL** per a consultes i modificacions.
    - Poden estar en **local** o en **remot** (un altre servidor o el núvol).

=== "Bases de dades NoSQL"

    - **Exemples:** MongoDB, Elasticsearch, DynamoDB, Firebase, Cosmos DB.
    - Solen usar **JSON** (o una variant, com BSON) per a comunicar-se.
    - Moltes ofereixen una **API REST**, a més dels seus propis llenguatges de consulta, sovint basats en JSON.
    - Són molt **escalables** i ràpides en lectura i escriptura.

=== "API"

    - Tornen la informació en **CSV, JSON o XML**.
    - Usen protocols estàndard per a les consultes: **REST** (el més habitual), **GraphQL**, **SOAP** o **gRPC**.
    - Algunes demanen una **clau d'accés** (*API key*) o un **SDK**: una llibreria del proveïdor per a usar-la des del teu llenguatge.

=== "Web scraping"

    - Quan una web **no té API**, es pot **simular la navegació** d'una persona: es descarrega l'HTML, s'hi localitzen les dades i s'extrauen.
    - Les dades extretes es transformen en formats més útils (CSV, JSON).
    - És el que fan els robots dels cercadors.
    - :warning: **No totes les pràctiques són legals** ni respecten les condicions d'ús de les webs. Consulta sempre el fitxer `robots.txt`, les condicions del servei i el RGPD si hi ha dades personals.

## 4. Segons la naturalesa

La **naturalesa** classifica les dades segons el seu **grau d'organització**. És la classificació més important per a una ETL, perquè determina **com s'han d'emmagatzemar, processar i preprocessar**.

### 4.1 Dades estructurades

**Què són.** Són les dades que segueixen un **format fix i ben definit**, normalment emmagatzemades en **taules amb files i columnes**. Cada element d'informació ocupa un camp concret i té un tipus de dada predeterminat (enter, data, text de 50 caràcters…). L'estructura, l'**esquema**, es defineix **abans** de guardar cap dada.

**Característiques**

- Organització rígida i ben definida.
- Accés fàcil amb **SQL** o altres llenguatges estructurats.
- **Alta qualitat i fiabilitat**, perquè solen provindre de sistemes transaccionals.
- Fàcils de validar i processar automàticament.

**Avantatges:** emmagatzematge eficient gràcies a l'estructura fixa, cerques i anàlisis molt ràpides, i facilitat per a aplicar regles de validació.
**Inconvenients:** poca flexibilitat davant de canvis en el model (afegir un camp obliga a modificar l'esquema) i no són adequades per a informació complexa o de format variable.

**On les trobem:** bases de dades relacionals (MySQL, PostgreSQL, Oracle), ERP, registres de vendes o factures, fulls de càlcul i alguns CSV.

!!! example "Exemple"
    Una taula de factures. Totes les files tenen exactament les mateixes columnes i cada columna, el seu tipus:

    | id | data | proveïdor | import |
    |---:|---|---|---:|
    | 1 | 2026-10-05 | ACME S.L. | 120,50 |
    | 2 | 2026-10-05 | Ferros Xàtiva | 89,00 |

### 4.2 Dades semiestructurades

**Què són.** Tenen informació **organitzada**, però **no segueixen una estructura rígida** com la d'una taula. No hi ha un esquema fix definit per endavant: l'estructura va **dins de la mateixa dada**, en forma d'**etiquetes**, **claus** o **delimitadors** (metadades) que descriuen cada valor. Dos registres poden tindre camps diferents i poden contindre estructures **niades** (una dada dins d'una altra) i **llistes**.

!!! note "Definició"
    Les dades semiestructurades permeten **flexibilitat en l'esquema** i faciliten la integració de fonts heterogènies, però necessiten ***parsers*** (analitzadors) específics per a llegir-les.

**Característiques**

- Estructura flexible i adaptable.
- Usen **metadades** (etiquetes o claus) per a descriure la informació.
- Més complexes de processar que les estructurades, però més manejables que les no estructurades.
- Molt habituals en entorns **web** i aplicacions modernes.

**Avantatges:** flexibilitat, facilitat d'integració entre sistemes i possibilitat d'evolucionar sense canvis dràstics en el model.
**Inconvenients:** anàlisi més complexa, necessitat d'eines de transformació i normalització (cal **aplanar-les** per a carregar-les en una taula) i risc d'**inconsistències** si no es gestionen bé.

**On les trobem:** JSON, XML, HTML, logs amb camps dinàmics, respostes d'API, lectures de sensors IoT, paquets de xarxa TCP/IP.

!!! example "Exemple"
    La mateixa factura en JSON. Fixa't que les línies estan **niades** dins de la factura i que el proveïdor té una **llista** de telèfons; un altre proveïdor podria no tindre'n cap, i el JSON seguiria sent vàlid:

    ```json
    {"id": 1, "data": "2026-10-05",
     "proveidor": {"nom": "ACME S.L.", "telefons": ["961 000 000", "962 000 000"]},
     "linies": [{"producte": "P-01", "quantitat": 3, "preu": 40.17}]}
    ```

### 4.3 Dades no estructurades

**Què són.** No segueixen cap model predefinit ni tenen una organització que un programa puga interpretar directament. Cada fitxer o document pot tindre un format diferent. Representen **la major part de la informació** que es genera avui, especialment en entorns digitals i xarxes socials.

**Característiques**

- Sense esquema: cada document pot ser diferent.
- Gran **varietat de formats**: text lliure, imatges, àudio, vídeo, PDF…
- Difícils de processar i analitzar automàticament.
- Necessiten tècniques avançades per a extraure'n valor: **processament del llenguatge natural** (NLP) per al text, **visió per computador** per a imatges i vídeos, **transcripció** per a l'àudio.

**Avantatges:** són la informació més abundant i rica en context, i la font clau de l'analítica predictiva i la intel·ligència artificial.
**Inconvenients:** difícils d'emmagatzemar i processar amb eines tradicionals, necessiten molta capacitat de càlcul i emmagatzematge, i la neteja i preparació costa molt de temps.

**On les trobem:** imatges i vídeos (fotografies, càmeres de seguretat), documents de text lliure (Word, PDF, correus), publicacions en xarxes socials, gravacions d'àudio, dades de sensors en brut.

!!! example "Exemple"
    La mateixa factura escanejada en PDF. Per a una persona té estructura (capçalera, línies, totals), però per a un programa només és una imatge o un conjunt de posicions de text. Cal **OCR** o un analitzador de documents per a convertir-la en dades estructurades.

### 4.4 Comparativa

| Característica | Estructurades | Semiestructurades | No estructurades |
|---|---|---|---|
| **Esquema fix** | Sí | Parcial | No |
| **Facilitat d'anàlisi** | Alta | Mitjana | Baixa |
| **Flexibilitat** | Baixa | Mitjana | Alta |
| **Eines habituals** | SQL, SGBD relacionals | JSON, XML, API, NoSQL | Big Data, NLP, IA |
| **Exemple típic** | Taula de clients | Fitxer JSON de logs | Vídeo d'una càmera |
| **Volum actual (aprox.)** | Menys del 10 % | Al voltant del 20 % | Més del 70 % |

### 4.5 On es guarda cada tipus

- **Estructurades:** bases de dades relacionals (SQL) i *data warehouses* per a l'anàlisi.
- **Semiestructurades:** bases de dades **NoSQL** (MongoDB, Cassandra) i eines d'integració (ETL/ELT).
- **No estructurades:** sistemes de fitxers distribuïts com **HDFS**, ***data lakes*** i algorismes d'IA per a l'anàlisi.

!!! quote "Font"
    Els apartats 4.1 a 4.5 (característiques, avantatges, inconvenients, comparativa i emmagatzematge) estan traduïts i adaptats de [«Tipos de datos»](https://alapvi.github.io/sbd/ingenieria-datos/ud1-introduccion/tipos-de-datos/), dels apunts de *Sistemas de Big Data* d'**Alberto Aparicio Vila** (IES Lluís Simarro). Les definicions, la nota sobre *parsers* i els exemples són d'elaboració pròpia i del tema *Tipologia de fonts de dades*.

## 5. Segons la formalitat

La **formalitat** indica com de **fiable** és una dada i, per tant, quant de preprocessament necessitarà.

Dades formals
:   Les generen sistemes oficials o automatitzats amb **validació estricta**: registres bancaris, dades meteorològiques oficials, el programa de facturació. Tenen alta qualitat i metadades clares.

Dades no formals
:   Les generen persones o dispositius personals sense cap control: tuits, comentaris en fòrums, fotos penjades a xarxes socials, notes de veu. Solen tindre **soroll**, faltes d'ortografia, **biaixos** i falta de context.

!!! warning "Atenció"
    Les dades no formals necessiten fases de **neteja i normalització** molt més intenses. En aprenentatge automàtic, un excés de soroll pot degradar el rendiment del model si no es gestiona bé.

## 6. Segons la ubicació

La ubicació determina **l'estratègia d'accés i els costos**.

**Local (*on-premise*)**
:   Les dades són en discos de servidors propis, en les instal·lacions de l'organització. Hi ha **control total** i poca latència per a l'accés intern, però l'escalabilitat és limitada i cal mantindre el maquinari i fer-ne les còpies de seguretat.

**Núvol**
:   Serveis gestionats per proveïdors externs (AWS, Azure, Google Cloud, Supabase, MongoDB Atlas…). Hi accedim per Internet, normalment amb credencials i xifratge. Hi ha tres tipus d'emmagatzematge:

    - **D'objectes:** ideal per a grans volums de dades no estructurades (imatges, logs). Exemples: Amazon S3, Azure Blob Storage.
    - **De blocs:** discos virtuals per a bases de dades o aplicacions.
    - **De fitxers:** sistemes de fitxers compartits.

    El núvol permet **escalar de manera elàstica** i pagar només pel que es consumeix, però crea dependència de la connectivitat i obliga a tindre en compte la seguretat i la privacitat.

**Híbrid**
:   Una part en local i una altra al núvol. És el cas més habitual en empreses.

!!! question "Per què t'importa com a enginyer o enginyera de dades?"
    Si la font està al núvol, potser la teua ETL tindrà **latència** i **costos de transferència**. Si és un fitxer local del departament de compres, potser arribarà per correu o per una carpeta compartida. La ubicació condiciona el **connector** que necessitaràs.

## 7. Segons la distribució física

Finalment, cal analitzar com estan **repartides** les dades.

**Monolítica**
:   Totes les dades són en un únic node o ubicació centralitzada. Simplifica la gestió, però crea **colls de botella** i un **punt únic de fallada**: si cau el servidor, cau tot.

**Distribuïda**
:   Les dades es reparteixen entre diversos nodes, potser en llocs geogràfics diferents. Hi ha dues tècniques, que sovint es combinen:

    - ***Sharding*** **(particionament):** cada node guarda **una part** de les dades (per exemple, un any de factures cadascun) per a millorar el rendiment.
    - **Replicació:** es **copien** les dades en diversos nodes per a tindre alta disponibilitat i lectures més ràpides.

La distribució afecta directament la **latència** (quant es tarda a accedir a la dada) i la **coherència** (que tots els nodes tinguen la mateixa versió de la dada). En arquitectures distribuïdes és clau el principi de **processar prop de les dades**, per a reduir el trànsit de xarxa. Ho veurem a fons a [S03](s03-entorns-arquitectures.md).

## 8. Exemple resolt

!!! example "Una empresa de logística"
    Una empresa de logística té sensors en els camions que envien les coordenades GPS cada minut. Apliquem les cinc preguntes:

    | Pregunta | Resposta | Per què |
    |---|---|---|
    | D'on ve? | **IoT** | Dispositius físics connectats |
    | Quina naturalesa té? | **Semiestructurada** | JSON amb latitud, longitud i *timestamp* |
    | És fiable? | **No formal** | Pot tindre errors de senyal (punts fora de la carretera, salts) |
    | On està? | **Núvol** | Es guarda en Amazon S3 |
    | Com està repartida? | **Distribuïda** | S3 reparteix i replica els objectes |

    **Conseqüència per a l'ETL:** abans d'alimentar un model d'optimització de rutes caldrà **netejar** les lectures errònies i **aplanar** el JSON.

## Material

- :material-file-document-outline: *Tipologia de fonts de dades i sistemes de gestió* (tema complet, a Aules)
- :material-file-document-outline: *Tipus de dades.pdf* (Aules)
- :material-web: [Introducción a BI · Visión general](https://alapvi.github.io/sbd/ingenieria-datos/ud1-introduccion/) i [Tipos de datos](https://alapvi.github.io/sbd/ingenieria-datos/ud1-introduccion/tipos-de-datos/) (Alberto Aparicio Vila)
- :material-cloud-outline: Núvol de conceptes inicial (Mentimeter) i infografia de BI per al debat d'inici

## Exercicis

### Exercici 1 · Fitxa de classificació de fonts

**Durada:** 1 h aprox. · **En parelles**

Per a cada una d'aquestes fonts, omple una fila de la taula de baix:

1. La base de dades PostgreSQL del programa de compres d'una empresa.
2. Les lectures dels sensors de temperatura del taller del centre.
3. L'API d'Open-Meteo amb la previsió per a Xàtiva.
4. Un Excel que el departament de vendes envia cada divendres per correu.
5. Els comentaris que deixen els clients a Google Maps.
6. Les gravacions de les trucades d'atenció al client.
7. El catàleg de productes d'una botiga en línia guardat en MongoDB Atlas.
8. Els registres (*logs*) d'un servidor web.
9. Wikidata.
10. Una font de la teua elecció del teu cicle o de la teua empresa de pràctiques.

| Font | Origen | Naturalesa | Formal? | Format | Ubicació | Distribució | Com t'hi connectaries? |
|---|---|---|---|---|---|---|---|
| 1 | | | | | | | |

!!! success "Què has de lliurar"
    La taula completada i, per a **dues** de les fonts, un paràgraf que justifique quina dificultat principal tindria extraure-la.

### Exercici 2 · Fonts per a un projecte de predicció de vendes

Un supermercat de València vol desenvolupar un model d'aprenentatge automàtic per a predir les vendes diàries de productes frescos. Ha identificat quatre fonts de dades:

1. **Base de dades interna (TPV):** registres de transaccions dels últims 5 anys emmagatzemats en un servidor local del supermercat. Conté camps com `fecha`, `producto_id`, `cantidad`, `precio_unitario` i `cliente_id`. Format: CSV.
2. **Sensors IoT de les cambres frigorífiques:** dades de temperatura i humitat de les cambres d'emmagatzematge, enviades cada 5 minuts a una plataforma al núvol (AWS IoT). Format: JSON.
3. **Xarxes socials (Instagram):** comentaris i publicacions d'usuaris locals que mencionen el supermercat, extrets amb una API oficial. Format: text pla (UTF-8).
4. **API de meteorologia (AEMET):** temperatura màxima, mínima i precipitació de la ciutat, obtingudes amb una API REST. Format: XML.

**Tasca:** classifica cada font segons la **naturalesa**, l'**origen**, la **ubicació física** i la **formalitat**. Justifica breument cada classificació.

??? tip "Orientació"
    Les dades estructurades tenen un esquema fix (files i columnes); les no estructurades no tenen un format predefinit per a les màquines (com el text lliure). La ubicació física es refereix a **on estan emmagatzemades les dades originals**, no a on es processen. La formalitat depén de si les dades les generen processos oficials o usuaris espontanis.

??? success "Solució"
    **1. Base de dades interna (TPV)**

    - **Naturalesa:** estructurada. Té un esquema fix definit per columnes i tipus de dades.
    - **Origen:** sistema gestor de dades (SGBD). És el sistema central del negoci.
    - **Ubicació:** local. L'enunciat diu «servidor local».
    - **Formalitat:** formal. Són registres oficials de transaccions comercials.

    **2. Sensors IoT de les cambres frigorífiques**

    - **Naturalesa:** semiestructurada. El JSON té claus, però pot variar o niar-se; no és una taula plana fixa.
    - **Origen:** IoT. Provenen de dispositius físics connectats.
    - **Ubicació:** núvol (plataforma AWS IoT).
    - **Formalitat:** formal. Són dades tècniques generades per un sistema de control automatitzat.

    **3. Xarxes socials (Instagram)**

    - **Naturalesa:** no estructurada. El text lliure no té un esquema interpretable directament sense NLP.
    - **Origen:** API / xarxes socials.
    - **Ubicació:** núvol. Les dades són en els servidors de Meta.
    - **Formalitat:** no formal. Són opinions espontànies d'usuaris.

    **4. API de meteorologia (AEMET)**

    - **Naturalesa:** semiestructurada. L'XML té una estructura jeràrquica amb etiquetes, però no és una taula plana.
    - **Origen:** API de tercers.
    - **Ubicació:** núvol o centre de dades extern de l'AEMET.
    - **Formalitat:** formal. És informació oficial d'un organisme públic.

    | Font | Naturalesa | Origen | Ubicació | Formalitat |
    |---|---|---|---|---|
    | TPV | Estructurada | SGBD | Local | Formal |
    | Cambres IoT | Semiestructurada | IoT | Núvol | Formal |
    | Instagram | No estructurada | API / xarxa social | Núvol | No formal |
    | AEMET | Semiestructurada | API | Núvol | Formal |

!!! info "Més exercicis del tema"
    La resta d'exercicis del tema *Tipologia de fonts de dades i sistemes de gestió* estan a la sessió on es treballa la teoria corresponent: SQL vs NoSQL, conversió de formats, SCADA i xarxes socials a [S02](s02-gestors-formats.md); arquitectures de processament, diagrama d'ingesta i *edge computing* a [S03](s03-entorns-arquitectures.md).

## Per a repassar

??? question "Una factura en PDF és una dada estructurada?"
    Per a una persona té estructura (capçalera, línies, totals), però per a un ordinador és **no estructurada**: el PDF guarda posicions de text, no camps. Cal extraure-la (amb un analitzador de PDF o OCR) per a convertir-la en dades estructurades.

??? question "Un JSON sempre és semiestructurat?"
    Sí, pel format. Però si totes les respostes d'una API tenen sempre els mateixos camps i sense nivells niats, convertir-lo en una taula és trivial: en la pràctica es comporta quasi com una dada estructurada.

??? question "Un CSV és sempre estructurat?"
    Normalment sí, però només si totes les files tenen les mateixes columnes i els valors respecten el tipus esperat. Un CSV amb columnes que canvien, separadors barrejats o text lliure dins d'un camp (com una descripció amb comes) pot donar molts problemes. El CSV **no guarda el tipus** de cada columna: cal validar-lo en la ingesta.
