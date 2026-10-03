# ETCL · Extracció, transformació i càrrega de dades des de fonts múltiples

Web del mòdul 5104 del Curs d'Especialització en Aprenentatge automàtic: gestió de dades i entrenament (curs 2026-27).

- **Valencià:** https://jorpema.github.io/etcl/
- **Castellano:** https://jorpema.github.io/etcl/es/

Professorat: **Jorge Penalba Mateu** (dilluns) i **Rafa Vidal Semper** (dimecres).
Material desenvolupat amb IA amb la revisió de Jorge Penalba Mateu i Rafa Vidal Semper. Llicència [CC BY-SA 4.0](LICENSE.md).

## Estructura

```
mkdocs.yml            configuració de la versió en valencià (arrel del lloc)
mkdocs.es.yml         configuració de la versió en castellà (/es/), hereta de mkdocs.yml
docs/ca/              pàgines en valencià
docs/es/              pàgines en castellà (mateixos noms de fitxer)
overrides/assets/     CSS, JS i icona compartits per les dues versions
includes/             definicions que apareixen en passar el ratolí (glossari / glosario)
shared/sql/           scripts de la pràctica OLTP → OLAP (font única)
tools/                dades del calendari (sessions.py), RA/CA (ra.py) i generador (genera.py)
.github/workflows/    publicació automàtica a GitHub Pages
```

## Treballar en local

```bash
pip install -r requirements.txt
python tools/genera.py                 # calendari, índexs, RA/CA, scripts i zip (totes dues llengües)
mkdocs serve                           # valencià: http://127.0.0.1:8000/etcl/
mkdocs serve -f mkdocs.es.yml -a 127.0.0.1:8001   # castellà
```

## Afegir o canviar sessions

1. Edita `tools/sessions.py`: cada sessió té les dades comunes i un bloc `ca` i un bloc `es`.
2. Executa `python tools/genera.py`. Regenera el calendari, els índexs i la pàgina de RA/CA i crea les fitxes noves en totes dues llengües. **No sobreescriu** les fitxes que ja existeixen.
3. Redacta la teoria en `docs/ca/...` i en `docs/es/...`. Els dos fitxers tenen el mateix nom.

## Continguts d'altres autors

Quan es copia o s'adapta contingut d'altres webs (per exemple, els apunts d'Alberto Aparicio Vila, https://alapvi.github.io/sbd/), s'indica just a sota amb un bloc `!!! quote "Font"`.

## Publicar

Cada `push` a `main` publica la web automàticament (GitHub Actions). A **Settings → Pages → Source** ha d'estar seleccionat **GitHub Actions**.
