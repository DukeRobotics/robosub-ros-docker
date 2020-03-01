# Dockerfile Notes

## Tags
This Dockerfile is used to generate three differently tagged images.

1. `amd64`: A Docker image built to be run on development computers and the NUC (and any other 64 bit x86 system).
2. `arm64`: A Docker image built to be run on the Jetson.
3. `latest`: A Docker manifest list. Pulling `latest` will automatically choose between an ARM and x86 image depending on your system. This is the one you should use in most cases.

## Building
- All of these images are also built and published automatically. They take a long time to build so be sure you need it.

- Building should be done by the maintainer of the Dockerfile, and published so that others can follow the 'Running' instructions to use the image.

- Buildx is currently experimental, for details, see [here](https://docs.docker.com/buildx/working-with-buildx/)

- Experimental features in Docker must be enabled to use buildx, go to Docker Preferences -> Docker Engine and set experimental to 'true'.

- All these commands must be executed in the directory containing the Dockerfile.

### Updating the manifest list
After each build and push of the `arm64` or `amd64` tags, you should ensure that the images used for the `latest` tag are up to date. This means pointing the `latest` tag to the newly built images. In order to do so, you will need to create and push a new manifest list:

```bash
docker manifest create dukerobotics/robosub-ros:latest dukerobotics/robosub-ros:arm64 dukerobotics/robosub-ros:amd64

docker manifest push -p dukerobotics/robosub-ros:latest
```

In the event that you get an error about an existing manifest list, check `~/.docker/manifests` to see if there are any existing manifests
that match. If so, delete them and run the commands again.
### `arm64`
Run the below command to build and push a new ARM image with the `arm64` tag.

```bash
docker buildx build --platform linux/arm64 -t dukerobotics/robosub-ros:arm64 --push .
```

Now to update the manifest list for `latest` run the command in the section on updating the manifest list.

### `amd64`
If there is ever a need to manually build and push the `amd64` tag, use the following commands:

```bash
docker build --build-arg TARGETPLATFORM=linux/amd64 -t dukerobotics/robosub-ros:amd64 .

docker push dukerobotics/robosub-ros:amd64
```

We now have the new image pushed to Docker Hub. Please note that any subsequent commit to master will erase this image.

Now to update the manifest list for `latest` run the command in the section on updating the manifest list.

### `latest`
The following command will build a new arm64 and amd64 image but **does not** update the `arm64` and `amd64` tags. Instead, it will push the new images directly to `latest`.

This command is therefore not recommended, since it can lead to the images falling out of sync.

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t dukerobotics/robosub-ros:latest --push .
```

