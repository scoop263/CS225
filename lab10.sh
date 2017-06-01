#!/bin/bash
TEMPFILE=$(mktemp -t lab10.XXXXXXXXXX)
trap cleanup HUP INT QUIT TERM
cleanup () {
  echo "You sir have interrupted the program!"
  rm -f $TEMPFILE
  exit 1 ;}
i=0
COUNT=0
for i in $(find / ); do
   echo "${i}"
   echo "File ${COUNT}: ${i}" >> $TEMPFILE
   (( COUNT++ ))
done
