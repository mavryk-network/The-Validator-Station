# Mavryk Validator Node on Kubernetes (Helm)

This directory contains configuration and examples for running a Mavryk validator node (baker) on Kubernetes using the official Helm chart.

- **Chart repo:** [mavryk-k8s](https://github.com/mavryk-network/mavryk-k8s)
- **Helm repo:** [mavryk-helm-charts](https://github.com/mavryk-network/mavryk-helm-charts)
- **Current version:** `6.30.3`

## Purpose

Easily deploy and manage a Mavryk validator node (baker) on Kubernetes using Helm. This setup is suitable for production and testnet deployments.

## Configuration Overview

- All configuration is done via `values.yaml` and Kubernetes Secrets.
- The baker alias and private key are set in the `accounts` section of `values.yaml` and referenced via a Kubernetes Secret (`accountsSecretName`).
- Your account must hold at least **6000 MVRK** on-chain to register as a baker.
- Choose a unique alias for your baker (replace every instance of `my_baker_account` with your chosen alias).

## Quickstart

### 1. Prepare Your Baker Account Secret

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

### 2. Edit `values.yaml`

- Set `accountsSecretName` to the name of your secret (e.g., `accounts-secret`).
- In the `accounts` section, replace every instance of `my_baker_account` with your chosen alias.
- Do **not** set the private key directly in `values.yaml`—it should only be in the secret.
- Make sure your alias is used consistently in the `nodes` section under `bake_using_accounts`.
- Example snippets are provided in the `values.yaml` file.

### 3. Deploy with Helm

Add the Helm repo and install the chart:

```sh
helm repo add mavryk https://charts.mavryk.org/
helm repo update
helm install my-mavryk-baker mavryk/mavryk-chain -f values.yaml --version 6.30.3
```

### 4. Notes

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