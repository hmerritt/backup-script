#!/bin/bash


# Script path
SCRIPT_PATH=`dirname "$(readlink -f "$0")"`


# Import modules
source "${SCRIPT_PATH}/modules/global.sh"
source "${SCRIPT_PATH}/modules/interface.sh"
source "${SCRIPT_PATH}/modules/process.sh"
source "${SCRIPT_PATH}/modules/files.sh"


# Print script title
title


##------------------------------------------------------------------------------


# Print script version
if [ "${ARGS[0]}" == "version" ]; then
	echo
	exit
fi


# Install script dependencies
if [ "${ARGS[0]}" == "install" ]; then
	action "Install script dependencies"

	task "Update package repo"
	apt-get update -y
	onfail "" "Are you root?"

	task "Install pigz"
	apt-get install pigz -y
	onfail "" "Are you root?"

	echo
	success "Install complete"
	exit
fi


##------------------------------------------------------------------------------


# ENTER FOLDERS TO BACKUP HERE
##############################
# backup "name-of-folder" "/directory-of-parent-folder/" "/directory-of-parent-backup-folder/"
# backup "profile-images" "/my/images/" "/my/backup/google-drive/images/"


##------------------------------------------------------------------------------


# Print finish message
echo
success "Backup complete"
