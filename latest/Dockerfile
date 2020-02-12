FROM ros:kinetic-ros-core-xenial

### Arguments ###
ARG USERNAME=duke
ARG PASSWORD=robotics
ARG BUILD_DIR_NAME=docker-build
ENV WORKDIR=/home/$USERNAME/$BUILD_DIR_NAME
ARG TARGETPLATFORM
### User Settings ###

# Create default user
RUN adduser --disabled-password --gecos "" $USERNAME
RUN echo $USERNAME":"$PASSWORD | chpasswd

# Add user to sudo and the dialout group to allow /dev access
RUN usermod -aG sudo,dialout $USERNAME

# Set the workdir
WORKDIR $WORKDIR

### Basic Setup ###

# Update and install tools
RUN apt-get update && apt-get install -y --no-install-recommends \
	openssh-server \
	x11-apps xauth \
	vim \
	curl \
	sudo \
    	usbutils \
    	apt-utils \
	python-catkin-tools \
	python-pip \
    	locales \
    	libceres-dev \
    	ros-kinetic-desktop-full \
    	ros-kinetic-mavros ros-kinetic-mavros-extras \
    	ros-kinetic-robot-localization  ros-kinetic-libg2o \
    	ros-kinetic-pid ros-kinetic-camera-info-manager-py \
    	ros-kinetic-rosserial ros-kinetic-rosserial-arduino \
    	ros-kinetic-rosbridge-suite && \
    	apt-get clean && \
    	# Clear apt caches to reduce image size
    	rm -rf /var/lib/apt/lists/*

# Get required python packages
RUN pip install pyserial dependency-injector

# Set up locales
RUN locale-gen en_GB.UTF-8 && locale-gen en_US.UTF-8

### SSH Settings ###

# Set ssh to not use local X11 so graphics are forwarded to user
RUN echo "X11UseLocalhost no" >> /etc/ssh/sshd_config && \
    # Set ssh to use port 2200
    sed -i "s/Port 22/Port 2200/" /etc/ssh/sshd_config

### ROS Plugins and Dependencies###

# Install Vimba libraries for avt_vimba_camera
COPY $TARGETPLATFORM/Vimba.tgz Vimba.tgz
RUN tar -xf Vimba.tgz && \
    cd Vimba_3_0/VimbaGigETL && \
    ./Install.sh
RUN rm Vimba.tgz

### Final Setup ###

# Change owner and group to user on installed files
RUN chown --recursive $USERNAME $WORKDIR && \
    chgrp --recursive $USERNAME $WORKDIR

# Add catkin workspace
RUN mkdir -p /home/$USERNAME/dev/robosub-ros && \
    chown --recursive $USERNAME /home/$USERNAME/dev && \
    chgrp --recursive $USERNAME /home/$USERNAME/dev

# Copy and set entrypoint script
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT $WORKDIR/entrypoint.sh
