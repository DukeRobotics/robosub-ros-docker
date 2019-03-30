# Dockerfile Notes

Basic docker setup for ros and ssh

## Running

1. Get the image
```bash
docker pull miron003/robosub-ros
```

2. Run a container
```bash
docker run -td -p 127.0.0.1:2200:22 --mount type=bind,source=/path/to/src,target=/home/duke/dev/robosub-ros/src  miron003/robosub-ros
```

#### Notes
* -t
  * Allocate a bash shell inside the container

* -d
  * Start the container in the background

* -p 127.0.0.1:2200:22
  * Forward port 22 on the container to port 2200 on user's computer

* --mount type=bind,source=/path/to/src,target=/home/duke/dev/robosub-ros/src
  * Create a binding between a folder on the user's computer to a folder inside the container
    * All files in src on user's computer will be mirrored to src inside container, i.e. changes made on user's computer will occur inside the container, and vice versa

* --privileged
  * Run the container in privileged mode, allowing access to /dev
  * Use this flag if you need to connect to USB devices

3. Connect to the container
```bash
ssh -XY -p 2200 duke@localhost
```

#### Notes
* -XY
  * Forward graphics over ssh connections

* -p 2200
  * ssh to port 2200, instead of the default port 22


## Building

- Building should be done by the maintainer of the Dockerfile, and published so that others can follow the 'Running' instructions to use the image

1. cd into the directory containing the Dockerfile
2. Build
```bash
docker build -t [dockerhub username]/robosub-ros .
```
