#!/bin/bash

set -ex

# Build image
cd ${FOLDER_NAME}
docker buildx build --build-arg BASE_IMAGE=${BASE_IMAGE} --platform ${TARGETPLATFORM} -t ${IMAGE_NAME} --load .

