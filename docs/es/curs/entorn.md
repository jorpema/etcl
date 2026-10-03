# Entorno de trabajo

Trabajaremos con **contenedores Docker**. Un contenedor es como una máquina virtual muy ligera que lleva un programa ya instalado y configurado: en lugar de instalar PostgreSQL, NiFi o MongoDB en tu sistema, arrancas el contenedor y lo tienes funcionando en segundos, igual para toda la clase.

!!! tip "Arranca solo lo que necesitas"
    No hace falta tenerlo todo encendido a la vez. NiFi y Elasticsearch consumen mucha memoria (más de 1 GB cada uno). En cada sesión te indicaremos qué servicios hacen falta.

## 1. Requisitos

- Docker Desktop (Windows o macOS) o Docker Engine (Linux), con **Docker Compose**.
- Al menos **8 GB de RAM** si quieres tener varios servicios encendidos a la vez.
- Un cliente de PostgreSQL: `psql` (viene con el contenedor) y, si quieres interfaz gráfica, **DBeaver**.

Comprueba que Docker funciona:

```bash
docker --version
docker compose version
```

## 2. PostgreSQL (lunes, desde la primera práctica)

Crea una carpeta `etcl` y, dentro, un fichero `docker-compose.yml`:

```yaml title="docker-compose.yml"
services:
  postgres:
    image: postgres:16
    container_name: etcl-postgres
    environment:
      POSTGRES_PASSWORD: etcl2627       # cámbiala si quieres
    ports:
      - "5432:5432"                     # puerto_de_tu_equipo:puerto_del_contenedor
    volumes:
      - pgdata:/var/lib/postgresql/data # los datos sobreviven si paras el contenedor
      - ./sql:/sql                      # tus scripts, visibles dentro del contenedor

volumes:
  pgdata:
```

Arráncalo y entra con `psql`:

```bash
docker compose up -d postgres
docker compose exec postgres psql -U postgres
```

Desde DBeaver: host `localhost`, puerto `5432`, usuario `postgres`, contraseña `etcl2627`.

## 3. NiFi (miércoles)

Seguiremos la versión **NiFi 2.x**, la misma de los [apuntes de Alberto Aparicio Vila](https://alapvi.github.io/sbd/nifi/instalacion/). Rafa os dará el `docker-compose.yml` completo en la sesión [D01](../p2/d01-nifi-intro.md). Recuerda:

- NiFi 2.x funciona por **HTTPS en el puerto 8443**: `https://localhost:8443/nifi`. El navegador avisará de que el certificado no es de confianza; es normal.
- La contraseña del usuario único debe tener **al menos 12 caracteres**.
- Para conectarse a PostgreSQL, NiFi necesita el **driver JDBC** (`postgresql-42.x.jar`) montado en un volumen.

## 4. MongoDB y Elasticsearch (a partir de diciembre)

Los añadiremos al mismo `docker-compose.yml` en las sesiones [S10](../p1/s10-mongodb-1.md) y [S12](../p1/s12-elasticsearch.md).

## Errores conocidos

??? failure "Elasticsearch se para nada más arrancar (`max virtual memory areas vm.max_map_count [65530] is too low`)"
    Hay que subir un parámetro del sistema anfitrión:

    === "Linux"
        ```bash
        sudo sysctl -w vm.max_map_count=262144
        ```
    === "Windows (WSL2)"
        ```powershell
        wsl -d docker-desktop sysctl -w vm.max_map_count=262144
        ```

??? failure "`port is already allocated` al arrancar PostgreSQL"
    Ya tienes otro PostgreSQL escuchando en el puerto 5432 (quizá instalado en el sistema). Cambia la línea de puertos por `"5433:5432"` y conéctate al puerto 5433.

??? failure "`psql: command not found` en mi equipo"
    No hace falta instalarlo: usa el del contenedor con `docker compose exec postgres psql -U postgres`.

??? failure "NiFi no abre la página o dice *Invalid username or password*"
    NiFi tarda uno o dos minutos en arrancar: mira `docker compose logs -f nifi` hasta que aparezca *Started Application*. Si la contraseña tiene menos de 12 caracteres, NiFi genera una aleatoria y la escribe en el log.
