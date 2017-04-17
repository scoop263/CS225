# !/bin/bash
LOOP=1
while [ $LOOP != 0 ]
do
echo "Please enter a number"
echo "Press K to kill program"
read NUMBER
# Kill Switch
if [ ${NUMBER} = "K" ] || [ ${NUMBER} = "k" ]; then
  exit
# Filters out non numeric input
elif [[ ${NUMBER} =~ [^+-.[:digit:]] ]]; then
  echo "Not a number! Input again."
else
# Checks to see if value on left hand side is greater than 5
  if [[ ${NUMBER%.*} -gt 5 ]] ; then
   echo "${NUMBER} is greater than 5"
# Checks to see if value on left hand side is equal to 5
  elif [[ ${NUMBER%.*} -eq 5 ]]; then
# Checks to see if value on right hand side is 0
# if not its larger than 5, if its 0 then its equal to 5
   if [[ ${NUMBER#*.} -eq 0 ]] || [[ ${NUMBER} -eq 5 ]]; then
   echo "${NUMBER} is equal to 5"
   else 
   echo "${NUMBER} is greater than 5"
   fi
# Anything else that isnt equal to 5 or greater 
# clearly is less than.
   else
   echo "${NUMBER} is less than 5"
   fi
fi
done
