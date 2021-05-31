docker run -ti --rm \
	   -e DISPLAY=$DISPLAY \
	   --privileged \
           -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket:ro \
	   -v $(pwd):/root/working \
	   michaelgtodd/ck_ros_dev:latest \
	   /bin/bash --rcfile /root/.profile
	   
