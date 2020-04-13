#!/bin/bash


## Move a file to another location
## - $1: path to original file
## - $2: path of new file
move () {
	mv "${1}" "${2}"
}


## Check if a file exists
## -$1: path to file
isfile () {
	if [ -f "${1}" ]; then
		return 0
	else
		return 1
	fi
}


## Check if a directory exists
## -$1: path to directory
isdirectory () {
	if [ -d "${1}" ]; then
		return 0
	else
		return 1
	fi
}


##------------------------------------------------------------------------------


## Backup individual file/folder
## - $1: name of item to backup
## - $2: directory of the item to backup
## - $3: directory of the backup location
backup () {
	action "Backing up ${1}"

	local TMP_FOLDER="/var/tmp"
	local TMP_FILE="${TMP_FOLDER}/${1}"

	if [ "${DIR_ROOT_LOCAL}" != "" ] || [ "${2}" != "" ]; then
		cd "${DIR_ROOT_LOCAL}${2}" || onfail "" "Error opening directory '${DIR_ROOT_LOCAL}${2}'"
	fi

	task "Compressing ${1}"
	compress "${TMP_FILE}" "${1}"
	onfail

	task "Moving ${1} to backup location"
	move "${TMP_FILE}.tar.gz" "${DIR_ROOT_BACKUP}${3}${1}.tar.gz"
	onfail

	success "Completed: ${1}"
}
