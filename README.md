# robosub-ros-docker
![Build Status](https://github.com/dukerobotics/robosub-ros-docker/workflows/build/badge.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/dukerobotics/robosub-ros)

Docker image for ROS system to control a robot for the RoboSub Competition

## Summary
Docker is a technology that allows encapsulation of the running environment. A docker container is like a tool that can be used to run code, irrespective of the computer. For more information, go [here](https://www.docker.com/resources/what-container).

As an example scenario, imagine that you made a python script and you want your friend to be able to run it. This python script relies on a couple different packages, that you downloaded on to your computer through various means. Now you send it to your friend and they try and run it, but then tell you it won't run, because they don't have any of the packages necessary. You can solve this in two ways. The first is to tell them how to install everything, send them links to where you got the packages, etc. Oh also, they're running Windows and you're on Ubuntu. You then realize that one of the packages only exists for Windows, and you start searching for a replacement.
Now the second option: Docker. What you can do is create a Dockerfile that inherits from Ubuntu, and then you can write out a series of instructions containing all the steps you followed to create your environment. For example, you can put all the `apt-get install`s in this Dockerfile. Then you can build this Dockerfile into an image, and put the image online. Now, all your friend on Windows has to do is download your image, create a container, and use the container to run your code. This means that your friend does not need to do any installation, and also runs the code in the exact same environment as you, despite being on a different computer.

Robot Operating System (ROS) is quite hefty and does not run easily on all machines. Our solution to this was to create a docker image with ROS inside it, so that for users to run ROS, they just need to install Docker and download our image.

## Building
Building a docker container is the process of taking a Dockerfile, running all the commands inside it, and creating an image. Because we need to build our Dockerfile for multiple platforms (x86 for most computers and ARM for the Jetson), we use the `buildx` command, which allows us to build for multiple platforms at the same time. For more information on buildx, go [here](https://docs.docker.com/buildx/working-with-buildx/).

Before trying to use buildx, make sure you have experimental features enabled. Go to Docker Preferences -> Command Line and select 'Enable experimental features'

You will also need to set-up a builder to do cross-platform builds. Create a new builder to get access to multi-architecture features
```bash
docker buildx create --name multibuilder
```
This will create a new builder with the name 'multibuilder' and 'docker-container' as the driver, giving it more capabilities.

Tell docker to use that builder
```bash
docker buildx use multibuilder
```

### Building `onboard` or `core`

You should almost never need to manually build these images since they are automatically pushed from the repo. If you do, the below instructions are primarily targeted at building the `core` and `onboard` images. The instructions for building the `landside` image are much simpler and can be found in that folder.

For the `core` and `onboard` images, we generate both arm64 and amd64 images which are then bundled together under a single "primary" tag. So for instance, for onboard, the images are called `onboard-arm64` and `onboard-amd64` while the primary tag is just `onboard`.

- All of these images are also built and published automatically. They take a long time to build so be sure you need it.

- Building should be done by the maintainer of the Dockerfile, and published so that others can follow the 'Running' instructions to use the image.

- Buildx is currently experimental, for details, see [here](https://docs.docker.com/buildx/working-with-buildx/)

- Experimental features in Docker must be enabled to use buildx, go to Docker Preferences -> Docker Engine and set experimental to 'true'.

- All these commands must be executed in the directory containing the Dockerfile.

#### Updating the manifest list
After each build and push of the arm64 or amd64 tags, you should ensure that the images used for the primary tag are up to date. This means pointing the primary tag to the newly built images. In order to do so, you will need to create and push a new manifest list. For example, to do this for the `onboard` image, you would run:

```bash
docker manifest create dukerobotics/robosub-ros:onboard dukerobotics/robosub-ros:onboard-arm64 dukerobotics/robosub-ros:onboard-amd64

docker manifest push -p dukerobotics/robosub-ros:onboard
```

In the event that you get an error about an existing manifest list, check `~/.docker/manifests` to see if there are any existing manifests
that match. If so, delete them and run the commands again.
#### arm64 image
Run the below command to build and push a new ARM image with the `onboard-arm64` tag.

```bash
docker buildx build --platform linux/arm64 -t dukerobotics/robosub-ros:onboard-arm64 --push .
```

Now to update the primary tag, run the command in the section on updating the manifest list.

#### amd64 image
Run the below command to build and push a new x86 image with the `onboard-amd64`:

```bash
docker build --build-arg TARGETPLATFORM=linux/amd64 -t dukerobotics/robosub-ros:onboard-amd64 .

docker push dukerobotics/robosub-ros:onboard-amd64
```

We now have the new image pushed to Docker Hub. Please note that any subsequent commit to master will erase this image.

Now to update the primary tag, run the command in the section on updating the manifest list.

#### Primary tag
The following command will build a new arm64 and amd64 image but **does not** update the `onboard-arm64` and `onboard-amd64` tags. Instead, it will push the new images directly to `onboard`.

This command is therefore not recommended, since it can lead to the images falling out of sync.

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t dukerobotics/robosub-ros:onboard --push .
```

### Building `base`
If you really need to update the base image, the procedure is as follows.

#### `base-arm64`
Because nvidia does not tag their images with the correct architecture, you need to create a new Dockerfile that just contains

```dockerfile
FROM nvcr.io/nvidia/l4t-base:r32.3.1
```

Then build it using the buildx commands outlined for the `onboard-arm64` image above.

#### `base-amd64`
This image is just the stock Ubuntu image. To update it, just run:

```bash
docker pull ubuntu:bionic
docker tag ubuntu:bionic dukerobotics/robosub-ros:base-amd64
docker push dukerobotics/robosub-ros:base-amd64
```

### Updating the manifest list for base image
Then update the manifest list at `dukerobotics/robosub-ros:base` to point to the new arm64 and amd64 images.
