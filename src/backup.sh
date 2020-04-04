#!/bin/bash


# Script path absolute
SCRIPT_PATH=`dirname "$(readlink -f "$0")"`


# Import modules
source "${SCRIPT_PATH}/modules/global.sh"
source "${SCRIPT_PATH}/modules/cli.sh"
source "${SCRIPT_PATH}/modules/files.sh"


##------------------------------------------------------------------------------


# Main execution function
main () {

	DIR_ROOT_LOCAL=""
	DIR_ROOT_BACKUP=""

	# ENTER FOLDERS TO BACKUP HERE
	##############################
	# backup "name-of-folder" "/directory-of-parent-folder/" "/directory-of-parent-backup-folder/"
	# backup "profile-images" "/my/images/" "/my/backup/google-drive/images/"

}


##------------------------------------------------------------------------------


# Print script title & version number
green "Backup [Version ${VERSION}]"

# Run main script and print its execution time
time main

# Print finish message
echo
success "Backup complete"
