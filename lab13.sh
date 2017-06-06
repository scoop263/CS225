#!/bin/bash
cleanup(){
	echo "Program has been interrupted!"
	echo "Printing Help Screen"
	help
	exit 1
}
help(){
	echo "--- Help menu ---"
	echo "If an email address contains special characters like ! ^ & place the email between '"
	echo "IP Address must contain '.'"
	echo "Credit Card numbers may or may not include '-'"
	echo "Telephone numbers must be a US number, may or may not include '-'"
	echo "Any numeric input without '-' or '.' must be a length of 10 11 or 16 characters long (IP ADDRESS being the exception)"
}
isEMAIL(){
	WRONG="NOT A VALID EMAIL ADDRESS"
	RIGHT="A VALID EMAIL ADDRESS"
	# John@Example.com = LOCAL@DOMAIN
	EMAIL=$1
	LOCAL=${EMAIL%@*}
	DOMAIN=${EMAIL#*@}
	# Certain characters cannot be placed at the end of the domain
	# This will be used to checking it
	NUMDOM=$(expr ${#DOMAIN} - 1)
	# if Email contains 2 @ symbols it will mess up the regex and this catches it.
	if [[ $LOCAL =~ [@] ]] && [[ $DOMAIN =~ [@] ]]; then
		echo $WRONG
		return 1
	else 
	#two parts of email address can only be 64 or 254 length depending on what side @ is
		if [[ ${#LOCAL} -lt 65 ]] && [[ ${#DOMAIN} -lt 255 ]]; then
			# Local can have any punctuation or numeric/ alpha. Domain cannot have that only numeric/alpha/ or hyphen
			if [[ ${LOCAL} =~ [[:punct:][:alnum:]] ]] && [[ ${DOMAIN} =~ [-[:alnum:]] ]]; then
				# at the beginning and ending of domain it cannot have a hyphen
				if [ ${DOMAIN:0:1} == "-" ] || [[ ${DOMAIN:${NUMDOM}:${#DOMAIN}} == "-" ]]; then
					echo $WRONG
					return 1
				else
					echo $RIGHT
					return 0
				fi
			else
				echo $WRONG
				return 1
			fi
		else 
			echo $WRONG
			return 1
		fi
	fi
}
isCC(){
	CREDITCARD=$1
	if [[ ${CREDITCARD:0:1} -eq 3 ]]; then
		echo "A VALID AMERICAN EXPRESS CARD NUMBER"
		return 0
	elif [[ ${CREDITCARD:0:1} -eq 4 ]]; then
		echo "A VALID VISA CARD NUMBER"
		return 0
	elif [[ ${CREDITCARD:0:1} -eq 5 ]]; then
		echo "A VALID MASTERCARD NUMBER"
		return 0
	elif [[ ${CREDITCARD:0:1} -eq 6 ]]; then
		echo "A VALID DISCOVER CARD NUMBER"
		return 0
	else
		echo "NOT A VALID CREDIT/DEBIT CARD NUMBER"
		return 1
	fi
}
isIP(){
	IPADDR=$1
	COUNTER=1
	WRONG="NOT A VALID IP ADDRESS"
	# The IPADDR contains mulple .'s so using delimter to isol
	while [[ $COUNTER -lt 5 ]]; do
		if [[ $(echo $IPADDR | cut -d'.' -f${COUNTER},${COUNTER}) -lt 256 ]]; then
			if [[ -z $(echo $IPADDR | cut -d'.' -f${COUNTER},${COUNTER}) ]]; then
				echo $WRONG
				return 1
			else
				:
			fi
		else
			echo $WRONG
			return 1
		fi
	(( COUNTER++ ))
	done
	echo "A VALID IP ADDRESS"
	return 0
}
isPHONE(){
	PHONE=$1
	if [[ ${#PHONE} -eq 11 ]]; then
		if [[ ${PHONE:0:1} -eq 1 ]]; then
			echo "THIS IS A VALID LONG DISTANCE US NUMBER"
			return 0
		else
			echo "THIS IS NOT A VALID LONG DISTANCE US NUMBER"
			return 1
		fi
	else
		echo "THIS IS A VALID NON-LONG DISTANCE US NUMBER"
		exit 0
	fi	
}
#---- MAIN ----
NUM=$1
ALTNUM=${NUM//-/''}
ALTNUM=${ALTNUM//./''}
#USED TO SEE IF ITS IPADDR
NUMBER=$(expr ${#NUM} - ${#ALTNUM})
trap cleanup HUP TERM KILL INT
if [[ -z $NUM ]]; then
	help
	exit 1
elif [[ $NUM =~ [@] ]]; then
	isEMAIL $NUM
elif [[ ${ALTNUM} =~ ^[0-9]+$ ]]; then
	if [[ ${#ALTNUM} -eq 16 ]]; then
		isCC ${ALTNUM}
	# After filtering out decimals the total number of digits must be under 13
	# Since you can only have '.' in IP address you must have a '.'
	# Because you can only have 3 '.' it checks to see if you have 3 '.' 
	elif [[ ${#ALTNUM} -lt 13 ]] && [[ ${NUM} =~ [.] ]] && [[ ${NUMBER} -eq 3 ]]; then
		isIP $NUM
	elif [[ ${#ALTNUM} -eq 11 ]] || [[ ${#ALTNUM} -eq 10 ]]; then
		isPHONE ${ALTNUM}
	else 
		echo "You have entered a numeric input that does not meet the"
		echo "requirements to run this script. Refer to help menu"
		help
		exit 1
	fi	
else
	echo "You have entered an unacceptable input."
	help
fi
