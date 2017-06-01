#!/bin/bash
cleanup(){
	echo "Interrupting Program!"
	exit
}
trap cleanup INT TERM HUP
LINE=$(tail -1 ~/addresses.csv)
LINE=${LINE//'"'/''}
OLDIFS=$IFS
IFS=','
set ${LINE}
declare -a FirstPart=(${1} ${3} ${5} ${7} ${9} ${11})
declare -a SecondPart=(${2} ${4} ${6} ${8} ${10} ${12})
COUNTER=0
echo -n "\""${FirstPart[${COUNTER}]}"\",\""${SecondPart[${COUNTER}]}"\","
(( COUNTER++ ))
while [ $COUNTER -lt 5 ]; do
	echo -n "\""${FirstPart[${COUNTER}]}"\",\""${SecondPart[${COUNTER}]}"\","
	(( COUNTER++ ))
done
echo "\""${FirstPart[${COUNTER}]}"\",\""${SecondPart[${COUNTER}]}"\""
IFS=$OLDIFS
