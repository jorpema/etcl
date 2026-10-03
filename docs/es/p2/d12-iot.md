# D12 · IoT y sensórica

<div class="sessio-meta" markdown>
<span><strong>Fecha</strong> mi 13/01/2027</span>
<span><strong>Duración</strong> 3 h 40 min</span>
<span><span class="tag p2">Rafa · miércoles</span></span>
<span><strong>RA·CA</strong> <span class="ra">RA8 e</span> <span class="ra">RA8 f</span> <span class="ra">RA1 b</span></span>
</div>

!!! abstract "Qué trabajaremos"
    Raspberry Pi → MQTT (Mosquitto) → NiFi ConsumeMQTT → filtrado → PostgreSQL o fichero. Alternativas: OPC UA simulado o una opción combinada.

## Objetivos

Al terminar la sesión habrás trabajado estos criterios:

- **RA8.e** · Se ha accedido a datos con origen en dispositivos IoT mediante sistemas SCADA, conectándose y consultado los datos almacenados en ellos.
- **RA8.f** · Se han aplicado filtros y transformaciones en origen a los datos con origen en dispositivos IoT mediante sistemas SCADA, usando lenguajes de programación y API de acceso propios de estos sistemas.
- **RA1.b** · Se han clasificado las fuentes de datos y conocimiento según su origen, (sistemas gestores de datos, sistemas IoT, plataformas de datos en streaming, integración con APIs u otro), según su naturaleza (estructuradas, no estructuradas), según sean formales o no formales (audios, imágenes o textos de redes sociales).

## Teoría

!!! info "Ficha en preparación"
    La teoría de esta sesión aún se está redactando. Mientras tanto, tienes los apuntes de referencia en la sección **Material**.

## Práctica

Captura de la sensórica del centro.

## Alternativas tecnológicas

La sesión está planteada con **MQTT y la sensórica del centro**. Hay dos alternativas que se pueden activar si hace falta:

=== "MQTT + sensórica (opción elegida)"

    La Raspberry Pi del centro publica las lecturas en un *broker* Mosquitto y NiFi se suscribe con `ConsumeMQTT`. Es la más motivadora porque los datos son reales. **Limitación:** MQTT es mensajería IoT, no un SCADA propiamente dicho.

=== "OPC UA simulado"

    Un servidor OPC UA simulado (Python `asyncua` o Prosys Simulation Server) hace de SCADA. Se leen etiquetas, históricos y suscripciones con filtro *deadband*. Cumple literalmente el criterio «mediante sistemas SCADA».

=== "Combinada"

    La Raspberry Pi publica por MQTT y un servidor OPC UA simulado hace de SCADA. NiFi lee de ambos y unifica el formato. Es la cobertura más completa, pero necesita más preparación.

## Material

**Apuntes de referencia (web de Alberto Aparicio Vila)**

- —

**Material del profesorado (en Aules)**

- :material-file-document-outline: Big Data Aplicat · Azure, prácticas 2.1–2.4

**Pendiente de elaborar**

- :material-hammer-wrench: Material nuevo
