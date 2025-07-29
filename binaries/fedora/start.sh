#!/bin/bash

set -e

echo "[INFO] Starting Mavryk node, baker, and accuser services on Fedora..."
sudo systemctl start mavryk-node mavryk-baker-ptboreas mavryk-accuser-ptboreas
echo "[SUCCESS] All services are up and running."
echo "[INFO] Check service status with: sudo systemctl status mavryk-node mavryk-baker-ptboreas mavryk-accuser-ptboreas" 