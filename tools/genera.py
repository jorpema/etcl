"""Genera, en VALENCIÀ i en CASTELLÀ:
  - el calendari, els índexs de Jorge i Rafa i la pàgina de RA/CA (sempre)
  - les fitxes de sessió que encara no existeixen (mai sobreescriu)
  - la còpia dels scripts SQL de shared/sql a cada idioma i el zip descarregable

Ús (des de l'arrel del repositori):  python tools/genera.py
"""
import datetime as dt
import os
import re
import shutil
import sys
import zipfile

sys.path.insert(0, os.path.dirname(__file__))
from sessions import P1, P2, FESTIUS, W, PROFES  # noqa: E402
from ra import RA, RA_ES  # noqa: E402

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
LANGS = ("ca", "es")
CA_TEXT = {"ca": RA, "es": RA_ES}

T = {
    "ca": dict(
        dies=["dl", "dt", "dc", "dj", "dv", "ds", "dg"],
        cal_title="Calendari del curs",
        cal_intro="Les 33 sessions del mòdul, de 3 h 40 min cadascuna. Els **dilluns** fa classe **Jorge Penalba Mateu** i els **dimecres**, **Rafa Vidal Semper**. Cada professor treballa continguts diferents, així que totes dues sessions de la setmana són imprescindibles.",
        f_all="Totes", f_p1="Dilluns · Jorge", f_p2="Dimecres · Rafa",
        week="Setmana del", festiu="Festiu",
        open="Obri la sessió", ra_label="Resultats d'aprenentatge",
        intro_p1=("Dilluns · Jorge Penalba Mateu",
                  "Fonts i tipus de dades, el model relacional (amb la pràctica **del model OLTP al model OLAP**), les bases de dades NoSQL (MongoDB i Elasticsearch) i, com a ampliació, la visualització amb Kibana i Power BI.",
                  "RA1, RA2 (c, d, e), RA3, RA4 i RA5 (b–f)"),
        intro_p2=("Dimecres · Rafa Vidal Semper",
                  "Apache NiFi des de zero, l'extracció i l'escriptura de fitxers, les bases de dades des de NiFi, les API REST, l'IoT, la web semàntica i el Big Data (HDFS i Spark).",
                  "RA2 (a, b, f, g), RA5 a, RA6, RA7 i RA8"),
        ra_title="Resultats d'aprenentatge i criteris d'avaluació",
        ra_intro=["Mòdul professional **5104 · Extracció, transformació i càrrega de dades des de fonts múltiples** (Reial decret 183/2026, de 11 de març; BOE-A-2026-5869). 115 hores · 13 ECTS.",
                  "Un **resultat d'aprenentatge (RA)** és el que has de saber fer en acabar el mòdul. Els **criteris d'avaluació (CA)** concreten com es comprova. Cada criteri enllaça amb les sessions on es treballa.",
                  '!!! note "Traducció"\n    El text oficial del BOE està en castellà; ací en tens una traducció fidel al valencià.'],
        th=("CA", "Criteri", "Sessions"),
        date="Data", dur="Durada", what="Què treballarem", obj="Objectius", obj_intro="En acabar la sessió hauràs treballat aquests criteris:",
        ampl="Ampliació del centre: no correspon a cap criteri del RD.", theory="Teoria",
        prep_t="Fitxa en preparació", prep="La teoria d'aquesta sessió encara s'està redactant. Mentrestant, tens els apunts de referència a la secció **Material**.",
        prac="Pràctica", mat="Material", ref="**Apunts de referència (web d'Alberto Aparicio Vila)**",
        aules="**Material del professorat (a Aules)**", pend="**Pendent d'elaborar**",
    ),
    "es": dict(
        dies=["lu", "ma", "mi", "ju", "vi", "sá", "do"],
        cal_title="Calendario del curso",
        cal_intro="Las 33 sesiones del módulo, de 3 h 40 min cada una. Los **lunes** da clase **Jorge Penalba Mateu** y los **miércoles**, **Rafa Vidal Semper**. Cada profesor trabaja contenidos diferentes, así que las dos sesiones de la semana son imprescindibles.",
        f_all="Todas", f_p1="Lunes · Jorge", f_p2="Miércoles · Rafa",
        week="Semana del", festiu="Festivo",
        open="Abrir la sesión", ra_label="Resultados de aprendizaje",
        intro_p1=("Lunes · Jorge Penalba Mateu",
                  "Fuentes y tipos de datos, el modelo relacional (con la práctica **del modelo OLTP al modelo OLAP**), las bases de datos NoSQL (MongoDB y Elasticsearch) y, como ampliación, la visualización con Kibana y Power BI.",
                  "RA1, RA2 (c, d, e), RA3, RA4 y RA5 (b–f)"),
        intro_p2=("Miércoles · Rafa Vidal Semper",
                  "Apache NiFi desde cero, la extracción y escritura de ficheros, las bases de datos desde NiFi, las API REST, el IoT, la web semántica y el Big Data (HDFS y Spark).",
                  "RA2 (a, b, f, g), RA5 a, RA6, RA7 y RA8"),
        ra_title="Resultados de aprendizaje y criterios de evaluación",
        ra_intro=["Módulo profesional **5104 · Extracción, transformación y carga de datos desde fuentes múltiples** (Real Decreto 183/2026, de 11 de marzo; BOE-A-2026-5869). 115 horas · 13 ECTS.",
                  "Un **resultado de aprendizaje (RA)** es lo que debes saber hacer al terminar el módulo. Los **criterios de evaluación (CA)** concretan cómo se comprueba. Cada criterio enlaza con las sesiones donde se trabaja.",
                  '!!! note "Texto oficial"\n    Texto literal del BOE-A-2026-5869 (incluida la errata «OLAT», que debe leerse OLTP).'],
        th=("CA", "Criterio", "Sesiones"),
        date="Fecha", dur="Duración", what="Qué trabajaremos", obj="Objetivos", obj_intro="Al terminar la sesión habrás trabajado estos criterios:",
        ampl="Ampliación del centro: no corresponde a ningún criterio del RD.", theory="Teoría",
        prep_t="Ficha en preparación", prep="La teoría de esta sesión aún se está redactando. Mientras tanto, tienes los apuntes de referencia en la sección **Material**.",
        prac="Práctica", mat="Material", ref="**Apuntes de referencia (web de Alberto Aparicio Vila)**",
        aules="**Material del profesorado (en Aules)**", pend="**Pendiente de elaborar**",
    ),
}


