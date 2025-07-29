#!/bin/bash

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
[INFO] Starting Mavryk node setup on Fedora...
[INFO] Baker alias: $BAKER_ALIAS
[INFO] (Private key is set)
[INFO] Your account must hold at least 6000 MVRK to register as a baker.
EOF

# Create necessary directories
echo "[INFO] Creating data directories..."
sudo mkdir -p /var/run/mavryk/node/data
sudo mkdir -p /var/run/mavryk/client
sudo chown -R $USER:$USER /var/run/mavryk

# Download latest snapshot
echo "[INFO] Downloading latest snapshot..."
wget https://snapshots.api.mavryk.network/basenet/full -O atlasnet.snapshot

# Initialize node configuration
echo "[INFO] Initializing node configuration..."
mavryk-node config init \
  --network https://testnets.mavryk.network/atlasnet \
  -d /var/run/mavryk/node/data \
  --config-file /var/run/mavryk/node/config.json

# Import snapshot
echo "[INFO] Importing snapshot..."
mavryk-node snapshot import /atlasnet.snapshot \
  -d /var/run/mavryk/node/data \
  --config-file /var/run/mavryk/node/config.json

# Start the node
echo "[INFO] Starting node..."
sudo systemctl start mavryk-node

# Wait for the node to be running
echo "[INFO] Waiting for node to start..."
sleep 30

# Import baker key
echo "[INFO] Importing baker key..."
mavryk-client import secret key "$BAKER_ALIAS" "unencrypted:$BAKER_PRIVATE_KEY"

# Wait for node to be bootstrapped
echo "[INFO] Waiting for node to be bootstrapped..."
mavryk-client bootstrapped

# Register baker as delegate
echo "[INFO] Registering baker as delegate..."
mavryk-client register key "$BAKER_ALIAS" as delegate

# Start baker and accuser services
echo "[INFO] Starting baker and accuser services..."
sudo systemctl start mavryk-baker-ptboreas
sudo systemctl start mavryk-accuser-ptboreas

# Enable services to start on boot
echo "[INFO] Enabling services to start on boot..."
sudo systemctl enable mavryk-node
sudo systemctl enable mavryk-baker-ptboreas
sudo systemctl enable mavryk-accuser-ptboreas

echo "[SUCCESS] Setup complete! You can now use ./start.sh to restart your node in the future."
echo "[INFO] Check service status with: sudo systemctl status mavryk-node mavryk-baker-ptboreas mavryk-accuser-ptboreas" 