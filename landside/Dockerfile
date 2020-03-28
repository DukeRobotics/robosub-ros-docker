FROM ros:kinetic-ros-core-xenial

### Arguments ###
ARG USERNAME=landside
ARG PASSWORD=robotics
ARG BUILD_DIR_NAME=docker-build
ENV WORKDIR=/home/$USERNAME/$BUILD_DIR_NAME
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
RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:jgmath2000/et && \
    apt-get update && apt-get install -y --no-install-recommends \
    openssh-server mosh et \
    x11-apps xauth \
    vim \
    curl \
    wget \
    sudo \
    usbutils \
    apt-utils \
    python-catkin-tools \
    python-pip \
    locales \
    ros-kinetic-geometry2 ros-kinetic-rviz \
    ros-kinetic-joy ros-kinetic-rosbridge-suite \
    xsltproc && \
    apt-get clean && \
    # Clear apt caches to reduce image size
    rm -rf /var/lib/apt/lists/*

# Install the simulator
RUN wget coppeliarobotics.com/files/CoppeliaSim_Edu_V4_0_0_Ubuntu16_04.tar.xz && \
    tar -xf CoppeliaSim_Edu_V4_0_0_Ubuntu16_04.tar.xz && \
    rm CoppeliaSim_Edu_V4_0_0_Ubuntu16_04.tar.xz && \
    mv CoppeliaSim_Edu_V4_0_0_Ubuntu16_04 coppelia && \
    cp coppelia/compiledRosPlugins/libsimExtROSInterface.so coppelia/libsimExtROSInterface.so

# Set up locales
RUN locale-gen en_GB.UTF-8 && locale-gen en_US.UTF-8

### SSH Settings ###

# Set ssh to use port 2002
RUN sed -i "s/Port 22/Port 2002/" /etc/ssh/sshd_config

# Change owner and group to user on installed files
RUN chown --recursive $USERNAME $WORKDIR && \
    chgrp --recursive $USERNAME $WORKDIR


# Add script to setup multiple machines for pool testing
COPY pool_setup.bash /home/$USERNAME/pool_setup.bash

# Add catkin workspace
RUN mkdir -p /home/$USERNAME/dev/robosub-ros && \
    chown --recursive $USERNAME /home/$USERNAME/dev && \
    chgrp --recursive $USERNAME /home/$USERNAME/dev

# Copy and set entrypoint script
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT $WORKDIR/entrypoint.sh