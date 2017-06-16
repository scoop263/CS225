MakeModel(){

#Uses exiv2 command to check make and model of camera
#If camera make and model exist then it uses regex to 
#rename variable for other functions. If make does not
#exist then it is changed to unknown which will be used 
#in another function. Also will take in any error and
#place it in Variable to be used if able
	
	LOCATION=$1
	ERROR="$(exiv2 ${LOCATION} 3>&1 1>&2 2>&3 >/dev/null)"
	MAKE=$(exiv2 $LOCATION | grep -a "Camera make")
	MODEL=$(exiv2 $LOCATION | grep -a "Camera model")
	MAKE=${MAKE#*:}
        MAKE=${MAKE//' '/'_'}
	#Also when using exiv2 command if it contains a line for make/model it is a space so if it is underscore changes to _unknown
	if [ -z $MAKE ] || [ $MAKE == '_' ]; then
		MAKE=_Unknown
		MODEL=_Unkown
		return 1
	else 
        	MODEL=${MODEL#*:}
        	MODEL=${MODEL//' '/'_'}
		return 0	
	fi
}
DateTime(){
# using stat command to take the DATE and TIME of the file and using delimitors
# to create variables based off the type of information to be used for a different function
	LOCATION=$1
	DATE=$(stat $LOCATION | grep "Modify: " | cut -d' ' -f2,2)
	TIME=$(stat $LOCATION | grep "Modify: " | cut -d' ' -f3,3)
	#Separates information to be used for other functions
	NOMSEC=${TIME%.*}
	NOMSEC=${NOMSEC//':'/-}
	YEAR=${DATE%%-*}
	MONTH=$(echo $DATE | cut -d'-' -f2,2)
	DAY=${DATE##*-}
	return 0
}
MoveCopy(){
	OLDFILE=$1
	NEWFILE=$2
	FORCE=$3
	#If user uses a force option then moves, otherwise copy forcing and preserves information
	if [[ $FORCE -eq 0 ]]; then
		mv -f $OLDFILE $NEWFILE
	else
		cp -pf $OLDFILE $NEWFILE
	fi
}
