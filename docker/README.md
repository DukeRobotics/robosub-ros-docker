# Dockerfile Notes

Basic docker setup for ros and ssh

## Running

1. Get the image
```bash
docker pull repo/imagename
```
TODO: Publish image and replace this ^

2. Run a container
```bash
docker run -td --network=host [imagename]
```
TODO: Replace imagename ^

### Notes
- -t: Allocate a bash shell inside the container
- -d: Start the container in the background
- --network=host: Set the container to use the same network as the user

3. Connect to the container
```bash
ssh -p 2200 duke@localhost
```

### Notes
- -p 2200: ssh to port 2200, instead of the default port 22


## Building

- Building should be done by the maintainer of the Dockerfile, and published so that others can follow the 'Running' instructions to use the image

1. cd into the directory containing the Dockerfile
2. Build
```bash
docker build -t ros-ssh .
```
