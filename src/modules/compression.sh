#!/bin/bash


## Create a compressed tar (uses parallel cpu multi-threading)
## - $1: name of new tar
## - $2: path of file/directory to tar
## - $3: custom tar args
compress () {
	## Check for custom tar arguments
	## Only add custom args if they exist
	if [ ! -n "${3}" ]; then
		tar --use-compress-program="pigz --best --recursive --no-time" -cf "${1}.tar.gz" "${2}"
	else
		tar "${3}" --use-compress-program="pigz --best --recursive --no-time" -cf "${1}.tar.gz" "${2}"
	fi
}


##------------------------------------------------------------------------------


## Perform a "quick tar" - creates tar of an item in the current directory
## - $1: name of file/folder to tar
qtar () {
	task "Running Quick-Tar in current directory"
	actionsub "Tar `green ${1}` -> `green ${1}.tar.gz`"

	##  Check if $1 exists
	if [ "${1}" == "" ]; then
		result "not-ok"
		error "\nUnable to run qtar"
		warning "No file/folder entered"
		exit 1
	fi

	ERROR=$(compress "${1}" "${1}" 2>&1)
	onfail "" "${ERROR}"

	result "ok";
	success "\nCompleted Quick-Tar: ${1}"
}
