#!/bin/bash


## Create a compressed tar (uses parallel cpu multi-threading)
## - $1: name of new tar
## - $2: path of file/directory to tar
compress () {
	tar --use-compress-program="pigz --best --recursive --no-time" -cf "${1}.tar.gz" "${2}"
}


##------------------------------------------------------------------------------


## Perform a "quick tar" - creates tar of an item in the current directory
## - $1: name of file/folder to tar
qtar () {
	action "Creating a Quick-Tar in the same directory"
	task "Tar `green ${1}` -> `green ${1}.tar.gz`"

	##  Check if $1 exists
	if [ "${1}" == "" ]; then
		error "Unable to run qtar"
		warning "No file/folder entered"
		forcefail
	fi

	compress "${1}" "${1}" & spinner
	onfail

	green "Completed Quick-Tar: ${1}"
}
