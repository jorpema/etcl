# D12 · IoT i sensòrica

<div class="sessio-meta" markdown>
<span><strong>Data</strong> dc 13/01/2027</span>
<span><strong>Durada</strong> 3 h 40 min</span>
<span><span class="tag p2">Prof. 2 · dimecres</span></span>
<span><strong>RA·CA</strong> <span class="ra">RA8 e</span> <span class="ra">RA8 f</span> <span class="ra">RA1 b</span></span>
</div>

!!! abstract "Què treballarem"
    Raspberry Pi → MQTT (Mosquitto) → NiFi ConsumeMQTT → filtratge → PostgreSQL o fitxer. Alternatives: OPC UA simulat o una opció combinada.

## Objectius

En acabar la sessió hauràs treballat aquests criteris:

- **RA8.e** · S'ha accedit a dades amb origen en dispositius IoT mitjançant sistemes SCADA, connectant-s'hi i consultant les dades que emmagatzemen.
- **RA8.f** · S'han aplicat filtres i transformacions en origen a dades de dispositius IoT mitjançant sistemes SCADA, usant llenguatges de programació i les API d'accés pròpies d'aquests sistemes.
- **RA1.b** · S'han classificat les fonts de dades i coneixement segons l'origen (sistemes gestors de dades, sistemes IoT, plataformes de dades en streaming, integració amb API o altres), segons la naturalesa (estructurades, no estructurades) i segons siguen formals o no formals (àudios, imatges o textos de xarxes socials).

## Teoria

!!! info "Fitxa en preparació"
    La teoria d'aquesta sessió encara s'està redactant. Mentrestant, tens els apunts de referència a la secció **Material**.

## Pràctica

Captura de la sensòrica del centre.

## Alternatives tecnològiques

La sessió està plantejada amb **MQTT i la sensòrica del centre**. Hi ha dues alternatives que es poden activar si cal:

=== "MQTT + sensòrica (opció triada)"

    La Raspberry Pi del centre publica les lectures en un *broker* Mosquitto i NiFi s'hi subscriu amb `ConsumeMQTT`. És la més motivadora perquè les dades són reals. **Limitació:** MQTT és missatgeria IoT, no un SCADA pròpiament dit.

=== "OPC UA simulat"

    Un servidor OPC UA simulat (Python `asyncua` o Prosys Simulation Server) fa de SCADA. Es llegeixen etiquetes, històrics i subscripcions amb filtre *deadband*. Compleix literalment el criteri «mitjançant sistemes SCADA».

=== "Combinada"

    La Raspberry Pi publica per MQTT i un servidor OPC UA simulat fa de SCADA. NiFi llig de tots dos i unifica el format. És la cobertura més completa, però necessita més preparació.

## Material

**Apunts de referència (web d'alapvi)**

- —

**Material del professorat (a Aules)**

- :material-file-document-outline: Big Data Aplicat · Azure, pràctiques 2.1–2.4

**Pendent d'elaborar**

- :material-hammer-wrench: Material nou
