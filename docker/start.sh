#!/bin/sh

set -e

echo "[INFO] Starting Mavryk node, baker, and accuser services..."
docker compose -f ./docker-compose.yml up -d mavkit-node mavkit-baker mavkit-accuser
echo "[SUCCESS] All services are up and running."
