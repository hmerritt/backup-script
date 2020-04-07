#!/bin/bash


ARGS=("$@")


## Import modules
source "modules/module-loader.sh"
loadmodules "${modules}" "modules"


##------------------------------------------------------------------------------


## Print script title
title


##------------------------------------------------------------------------------


## Print script version
if [ "${ARGS[0]}" == "version" ]; then
	echo
	exit
fi


## Install script dependencies
if [ "${ARGS[0]}" == "install" ]; then
	action "Install script dependencies"

	task "Update package repo"
	apt-get update -y
	onfail "" "Are you root?"

	task "Install tar"
	apt-get install tar -y
	onfail "" "Are you root?"

	task "Install pigz"
	apt-get install pigz -y
	onfail "" "Are you root?"

	echo
	success "Install complete"
	exit
fi


## Setup user config file
if [ "${ARGS[0]}" == "setup" ]; then
	action "Setting up backup.sh"

	## TODO: install dependencies

	task "Creating backup-config file"
	if isfile "backup-config.sh"; then
		warning "backup-config already exists. skipping task"
	else
		echo '## Backup Configuration File
############################

DIR_ROOT_LOCAL=""
DIR_ROOT_BACKUP=""


## ENTER FOLDERS TO BACKUP HERE
###############################
## backup "name-of-folder" "/directory-of-parent-folder/" "/directory-of-parent-backup-folder/"
## backup "profile-images" "/my/images/" "/my/backup/google-drive/images/"

' >> "backup-config.sh"
	fi
	onfail

	echo
	success "Setup complete"
	exit
fi


## Perform a "quick tar" - create tar of an item in same directory
## - ARGS[1]: name of file/folder to tar
if [ "${ARGS[0]}" == "qtar" ] || [ "${ARGS[0]}" == "quick-tar" ]; then

	## Check if item to backup has been entered
	if [ "${ARGS[1]}" == "" ]; then
		action "Quick-Tar (qtar)"
		echo "Tar item in the current directory (uses name of item to backup as final name)"
		action "Usage:"
		echo "qtar <name of item to tar>"
		action "Example:"
		echo ":~$ backup qtar images"
		echo ":~$ ls"
		echo "images images.tar.gz"
		echo
		exit 1
	fi

	action "Creating a Quick-Tar in the same directory"

	task "Tar `green ${ARGS[1]}` -> `green ${ARGS[1]}.tar.gz`"
	compress "${ARGS[1]}" "${ARGS[1]}"
	onfail

	echo
	success "Quick-Tar complete"
	exit
fi


##------------------------------------------------------------------------------


## Import user config file
action "Loading config file"

## Check for cli argument
if [ "${CONFIG_PATH}" == "" ]; then

	## Fallback to opening default config-file
	CONFIG_PATH="backup-config.sh"

	warning "No config file entered"
	task "Attempting to open default config-file: ${CONFIG_PATH}"
fi

## Check if config file exists
if isfile "${CONFIG_PATH}"; then

	## Load config
	source "${CONFIG_PATH}"
	success "Loaded config"

else

	## Failed to find config
	error "Unable to open config file: ${CONFIG_PATH}"
	warning "You can create another config using: backup setup"
	forcefail
fi


##------------------------------------------------------------------------------


## Print finish message
echo
success "Backup complete"
