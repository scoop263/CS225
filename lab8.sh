# !/bin/bash
LLINE=$(tail -1 /var/share/CS225/addresses.csv)
LLINE=${LLINE//'"'/' '}
FNAME=${LLINE%%,*}
LLINE=${LLINE#*,}
LNAME=${LLINE%%,*}
LLINE=${LLINE#*,}
COMPANY=${LLINE%%,*}
LLINE=${LLINE#*,}
STREET=${LLINE%%,*}
LLINE=${LLINE#*,}
CITY=${LLINE%%,*}
LLINE=${LLINE#*,}
STATE=${LLINE%%,*}
LLINE=${LLINE#*,}
STATEABR=${LLINE%%,*}
LLINE=${LLINE#*,}
ZIP=${LLINE%%,*}
LLINE=${LLINE#*,}
HPHONE=${LLINE%%,*}
LLINE=${LLINE#*,}
WPHONE=${LLINE%%,*}
LLINE=${LLINE#*,}
EMAIL=${LLINE%%,*}
LLINE=${LLINE#*,}
WEBURL=${LLINE%%,*}
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
