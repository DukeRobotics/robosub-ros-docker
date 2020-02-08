cd ~/coppelia
SERVER="comm_server_scene.ttt"
LIBRARY="libsimExtROSInterface.so"
if [ -f $SERVER ]; then
        echo "Server scene found."
else
        cd
        SERVERPATH="$(find -name $SERVER | grep -m 1 $SERVER)"
        cp $SERVERPATH coppelia/
        cd coppelia
        echo "Server scene not found. Moving..."
fi
if [ -f $LIBRARY ]; then
        echo "ROS Library found."
else
        LIBPATH="$(find -name libsimExtROSInterface.so | grep -m 1 $LIBRARY)"
        cp $LIBPATH .
        echo "ROS Library not found. Moving..."
fi
echo "Starting CoppeliaSim"

./coppeliaSim.sh -h -s comm_server_scene.ttt