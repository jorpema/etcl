---
hide:
  - navigation
  - toc
---

<div class="etcl-hero" markdown>
<span class="etcl-blob b1"></span><span class="etcl-blob b2"></span><span class="etcl-blob b3"></span>

# Extracció, transformació i càrrega de dades des de fonts múltiples

Mòdul 5104 del Curs d'Especialització en **Aprenentatge automàtic: gestió de dades i entrenament**. Ací trobaràs la teoria, les pràctiques, el calendari i tot el que necessites per a portar dades de qualsevol font fins a on es puguen analitzar o servir per a entrenar un model.

[Comença pel calendari :material-calendar-month:](curs/calendari.md){ .md-button .md-button--primary }
[Què aprendràs :material-target:](curs/ra-ca.md){ .md-button }

<div class="etcl-pipeline" markdown>
<span markdown>:material-database-export: Extracció</span><i></i>
<span markdown>:material-swap-horizontal: Transformació</span><i></i>
<span markdown>:material-database-import: Càrrega</span>
</div>
</div>

<div class="xifres">
<div class="xifra"><b data-n="33">33</b><span>sessions</span></div>
<div class="xifra"><b data-n="121">121</b><span>hores de classe</span></div>
<div class="xifra"><b data-n="8">8</b><span>resultats d'aprenentatge</span></div>
<div class="xifra"><b data-n="51">51</b><span>criteris d'avaluació</span></div>
</div>

## On vols anar?

<div class="grid cards" markdown>

-   :material-school-outline:{ .lg .middle } __El mòdul__

    ---

    Què és una ETL, com s'organitza el curs, com s'avalua i qui en fa classe.

    [:octicons-arrow-right-24: Presentació](curs/index.md)

-   :material-calendar-month-outline:{ .lg .middle } __Calendari__

    ---

    Les 33 sessions, setmana a setmana, amb un filtre per professor i el progrés del curs.

    [:octicons-arrow-right-24: Calendari](curs/calendari.md)

-   :material-database-cog-outline:{ .lg .middle } __Dilluns · Prof. 1__

    ---

    Fonts i tipus de dades, el model relacional i el data warehouse, MongoDB, Elasticsearch i visualització.

    [:octicons-arrow-right-24: Sessions de dilluns](p1/index.md)

-   :material-transit-connection-variant:{ .lg .middle } __Dimecres · Prof. 2__

    ---

    Apache NiFi, fitxers, API REST, IoT, web semàntica i Big Data amb HDFS i Spark.

    [:octicons-arrow-right-24: Sessions de dimecres](p2/index.md)

-   :material-flask-outline:{ .lg .middle } __Pràctiques__

    ---

    Enunciats, scripts per descarregar i què has de lliurar en cada pràctica.

    [:octicons-arrow-right-24: Pràctiques](practiques/index.md)

-   :material-docker:{ .lg .middle } __Entorn de treball__

    ---

    Docker, PostgreSQL, NiFi i la resta d'eines. Com muntar-ho i els errors coneguts.

    [:octicons-arrow-right-24: Entorn](curs/entorn.md)

</div>

## El viatge d'una dada en aquest curs

```mermaid
flowchart LR
    subgraph F[Fonts]
      A[(BD relacional)]
      B[(NoSQL)]
      C[/CSV · JSON · XML/]
      D{{API REST}}
      E[[Sensors IoT]]
      G([Web semàntica])
    end
    F -->|Extracció| T[Transformació<br/>NiFi · SQL · Python · Spark]
    T -->|Càrrega| DW[(Data warehouse<br/>PostgreSQL)]
    T -->|Càrrega| NS[(MongoDB ·<br/>Elasticsearch)]
    T -->|Càrrega| L[(Fitxers · HDFS<br/>Parquet)]
    DW --> U[Anàlisi i<br/>entrenament de models]
    NS --> U
    L --> U
```

!!! tip "Com aprofitar aquesta web"
    - Cada sessió té una **fitxa** amb els criteris que es treballen, la teoria, la pràctica i el material.
    - Les paraules tècniques subratllades amb punts mostren una **definició** si hi passes el ratolí. Les tens totes al [glossari](recursos/glossari.md).
    - Fes servir el **cercador** (tecla ++s++) per a trobar qualsevol concepte.
