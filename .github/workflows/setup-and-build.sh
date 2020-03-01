#!/bin/bash

set -ex

# Install buildx
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
mkdir -p ~/.docker/cli-plugins
wget -O ~/.docker/cli-plugins/docker-buildx https://github.com/docker/buildx/releases/download/v0.3.1/buildx-v0.3.1.linux-amd64
chmod a+x ~/.docker/cli-plugins/docker-buildx
docker buildx create --name robobuilder --driver docker-container --use
docker buildx inspect --bootstrap
docker buildx ls

# Build image
cd latest
docker buildx build --platform ${TARGETPLATFORM} -t ${IMAGE_NAME} --load .

# Test image
docker-compose --file clone-and-build.test.yml run sut
