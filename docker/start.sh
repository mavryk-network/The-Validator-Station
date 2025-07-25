#!/bin/sh

set -e

echo "[INFO] Starting Mavryk node, baker, and accuser services..."
docker compose -f ./atlas.yml up -d mavkit-node mavkit-baker mavkit-accuser
echo "[SUCCESS] All services are up and running."
