# Mavryk Validator Node Setup

This directory contains scripts and configuration to help you run a validator node on the Mavryk Blockchain.

## Protocol and Testnet Disclaimer

**Protocol Updates:**
- **Atlas**: The first update of the Mavryk blockchain protocol code
- **Boreas**: The second update of the Mavryk blockchain protocol code (current)

**Testnets:**
- **Atlasnet**: The testnet on which Atlas was initially deployed. It has now been updated to run the Boreas protocol.
- **Basenet**: The name given to the long-running testnet. Currently, Atlasnet and Basenet refer to the same testnet (Atlasnet = Basenet).

The current setup uses the **Boreas protocol** on the **Atlasnet/Basenet testnet**.

## Quick Start

### 1. Create a Mavryk Account

Before setting up your validator, you need a Mavryk account. You have two options:

**Option A: Browser Wallet (Recommended for beginners)**
- Visit [https://mavryk.org/wallet](https://mavryk.org/wallet) to create an account using the browser wallet extension.
- This is the easiest way to get started and manage your account.

**Option B: Command Line**
If you prefer to generate your account via command line:

```bash
# Generate a new key pair
docker run --rm -v mavryk_client_data:/var/run/mavryk/client mavrykdynamics/mavryk:mavkit-v20.3-rc2 mavkit-client gen keys $BAKER_ALIAS

# View your address and private key (keep this private!)
docker run --rm -v mavryk_client_data:/var/run/mavryk/client mavrykdynamics/mavryk:mavkit-v20.3-rc2 mavkit-client show address $BAKER_ALIAS -S
```

**⚠️ Important:** The private key should be temporarily exported to `BAKER_PRIVATE_KEY` environment variable. Never share your private key with anyone.

### 2. Configure Your Baker

Before running any scripts, you **must** set two environment variables:

- `BAKER_ALIAS`: The alias you want to use for your baker (e.g., `my_baker_account`).
- `BAKER_PRIVATE_KEY`: Your account's private key (e.g., `edsk...`).

You can set these in your shell or in a `.env` file (see below).

**Your account must hold at least 6000 MVRK on-chain to register as a baker.**

### 3. Initialize Your Node

Run the setup script to initialize your node, import the latest snapshot, and configure your baker:

```sh
cd docker
export BAKER_ALIAS=your_baker_alias
export BAKER_PRIVATE_KEY=edsk...
./setup.sh
```

- This will download and import the latest snapshot, start the node, import your baker key, and register your baker.
- **Do not run `docker-compose.yml` directly** – it will resync a new snapshot and may overwrite your data.

### 4. Start/Restart Your Node

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
