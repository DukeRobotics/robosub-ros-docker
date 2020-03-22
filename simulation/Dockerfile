FROM dukerobotics/robosub-ros:amd64

# Set the workdir
WORKDIR /home/duke/dev

### Basic Setup ###

# Update and install tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-kinetic-geometry2 \
    xsltproc && \
    apt-get clean && \
    # Clear apt caches to reduce image size
    rm -rf /var/lib/apt/lists/*

# Install the simulator
RUN wget coppeliarobotics.com/files/CoppeliaSim_Edu_V4_0_0_Ubuntu16_04.tar.xz && \
    tar -kxvf CoppeliaSim_Edu_V4_0_0_Ubuntu16_04.tar.xz && \
    rm CoppeliaSim_Edu_V4_0_0_Ubuntu16_04.tar.xz && \
    mv CoppeliaSim_Edu_V4_0_0_Ubuntu16_04 coppelia && \
    cp coppelia/compiledRosPlugins/libsimExtROSInterface.so coppelia/libsimExtROSInterface.so
