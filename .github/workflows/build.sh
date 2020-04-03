#!/bin/bash

set -ex

# Use experimental Docker
sudo python3 ./.github/workflows/experimental.py
sudo systemctl restart docker

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

# Build image
cd ${FOLDER_NAME}
docker build --build-arg BASE_IMAGE=${BASE_IMAGE} --build-arg TARGETPLATFORM=${TARGETPLATFORM} --platform ${TARGETPLATFORM} -t ${IMAGE_NAME} .


