FROM osrf/ros:kinetic-desktop-full-xenial


### Basic Setup ###

# Update and install tools
RUN apt-get update && apt-get install -y \
	openssh-server \
	x11-apps \
	vim \
	sudo

# Set up locales
RUN apt install -y locales
RUN locale-gen en_GB.UTF-8 && locale-gen en_US.UTF-8



### User Settings ###

# Create default user
RUN adduser --disabled-password --gecos "" duke
RUN echo "duke:robotics" | chpasswd

# Add user to sudo and the dialout group to allow /dev access
RUN usermod -aG sudo,dialout duke



### SSH Settings ###

# Set ssh to not use local X11 so graphics are forwarded to user
RUN echo "X11UseLocalhost no" >> /etc/ssh/sshd_config

# Set ssh to use port 2200
RUN sed -i "s/Port 22/Port 2200/" /etc/ssh/sshd_config


#clear apt caches to reduce image size
RUN rm -rf /var/lib/apt/lists/*


ENTRYPOINT service ssh restart && bash
