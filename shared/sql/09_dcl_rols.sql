-- ============================================================
-- 09_dcl_rols.sql
-- DCL: ROLS, PERMISOS I ROW LEVEL SECURITY (RA3.e)
-- Executar com a superusuari (postgres)
-- ============================================================

-- Neteja per a poder re-executar (la primera vegada els DROP OWNED
-- donen error perquè els rols encara no existeixen: és normal)
\set ON_ERROR_STOP off
DROP OWNED BY etl_compras;
DROP OWNED BY analista_bi;
DROP OWNED BY analista_valencia;
DROP ROLE IF EXISTS etl_compras;
DROP ROLE IF EXISTS analista_bi;
DROP ROLE IF EXISTS analista_valencia;
\set ON_ERROR_STOP on

-- 1. Rol tècnic d'ETL: llig l'OLTP i escriu el DW
CREATE ROLE etl_compras LOGIN PASSWORD 'etl_canvia_me';
GRANT USAGE ON SCHEMA compras, dw_compras TO etl_compras;
GRANT SELECT ON ALL TABLES IN SCHEMA compras TO etl_compras;
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA dw_compras TO etl_compras;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA dw_compras TO etl_compras;

-- 2. Rol d'analista: només lectura del DW (mai de l'OLTP)
CREATE ROLE analista_bi LOGIN PASSWORD 'bi_canvia_me';
GRANT USAGE ON SCHEMA dw_compras TO analista_bi;
GRANT SELECT ON ALL TABLES IN SCHEMA dw_compras TO analista_bi;

-- 3. Principi de mínim privilegi: el CIF i el domicili no arriben al DW,
--    i a més tallem l'accés a l'OLTP a qualsevol rol per defecte
REVOKE ALL ON SCHEMA compras FROM PUBLIC;

-- 4. Row Level Security: un analista només veu els proveïdors de València
CREATE ROLE analista_valencia LOGIN PASSWORD 'vlc_canvia_me';
GRANT USAGE ON SCHEMA dw_compras TO analista_valencia;
GRANT SELECT ON dw_compras.dim_proveedor TO analista_valencia;

ALTER TABLE dw_compras.dim_proveedor ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS p_valencia ON dw_compras.dim_proveedor;
DROP POLICY IF EXISTS p_tots ON dw_compras.dim_proveedor;
CREATE POLICY p_valencia ON dw_compras.dim_proveedor
    FOR SELECT TO analista_valencia
    USING (provincia = 'Valencia');
-- La resta de rols amb permís continuen veient-ho tot
CREATE POLICY p_tots ON dw_compras.dim_proveedor
    FOR ALL TO etl_compras, analista_bi
    USING (true) WITH CHECK (true);

-- 5. Comprovacions (canviem de rol dins la sessió)
SET ROLE analista_bi;
SELECT COUNT(*) AS proveidors_visibles_bi FROM dw_compras.dim_proveedor;
RESET ROLE;

SET ROLE analista_valencia;
SELECT COUNT(*) AS proveidors_visibles_valencia FROM dw_compras.dim_proveedor;
RESET ROLE;

-- 6. Prova que ha de FALLAR: l'analista intenta llegir l'OLTP
-- SET ROLE analista_bi;
-- SELECT * FROM compras.proveedor LIMIT 1;   -- ERROR: permission denied
-- RESET ROLE;
