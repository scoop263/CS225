#!/bin/bash
FM="-----------"
SP="        "
help () {
echo "$FM Help Menu $FM" 
echo "Options:"
echo "${SP}d - Turns Debugging on"
echo "${SP}v - Turns Verbose on"
echo "${SP}h - Displays Help Menu"
echo "${SP}l - Displays the Directory Contents"
echo "${SP}n - Displays the first argument passed" ;}

while getopts :dvhln: opt; do
 case $opt in
  d) set -x ;;
  v) _V=True
     echo "Verbose is set to $_V ";;
  h) help ;;
  l) ARGUMENT="$OPTARG"
     read -p "Would you like to display the directory?(Y/n): " DISPLAY
     if [[ $DISPLAY == "Y" ]] || [[ $DISPLAY == "y" ]]; then
       ls -la ${ARGUMENT}
     fi ;;
  n) ARGUMENT="$OPTARG"
     echo "You have entered the arguments $ARGUMENT";;
  *) echo "You have entered an unknown option."
     help; echo " "; exit;;
 esac
done
shift $(($OPTIND - 1))
