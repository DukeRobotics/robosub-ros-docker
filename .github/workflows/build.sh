#!/bin/bash

set -ex

# Build image
cd latest
docker buildx build --platform ${TARGETPLATFORM} -t ${IMAGE_NAME} --load .

# Test image
docker-compose --file clone-and-build.test.yml run sut
