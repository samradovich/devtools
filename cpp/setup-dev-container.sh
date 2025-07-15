#!/bin/bash

# Source file name and image name
CONTAINER_NAME="cpp-dev-container"
DOCKERFILE="Dockerfile.dev"

sudo docker build -t $CONTAINER_NAME -f $DOCKERFILE .

sudo docker run -it --rm \
    -d \
    -p 7776:22 \
    -v "$SOURCE_DIR:/usr/src/app" \
    --name $CONTAINER_NAME \
    $CONTAINER_NAME

echo "Container started with source code mounted at /usr/src/app"
echo "SSH connection available on port 7776"
