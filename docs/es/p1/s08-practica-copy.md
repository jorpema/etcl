# S08 · Práctica: carga masiva

<div class="sessio-meta" markdown>
<span><strong>Fecha</strong> lu 30/11/2026</span>
<span><strong>Duración</strong> 3 h 40 min</span>
<span><span class="tag p1">Jorge · lunes</span></span>
<span><strong>RA·CA</strong> <span class="ra">RA3 f</span> <span class="ra">RA2 c</span></span>
<span><strong>Práctica</strong> [OLTP → OLAP, parte 4](../practiques/oltp-olap/index.md)</span>
</div>

!!! abstract "Qué trabajaremos"
    Haremos crecer el OLTP hasta **100.000 líneas**, volveremos a cargar el DW y mediremos qué diferencia hay entre las herramientas de **carga masiva** del SGBD (`COPY`) y la inserción fila a fila. Al final leeremos y cargaremos datos desde **Python**.

## Objetivos

- **RA3.f** · Usar herramientas de carga masiva propias de un SGBD relacional desde ficheros planos u otras fuentes externas.
- **RA2.c** · Acceder a las bases de datos con DQL embebido en un lenguaje anfitrión (*host*).

## 1. Escalar el OLTP y recargar el DW

```sql
\i 07_scale_100k.sql      -- tarda unos segundos
\i 04_load_olap.sql       -- el script vacía el hecho y lo vuelve a cargar
```

Comprueba que la **conciliación** vuelve a cuadrar con 100.000 líneas. El script `04_load_olap.sql` es **reejecutable**: por eso puedes lanzarlo tantas veces como haga falta.

## 2. `COPY` y `\copy`

| | `COPY` | `\copy` |
|---|---|---|
| Quién lee el fichero | El **servidor** de PostgreSQL | El **cliente** `psql` |
| Dónde tiene que estar el fichero | En la máquina del servidor (dentro del contenedor) | En tu equipo |
| Permisos | Superusuario o rol `pg_read_server_files` | Los tuyos |

Los dos usan el mismo mecanismo interno: leen el fichero en bloque y escriben las filas **sin pasar por el analizador SQL una vez por fila**.

## 3. Mídelo

Ejecuta `10_copy_massiva.sql` y rellena esta tabla con los tiempos (`\timing`):

| Método | Filas | Tiempo | Tiempo estimado para 100.000 |
|---|---:|---:|---:|
| `\copy … FROM 'hecho_compras.csv'` | 100.000 | | |
| `INSERT … SELECT` | 100.000 | | |
| `INSERT` fila a fila (bucle) | 2.000 | | |

!!! question "Preguntas"
    1. ¿Cuántas veces más lento es el `INSERT` fila a fila que `\copy`, extrapolado a 100.000 filas?
    2. `INSERT … SELECT` es rápido porque no lee ningún fichero. ¿Cuándo **no** podrías usarlo?
    3. La tabla `hecho_compras_copia` no tiene índices ni FK. Añádele un índice y una FK y repite el `\copy`. ¿Qué pasa con el tiempo? ¿Por qué en las cargas masivas grandes se desactivan los índices y se vuelven a crear al final?

## 4. Python como lenguaje anfitrión

Las ETL a menudo se programan en un lenguaje anfitrión que **embebe** las sentencias SQL. Instala el driver:

```bash
pip install "psycopg[binary]" pandas
```

```python title="extraccion.py"
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
    # 1. DQL embebido con parámetros (%s): nunca concatenes texto, para evitar SQL injection
    cur.execute(SQL, (2025,))
    filas = cur.fetchall()                       # lista de tuplas Python
    df = pd.DataFrame(filas, columns=[c.name for c in cur.description])
    print(df)

    # 2. Carga masiva desde Python con COPY
    cur.execute("CREATE TABLE IF NOT EXISTS dw_compras.resumen_python (tipo text, anio int, total numeric)")
    with cur.copy("COPY dw_compras.resumen_python (tipo, anio, total) FROM STDIN") as copy:
        for fila in filas:
            copy.write_row(fila)
# al salir del bloque 'with', psycopg hace COMMIT automáticamente
```

!!! question "Reto"
    Modifica el script para que lea un **CSV externo** (por ejemplo, una lista de precios de proveedores), lo transforme con pandas y lo cargue con `COPY` en una tabla de staging.

## Antes de salir

- [ ] El OLTP tiene 100.000 líneas y la conciliación cuadra.
- [ ] Tengo la tabla de tiempos completada y las preguntas respondidas.
- [ ] Mi script Python funciona y está en la entrega.
