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
for i in [ $START -lt $LOOP ]
