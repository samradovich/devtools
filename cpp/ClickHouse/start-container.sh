#!/bin/bash

# Exit on any error
set -e

# Source file name and image name
CONTAINER_NAME="clickhouse-dev-container"
DOCKERFILE="Dockerfile.dev"
WORKDIR="/usr/src/ClickHouse"
SOURCE_DIR="/home/samradovich/Documents/projects/ClickHouse"
SETUPDIR="/usr/src/ClickHouseSetup"
SETUP_SCRIPT="setup-dependencies.sh"

sudo docker build -t $CONTAINER_NAME -f $DOCKERFILE .

# Remove existing container if it exists
sudo docker rm -f $CONTAINER_NAME 2>/dev/null || true

sudo docker run -it --rm \
    -d \
    -p 7776:22 \
    -v "$SOURCE_DIR:$WORKDIR" \
    --name $CONTAINER_NAME \
    $CONTAINER_NAME

echo "Container started with source code mounted at $WORKDIR"
echo "SSH connection available on port 7776"

# Check if setup script exists
SETUP_SCRIPT_PATH="$(dirname "$0")/$SETUP_SCRIPT"
if [ ! -f "$SETUP_SCRIPT_PATH" ]; then
    echo "Error: Setup script not found at $SETUP_SCRIPT_PATH"
    exit 1
fi

# Create the setup directory in the container
sudo docker exec $CONTAINER_NAME mkdir -p $SETUPDIR

# Copy the setup script to the container
sudo docker cp "$SETUP_SCRIPT_PATH" $CONTAINER_NAME:$SETUPDIR/

echo "Setup script $SETUP_SCRIPT copied to $SETUPDIR/... you need to run it"
