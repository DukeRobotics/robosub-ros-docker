ARG BASE_IMAGE=ros:melodic-ros-core-bionic
FROM ${BASE_IMAGE}

### Arguments ###
ARG BUILD_DIR_NAME=docker-build
ENV WORKDIR=/root/$BUILD_DIR_NAME

### Basic Setup ###

# Set the workdir
WORKDIR $WORKDIR

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

# Add catkin ws
RUN mkdir -p /root/dev/robosub-ros

# Copy and set entrypoint script
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT $WORKDIR/entrypoint.sh
