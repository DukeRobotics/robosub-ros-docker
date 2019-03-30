# Set up environment variables for simulation

base_dir=$1

# Source gazebo setup
source /usr/share/gazebo/setup.sh

# Add freebuoyancy models and resources
export GAZEBO_MODEL_PATH=$base_dir/freebuoyancy_gazebo/model:$GAZEBO_MODEL_PATH
export GAZEBO_RESOURCE_PATH=$base_dir/freebuoyancy_gazebo/worlds:$GAZEBO_RESOURCE_PATH

# Add ardupilot_gazebo models and resources
export GAZEBO_MODEL_PATH=$base_dir/ardupilot_gazebo/models:$GAZEBO_MODEL_PATH
export GAZEBO_RESOURCE_PATH=$base_dir/ardupilot_gazebo/worlds:$GAZEBO_RESOURCE_PATH

# Add bluerov_ros_playground models and resources
export GAZEBO_MODEL_PATH=$base_dir/bluerov_ros_playground/model:$GAZEBO_MODEL_PATH
export GAZEBO_RESOURCE_PATH=$base_dir/bluerov_ros_playground/worlds:$GAZEBO_RESOURCE_PATH


# Add ardupilot autotest tools to path
export PATH=$PATH:~/docker-build/ardupilot/Tools/autotest
