# !/bin/bash

LOOP=1
while [ $LOOP != 0 ]
do
echo "Please enter a number"
echo "Press K to kill program"
read NUMBER
# Before filtering out characters it checks
# for K or k first to quit program.
if [ ${NUMBER} = "K" ] || [ ${NUMBER} = "k" ]; then
  exit
# Uses a pattern to filter out anything that
# includes a character letter or decimal number.
elif [[ ${NUMBER} =~ [^+-[:digit:]] ]]; then
  echo "Input is either a decimal or non-numeric."
  echo "Input again."
else 
# Checks to see if it is even or odd.
 if [ $(( ${NUMBER} % 2 )) -eq 0 ]; then
   echo "${NUMBER} is even"
  else
   echo "${NUMBER} is odd"
  fi
fi
done
