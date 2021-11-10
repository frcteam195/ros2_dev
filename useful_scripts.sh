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
	exit 1
}
infomsg()
{
	printf "\n${GREEN}INFO:${NC} ${1}\n\n" >> /dev/stderr
}