#!/bin/bash


# Import modules
source "modules/global.sh"
source "modules/cli.sh"
source "modules/files.sh"


# Main execution function
main () {

	dir_root_local=""
	dir_root_backup=""

	# ENTER FOLDERS TO BACKUP HERE
	##############################
	# backup "name-of-folder" "/directory-of-parent-folder/" "/directory-of-parent-backup-folder/"
	# backup "profile-images" "/my/images/" "/my/backup/google-drive/images/"

}


# Print script title & version number
green "Backup [Version ${VERSION}]"

# Run main script and print its execution time
time main

# Print finish message
echo
success "Backup complete"
