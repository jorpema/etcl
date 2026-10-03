#!/usr/bin/env bash
# ============================================================
# 11_carrega_paralela.sh
# CÀRREGA PARAL·LELA (RA3.g): una taula particionada per any i
# un procés \copy per partició executant-se alhora.
# Ús (dins del contenidor):  PGUSER=postgres bash ./11_carrega_paralela.sh
# ============================================================
set -euo pipefail
PSQL="psql -v ON_ERROR_STOP=1 -q"

# 1. Taula particionada per any (a partir de sk_tiempo -> any via staging)
$PSQL <<'SQL'
DROP TABLE IF EXISTS dw_compras.hecho_part CASCADE;
CREATE TABLE dw_compras.hecho_part (
    LIKE dw_compras.hecho_compras INCLUDING DEFAULTS,
    anio smallint NOT NULL
) PARTITION BY RANGE (anio);
CREATE TABLE dw_compras.hecho_part_2024 PARTITION OF dw_compras.hecho_part FOR VALUES FROM (2024) TO (2025);
CREATE TABLE dw_compras.hecho_part_2025 PARTITION OF dw_compras.hecho_part FOR VALUES FROM (2025) TO (2026);
CREATE TABLE dw_compras.hecho_part_2026 PARTITION OF dw_compras.hecho_part FOR VALUES FROM (2026) TO (2027);
CREATE TABLE dw_compras.hecho_part_2027 PARTITION OF dw_compras.hecho_part FOR VALUES FROM (2027) TO (2028);
SQL

# 2. Un CSV per any (així cada procés treballa amb el seu fitxer)
for any in 2024 2025 2026 2027; do
  $PSQL -c "\copy (SELECT h.*, dt.anio FROM dw_compras.hecho_compras h JOIN dw_compras.dim_tiempo dt USING (sk_tiempo) WHERE dt.anio = $any) TO 'hecho_$any.csv' WITH (FORMAT csv)"
done

# 3. Càrrega SEQÜENCIAL (referència)
inici=$(date +%s.%N)
for any in 2024 2025 2026 2027; do
  $PSQL -c "\copy dw_compras.hecho_part FROM 'hecho_$any.csv' WITH (FORMAT csv)"
done
fi_seq=$(date +%s.%N)
$PSQL -c "TRUNCATE dw_compras.hecho_part"

# 4. Càrrega PARAL·LELA: 4 processos alhora (&) i esperem que acaben (wait)
inici_par=$(date +%s.%N)
for any in 2024 2025 2026 2027; do
  $PSQL -c "\copy dw_compras.hecho_part_$any FROM 'hecho_$any.csv' WITH (FORMAT csv)" &
done
wait
fi_par=$(date +%s.%N)

awk -v a="$inici" -v b="$fi_seq" 'BEGIN{printf "Seqüencial: %.2f s\n", b-a}'
awk -v a="$inici_par" -v b="$fi_par" 'BEGIN{printf "Paral·lel : %.2f s\n", b-a}'
$PSQL -c "SELECT tableoid::regclass AS particio, COUNT(*) FROM dw_compras.hecho_part GROUP BY 1 ORDER BY 1"
# Amb 100.000 files la diferència és xicoteta: prova-ho també amb 1 milió.
