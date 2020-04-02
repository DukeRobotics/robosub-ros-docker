ARG BASE_IMAGE=dukerobotics/robosub-ros:core
FROM ${BASE_IMAGE}

ARG TARGETPLATFORM

### SSH Setup ###

# Set ssh to use port 2200
RUN sed -i "s/Port 22/Port 2200/" /etc/ssh/sshd_config

### Basic Setup ###

# Update and install tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    libceres-dev \
    ros-kinetic-cv-bridge ros-kinetic-tf \
    ros-kinetic-robot-localization  ros-kinetic-libg2o \
    ros-kinetic-pid ros-kinetic-camera-info-manager-py \
    ros-kinetic-rosserial ros-kinetic-rosserial-arduino && \
    apt-get clean && \
    # Clear apt caches to reduce image size
    rm -rf /var/lib/apt/lists/*

# Get required python packages
RUN pip install pyserial dependency-injector

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

ENV COMPUTER_TYPE=robot
