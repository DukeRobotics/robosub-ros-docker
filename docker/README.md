# Dockerfile Notes

Basic docker setup for ros and ssh

## Running

1. Get the image
```bash
docker pull miron003/robosub-ros
```

2. Run a container
```bash
docker run -td -p 2200:2200 --mount type=bind,source=/PATH/TO/SRC,target=/home/duke/dev/robosub-ros/catkin_ws/src  miron003/robosub-ros
```

3. Connect to the container
```bash
ssh -XY -p 2200 duke@localhost
```

#### Run a container notes
* -t
  * Allocate a bash shell inside the container

* -d
  * Start the container in the background

* -p 2200:2200
  * Forward port 2200 on the container to port 2200 on user's computer

* --mount type=bind,source=/PATH/TO/SRC,target=/home/duke/dev/robosub-ros/src
  * Create a binding between a folder on the user's computer to a folder inside the container
    * All files in src on user's computer will be mirrored to src inside container, i.e. changes made on user's computer will occur inside the container, and vice versa

* --privileged
  * Run the container in privileged mode, allowing access to /dev
  * Use this flag if you need to connect to USB devices


  
#### Run a container examples
* Windows
```bash
docker run -td -p 2200:2200 --mount type=bind,source=C:\Users\Eric\Documents\Robotics\CS,target=/home/duke/dev/robosub-ros/src  miron003/robosub-ros
```

* Mac
```bash
```
  
#### Connect to a container notes
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


