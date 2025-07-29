# Mavryk Validator Node on Kubernetes (Helm)

This directory contains configuration and examples for running a Mavryk validator node (baker) on Kubernetes using the official Helm chart.

- **Chart repo:** [mavryk-k8s](https://github.com/mavryk-network/mavryk-k8s)
- **Helm repo:** [mavryk-helm-charts](https://github.com/mavryk-network/mavryk-helm-charts)
- **Current version:** `6.30.3`

## Purpose

Easily deploy and manage a Mavryk validator node (baker) on Kubernetes using Helm. This setup is suitable for production and testnet deployments.

## Protocol and Testnet Disclaimer

**Protocol Updates:**
- **Atlas**: The first update of the Mavryk blockchain protocol code
- **Boreas**: The second update of the Mavryk blockchain protocol code (current)

**Testnets:**
- **Atlasnet**: The testnet on which Atlas was initially deployed. It has now been updated to run the Boreas protocol.
- **Basenet**: The name given to the long-running testnet. Currently, Atlasnet and Basenet refer to the same testnet (Atlasnet = Basenet).

The current setup uses the **Boreas protocol** on the **Atlasnet/Basenet testnet**.

## Configuration Overview

- All configuration is done via `values.yaml` and Kubernetes Secrets.
- **Do NOT use environment variables for your baker alias or private key.**
- The baker alias and private key are set in the `accounts` section of `values.yaml` and referenced via a Kubernetes Secret (`accountsSecretName`).
- Your account must hold at least **6000 MVRK** on-chain to register as a baker.
- Choose a unique alias for your baker (replace every instance of `my_baker_account` with your chosen alias).

## Quickstart

### 1. Create a Mavryk Account

Before setting up your validator, you need a Mavryk account. You have two options:

**Option A: Browser Wallet (Recommended for beginners)**
- Visit [https://mavryk.org/wallet](https://mavryk.org/wallet) to create an account using the browser wallet extension.
- This is the easiest way to get started and manage your account.

**Option B: Command Line**
If you prefer to generate your account via command line (after deploying the chart):

```bash
# Generate a new key pair
kubectl exec -it deployment/mavryk-node -- mavkit-client gen keys $BAKER_ALIAS

# View your address and private key (keep this private!)
kubectl exec -it deployment/mavryk-node -- mavkit-client show address $BAKER_ALIAS -S
```

**⚠️ Important:** The private key should be temporarily exported to `BAKER_PRIVATE_KEY` environment variable. Never share your private key with anyone.

### 2. Prepare Your Baker Account Secret

Create a Kubernetes secret containing your baker's private key. Example manifest:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: accounts-secret # This name should match accountsSecretName in values.yaml
stringData:
  ACCOUNTS: |
    {
      "my_baker_account": {
        "is_bootstrap_baker_account": false,
        "key": "edsk..." # <-- Your private key here
      }
    }
```

Apply the secret:
```sh
kubectl apply -f accounts-secret.yaml
```

### 3. Edit `values.yaml`

- Set `accountsSecretName` to the name of your secret (e.g., `accounts-secret`).
- In the `accounts` section, replace every instance of `my_baker_account` with your chosen alias.
- Do **not** set the private key directly in `values.yaml`—it should only be in the secret.
- Make sure your alias is used consistently in the `nodes` section under `bake_using_accounts`.
- Example snippets are provided in the `values.yaml` file.

### 4. Deploy with Helm

Add the Helm repo and install the chart:

```sh
helm repo add mavryk https://charts.mavryk.org/
helm repo update
helm install my-mavryk-baker mavryk/mavryk-chain -f values.yaml --version 6.30.3
```

### 5. Notes

- Your account must have at least **6000 MVRK** to register as a baker.
- Choose a unique alias for your baker and use it everywhere in your config and secret.
- **Never share your private key.**
- For advanced configuration, see the [official chart documentation](https://github.com/mavryk-network/mavryk-k8s) and the example `values.yaml` in this directory.

---

## Example: Setting the Baker Alias and Key

In your `values.yaml`:

```yaml
accountsSecretName: accounts-secret
accounts:
  my_baker_account: # <-- Replace with your alias
    is_bootstrap_baker_account: false
    # key is loaded from the secret
...
```

In your secret (as above):

```json
{
  "my_baker_account": {
    "is_bootstrap_baker_account": false,
    "key": "edsk..."
  }
}
```

---

For more details, see the comments in `values.yaml` and the [official chart repo](https://github.com/mavryk-network/mavryk-k8s). 