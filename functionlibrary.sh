#------- FUNCTION LIBRARY --------
# Generic Functions that will be used in functions
#--------------------------------
# Will use stat command on the file name in argument 1.
# Will pipe it through grep and using cut command to 
# cut the delimiter ' '. After that it will put it in
# multiple variables depending on Month and Day of month.
getStat () {
	Date=$(stat ${LOC}/${1} | grep "Modify: " | cut -d' ' -f2,2)
	NDATE="${Date#*-}"
	Month=$(echo ${NDATE%%-*})
	NDATE=$(echo ${NDATE#*-})
	Day=$(echo ${NDATE})
}
# Depending on method used, files will either be copied or moved
# to the location
# Positional Arguments, 1 - 2 are directories, 3 is file name, 4 is method
moveCopy(){
	if [[ $4 -eq 0 ]]; then
	     mv -f ${LOC}/${3} ~/${1}/${2}/${3}
	else
             cp -pf ${LOC}/${3} ~/${1}/${2}/${3}
	fi
}
