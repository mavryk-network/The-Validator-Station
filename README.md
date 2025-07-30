# The Validator Station

This repository provides everything you need to bootstrap and run Validator Nodes (bakers) on the Mavryk Blockchain, using Docker Compose, Kubernetes (Helm), or native system packages.

## ⚠️ Fedora Package Disclaimer

**Fedora packages are currently broken and cannot be used at this time.** The packages in the Mavryk Dynamics COPR repository need to be fixed before they can be used for validator node deployment. Please use Docker Compose, Kubernetes, or Ubuntu packages instead.


See the full onboarding guide: https://mavrykdynamics.notion.site/validator-onboarding-guide

## Protocol and Testnet Disclaimer

**Protocol Updates:**
- **Atlas**: The first update of the Mavryk blockchain protocol code
- **Boreas**: The second update of the Mavryk blockchain protocol code (current)

**Testnets:**
- **Atlasnet**: The testnet on which Atlas was initially deployed. It has now been updated to run the Boreas protocol.
- **Basenet**: The name given to the long-running testnet. Currently, Atlasnet and Basenet refer to the same testnet (Atlasnet = Basenet).

The current setup uses the **Boreas protocol** on the **Atlasnet/Basenet testnet**.

## What You'll Find Here

- **docker/**: Scripts and configuration for running a validator node using Docker Compose. Ideal for local setups, testing, or simple deployments.
- **kubernetes/**: Example configuration and documentation for deploying a validator node on Kubernetes using the official Helm chart. Best for production or cloud-native environments.
- **ubuntu/**: Scripts and configuration for running a validator node using native Ubuntu packages from the [Mavryk Dynamics PPA](https://launchpad.net/~mavrykdynamics/+archive/ubuntu/mavryk-rc). Supports Ubuntu 20.04, 22.04, and 24.04.
- **fedora/**: Scripts and configuration for running a validator node using native Fedora packages from the [Mavryk Dynamics COPR repository](https://copr.fedorainfracloud.org/coprs/g/MavrykDynamics/Mavryk-rc). Supports Fedora 41.

## Quick Overview

### Docker Compose
- Use the `docker/` folder if you want a straightforward, script-driven setup.
- Follow the instructions in `docker/README.md` to:
  - Initialize your node with `setup.sh` (imports a snapshot, configures your baker, and registers your account).
  - Start or restart your node with `start.sh`.
- You must set your baker alias and private key as environment variables before running the scripts.
- **Do not run `docker-compose.yml` directly**—always use the provided scripts.

### Kubernetes (Helm)
- Use the `kubernetes/` folder for scalable, production-grade deployments.
- All configuration is managed via `values.yaml` and Kubernetes Secrets (not environment variables).
- Follow the instructions in `kubernetes/README.md` to:
  - Create a Kubernetes Secret for your baker account.
  - Edit `values.yaml` to set your alias and reference the secret.
  - Deploy using the official Helm chart.

### Ubuntu Packages
- Use the `ubuntu/` folder for native Ubuntu installations using system packages.
- Follow the instructions in `ubuntu/README.md` to:
  - Add the Mavryk PPA and install packages.
  - Set your baker alias and private key as environment variables.
  - Initialize your node with `setup.sh` and manage services with `start.sh`.
- Services run as systemd units for better integration with Ubuntu.

### Fedora Packages
- Use the `fedora/` folder for native Fedora installations using system packages.
- Follow the instructions in `fedora/README.md` to:
  - Enable the Mavryk COPR repository and install packages.
  - Set your baker alias and private key as environment variables.
  - Initialize your node with `setup.sh` and manage services with `start.sh`.
- Services run as systemd units for better integration with Fedora.

## Requirements
- You must have at least **6000 MVRK** on-chain to register as a baker.
- Choose a unique alias for your baker.
- **Never share your private key.**

## More Information
- For detailed onboarding and best practices, see the [Validator Onboarding Guide](https://mavrykdynamics.notion.site/validator-onboarding-guide).
- For advanced configuration, see the documentation in each subfolder. 
