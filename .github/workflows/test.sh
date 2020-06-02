#!/bin/bash

set -ex

docker-compose --file clone-and-build.test.yml run sut