def d(iso):
    return dt.date.fromisoformat(iso)


def fdate(iso, lang):
    x = d(iso)
    return f"{T[lang]['dies'][x.weekday()]} {x:%d/%m/%Y}"


def parse_ra(tag):
    m = re.match(r"RA(\d)\s*(.*)", tag)
    if not m:
        return []
    n, rest = int(m.group(1)), m.group(2).strip()
    if not rest:
        return [(n, k) for k in RA[n][1]]
    if "-" in rest:
        a, b = rest.split("-")
        return [(n, chr(c)) for c in range(ord(a), ord(b) + 1)]
    return [(n, k.strip()) for k in rest.split(",")]


def ra_tag(r, lang):
    return "Ampliación" if (r == "Ampliació" and lang == "es") else r


SESS = []
for prof, lst in (("p1", P1), ("p2", P2)):
    for i, s in enumerate(lst, 1):
        SESS.append(dict(s, prof=prof, code=("S" if prof == "p1" else "D") + f"{i:02d}"))
SESS.sort(key=lambda s: s["date"])


def tags(ras, lang):
    return " ".join(f'<span class="ra">{ra_tag(r, lang)}</span>' for r in ras)


def prof_tag(p, lang):
    pr = PROFES[p]
    return f'<span class="tag {p}">{pr["curt"]} · {pr["dia"][lang]}</span>'


def out(lang, *parts):
    return os.path.join(ROOT, "docs", lang, *parts)


def calendari(lang):
    t = T[lang]
    items = sorted([("s", s["date"], s) for s in SESS] + [("f", f[0], f[1][lang]) for f in FESTIUS], key=lambda x: x[1])
    dates = ",".join(s["date"] for s in SESS)
    o = [f"# {t['cal_title']}", "", t["cal_intro"], "",
         f'<div class="progres" data-dates="{dates}"><div></div></div>', '<small id="progres-text"></small>', "",
         '<div class="filtres">', f'<button class="actiu" data-f="tots">{t["f_all"]}</button>',
         f'<button data-f="p1">{t["f_p1"]}</button>', f'<button data-f="p2">{t["f_p2"]}</button>', "</div>", "",
         '<div class="timeline" markdown>', ""]
    week = None
    for kind, date, obj in items:
        x = d(date)
        monday = x - dt.timedelta(days=x.weekday())
        if monday != week:
            week = monday
            o += [f'<div class="tl-week">{t["week"]} {monday:%d/%m}</div>', ""]
        if kind == "f":
            o += [f'<div class="tl-item festiu" data-date="{date}" markdown>',
                  f'<span class="tl-date">{fdate(date, lang)}</span> <span class="tag festiu">{t["festiu"]}</span> {obj}', "</div>", ""]
        else:
            s = obj
            o += [f'<div class="tl-item {s["prof"]}" data-date="{date}" markdown>',
                  f'<span class="tl-date">{fdate(date, lang)}</span> [{s["code"]} · {s[lang]["title"]}](../{s["prof"]}/{s["file"]}.md)  ',
                  f'{prof_tag(s["prof"], lang)} {tags(s["ras"], lang)}', "</div>", ""]
    o += ["</div>", ""]
    open(out(lang, "curs", "calendari.md"), "w").write("\n".join(o))


