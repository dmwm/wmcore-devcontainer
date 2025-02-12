# WMCore Development Scripts

Scripts and configuration to develop in WMCore containers

## Requirements
* `docker`, `docker compose` plugin
* Access to CERN registry

## Configuration
Environment variables in the `docker-compose.yaml` file is customizable using a `.env` file located in the same directory as the compose file.

| Variable               | Description                | Example       |
|------------------------|----------------------------|---------------|
| `MDB_TAG`              | WMAgent MariaDB Image Tag  | `10.6.5`      |
| `COUCH_TAG`            | WMAgent CouchDB Image Tag  | `3.2.2`       |
| `WMDEV_TAG`            | WMCore Developer Image Tag | `latest`      |
| `CERT_DIR`             | User Certificate Directory | `/data/certs` |
| `DEVCONTAINER_DIRNAME` | Name of this repository's directory | `.devcontainer` |

## Usage

```bash
1. Configure `.env` file
# Enter WMCore code directory
cd $WMCORE_CODE 

# Clone this repository
git clone https://github.com/d-ylee/wmcore-development .devcontainer` into WMCore directory

# Log into registry
docker login registry.cern.ch

# Start containers
cd .devcontainer
docker compose up -d wmcore-dev2

# Enter wmcore-dev2 container
docker compose exec -it wmcore-dev2 /bin/bash

# Source unit test environment
cd WMCore
source .devcontainer/env_unittest.sh
```


## Usage in VSCode
`devcontainer.json` contains configuration for VSCode IDE integration.
