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

	## Get args | use fallback values
	item_name=$(fallback "${1}" "")
	item_dir_local=$(fallback "${2}" "/")
	item_dir_backup=$(fallback "${3}" "${item_dir_local}")

	action "Backing up ${item_name}"

	## Set tmp folder location
	local tmp_folder="/var/tmp"
	local tmp_file="${tmp_folder}/${item_name}"

	## If root folder exists
	## Use absolute file paths
	if [ "${DIR_ROOT_LOCAL}" != "" ] || [ "${item_dir_local}" != "" ]; then
		cd "${DIR_ROOT_LOCAL}${item_dir_local}" || \
		   onfail "" "Error opening directory '${DIR_ROOT_LOCAL}${item_dir_local}'"
	fi

	## Tar.gz item
	task "Compressing ${item_name}"
	compress "${tmp_file}" "${item_name}" & spinner
	onfail

	## Move item from tmp/ to backup location
	task "Moving ${item_name} to backup location"
	move "${tmp_file}.tar.gz" "${DIR_ROOT_BACKUP}${item_dir_backup}${item_name}.tar.gz" & spinner
	onfail

	green "Completed: ${item_name}"

}
