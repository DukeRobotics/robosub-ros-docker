cd coppelia
SERVER="comm_server_scene.ttt"
if [ -f $SERVER ]; then
        echo "Server scene found."
else
        cd ..
	echo "Server scene not found."
        SERVERPATH="$(find -name $SERVER | grep -m 1 $SERVER)"
	echo "Found file: $SERVERPATH"
	echo "Copying..."
        cp $SERVERPATH coppelia/
        cd coppelia
fi
echo "Starting CoppeliaSim"

./coppeliaSim.sh -h -s comm_server_scene.ttt
