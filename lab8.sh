# !/bin/bash
FILENAME=/var/share/CS225/addresses.csv
OPERATION="tail -1 ${FILENAME}"
FNAME=$($OPERATION | cut -d'"' -f2)
LNAME=$($OPERATION | cut -d'"' -f4)
COMPANY=$($OPERATION | cut -d'"' -f6)
STREET=$($OPERATION | cut -d'"' -f8)
CITY=$($OPERATION | cut -d'"' -f10)
STATE=$($OPERATION | cut -d'"' -f12)
STATEABR=$($OPERATION | cut -d'"' -f14)
ZIP=$($OPERATION | cut -d'"' -f16)
HPHONE=$($OPERATION | cut -d'"' -f18)
WPHONE=$($OPERATION | cut -d'"' -f20)
EMAIL=$($OPERATION | cut -d'"' -f22)
WEBURL=$($OPERATION | cut -d'"' -f24)
echo ${FNAME,,}
echo ${LNAME,,}
echo ${COMPANY,,}
echo ${STREET,,}
echo ${CITY,,}
echo ${STATE,,}
echo ${STATEABR,,}
echo ${ZIP,,}
echo ${HPHONE,,}
echo ${WPHONE,,}
echo ${EMAIL,,}
echo ${WEBURL,,}

