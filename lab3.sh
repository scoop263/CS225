# !/bin/bash

#USR=$(whoami)
#echo $USR
#SUID=$(id -u ${USR})
if [ ${UID} -eq 0 ]; then
   echo "User is $(whoami), you do not have permission."
   exit
elif [ ${UID} -lt 500 ]; then
   echo "You are $(whoami), you do not have permission."
   exit 
else
   echo "$(whoami) your UID is ${UID}"
   echo "$(grep "$(whoami)" /etc/passwd | cut -d':' -f6,6)"
   if [[ -r /etc/passwd ]]; then
   echo "/etc/passwd is found"
   echo "$(grep "$(whoami)" /etc/passwd | cut -d':' -f6,6)"
   else 
   echo "/etc/passwd is not found"
   fi
fi
