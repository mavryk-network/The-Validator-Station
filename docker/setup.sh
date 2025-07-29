#!/bin/sh

# This script should be run only at initialization as it imports a snapshot for your node
set -e

# Check for required environment variables
if [ -z "$BAKER_ALIAS" ]; then
  echo "[ERROR] BAKER_ALIAS environment variable is not set. Please set it to your desired baker alias."
  exit 1
fi
if [ -z "$BAKER_PRIVATE_KEY" ]; then
  echo "[ERROR] BAKER_PRIVATE_KEY environment variable is not set. Please set it to your account's private key."
  exit 1
fi

# Print configuration
cat <<EOF
[INFO] Starting Mavryk node setup...
[INFO] Baker alias: $BAKER_ALIAS
[INFO] (Private key is set)
[INFO] Your account must hold at least 6000 MVRK to register as a baker.
EOF

# Get the latest snapshot (uncomment if you want to download automatically)
echo "[INFO] Downloading latest snapshot..."
wget https://snapshots.api.mavryk.network/basenet/full -O atlasnet.snapshot

# Import snapshot
echo "[INFO] Importing snapshot..."
docker compose -f docker-compose.yml run --rm mavkit-snapshot-import

# Start the node
echo "[INFO] Starting node..."
docker compose -f docker-compose.yml up -d mavkit-node

echo "[INFO] Waiting for node to be bootstrapped..."
docker exec -it mavkit-node mavkit-client bootstrapped

echo "[INFO] Importing baker key..."
docker exec -it mavkit-node mavkit-client import secret key "$BAKER_ALIAS" "unencrypted:$BAKER_PRIVATE_KEY"

echo "[INFO] Registering baker as delegate..."
docker exec -it mavkit-node mavkit-client register key "$BAKER_ALIAS" as delegate

echo "[INFO] Starting baker and accuser services..."
docker compose -f ./docker-compose.yml up -d mavkit-baker mavkit-accuser

echo "[SUCCESS] Setup complete! You can now use ./start.sh to restart your node in the future."
