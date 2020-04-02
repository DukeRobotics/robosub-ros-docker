#!/bin/bash

set -ex

cd ${FOLDER_NAME}
docker-compose --file clone-and-build.test.yml run sut
