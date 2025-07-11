#!/bin/bash

# Source file name and image name
CONTAINER_NAME="cpp-dev-container"
DOCKERFILE="Dockerfile.dev"

sudo docker build -t $CONTAINER_NAME -f $DOCKERFILE .

sudo docker run -it --rm \
    -d \
    -p 7776:22 \
    --name $CONTAINER_NAME \
    $CONTAINER_NAME