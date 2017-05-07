# !/bin/bash
read STUFF
# Check 1: Checks to see if the line contains
# only "/" characters if so, returns /,
if [[ ! "${STUFF}" =~ [^/] ]]; then
   echo "/"
# Check 2: Checks to see if string contains a
# "/" if so. It will make a while loop until NULL
# is gone and will reassign variable with
# string up till that last / mark that was just removed
# once there are no more NULL loop ends and echoes the last
# part of the string.
elif [[ "${STUFF}" = */ ]] || [[ "${STUFF}" = /* ]]; then
   while [[ -z "${STUFF##*/}" ]]; do
   STUFF=${STUFF%*/}
   done
   echo "${STUFF##*/}"
# Check 3: Incase user doesnt input / in string returns
# string as output.
else
   echo "${STUFF}"
fi
