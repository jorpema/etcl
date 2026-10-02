# El mòdul

## Què és una ETL i per què et fa falta

Abans d'entrenar qualsevol model d'aprenentatge automàtic, les dades han d'estar **disponibles, netes i juntes**. En una empresa real, però, estan escampades: una part en la base de dades del programa de facturació, una altra en fitxers Excel, una altra en una API d'un proveïdor i una altra en els sensors d'una fàbrica.

Un procés **ETL** (*Extract, Transform, Load*) és el conjunt de passos que porta les dades des d'aquestes fonts fins a un lloc on es poden analitzar:

1. **Extracció (E):** connectar-se a cada font i llegir-ne les dades.
2. **Transformació (T):** canviar-ne el format, filtrar, unir, calcular, anonimitzar…
3. **Càrrega (L, *load*):** guardar el resultat en el destí (un *data warehouse*, una base de dades NoSQL, fitxers Parquet…).

Quan la transformació es fa **dins** del sistema destí, després de carregar, se li diu **ELT**. Ho veuràs amb SQL a la pràctica del data warehouse.

## Dades del mòdul

| | |
|---|---|
| **Codi i nom** | 5104 · Extracció, transformació i càrrega de dades des de fonts múltiples |
| **Curs** | Curs d'Especialització en Aprenentatge automàtic: gestió de dades i entrenament |
| **Normativa** | Reial decret 183/2026 (BOE-A-2026-5869) |
| **Durada** | 115 h (13 ECTS) · 33 sessions de 3 h 40 min |
| **Calendari** | Del 5 d'octubre de 2026 al 17 de febrer de 2027 |
| **Horari** | Dilluns (Prof. 1) i dimecres (Prof. 2) |

## Com s'organitza

El mòdul el comparteixen **dos professors**, i cadascú treballa continguts diferents. No hi ha una sessió que repetisca la d'un altre dia, així que **totes dues sessions setmanals són imprescindibles**.

<div class="grid cards" markdown>

-   :material-database-cog-outline:{ .lg .middle } __Dilluns · Prof. 1__

    ---

    - Tipus de fonts de dades (RA1)
    - Bases de dades relacionals: consulta, model OLTP/OLAP, DDL, DML, DCL i càrrega massiva (RA2, RA3)
    - NoSQL: MongoDB i Elasticsearch (RA4, RA5)
    - Ampliació: Kibana i Power BI

    [:octicons-arrow-right-24: Sessions](../p1/index.md)

-   :material-transit-connection-variant:{ .lg .middle } __Dimecres · Prof. 2__

    ---

    - Apache NiFi des de zero
    - Fitxers CSV, JSON i XML: llegir, transformar i escriure (RA6, RA7)
    - Bases de dades i NoSQL des de NiFi (RA2, RA5)
    - API REST, IoT, web semàntica i Big Data (RA8)

    [:octicons-arrow-right-24: Sessions](../p2/index.md)

</div>

## Avaluació

En FP s'avalua **per resultats d'aprenentatge**: per a superar el mòdul has de superar tots els RA. Cada RA s'avalua amb les evidències de les sessions on es treballa (pràctiques lliurades i proves).

| Evidència | Quan | RA |
|---|---|---|
| Prova curta de tipus de fonts | dl 02/11 | RA1 |
| Pràctica *Del model OLTP al model OLAP* | lliurament dl 14/12 | RA2 c–e, RA3 |
| Prova de MongoDB i Elasticsearch | dl 25/01 | RA4, RA5 b–f |
| Lliurament de fitxers amb NiFi | dc 09/12 | RA6, RA7 |
| Lliurament de fonts externes | dc 10/02 | RA8 |
| Pipelines amb NiFi (BD i NoSQL) | al llarg del curs | RA2 a, b, f, g, RA5 a |
| Proves pràctiques finals | dl 15/02 i dc 17/02 | Tots |

!!! warning "Pendent de concretar"
    El professorat publicarà ací els **pesos** de cada evidència i els criteris de recuperació.

## Normes de les pràctiques

- Cada pràctica té un **enunciat**, una data de **lliurament** i una **rúbrica**.
- Lliura sempre el que demana l'apartat *Què has de lliurar*: scripts, captures i respostes a les preguntes.
- El codi ha de funcionar des de zero: comprova que els teus scripts s'executen en una base de dades buida abans de lliurar-los.
