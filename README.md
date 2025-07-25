# The Validator Station

This repository provides everything you need to bootstrap and run Validator Nodes (bakers) on the Mavryk Blockchain, using either Docker Compose or Kubernetes (Helm).

See the full onboarding guide: https://mavrykdynamics.notion.site/validator-onboarding-guide

## What You'll Find Here

- **docker/**: Scripts and configuration for running a validator node using Docker Compose. Ideal for local setups, testing, or simple deployments.
- **kubernetes/**: Example configuration and documentation for deploying a validator node on Kubernetes using the official Helm chart. Best for production or cloud-native environments.

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

## Requirements
- You must have at least **6000 MVRK** on-chain to register as a baker.
- Choose a unique alias for your baker.
- **Never share your private key.**

## More Information
- For detailed onboarding and best practices, see the [Validator Onboarding Guide](https://mavrykdynamics.notion.site/validator-onboarding-guide).
- For advanced configuration, see the documentation in each subfolder. 
