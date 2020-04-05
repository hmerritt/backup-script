#!/bin/bash


# Script path
SCRIPT_PATH=`dirname "$(readlink -f "$0")"`


# Import modules
source "${SCRIPT_PATH}/modules/global.sh"
source "${SCRIPT_PATH}/modules/cli.sh"
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
	action "Installing script dependencies"

	task "Updating package repo"
	apt-get update -y

	task "Installing pigz"
	apt-get install pigz -y

	echo
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
