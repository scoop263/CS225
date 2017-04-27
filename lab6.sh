# !/bin/bash
LOC=/root/medialab/
FILE=/root/medialab/media.xml
FCOUNT=0
DCOUNT=0
XML=/root/medialab/xmlfile.txt
DIR=/root/medialab/directory.txt
touch $XML
touch $DIR
grep -oP '(?<=field name="filename">)[^<]+' "${FILE}" | grep -E '.mpg|.mp3' > ${XML}
ls ${LOC} | grep -E '.mpg|.mp3' > ${DIR}
echo "Files not in media directory"
while read i
do
  if [[ $(grep '$i' "${DIR}" | wc -l) -eq 0 ]]; then
    echo "$i"
  (( FCOUNT++ ))
  else
  :
  fi
done <$XML
echo "Files not in media.xml"
while read j
do
  if [[ $(grep '$j' "${XML}" | wc -l) -eq 0 ]]; then
   echo "$j"
  (( DCOUNT++ ))
  else
  :
  fi
done <$DIR
echo "$FCOUNT media files in media.xml that are not in medialab directory"
echo "$DCOUNT media files in medialab directory that are not in media.xml"
rm -f ${XML}
rm -f ${DIR}
