#!/bin/bash

set -e

# -----------------------------
# VALIDATION
# -----------------------------
if [ -z "$1" ]; then
  echo "❌ Usage: $0 <TMDB_V3_API_KEY>"
  exit 1
fi

TMDB_V3_API_KEY="$1"
IMAGE_NAME="netflix"

# -----------------------------
# INSTALL DOCKER
# -----------------------------
sudo apt-get update -y
sudo apt-get install -y docker.io

# -----------------------------
# ENABLE DOCKER
# -----------------------------
sudo systemctl start docker
sudo systemctl enable docker

# -----------------------------
# ADD USER TO DOCKER GROUP
# -----------------------------
sudo usermod -aG docker "$USER"

echo "⚠️  Log out and log back in to use Docker without sudo."

# -----------------------------
# BUILD IMAGE
# -----------------------------
sudo docker build \
  --build-arg TMDB_V3_API_KEY="$TMDB_V3_API_KEY" \
  -t "$IMAGE_NAME" .

echo "✅ Docker image '$IMAGE_NAME' built successfully!"
