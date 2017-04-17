# !/bin/bash

USR=$(whoami)
if [ ${UID} -eq 0 ]; then
   echo "You are ${USR}, you do not have permission."
   exit
elif [ ${UID} -lt 500 ] || [ ${UID} -eq 500 ]; then
   echo "You are ${USR}, you do not have permission."
   exit 
else
   echo "${USR} your UID is ${UID}"
   if [[ -r /etc/passwd ]]; then
   echo "/etc/passwd is found"
   HDIR=$(grep "${USR}" /etc/passwd | cut -d':' -f6,6)
   echo "${HDIR}"
   du -h ${HDIR}   
   else 
   echo "/etc/passwd is not found"
   fi
fi
