forall() {
	COMMAND=$@
	if [ ${#@} -lt 1 ]; then
    	echo "No command entered! Please enter a command to run!"
		return;
	fi
	echo "Running $COMMAND"
	find . -maxdepth 1 \( ! -name . \) | grep -v \\./\\. | xargs -I {} bash -c "cd '{}' && echo && echo {} && $COMMAND";
}

#Colors: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
errmsg()
{
	printf "\n${RED}ERROR:${NC} ${1}\n\n" >> /dev/stderr
	if [ "${2}" != "noexit" ]
	then
		exit 1
	fi
}
infomsg()
{
	printf "\n${GREEN}INFO:${NC} ${1}\n\n" >> /dev/stderr
}

exit_if_macOS()
{
	if [[ $OSTYPE == 'darwin'* ]]; then
		errmsg 'macOS is no longer supported. Please run this in an Ubuntu virtual machine.'
	fi
}

exit_if_docker()
{
	if [ -f /.dockerenv ]; then
		errmsg 'This cannot be run inside a docker container.'
	fi
}

exit_if_not_docker()
{
	if [ ! -f /.dockerenv ]; then
		errmsg 'This must be run inside a docker container.'
	fi
}

flatten_trajectories()
{
	cd ./*trajectories_* 2>> /dev/null
	if [ $? -eq 0 ]; then
		TRAJ_DIR=$(pwd)
		cd ..
		echo "Deploying Trajectories..."
		mkdir -p ./tmptraj
		rm -Rf ./tmptraj/**
		cp ${TRAJ_DIR}/**/*.shoe ./tmptraj/
		cp ${TRAJ_DIR}/*.shoe ./tmptraj/ 2>>/dev/null
	fi
}