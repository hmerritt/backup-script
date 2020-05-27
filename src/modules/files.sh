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
	local item_name=$(fallback "${1}" "")
	local item_dir_local=$(fallback "${2}" "/")
	local item_dir_backup=$(fallback "${3}" "${item_dir_local}")

	actionsub "${item_name}"

	## Set folder locations
	local tmp_file="${tmp_folder}/${item_name}"
	local dir_local="${dir_root_local}${item_dir_local}"
	local dir_backup="${dir_root_backup}${item_dir_backup}"

	## If root folder exists
	## Use absolute file paths
	if [ "${dir_root_local}" != "" ] || [ "${item_dir_local}" != "" ]; then
		cd "${dir_local}" || \
		   onfail "" "Error opening directory '${dir_local}'"
	fi

	## Tar.gz item
	ERROR=$(compress "${tmp_file}" "${item_name}" "${tar_args}" 2>&1)
	onfail "" "${ERROR}"

	##  If backup folder does not exist
	if ! isdirectory "${dir_backup}"; then
		##  Create backup folder location
		ERROR=$(mkdir -p "${dir_backup}" 2>&1)
		onfail "" "${ERROR}"
	fi

	## Move item from tmp/ to backup location
	ERROR=$(move "${tmp_file}.tar.gz" "${dir_backup}${item_name}.tar.gz" 2>&1)
	onfail "" "${ERROR}"

	result "ok"

}

## Restore backup (tar.gz)
## - $1: name of item to restore
## - $2: directory of the item to restore
## - $3: directory of the restore location
restore () {

	## Get args | use fallback values
	local item_name=$(fallback "${1}" "")
	local item_dir_backup=$(fallback "${2}" "/")
	local item_dir_restore=$(fallback "${3}" "${item_dir_backup}")

	actionsub "restore:${item_name}"

	## Set folder locations
	local dir_backup="${dir_root_backup}${item_dir_backup}"
	local dir_restore="${dir_root_local}${item_dir_restore}"

	## If root folder exists
	## Use absolute file paths
	if [ "${dir_root_local}" != "" ] || [ "${item_dir_restore}" != "" ]; then
		cd "${dir_restore}" || \
		   onfail "" "Error opening directory '${dir_restore}'"
	fi

	## Tar.gz item
	##                  full-path to tar.gz         restore path
	ERROR=$(decompress "${dir_backup}${item_name}" "${dir_restore}" "${tar_args}" 2>&1)
	onfail "" "${ERROR}"

	result "ok"

}
