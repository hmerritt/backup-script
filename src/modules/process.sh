#!/bin/bash


# Check latest exit code
exitcheck () {
	return $?
}


# Print what the script was doing when the error occured
errortrace () {
	error "Error Trace:"
	error "-> Action: ${CURRENT_ACTION}"
	error "---> Task: ${CURRENT_TASK}"
}


# Print message when a process fails
onfail () {
	if [ "${?}" != "0" ]; then

		# Check for additional error message
		if [ "${2}" != "" ]; then
			error "${2}"
		fi

		# Print what the script was doing when the error occured
		errortrace

		# Print failure message
		if [ "${1}" != "" ]; then
			failure "${1}"
		else
			failure "Failed: ${CURRENT_ACTION}"
		fi

		# Exit script
		exit 1
	fi
}
