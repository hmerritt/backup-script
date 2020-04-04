#!/bin/bash

SCRIPTPATH=`dirname $(realpath -s $0)`

# Color codes
NOCOLOR='\e[0m'
WHITE='\e[97m'
RED='\e[31m'
GREEN='\e[32m'
BG_GREEN='\e[42m\e[97m'

# Print colored text to the terminal
cprint () {
	echo -e "$1$2${NOCOLOR}"
}

# Print done
cdone () {
	cprint $BG_GREEN "Done"
}

# Create a compressed tar (uses cpu multi-threading)
# -> 1) name of new tar
# -> 2) path of file/directory to tar
ctar () {
	tar --use-compress-program="pigz --best --recursive" -cvf "${1}.tar.gz" "${2}"
}


# Backup individual file/folder
# -> 1) compress into .tar.gz
# -> 2) move to backup folder
backup () {
	local localRootDir="/mnt/c/Users/Harry/Documents"
	local backupRootDir="/mnt/c/Users/Harry/Documents/my/sync/drive"

	local tmpFolder="${SCRIPTPATH}/tmp"
	local tmpFile="${tmpFolder}/${1}"
	
	cd $localRootDir$2
	
	cprint $WHITE "\n* Backing up ${1}"
	ctar "${tmpFile}" "${1}"
	mv "${tmpFile}.tar.gz" "${backupRootDir}${3}${1}.tar.gz"
	cdone
}


# Main execution function
main () {
	
	# ENTER FOLDERS TO BACKUP HERE
	##############################
	# backup "name-of-folder" "/directory-of-parent-folder/" "/directory-of-parent-backup-folder/"
	# backup "profile-images" "/my/images/" "/my/backup/google-drive/images/"

}


# Print script title & version number 
cprint $GREEN "Backup [Version 0.1.0]"

# Run main script and print its execution time
time main

# Print finish message
echo 
cprint $BG_GREEN "Backup complete"
