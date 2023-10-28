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
	task "Install script dependencies"

	actionsub "Update package repo"
	ERROR=$(apt-get update -y 2>&1)
	onfail "" "Are you root?"
	result "ok"

	actionsub "Install tar"
	ERROR=$(apt-get install tar -y 2>&1)
	onfail "" "${ERROR}"
	result "ok"

	actionsub "Install pigz"
	ERROR=$(apt-get install pigz -y 2>&1)
	onfail "" "${ERROR}"
	result "ok"

	actionsub "Install cURL"
	ERROR=$(apt-get install curl -y 2>&1)
	onfail "" "${ERROR}"
	result "ok"

	echo
	success "Install complete"
	exit
fi


## Update script to latest version
## (overwrites itself)
if [ "${ARGS[0]}" == "update" ]; then
	task "Update script to latest version"

	actionsub "Checking for newer version"
	github_tags_url="https://api.github.com/repos/hmerritt/backup-script/tags"
	version_latest=$(curl -s "${github_tags_url}" | grep -Po -m 1 '[^v]*[0-9]\.[0-9]\.[0-9]')
	onfail "" "${version_latest}"
	result "ok"

	## Compare current version with latest
	## Prevents needless update
	if [ "${VERSION//.}" -ge "${version_latest//.}" ]; then
		echo
		green "No new update available"
		green "-> v${version_latest} is latest"
		echo
		exit 0
	fi

	actionsub "Fetching latest version"
	github_file="https://github.com/hmerritt/backup-script/releases/download/v${version_latest}/backup.sh"
	cd "/var/tmp" || "/tmp"
	ERROR=$(curl -L "${github_file}" -o "backup.sh" 2>&1)
	onfail "" "${ERROR}"

	## Varify downloaded file
	first_line=$(head -n 1 "backup.sh")
	if [ "${first_line}" != "#!/bin/bash" ]; then
		echo
		error "Failed to fetch latest version: v${version_latest}"
		error "-> Could not verify downloaded file"
		echo
		warning "You could try fetching it manually from GitHub"
		warning "${github_file}"
		echo
		failure "Update failed"

		rm "backup.sh"
		exit 1
	fi
	onfail
	result "ok"

	actionsub "Replacing script with newer version"
	ERROR=$(mv "backup.sh" "${SCRIPT_PATH}/${SCRIPT_NAME}" 2>&1)
	onfail "" "${ERROR}"
	ERROR=$(chmod +x "${SCRIPT_PATH}/${SCRIPT_NAME}" 2>&1)
	onfail "" "${ERROR}"
	result "ok"

	echo
	green "Updated: ${VERSION} --> ${version_latest}"

	echo
	success "Update complete"
	exit
fi


## Setup user config file
if [ "${ARGS[0]}" == "setup" ] || [ "${ARGS[0]}" == "init" ]; then
	action "Setting up backup.sh"

	## TODO: install dependencies

	task "Creating backup-config file"
	if isfile "backup.config"; then
		warning "backup.config already exists. skipping task"
	else
		echo "## Backup Configuration File
############################

## Set custom config vars
dir_root_local=\"${dir_root_local}\"
dir_root_backup=\"${dir_root_backup}\"
tmp_folder=\"${tmp_folder}\"
tar_args=\"${tar_args}\"


## ENTER FOLDERS TO BACKUP HERE
###############################
## backup \"name-of-folder\" \"/directory-of-parent-folder/\" \"/directory-of-parent-backup-folder/\"
## backup \"profile-images\" \"/my/images/\" \"/my/backup/google-drive/images/\"

" >> "backup.config"
	fi
	onfail

	echo
	success "Setup complete"
	exit
fi


## Perform a "quick tar" - creates tar of an item in the current directory
## - ARGS[1]: name of file/folder to tar
if [ "${ARGS[0]}" == "qtar" ] || [ "${ARGS[0]}" == "quick-tar" ]; then
	## Check if item to backup has been entered
	if [ "${ARGS[0]}" == "" ]; then
		action "Quick-Tar (qtar)"
		echo "Tar item in the current directory (uses name of item to backup as final name)"
		action "Usage:"
		echo "qtar <name of item to tar>"
		action "Example:"
		echo ":~$ backup qtar images"
		echo ":~$ ls"
		echo "images images.tar.gz"
		echo
		exit 0
	fi

	qtar "${ARGS[1]}"
	exit
fi


##------------------------------------------------------------------------------


## Import user config file
action "Loading config file"

## Check for cli argument
if [ "${CONFIG_PATH}" == "" ]; then

	## Fallback to opening default config-file
	CONFIG_PATH="backup.config"

fi

## Check if config file exists
if isfile "${CONFIG_PATH}"; then

	## Load config
	result "ok"
	task "\nRunning Backups"
	source "${CONFIG_PATH}"

else

	## Failed to find config
	result "not-ok"
	error "\nUnable to open config file: ${CONFIG_PATH}"
	warning "You can create a new config using: backup init"
	exit 0

fi


##------------------------------------------------------------------------------


## Print finish message
echo
SCRIPT_ELAPSED_TIME=$(($SECONDS - $SCRIPT_START_TIME))
success "Backup completed in ${SCRIPT_ELAPSED_TIME}s"
