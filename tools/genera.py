"""Genera el calendari, els índexs de professorat, la pàgina de RA/CA
i les fitxes de sessió que encara no existeixen.

Ús (des de l'arrel del repositori):  python tools/genera.py
Les fitxes ja existents NO es sobreescriuen: edita-les a mà.
"""
import datetime as dt
import os
import re
import sys

sys.path.insert(0, os.path.dirname(__file__))
from sessions import P1, P2, FESTIUS, W  # noqa: E402
from ra import RA  # noqa: E402

ROOT = os.path.join(os.path.dirname(__file__), "..", "docs")
DIES = ["dl", "dt", "dc", "dj", "dv", "ds", "dg"]


def d(iso):
    return dt.date.fromisoformat(iso)


def fdate(iso):
    x = d(iso)
    return f"{DIES[x.weekday()]} {x:%d/%m/%Y}"


def code(prof, i):
    return ("S" if prof == "p1" else "D") + f"{i:02d}"


def parse_ra(tag):
    """'RA4 a' -> [(4,'a')] · 'RA2 a,b,f,g' -> ... · 'RA2 c-e' -> c,d,e · 'RA3' -> tots."""
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


SESS = []
for prof, lst in (("p1", P1), ("p2", P2)):
    for i, s in enumerate(lst, 1):
        f, date, title, ras, cont, prac, web, aules, nou, estat = s
        SESS.append(dict(prof=prof, code=code(prof, i), file=f, date=date, title=title,
                         ras=ras, cont=cont, prac=prac, web=web, aules=aules, nou=nou, estat=estat))
SESS.sort(key=lambda s: s["date"])


def tags(ras):
    return " ".join(f'<span class="ra">{r}</span>' for r in ras)


def prof_tag(p):
    return '<span class="tag p1">Prof. 1 · dilluns</span>' if p == "p1" else '<span class="tag p2">Prof. 2 · dimecres</span>'


# ---------------------------------------------------------------- calendari
def calendari():
    items = [("s", s["date"], s) for s in SESS] + [("f", f[0], f[1]) for f in FESTIUS]
    items.sort(key=lambda x: x[1])
    dates = ",".join(s["date"] for s in SESS)
    out = ["# Calendari del curs", "",
           "Les 33 sessions del mòdul, de 3 h 40 min cadascuna. Els **dilluns** fa classe el **Prof. 1** i els **dimecres**, el **Prof. 2**. "
           "Cada professor treballa continguts diferents, així que totes dues sessions de la setmana són imprescindibles.", "",
           f'<div class="progres" data-dates="{dates}"><div></div></div>',
           '<small id="progres-text"></small>', "",
           '<div class="filtres">',
           '<button class="actiu" data-f="tots">Totes</button>',
           '<button data-f="p1">Dilluns · Prof. 1</button>',
           '<button data-f="p2">Dimecres · Prof. 2</button>',
           "</div>", "",
           '<div class="timeline" markdown>', ""]
    week = None
    for kind, date, obj in items:
        x = d(date)
        monday = x - dt.timedelta(days=x.weekday())
        if monday != week:
            week = monday
            out += [f'<div class="tl-week">Setmana del {monday:%d/%m}</div>', ""]
        if kind == "f":
            out += [f'<div class="tl-item festiu" data-date="{date}" markdown>',
                    f'<span class="tl-date">{fdate(date)}</span> <span class="tag festiu">Festiu</span> {obj}', "</div>", ""]
        else:
            s = obj
            out += [f'<div class="tl-item {s["prof"]}" data-date="{date}" markdown>',
                    f'<span class="tl-date">{fdate(date)}</span> [{s["code"]} · {s["title"]}](../{s["prof"]}/{s["file"]}.md)  ',
                    f'{prof_tag(s["prof"])} {tags(s["ras"])}', "</div>", ""]
    out += ["</div>", ""]
    open(os.path.join(ROOT, "curs", "calendari.md"), "w").write("\n".join(out))


# ---------------------------------------------------------------- índexs P1/P2
INTRO = {
    "p1": ("Dilluns · Prof. 1",
           "Fonts i tipus de dades, el model relacional (amb la pràctica **del model OLTP al model OLAP**), "
           "les bases de dades NoSQL (MongoDB i Elasticsearch) i, com a ampliació, la visualització amb Kibana i Power BI.",
           "RA1, RA2 (c, d, e), RA3, RA4 i RA5 (b–f)"),
    "p2": ("Dimecres · Prof. 2",
           "Apache NiFi des de zero, l'extracció i l'escriptura de fitxers, les bases de dades des de NiFi, les API REST, "
           "l'IoT, la web semàntica i el Big Data (HDFS i Spark).",
           "RA2 (a, b, f, g), RA5 a, RA6, RA7 i RA8"),
}


