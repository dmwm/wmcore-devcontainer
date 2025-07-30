# WMCore Development Containers

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

# cd to your container area
cd .devcontainer

# Copy `env-template` to `.env` and
# modify CERT_DIR, WMCORE_CODE_DIR
cp env-template .env

# optionally: adjust your .env file if necessary

# Log into registry
docker login registry.cern.ch

# Start containers
docker compose up -d wmcore-dev

# Enter wmcore-dev container
docker compose exec -it wmcore-dev /bin/bash

# now you should get prompt within docker image where you should cd to /workspaces/WMCore
[root@docker-desktop cmsbld]# cd /workspaces/WMCore

# Source unit test environment
source .devcontainer/env_unittest.sh

# Stop all containers
docker compose down

# Updating or adding dependencies
pip install <dependency>

# Stopping containers
# In the devcontainer directory
docker compose down
```

## Configuration
Environment variables used in the `docker-compose.yaml` file must be defined in a `.env` file located in the same directory as the compose file.

| Variable                | Description                                   | Example         |
| ----------------------- | --------------------------------------------- | --------------- |
| `WMCORE_CODE_DIR`       | Location of WMCore repository on host machine | `~/src/WMCore`  |
| `CERT_DIR`              | User Certificate Directory on host            | `~/certs`       |
| `PLATFORM`              | Architecture Platform                         | `linux/amd64`   |
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

### Certificates
Currently, the certificates and keys are located in `$CERT_DIR/usercert.pem` and `$CERT_DIR/userkey_nopwd.pem`. This was created following instructions here: https://cms-wmcore.docs.cern.ch/development/setup-wmcore-unittest/#5-authenticate-yourself-when-running-unittests

```
openssl pkcs12 -in ~/certs-mount/myCertificate.p12 -clcerts -nokeys -out ~/certs/usercert.pem`
openssl pkcs12 -in ~/certs-mount/myCertificate.p12 -nocerts -out ~/certs/userkey.pem
chmod 400 ~/certs/userkey.pem
openssl rsa -in ~/certs/userkey.pem -out ~/certs/userkey_nopwd.pem
```

## Integration with VSCode
This repository also contains a `devcontainer.json` configuration file for integration with VSCode. This can be pretty opinionated, such as adding tools a developer may use normally. In this case, forking this repo is suggested.

1. Clone this repo in `WMCore/.devcontainer`. This repo must be located under `WMCore/.devcontainer`.
```bash
git clone https://github.com/d-ylee/wmcore-development .devcontainer
```

2. Open `WMCore` in VSCode.
3. Reopen the repository in a container.

## Caveats
On macOS, since Docker/Podman containers are run in a virtual machine, bind mounts may be slow. Future developments can consider cloning the dmwm/WMCore repository in a named volume, or a container volume

Some tips here: https://code.visualstudio.com/remote/advancedcontainers/improve-performance#_use-a-named-volume-for-your-entire-source-tree