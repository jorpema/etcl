-- ============================================================
-- 10_copy_massiva.sql
-- CÀRREGA MASSIVA AMB EINES PRÒPIES DEL SGBD (RA3.f)
-- Executar amb psql DESPRÉS de 07_scale_100k.sql i 04_load_olap.sql
-- \copy s'executa al CLIENT (fitxer al teu equip);
-- COPY s'executa al SERVIDOR (fitxer dins del contenidor/servidor).
-- ============================================================

\timing on
\set ON_ERROR_STOP on

-- 1. Exportem el fet a CSV (fitxer al directori des d'on has obert psql)
\copy dw_compras.hecho_compras TO 'hecho_compras.csv' WITH (FORMAT csv, HEADER true)

-- 2. Taula buida amb la mateixa estructura per a fer les proves
DROP TABLE IF EXISTS dw_compras.hecho_compras_copia;
CREATE TABLE dw_compras.hecho_compras_copia
    (LIKE dw_compras.hecho_compras INCLUDING DEFAULTS);

-- 3. Prova A: càrrega amb \copy (anota el temps)
\copy dw_compras.hecho_compras_copia FROM 'hecho_compras.csv' WITH (FORMAT csv, HEADER true)
SELECT COUNT(*) AS files_copy FROM dw_compras.hecho_compras_copia;

-- 4. Prova B: la mateixa càrrega amb INSERT ... SELECT (anota el temps)
TRUNCATE dw_compras.hecho_compras_copia;
INSERT INTO dw_compras.hecho_compras_copia SELECT * FROM dw_compras.hecho_compras;

-- 5. Prova C: INSERT fila a fila (només 2.000 files: extrapola el resultat!)
TRUNCATE dw_compras.hecho_compras_copia;
DO $$
DECLARE i bigint;
BEGIN
  FOR i IN SELECT id_hecho FROM dw_compras.hecho_compras ORDER BY id_hecho LIMIT 2000 LOOP
    INSERT INTO dw_compras.hecho_compras_copia
    SELECT * FROM dw_compras.hecho_compras WHERE id_hecho = i;
  END LOOP;
END $$;

-- Preguntes: per què COPY és més ràpid que l'INSERT fila a fila?
-- Què passaria amb els índexs i les FK si la taula destí en tinguera?
