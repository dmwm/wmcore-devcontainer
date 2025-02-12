# WMCore Development Scripts

Scripts and configuration to develop in WMCore containers

## Requirements
* `docker`, `docker compose` plugin
* Access to CERN registry

## Usage

```bash
# Enter WMCore code directory
cd <wmcore code directory>

# Clone this repository
git clone https://github.com/d-ylee/wmcore-development .devcontainer`

# Copy `env-template` to `.env` and
# modify CERT_DIR, WMCORE_CODE_DIR
cp env-template .env

# Log into registry
docker login registry.cern.ch

# Start containers
cd .devcontainer
docker compose up -d wmcore-dev

# Enter wmcore-dev2 container
docker compose exec -it wmcore-dev /bin/bash

# Source unit test environment
source .devcontainer/env_unittest.sh
```

## Configuration
Environment variables used in the `docker-compose.yaml` file must be defined in a `.env` file located in the same directory as the compose file.

| Variable                | Description                                   | Example         |
| ----------------------- | --------------------------------------------- | --------------- |
| `WMCORE_CODE_DIR`       | Location of WMCore repository on host machine | `~/src/WMCore`  |
| `CERT_DIR`              | User Certificate Directory on host            | `~/certs`       |
| `MDB_TAG`               | WMAgent MariaDB Image Tag                     | `10.6.5`        |
| `COUCH_TAG`             | WMAgent CouchDB Image Tag                     | `3.2.2`         |
| `WMDEV_TAG`             | WMCore Developer Image Tag                    | `latest`        |
| `DEVCONTAINER_DIRNAME`  | Name of this repository's directory           | `.devcontainer` |
| `MARIADB_ROOT_PASSWORD` | MariaDB Root Account Password                 | `userdevpass`   |

Unit test secrets are located in the `WMAgent_unittest.secrets` file.

| Secret            | Description                        | Example           |
| ----------------- | ---------------------------------- | ----------------- |
| `MDB_ROOT`        | MariaDB Root account               | `root`            |
| `MDB_ROOTPASS`    | MariaDB Root account password      | `userdevpass`     |
| `MDB_USER`        | MariaDB user account password      | `dmwmtest`        |
| `MDB_PASS`        | MariaDB user account password      | `unittestagent`   |
| `MDB_UNITTEST_DB` | MariaDB Database to create and use | `wmagent`         |
| `COUCH_USER`      | WMAgent CouchDB User               | `unittestagent`   |
| `COUCH_PASS`      | WMAgent CouchDB Password           | `passwd`          |
| `COUCH_PORT`      | WMAgent CouchDB Port               | `5984`            |
| `COUCH_HOST`      | WMAgent CouchDB Host               | `0.0.0.0`         |
| `RUCIO_ACCOUNT`   | Rucio account to connect as        | `wma_test`        |
| `RUCIO_HOST`      | Rucio server to connect to         |                   |
| `RUCIO_AUTH`      | Rucio auth server to connect to    |                   |
| `GRAFANA_TOKEN`   | Token to connect to Grafana        | `test_fake_token` |