def index(prof):
    title, desc, ras = INTRO[prof]
    out = [f"# {title}", "", desc, "", f"**Resultats d'aprenentatge:** {ras}.", "",
           '<div class="grid cards" markdown>', ""]
    for s in [x for x in SESS if x["prof"] == prof]:
        icon = ":material-book-open-variant:" if s["estat"] == "redactada" else ":material-progress-pencil:"
        out += [f'-   {icon}{{ .lg .middle }} __{s["code"]} · {s["title"]}__', "", "    ---", "",
                f'    {fdate(s["date"])} · {", ".join(s["ras"])}', "",
                f'    {s["cont"]}', "",
                f'    [:octicons-arrow-right-24: Obri la sessió]({s["file"]}.md)', ""]
    out += ["</div>", ""]
    open(os.path.join(ROOT, prof, "index.md"), "w").write("\n".join(out))


# ---------------------------------------------------------------- RA/CA
def ra_ca():
    where = {}
    for s in SESS:
        for t in s["ras"]:
            for k in parse_ra(t):
                where.setdefault(k, []).append(s)
    out = ["# Resultats d'aprenentatge i criteris d'avaluació", "",
           "Mòdul professional **5104 · Extracció, transformació i càrrega de dades des de fonts múltiples** "
           "(Reial decret 183/2026, de 11 de març; BOE-A-2026-5869). 115 hores · 13 ECTS.", "",
           "Un **resultat d'aprenentatge (RA)** és el que has de saber fer en acabar el mòdul. Els **criteris d'avaluació (CA)** "
           "concreten com es comprova. Cada criteri enllaça amb les sessions on es treballa.", "",
           "!!! note \"Traducció\"", "    El text oficial del BOE està en castellà; ací en tens una traducció fidel al valencià.", ""]
    for n, (txt, cas) in RA.items():
        out += [f"## RA{n}", "", f"> {txt}", "", "| CA | Criteri | Sessions |", "|:--:|---|---|"]
        for k, ctext in cas.items():
            ss = where.get((n, k), [])
            links = ", ".join(f'[{s["code"]}](../{s["prof"]}/{s["file"]}.md)' for s in ss) or "—"
            out.append(f"| **{k}** | {ctext} | {links} |")
        out.append("")
    open(os.path.join(ROOT, "curs", "ra-ca.md"), "w").write("\n".join(out))
    missing = [(n, k) for n, (_, cas) in RA.items() for k in cas if (n, k) not in where]
    return missing


# ---------------------------------------------------------------- fitxes plantilla
def fitxa(s):
    path = os.path.join(ROOT, s["prof"], s["file"] + ".md")
    if os.path.exists(path):
        return False
    objs = []
    for t in s["ras"]:
        for n, k in parse_ra(t):
            if n in RA and k in RA[n][1]:
                objs.append(f"- **RA{n}.{k}** · {RA[n][1][k]}")
    web = "\n".join(f"- :material-web: [{t}]({W}{u})" for t, u in s["web"]) or "- —"
    aules = "\n".join(f"- :material-file-document-outline: {a}" for a in s["aules"]) or "- —"
    nou = "\n".join(f"- :material-hammer-wrench: {a}" for a in s["nou"])
    out = [f"# {s['code']} · {s['title']}", "",
           '<div class="sessio-meta" markdown>',
           f'<span><strong>Data</strong> {fdate(s["date"])}</span>',
           f'<span><strong>Durada</strong> 3 h 40 min</span>',
           f'<span>{prof_tag(s["prof"])}</span>',
           f'<span><strong>RA·CA</strong> {tags(s["ras"])}</span>',
           "</div>", "",
           '!!! abstract "Què treballarem"', f"    {s['cont']}", "",
           "## Objectius", "", "En acabar la sessió hauràs treballat aquests criteris:", "",
           *(objs or ["- Ampliació del centre: no correspon a cap criteri del RD."]), "",
           "## Teoria", "",
           '!!! info "Fitxa en preparació"',
           "    La teoria d'aquesta sessió encara s'està redactant. Mentrestant, tens els apunts de referència a la secció **Material**.", ""]
    if s["prac"]:
        out += ["## Pràctica", "", s["prac"], ""]
    out += ["## Material", "", "**Apunts de referència (web d'alapvi)**", "", web, "",
            "**Material del professorat (a Aules)**", "", aules, ""]
    if nou:
        out += ["**Pendent d'elaborar**", "", nou, ""]
    open(path, "w").write("\n".join(out))
    return True


if __name__ == "__main__":
    calendari()
    index("p1")
    index("p2")
    missing = ra_ca()
    created = [s["code"] for s in SESS if fitxa(s)]
    print(f"Sessions: {len(SESS)} (P1 {sum(s['prof']=='p1' for s in SESS)}, P2 {sum(s['prof']=='p2' for s in SESS)})")
    print("CA sense sessió:", missing or "cap")
    print("Fitxes noves:", ", ".join(created) or "cap")
