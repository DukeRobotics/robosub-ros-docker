FROM osrf/ros:kinetic-desktop-full-xenial


### Basic Setup ###

# Update and install tools
RUN apt-get update && apt-get install -y \
	openssh-server \
	x11-apps \
	vim \
	curl \
	sudo

# Set up locales
RUN apt-get install -y locales
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


# Clear apt caches to reduce image size
RUN rm -rf /var/lib/apt/lists/*



### Gazebo setup ###

# Install dependencies
RUN apt-get update && apt-get install -y \
    libsdformat4 \
    gazebo7 \
    gazebo7-plugin-base \
    libignition-math2 \
    libignition-math2-dev \
    libsdformat4-dev \
    libgazebo7 \
    libgazebo7-dev

RUN apt-get update && apt-get install -y \
    libjansson-dev \
    nodejs \
    npm \
    nodejs-legacy \
    libboost-dev \
    imagemagick \
    libtinyxml-dev \
    mercurial \
    cmake \
    build-essential

# Upgrade node
RUN curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

# Clone gzweb
RUN cd ~; \
    hg clone https://bitbucket.org/osrf/gzweb; \
    cd ~/gzweb; \
    hg up gzweb_1.4.0; \
    source /usr/share/gazebo/setup.sh; \
    npm run deploy --- -m


COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ./entrypoint.sh
