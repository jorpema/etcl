# S08 · Pràctica: càrrega massiva

<div class="sessio-meta" markdown>
<span><strong>Data</strong> dl 30/11/2026</span>
<span><strong>Durada</strong> 3 h 40 min</span>
<span><span class="tag p1">Jorge · dilluns</span></span>
<span><strong>RA·CA</strong> <span class="ra">RA3 f</span> <span class="ra">RA2 c</span></span>
<span><strong>Pràctica</strong> [OLTP → OLAP, part 4](../practiques/oltp-olap/index.md)</span>
</div>

!!! abstract "Què treballarem"
    Farem créixer l'OLTP fins a **100.000 línies**, tornarem a carregar el DW i mesurarem quina diferència hi ha entre les eines de **càrrega massiva** del SGBD (`COPY`) i la inserció fila a fila. Al final llegirem i carregarem dades des de **Python**.

## Objectius

- **RA3.f** · Usar eines de càrrega massiva pròpies d'un SGBD relacional des de fitxers plans o altres fonts externes.
- **RA2.c** · Accedir a les bases de dades amb DQL embegut en un llenguatge amfitrió (*host*).

## 1. Escalar l'OLTP i recarregar el DW

```sql
\i 07_scale_100k.sql      -- tarda uns segons
\i 04_load_olap.sql       -- l'script buida el fet i el torna a carregar
```

Comprova que la **reconciliació** torna a quadrar amb 100.000 línies. L'script `04_load_olap.sql` és **re-executable**: per això el pots llançar tantes vegades com calga.

## 2. `COPY` i `\copy`

| | `COPY` | `\copy` |
|---|---|---|
| Qui llig el fitxer | El **servidor** de PostgreSQL | El **client** `psql` |
| On ha d'estar el fitxer | En la màquina del servidor (dins del contenidor) | En el teu equip |
| Permisos | Superusuari o rol `pg_read_server_files` | Els teus |

Tots dos usen el mateix mecanisme intern: llegeixen el fitxer en bloc i escriuen les files **sense passar per l'analitzador SQL una vegada per fila**.

## 3. Mesura-ho

Executa `10_copy_massiva.sql` i omple aquesta taula amb els temps (`\timing`):

| Mètode | Files | Temps | Temps estimat per a 100.000 |
|---|---:|---:|---:|
| `\copy … FROM 'hecho_compras.csv'` | 100.000 | | |
| `INSERT … SELECT` | 100.000 | | |
| `INSERT` fila a fila (bucle) | 2.000 | | |

!!! question "Preguntes"
    1. Quantes vegades més lent és l'`INSERT` fila a fila que `\copy`, extrapolat a 100.000 files?
    2. `INSERT … SELECT` és ràpid perquè no llig cap fitxer. Quan **no** el podries usar?
    3. La taula `hecho_compras_copia` no té índexs ni FK. Afig-li un índex i una FK i repeteix el `\copy`. Què passa amb el temps? Per què en les càrregues massives grans es desactiven els índexs i es tornen a crear al final?

## 4. Python com a llenguatge amfitrió

Les ETL sovint es programen en un llenguatge amfitrió que **embeu** les sentències SQL. Instal·la el driver:

```bash
pip install "psycopg[binary]" pandas
```

```python title="extraccio.py"
import psycopg
import pandas as pd

CONN = "host=localhost port=5432 dbname=postgres user=postgres password=etcl2627"

SQL = """
    SELECT dpr.tipo_proveedor, dt.anio, SUM(h.importe_total) AS total
    FROM dw_compras.hecho_compras h
    JOIN dw_compras.dim_proveedor dpr USING (sk_proveedor)
    JOIN dw_compras.dim_tiempo dt USING (sk_tiempo)
    WHERE dt.anio = %s
    GROUP BY 1, 2 ORDER BY total DESC
"""

with psycopg.connect(CONN) as conn, conn.cursor() as cur:
    # 1. DQL embegut amb paràmetres (%s): mai concatenes text, per evitar SQL injection
    cur.execute(SQL, (2025,))
    files = cur.fetchall()                       # llista de tuples Python
    df = pd.DataFrame(files, columns=[c.name for c in cur.description])
    print(df)

    # 2. Càrrega massiva des de Python amb COPY
    cur.execute("CREATE TABLE IF NOT EXISTS dw_compras.resum_python (tipo text, anio int, total numeric)")
    with cur.copy("COPY dw_compras.resum_python (tipo, anio, total) FROM STDIN") as copy:
        for fila in files:
            copy.write_row(fila)
# en eixir del bloc 'with', psycopg fa COMMIT automàticament
```

!!! question "Repte"
    Modifica l'script perquè llija un **CSV extern** (per exemple, una llista de preus de proveïdors), el transforme amb pandas i el carregue amb `COPY` en una taula d'staging.

## Abans d'eixir

- [ ] L'OLTP té 100.000 línies i la reconciliació quadra.
- [ ] Tinc la taula de temps completada i les preguntes respostes.
- [ ] El meu script Python funciona i està al lliurament.
