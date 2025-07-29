# Mavryk Validator Node on Ubuntu

This directory contains configuration and scripts for running a Mavryk validator node (baker) on Ubuntu using the official Mavryk Dynamics PPA packages.

## Supported Ubuntu Versions

- **Ubuntu 20.04 (Focal)**
- **Ubuntu 22.04 (Jammy)** 
- **Ubuntu 24.04 (Noble)**

## Quick Start

### 1. Add the Mavryk PPA

```bash
sudo add-apt-repository ppa:mavrykdynamics/mavryk-rc
sudo apt update
```

### 2. Install Mavryk Packages

```bash
sudo apt install mavryk-node mavryk-client mavryk-baker-ptboreas mavryk-accuser-ptboreas
```

### 3. Configure Your Baker

Before running any scripts, you **must** set two environment variables:

- `BAKER_ALIAS`: The alias you want to use for your baker (e.g., `my_baker_account`).
- `BAKER_PRIVATE_KEY`: Your account's private key (e.g., `edsk...`).

You can set these in your shell or in a `.env` file (see below).

**Your account must hold at least 6000 MVRK on-chain to register as a baker.**

### 4. Initialize Your Node

Run the setup script to initialize your node, import the latest snapshot, and configure your baker:

```bash
cd ubuntu
export BAKER_ALIAS=your_baker_alias
export BAKER_PRIVATE_KEY=edsk...
./setup.sh
```

This will:
- Download and import the latest snapshot
- Start the node
- Import your baker key
- Register your baker
- Start the baker and accuser services

### 5. Start/Restart Your Node

After initialization, you can start or restart your deployment at any time with:

```bash
./start.sh
```

This will start the node, baker, and accuser services using your existing configuration.

---

## Environment Variables

You can set the required variables in your shell or create a `.env` file in this directory:

```
BAKER_ALIAS=your_baker_alias
BAKER_PRIVATE_KEY=edsk...
```

---

## System Requirements

- Ubuntu 20.04, 22.04, or 24.04
- At least 4GB RAM
- 100GB+ available disk space
- Stable internet connection

## Notes

- Make sure your account has at least 6000 MVRK before registering as a baker.
- Choose a unique alias for your baker.
- Never share your private key with anyone.
- The PPA provides release-candidate packages. For production use, consider using stable releases.
- For more details, see the comments in `setup.sh` and `start.sh`.

## Troubleshooting

- **Package not found**: Make sure you've added the PPA and run `sudo apt update`.
- **Permission errors**: Ensure you have sudo privileges for package installation.
- **Service fails to start**: Check the logs in `/var/log/mavryk/` for detailed error messages.

---

For more information, see the [Mavryk PPA](https://launchpad.net/~mavrykdynamics/+archive/ubuntu/mavryk-rc) and the [Validator Onboarding Guide](https://mavrykdynamics.notion.site/validator-onboarding-guide). 