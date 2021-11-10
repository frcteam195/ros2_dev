xhost + > /dev/null

export GID=$(id -g)
OS_NAME=$(uname -a)
XAUTH=/tmp/.docker.xauth
touch $XAUTH
XDISPL=`xauth nlist $DISPLAY`

if [ ! -z "$XDISPL" ]
then
  xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
fi

chmod 777 $XAUTH

if [[ $OSTYPE == 'darwin'* ]]; then
  DISPLAY_CMD=`echo $DISPLAY | sed 's/^[^:]*\(.*\)/host.docker.internal\1/'`
else
  DISPLAY_CMD=$DISPLAY
fi

OS_SPECIFIC_FLAGS=""

if [[ "$OS_NAME" == *"penguin"* ]]; then
	echo "Chrome OS detected"
else
	OS_SPECIFIC_FLAGS="--privileged --device=/dev/dri:/dev/dri"
fi

cp ~/.gitconfig $(pwd)

docker run -ti --rm \
	   -e DISPLAY=$DISPLAY_CMD \
	   $OS_SPECIFIC_FLAGS \
	   -e XAUTHORITY=$XAUTH \
       	   -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket:ro \
	   -v $(pwd):/mnt/working \
	   -v /tmp/.X11-unix:/tmp/.X11-unix \
	   -v ~/.ssh:/home/$USER/.ssh \
	   -v $XAUTH:$XAUTH \
	   --user $UID:$GID \
	   --volume="/etc/group:/etc/group:ro" \
       --volume="/etc/passwd:/etc/passwd:ro" \
       --volume="/etc/shadow:/etc/shadow:ro" \
       --net=host \
       -e HOME=/mnt/working \
	   guitar24t/ck-ros \
	   /bin/bash --rcfile /mnt/.bashrc
	   
