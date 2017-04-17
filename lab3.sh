# !/bin/bash

USR=$(whoami)
if [ ${UID} -eq 0 ]; then
   echo "User is ${USR}, you do not have permission."
   exit
elif [ ${UID} -lt 500 ]; then
   echo "You are ${USR}, you do not have permission."
   exit 
else
   echo "${USR} your UID is ${UID}"
   echo "$(grep "${USR}" /etc/passwd | cut -d':' -f6,6)"
   if [[ -r /etc/passwd ]]; then
   echo "/etc/passwd is found"
   echo "$(grep "${USR}" /etc/passwd | cut -d':' -f6,6)"
   else 
   echo "/etc/passwd is not found"
   fi
fi
