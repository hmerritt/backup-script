#!/bin/bash


# Move a file to another location
# - $1: path to original file
# - $2: path of new file
move () {
	mv "${1}" "${2}"
}


##------------------------------------------------------------------------------


# Create a compressed tar (uses parallel cpu multi-threading)
# - $1: name of new tar
# - $2: path of file/directory to tar
compress () {
	tar --use-compress-program="pigz --best --recursive" -cvf "${1}.tar.gz" "${2}"
}


##------------------------------------------------------------------------------


# Backup individual file/folder
# - $1: name of item to backup
# - $2: directory of the item to backup
# - $3: directory of the backup location
backup () {
	local TMP_FOLDER="${SCRIPT_PATH}/tmp"
	local TMP_FILE="${TMP_FOLDER}/${1}"

	cd $DIR_ROOT_LOCAL$2

	action "Backing up ${1}"
	compress "${TMP_FILE}" "${1}"
	move "${TMP_FILE}.tar.gz" "${DIR_ROOT_BACKUP}${3}${1}.tar.gz"
	success "done"
}
