# !/bash/bin
# -------------------------------
LOCATION=/root/
FILENAME=HA
START=0
# -------------------------------
touch ${LOCATION}${FILENAME}.txt
VAR=$(ls -la ${LOCATION} | grep "${FILENAME}*" | wc -l)
echo $VAR
#read BLANK
LOOP=$(ls -la ${LOCATION} | grep "${FILENAME}" | wc -l)
# -------------------------------
while [ $START -lt $LOOP ]
do
  for (( i=0; i<${LOOP}; i++ ))
   do
   DUP=$(ls -la ${LOCATION} | grep '${FILENAME}' | wc -l)
   touch ${LOCATION}${FILENAME}${DUP}.txt
   echo $?
   done
(( START++ ))
done
