# Mavryk Validator Node on Fedora

This directory contains configuration and scripts for running a Mavryk validator node (baker) on Fedora using the official Mavryk Dynamics COPR packages.

## Supported Fedora Versions

- **Fedora 41**

## Protocol and Testnet Disclaimer

**Protocol Updates:**
- **Atlas**: The first update of the Mavryk blockchain protocol code
- **Boreas**: The second update of the Mavryk blockchain protocol code (current)

**Testnets:**
- **Atlasnet**: The testnet on which Atlas was initially deployed. It has now been updated to run the Boreas protocol.
- **Basenet**: The name given to the long-running testnet. Currently, Atlasnet and Basenet refer to the same testnet (Atlasnet = Basenet).

The current setup uses the **Boreas protocol** on the **Atlasnet/Basenet testnet**.

## Quick Start

### 1. Enable the Mavryk COPR Repository

```bash
sudo dnf copr enable -y @MavrykDynamics/Mavryk-rc
sudo dnf update
```

### 2. Install Mavryk Packages

```bash
sudo dnf install mavryk-node mavryk-client mavryk-baker-ptboreas mavryk-accuser-ptboreas
```

### 3. Create a Mavryk Account

Before setting up your validator, you need a Mavryk account. You have two options:

**Option A: Browser Wallet (Recommended for beginners)**
- Visit [https://mavryk.org/wallet](https://mavryk.org/wallet) to create an account using the browser wallet extension.
- This is the easiest way to get started and manage your account.

**Option B: Command Line**
If you prefer to generate your account via command line:

```bash
# Generate a new key pair
mavkit-client gen keys $BAKER_ALIAS

# View your address and private key (keep this private!)
mavkit-client show address $BAKER_ALIAS -S
```

**⚠️ Important:** The private key should be temporarily exported to `BAKER_PRIVATE_KEY` environment variable. Never share your private key with anyone.

### 4. Configure Your Baker

Before running any scripts, you **must** set two environment variables:

- `BAKER_ALIAS`: The alias you want to use for your baker (e.g., `my_baker_account`).
- `BAKER_PRIVATE_KEY`: Your account's private key (e.g., `edsk...`).

You can set these in your shell or in a `.env` file (see below).

**Your account must hold at least 6000 MVRK on-chain to register as a baker.**

### 5. Initialize Your Node

Run the setup script to initialize your node, import the latest snapshot, and configure your baker:

```bash
cd fedora
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

### 6. Start/Restart Your Node

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

- Fedora 41
- At least 4GB RAM
- 100GB+ available disk space
- Stable internet connection

## Notes

- Make sure your account has at least 6000 MVRK before registering as a baker.
- Choose a unique alias for your baker.
- Never share your private key with anyone.
- The COPR repository provides release-candidate packages. For production use, consider using stable releases.
- For more details, see the comments in `setup.sh` and `start.sh`.

## Troubleshooting

- **Package not found**: Make sure you've enabled the COPR repository and run `sudo dnf update`.
- **Permission errors**: Ensure you have sudo privileges for package installation.
- **Service fails to start**: Check the logs in `/var/log/mavryk/` for detailed error messages.
- **DNF errors**: If you encounter issues with the COPR repository, try refreshing the DNF cache: `sudo dnf clean all && sudo dnf makecache`.

---

For more information, see the [Mavryk COPR Repository](https://copr.fedorainfracloud.org/coprs/g/MavrykDynamics/Mavryk-rc) and the [Validator Onboarding Guide](https://mavrykdynamics.notion.site/validator-onboarding-guide). 