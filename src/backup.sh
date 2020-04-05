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


# ENTER FOLDERS TO BACKUP HERE
##############################
# backup "name-of-folder" "/directory-of-parent-folder/" "/directory-of-parent-backup-folder/"
# backup "profile-images" "/my/images/" "/my/backup/google-drive/images/"


##------------------------------------------------------------------------------


# Print finish message
echo
success "Backup complete"
