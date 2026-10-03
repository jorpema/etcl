# El módulo

## Qué es una ETL y por qué la necesitas

Antes de entrenar cualquier modelo de aprendizaje automático, los datos tienen que estar **disponibles, limpios y juntos**. En una empresa real, sin embargo, están dispersos: una parte en la base de datos del programa de facturación, otra en ficheros Excel, otra en una API de un proveedor y otra en los sensores de una fábrica.

Un proceso **ETL** (*Extract, Transform, Load*) es el conjunto de pasos que lleva los datos desde esas fuentes hasta un lugar donde se pueden analizar:

1. **Extracción (E):** conectarse a cada fuente y leer sus datos.
2. **Transformación (T):** cambiar el formato, filtrar, unir, calcular, anonimizar…
3. **Carga (L, *load*):** guardar el resultado en el destino (un *data warehouse*, una base de datos NoSQL, ficheros Parquet…).

Cuando la transformación se hace **dentro** del sistema destino, después de cargar, se llama **ELT**. Lo verás con SQL en la práctica del data warehouse.

## Datos del módulo

| | |
|---|---|
| **Código y nombre** | 5104 · Extracción, transformación y carga de datos desde fuentes múltiples |
| **Curso** | Curso de Especialización en Aprendizaje automático: gestión de datos y entrenamiento |
| **Normativa** | Real Decreto 183/2026 (BOE-A-2026-5869) y Decreto 95/2026 (DOGV) |
| **Duración** | 115 h (13 ECTS) · 33 sesiones de 3 h 40 min |
| **Calendario** | Del 5 de octubre de 2026 al 17 de febrero de 2027 |
| **Horario** | Lunes (Jorge Penalba Mateu) y miércoles (Rafa Vidal Semper) |

## Cómo se organiza

El módulo lo comparten **Jorge Penalba Mateu** (lunes) y **Rafa Vidal Semper** (miércoles), y cada uno trabaja contenidos diferentes. No hay ninguna sesión que repita la de otro día, así que **las dos sesiones semanales son imprescindibles**.

<div class="grid cards" markdown>

-   :material-database-cog-outline:{ .lg .middle } __Lunes · Jorge Penalba Mateu__

    ---

    - Tipos de fuentes de datos (RA1)
    - Bases de datos relacionales: consulta, modelo OLTP/OLAP, DDL, DML, DCL y carga masiva (RA2, RA3)
    - NoSQL: MongoDB y Elasticsearch (RA4, RA5)
    - Ampliación: Kibana y Power BI

    [:octicons-arrow-right-24: Sesiones](../p1/index.md)

-   :material-transit-connection-variant:{ .lg .middle } __Miércoles · Rafa Vidal Semper__

    ---

    - Apache NiFi desde cero
    - Ficheros CSV, JSON y XML: leer, transformar y escribir (RA6, RA7)
    - Bases de datos y NoSQL desde NiFi (RA2, RA5)
    - API REST, IoT, web semántica y Big Data (RA8)

    [:octicons-arrow-right-24: Sesiones](../p2/index.md)

</div>

## Evaluación

En FP se evalúa **por resultados de aprendizaje**: para superar el módulo tienes que superar todos los RA. Cada RA se evalúa con las evidencias de las sesiones donde se trabaja (prácticas entregadas y pruebas).

| Evidencia | Cuándo | RA |
|---|---|---|
| Prueba corta de tipos de fuentes | lu 02/11 | RA1 |
| Práctica *Del modelo OLTP al modelo OLAP* | entrega lu 14/12 | RA2 c–e, RA3 |
| Prueba de MongoDB y Elasticsearch | lu 25/01 | RA4, RA5 b–f |
| Entrega de ficheros con NiFi | mi 09/12 | RA6, RA7 |
| Entrega de fuentes externas | mi 10/02 | RA8 |
| Pipelines con NiFi (BD y NoSQL) | a lo largo del curso | RA2 a, b, f, g, RA5 a |
| Pruebas prácticas finales | lu 15/02 y mi 17/02 | Todos |

!!! warning "Pendiente de concretar"
    El profesorado publicará aquí los **pesos** de cada evidencia y los criterios de recuperación.

## Normas de las prácticas

- Cada práctica tiene un **enunciado**, una fecha de **entrega** y una **rúbrica**.
- Entrega siempre lo que pide el apartado *Qué tienes que entregar*: scripts, capturas y respuestas a las preguntas.
- El código tiene que funcionar desde cero: comprueba que tus scripts se ejecutan en una base de datos vacía antes de entregarlos.
