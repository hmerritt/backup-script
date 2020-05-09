#!/bin/bash


VERSION="0.2.4"


##------------------------------------------------------------------------------


SCRIPT_PATH=`dirname "$(readlink -f "$0")"`
SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"


##------------------------------------------------------------------------------


CONFIG_PATH="${ARGS[0]}"


CURRENT_ACTION=""
CURRENT_TASK=""


# Backup vars
dir_root_local=""
dir_root_backup=""
tmp_folder="/var/tmp"
tar_args=""

ERROR=""
