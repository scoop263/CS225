#!/bin/bash
source library.sh
help(){
	echo "Script uses exiv2 command, make sure it's installed."
	echo "To use script you must input a pathname to the folder."
	echo "Options:"
	echo "          d - sets Debugging on"
	echo "          f - sets script to move instead of copy"
	echo ""
}
logging(){
#Logging function takes in parameters and sends it to the journal
#Depending on force message changes
	PAST=$1
	NEW=$2
	FORCE=$3
	if [[ ${FORCE} -eq 0 ]]; then
		logger "$(date): File ${PAST} has been moved to ${NEW}"
	else	
		logger "$(date): File ${PAST} has been copied to ${NEW}"
	fi
}
cleanupInt(){
	# Calls the cleanupExit to properly cleanup script
	# But displays error message from this one
	cleanupExit
	echo "You interrupted the program!"
	help
	exit 1
}
cleanupExit(){
	# Function is meant to perform cleanup after script is done
        if [ -e ~/ERRORLOGFILE.txt ]; then
                ELOGGING=$(ls ~/ | grep "ERRORLOGFILE" | wc -l)
                cat $ERRORTEMP > ~/ERRORLOGFILE${ELOGGING}.txt
        else
                cat $ERRORTEMP > ~/ERRORLOGFILE.txt
        fi
	
	if [ -e ~/LOGSFILE.txt ]; then
		LOGGING=$(ls ~/ | grep "LOGSFILE" | wc -l)
		cat $LOGTEMP > ~/LOGSFILE${LOGGING}.txt
	else
		cat $LOGTEMP > ~/LOGSFILE.txt
	fi
	if [ -e $LOGTEMP ]; then
		rm -f $LOGTEMP
	else
		:
	fi
	if [ -e $ERRORTEMP ]; then
		rm -f $ERRORTEMP
	else
		:
	fi
}
exist(){
#Exiv2 is a downloaded command so checks to see if command exists.
	if [ ! -z $(which exiv2) ]; then
		:
	else
		help
		exit 1
	fi
}
mkDir(){
#makes directory based off information from DateTime()
	mkdir -p ~/${YEAR}/${MONTH}/${DAY}
	return 0
}
mkChkFile(){
#Takes information from DateTime() MakeModel() extension() function to create a filepath for said file.
	FILE=~/${YEAR}/${MONTH}/${DAY}/${NOMSEC}${MAKE}${MODEL}.${EXT}
	#If File already exists will look in directory and see how many copies exists 
	#and changes counter appropriately.
	if [ -e $FILE ]; then
		#FNAME.EXT
		FNAME=${FILE%.*}
		NUM=${FNAME##*-}
		COUNTER=$(ls ~/${YEAR}/${MONTH}/${DAY}/ | grep ${NOMSEC}${MAKE}${MODEL} |  wc -l)
		FILE=${FILE%.*}-${COUNTER}.${EXT}
		return 0
	else
		return 0
	fi
	return 0
}
extension(){
#Takes the files name and recreates a variable with just the ext name lowercase
	EXT=$1
	EXT=${EXT##*.}
	EXT=${EXT,,}
	return 0
}
#----------- TEMPFILES -------------
ERRORTEMP=$(mktemp -t ERROR.XXXXXXXXXX)
LOGTEMP=$(mktemp -t LOG.XXXXXXXXXX)
#------------- MAIN ----------------
FORCE=1
trap cleanupInt INT TERM
exist
while getopts :df opt; do
	case $opt in
		d) set -x ;;
		f) FORCE=0 ;;
		*) echo "invalid option"
		   help
		   exit 1 ;;
	esac
done
shift $(($OPTIND - 1))
LOC=$1
#Used to see what file is being worked on.
NUMOFFILES=$(find $LOC | wc -l)
NUMOFFILES=$(expr $NUMOFFILES - 1)
CURRENTFILE=1
#If no one puts an argument in when running script will exit
if [ -z $LOC ]; then
	echo "you have not specified the location"
	help
	exit 1
else
	:
fi	
for i in $(find ${LOC}); do
	
	#find includes the directory itself
	if [ -z ${i##*'/'} ]; then
		:
	else
		
		MakeModel $i
		#MakeModel() creates a ERROR variable to catch standard error
		#Known issue: Currently in MakeModel() does not make standard error more readable.
		#So ErrorTemp, will have large spacing between error messages
		echo $ERROR >> $ERRORTEMP
		DateTime $i
		mkDir
		extension $i
		mkChkFile
		MoveCopy $i $FILE $FORCE
		#Will echo to screen. input info to journal. and send information to a tempfile
		if [[ $FORCE -eq 0 ]]; then
                        echo "$(date): File $CURRENTFILE of $NUMOFFILES : ${i} moved to ${FILE}"
			echo "$(date): File $CURRENTFILE of $NUMOFFILES : ${i} moved to ${FILE}" >> $LOGTEMP
			logging ${i} ${FILE} $FORCE
		else
                        echo "$(date): File $CURRENTFILE of $NUMOFFILES : ${i} copied to ${FILE}"
			echo "$(date): File $CURRENTFILE of $NUMOFFILES : ${i} copied to ${FILE}" >> $LOGTEMP
			logging ${i} ${FILE} $FORCE
		fi
		(( CURRENTFILE++ ))
	fi
done
trap cleanupExit EXIT
