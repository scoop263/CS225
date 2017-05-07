# !/bin/bash
LOC=/root/medialab/
FILE=medialist.txt
touch lostfiles.txt
touch foundfiles.txt
echo "Files that are lost" > ${LOC}lostfiles.txt
echo "Files that are found" > ${LOC}foundfiles.txt
while read p; do
   if [[ $(ls -la ${LOC} | grep "${p}" | wc -l) -eq 0 ]]; then
   	echo "${p}" >> ${LOC}lostfiles.txt
   	echo $?
   else
   	echo "${p}" >> ${LOC}foundfiles.txt
   	echo $?
fi
done < "${LOC}${FILE}"
