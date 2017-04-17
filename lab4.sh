# !/bin/bash

echo "Please enter number"
read NUMBER
if [[ ${NUMBER} = [^+-[:digits:]] ]] || [ ${NUMBER} -lt 50 ] || [ ${NUMBER} -gt 100 ]; then
  echo "Input is either not an integer or less that 50 and greater than 100"
else
  echo "Success"
fi
