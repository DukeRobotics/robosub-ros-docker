# robosub-ros-docker
Docker image for ROS system to control a robot for the RoboSub Competition

## Summary
Docker is a technology that allows encapsulation of the running environment. A docker container is like a tool that can be used to run code, irrespective of the computer. For more information, go [here](https://www.docker.com/resources/what-container).

As an example scenario, imagine that you made a python script and you want your friend to be able to run it. This python script relies on a couple different packages, that you downloaded on to your computer through various means. Now you send it to your friend and they try and run it, but then tell you it won't run, because they don't have any of the packages necessary. You can solve this in two ways. The first is to tell them how to install everything, send them links to where you got the packages, etc. Oh also, they're running Windows and you're on Ubuntu. You then realize that one of the packages only exists for Windows, and you start searching for a replacement. Now the second option: Docker. What you can do is create a Dockerfile that inherits from Ubuntu, and then you can write out a series of instructions containing all the steps you followed to create your environment. For example, you can put all the `apt-get install`s in this Dockerfile. Then you can build this Dockerfile into an image, and put the image online. Now, all your friend on Windows has to do is download your image, create a container, and use the container to run your code. This means that your friend does not need to do any installation, and also runs the code in the exact same environment as you, despite being on a different computer.

Robot Operating System (ROS) is quite hefty and does not run easily on all machines. Our solution to this was to create a docker image with ROS inside it, so that for users to run ROS, they just need to install Docker and download our image.

## Building
Building a docker container is the process of taking a Dockerfile, running all the commands inside it, and creating an image. Because we need to build our Dockerfile for multiple platforms (x86 for most computers and ARM for the Jetson), we use the `buildx` command, which allows us to build for multiple platforms at the same time. For more information on buildx, go [here](https://docs.docker.com/buildx/working-with-buildx/).

Before trying to use buildx, make sure you have experimental features enabled. Go to Docker Preferences -> Command Line and select 'Enable experimental features'

### Building an image

`cd` into the directory containing the Dockerfile.

Create a new builder to get access to multi-architecture features
```bash
docker buildx create --name multibuilder
```
- This will create a new builder with the name 'multibuilder' and 'docker-container' as the driver, giving it more capabilities.

Tell docker to use that builder
```bash
docker buildx use multibuilder
```

Build the Dockerfile
```bash
docker buildx build --platform linux/amd64,linux/arm64 -t dukerobotics/robosub-ros:latest .
```
- This command will build an image for amd64 and arm64, called 'dukerobotics/robosub-ros' with the tag 'latest'

If you want to automatically push the image to Dockerhub, add the `--push` tag to the command.

To push manually, use the following command. You need to be a member of the docker organization for this.
```bash
docker push [repository]/[image]:[tag]
```
