# ETCL · Extracció, transformació i càrrega de dades des de fonts múltiples

Web del mòdul 5104 del Curs d'Especialització en Aprenentatge automàtic: gestió de dades i entrenament (curs 2026-27).

**Web publicada:** https://jorpema.github.io/etcl/

## Estructura

```
docs/                 contingut de la web (Markdown)
  curs/               presentació, calendari, RA/CA i entorn
  p1/  p2/            fitxes de sessió de dilluns i dimecres
  practiques/         enunciats i scripts
  recursos/           glossari i enllaços
  assets/             CSS, JS i icona
includes/glossari.md  definicions que apareixen en passar el ratolí
tools/                dades del calendari i generador
.github/workflows/    publicació automàtica a GitHub Pages
```

## Treballar en local

```bash
pip install -r requirements.txt
mkdocs serve          # http://127.0.0.1:8000, es recarrega en guardar
```

## Afegir o canviar sessions

1. Edita `tools/sessions.py` (dates, títols, RA/CA, material).
2. Executa `python tools/genera.py`: regenera el calendari, els índexs i la pàgina de RA/CA, i crea les fitxes noves. **No sobreescriu** les fitxes existents.
3. Redacta la teoria directament en `docs/p1/…` o `docs/p2/…`.

## Publicar

Cada `push` a `main` publica la web automàticament (GitHub Actions). La primera vegada cal anar a **Settings → Pages → Source: GitHub Actions**.
