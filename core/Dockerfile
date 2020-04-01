FROM ros:kinetic-ros-core-xenial

### Arguments ###
ENV USERNAME=duke
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
    vim \
    curl \
    wget \
    sudo \
    usbutils \
    apt-utils \
    python-catkin-tools \
    python-pip \
    locales && \
    apt-get clean && \
    # Clear apt caches to reduce image size
    rm -rf /var/lib/apt/lists/*

# Set up locales
RUN locale-gen en_GB.UTF-8 && locale-gen en_US.UTF-8

### Final Setup ###

# Add catkin workspace
RUN mkdir -p /home/$USERNAME/dev/robosub-ros && \
    chown --recursive $USERNAME /home/$USERNAME/dev && \
    chgrp --recursive $USERNAME /home/$USERNAME/dev

# Copy and set entrypoint script
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT $WORKDIR/entrypoint.sh
