# Entorn de treball

Treballarem amb **contenidors Docker**. Un contenidor és com una màquina virtual molt lleugera que porta un programa ja instal·lat i configurat: en lloc d'instal·lar PostgreSQL, NiFi o MongoDB al teu sistema, arranques el contenidor i el tens funcionant en segons, igual per a tota la classe.

!!! tip "Arranca només el que necessites"
    No cal tindre-ho tot engegat alhora. NiFi i Elasticsearch consumeixen molta memòria (més d'1 GB cadascun). A cada sessió t'indicarem quins serveis fan falta.

## 1. Requisits

- Docker Desktop (Windows o macOS) o Docker Engine (Linux), amb **Docker Compose**.
- Almenys **8 GB de RAM** si vols tindre diversos serveis engegats alhora.
- Un client de PostgreSQL: `psql` (ve amb el contenidor) i, si vols interfície gràfica, **DBeaver**.

Comprova que Docker funciona:

```bash
docker --version
docker compose version
```

## 2. PostgreSQL (dilluns, des de la primera pràctica)

Crea una carpeta `etcl` i, dins, un fitxer `docker-compose.yml`:

```yaml title="docker-compose.yml"
services:
  postgres:
    image: postgres:16
    container_name: etcl-postgres
    environment:
      POSTGRES_PASSWORD: etcl2627       # canvia-la si vols
    ports:
      - "5432:5432"                     # port_del_teu_equip:port_del_contenidor
    volumes:
      - pgdata:/var/lib/postgresql/data # les dades sobreviuen si pares el contenidor
      - ./sql:/sql                      # els teus scripts, visibles dins del contenidor

volumes:
  pgdata:
```

Arranca'l i entra amb `psql`:

```bash
docker compose up -d postgres
docker compose exec postgres psql -U postgres
```

Des de DBeaver: host `localhost`, port `5432`, usuari `postgres`, contrasenya `etcl2627`.

## 3. NiFi (dimecres)

Seguirem la versió **NiFi 2.x**, la mateixa dels [apunts d'Alberto Aparicio Vila](https://alapvi.github.io/sbd/nifi/instalacion/). Rafa us donarà el `docker-compose.yml` complet a la sessió [D01](../p2/d01-nifi-intro.md). Recorda:

- NiFi 2.x funciona per **HTTPS al port 8443**: `https://localhost:8443/nifi`. El navegador avisarà que el certificat no és de confiança; és normal.
- La contrasenya de l'usuari únic ha de tindre **almenys 12 caràcters**.
- Per a connectar-se a PostgreSQL, NiFi necessita el **driver JDBC** (`postgresql-42.x.jar`) muntat en un volum.

## 4. MongoDB i Elasticsearch (a partir de desembre)

Els afegirem al mateix `docker-compose.yml` a les sessions [S10](../p1/s10-mongodb-1.md) i [S12](../p1/s12-elasticsearch.md).

## Errors coneguts

??? failure "Elasticsearch s'atura nada més arrancar (`max virtual memory areas vm.max_map_count [65530] is too low`)"
    Cal pujar un paràmetre del sistema amfitrió:

    === "Linux"
        ```bash
        sudo sysctl -w vm.max_map_count=262144
        ```
    === "Windows (WSL2)"
        ```powershell
        wsl -d docker-desktop sysctl -w vm.max_map_count=262144
        ```

??? failure "`port is already allocated` en arrancar PostgreSQL"
    Ja tens un altre PostgreSQL escoltant al port 5432 (potser instal·lat al sistema). Canvia la línia de ports per `"5433:5432"` i connecta't al port 5433.

??? failure "`psql: command not found` al meu equip"
    No cal instal·lar-lo: usa el del contenidor amb `docker compose exec postgres psql -U postgres`.

??? failure "NiFi no obri la pàgina o diu *Invalid username or password*"
    NiFi tarda un o dos minuts a arrancar: mira `docker compose logs -f nifi` fins que aparega *Started Application*. Si la contrasenya té menys de 12 caràcters, NiFi en genera una d'aleatòria i l'escriu al log.
