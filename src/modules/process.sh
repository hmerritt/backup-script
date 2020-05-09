#!/bin/bash


## Use a fallback value if initial value does not exist
## - Usage: value=$(fallback $1 "fallback")
## - $1: initial value
## - $2: fallback value
fallback () {
	local value=$1

	##  Check for NULL/empty value
	if [ ! -n "${value}" ]; then
		local value=$2
	fi

	echo "${value}"
}


##------------------------------------------------------------------------------


## Check latest exit code
exitcheck () {
	return $?
}


## Print what the script was doing when the error occured
errortrace () {
	error "Error Trace:"
	error "-> Action: ${CURRENT_ACTION}"
	error "---> Task: ${CURRENT_TASK}"
}


## Print message when a process fails
onfail () {
	if [ "${?}" != "0" ]; then

		result "not-ok"

		echo

		## Check for additional error message
		if [ "${2}" != "" ]; then
			error "${2}"
			echo
		fi

		## Print failure message
		if [ "${1}" != "" ]; then
			failure "${1}"
		else
			failure "Failed: ${CURRENT_ACTION}"
		fi

		## Exit script
		exit 1
	fi
}


## Simulate a scrpit failure
simfail () {
	return 1
}


## Force a script failure
forcefail () {
	simfail
	onfail
}
