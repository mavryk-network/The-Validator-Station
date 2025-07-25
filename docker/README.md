# Mavryk Validator Node Setup

This directory contains scripts and configuration to help you run a validator node on the Mavryk Blockchain.

## Quick Start

### 1. Configure Your Baker

Before running any scripts, you **must** set two environment variables:

- `BAKER_ALIAS`: The alias you want to use for your baker (e.g., `my_baker_account`).
- `BAKER_PRIVATE_KEY`: Your account's private key (e.g., `edsk...`).

You can set these in your shell or in a `.env` file (see below).

**Your account must hold at least 6000 MVRK on-chain to register as a baker.**

### 2. Initialize Your Node

Run the setup script to initialize your node, import the latest snapshot, and configure your baker:

```sh
cd docker
export BAKER_ALIAS=your_baker_alias
export BAKER_PRIVATE_KEY=edsk...
./setup.sh
```

- This will download and import the latest snapshot, start the node, import your baker key, and register your baker.
- **Do not run `docker-compose.yml` directly** – it will resync a new snapshot and may overwrite your data.

### 3. Start/Restart Your Node

After initialization, you can start or restart your deployment at any time with:

```sh
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

## Notes

- Make sure your account has at least 6000 MVRK before registering as a baker.
- Choose a unique alias for your baker.
- Never share your private key with anyone.
- For more details, see the comments in `setup.sh` and `start.sh`.
