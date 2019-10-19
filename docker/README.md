# Dockerfile Notes
  
## Building

- Building should be done by the maintainer of the Dockerfile, and published so that others can follow the 'Running' instructions to use the image

- Buildx is currently experimental, for details, see [here](https://docs.docker.com/buildx/working-with-buildx/)

1. ```cd``` into the directory containing the Dockerfile

2. Build
```bash
docker buildx build --platform linux/amd64,linux/arm64 -t dukerobotics/robosub-ros:latest --push .
```