def index(prof, lang):
    t = T[lang]
    title, desc, ras = t["intro_" + prof]
    o = [f"# {title}", "", desc, "", f"**{t['ra_label']}:** {ras}.", "", '<div class="grid cards" markdown>', ""]
    for s in [x for x in SESS if x["prof"] == prof]:
        icon = ":material-book-open-variant:" if s["estat"] == "redactada" else ":material-progress-pencil:"
        o += [f'-   {icon}{{ .lg .middle }} __{s["code"]} · {s[lang]["title"]}__', "", "    ---", "",
              f'    {fdate(s["date"], lang)} · {", ".join(ra_tag(r, lang) for r in s["ras"])}', "",
              f'    {s[lang]["cont"]}', "", f'    [:octicons-arrow-right-24: {t["open"]}]({s["file"]}.md)', ""]
    o += ["</div>", ""]
    open(out(lang, prof, "index.md"), "w").write("\n".join(o))


def ra_ca(lang):
    t = T[lang]
    where = {}
    for s in SESS:
        for tg in s["ras"]:
            for k in parse_ra(tg):
                where.setdefault(k, []).append(s)
    o = [f"# {t['ra_title']}", ""] + sum([[p, ""] for p in t["ra_intro"]], [])
    for n, (txt, cas) in CA_TEXT[lang].items():
        o += [f"## RA{n}", "", f"> {txt}", "", "| {} | {} | {} |".format(*t["th"]), "|:--:|---|---|"]
        for k, ctext in cas.items():
            links = ", ".join(f'[{s["code"]}](../{s["prof"]}/{s["file"]}.md)' for s in where.get((n, k), [])) or "—"
            o.append(f"| **{k}** | {ctext} | {links} |")
        o.append("")
    open(out(lang, "curs", "ra-ca.md"), "w").write("\n".join(o))
    return [(n, k) for n, (_, cas) in RA.items() for k in cas if (n, k) not in where]


def fitxa(s, lang):
    path = out(lang, s["prof"], s["file"] + ".md")
    if os.path.exists(path):
        return False
    t, L = T[lang], s[lang]
    objs = [f"- **RA{n}.{k}** · {CA_TEXT[lang][n][1][k]}" for tg in s["ras"] for n, k in parse_ra(tg)
            if n in CA_TEXT[lang] and k in CA_TEXT[lang][n][1]]
    web = "\n".join(f"- :material-web: [{a}]({W}{u})" for a, u in s["web"]) or "- —"
    aules = "\n".join(f"- :material-file-document-outline: {a}" for a in L["aules"]) or "- —"
    nou = "\n".join(f"- :material-hammer-wrench: {a}" for a in L["nou"])
    o = [f"# {s['code']} · {L['title']}", "", '<div class="sessio-meta" markdown>',
         f'<span><strong>{t["date"]}</strong> {fdate(s["date"], lang)}</span>',
         f'<span><strong>{t["dur"]}</strong> 3 h 40 min</span>', f'<span>{prof_tag(s["prof"], lang)}</span>',
         f'<span><strong>RA·CA</strong> {tags(s["ras"], lang)}</span>', "</div>", "",
         f'!!! abstract "{t["what"]}"', f"    {L['cont']}", "", f"## {t['obj']}", "", t["obj_intro"], "",
         *(objs or [f"- {t['ampl']}"]), "", f"## {t['theory']}", "",
         f'!!! info "{t["prep_t"]}"', f"    {t['prep']}", ""]
    if L["prac"]:
        o += [f"## {t['prac']}", "", L["prac"], ""]
    o += [f"## {t['mat']}", "", t["ref"], "", web, "", t["aules"], "", aules, ""]
    if nou:
        o += [t["pend"], "", nou, ""]
    open(path, "w").write("\n".join(o))
    return True


def sql(lang):
    dst = out(lang, "practiques", "oltp-olap", "sql")
    if os.path.exists(dst):
        shutil.rmtree(dst)
    shutil.copytree(os.path.join(ROOT, "shared", "sql"), dst)
    zp = out(lang, "practiques", "oltp-olap", "compras_sql.zip")
    with zipfile.ZipFile(zp, "w", zipfile.ZIP_DEFLATED) as z:
        for f in sorted(os.listdir(dst)):
            z.write(os.path.join(dst, f), f"sql/{f}")


if __name__ == "__main__":
    for lang in LANGS:
        for sub in ("curs", "p1", "p2"):
            os.makedirs(out(lang, sub), exist_ok=True)
        calendari(lang)
        index("p1", lang)
        index("p2", lang)
        missing = ra_ca(lang)
        created = [s["code"] for s in SESS if fitxa(s, lang)]
        sql(lang)
        print(f"[{lang}] sessions {len(SESS)} · CA sense sessió: {missing or 'cap'} · fitxes noves: {', '.join(created) or 'cap'}")
