#!/bin/bash
source /root/CS225REPO/functionlibrary.sh
#VARIABLES
METHOD=1
LOC=/root/timefiles

#----- Functions --------
# Help Function, prompts the user if they use the -h option
help(){
	echo "------------------- Help --------------------"
	echo "Options:"
	echo "        d - Debugging"
	echo "        h - Help Menu"
	echo "        f - Enables Move"
	echo "        * - No options used\, uses cp command"
	echo "---------------------------------------------"
}
# Removes Temp file after exiting
cleanExit() {
	rm -f $MKTEMP
	exit 0
}
# Makes directory structure by using the variables produced
# by the modifyStat function in Function Library.
# Will search to see if a directory of said month, and or day exists
# if so it doesnt create, if not it creates

mkDirFolders(){
	if [ -d ~/${Month} ]; then
	  echo "Directory ${Month} Already Exists"
	else
	   echo "Creating Directory ~/${Month}"
	   mkdir ~/${Month}
	fi
	if [ -d ~/${Month}/${Day} ]; then
	  echo "Directory ${Month}/${Day} Already Exists"
	else
	  echo "Creating Directory ~/${Month}/${Day}"
	  mkdir ~/${Month}/${Day}
	fi
}

#------ Main --------
MKTEMP=$(mktemp -t LOCATION.XXXXXXXXXX)
trap cleanExit HUP INT TERM EXIT
while getopts :dhf opt; do
	case $opt in
   		 d) set -x ;;
		 h) help ;;
		 f) METHOD=0 ;;
		 *) echo "You have entered an unknown option"
       	            help
                    exit ;;
	esac
done
for i in $(ls ${LOC}/); do
	getStat $i
        mkDirFolders
	moveCopy ${Month} ${Day} ${i} ${METHOD}
	if [[ $METHOD -eq 0 ]]; then
		echo "${LOC}/${i} has been moved to ~/${Month}/${Day}/${i}" >> $MKTEMP
        else
		echo "${LOC}/${i} has been copied to ~/${Month}/${Day}/${i}" >> $MKTEMP
	fi
done
# Now I'm sure there is another way to do this, like appending the Temporary file contents
# to the lab11Ouputlist.txt file, however when i tried to do this I was getting permission denied
# So this way works but it slows the script down, Since im constantly overwriting the file.
	while read -r line; do
		echo $line >> ~/lab11Outputlist.txt
	done < "${MKTEMP}"
