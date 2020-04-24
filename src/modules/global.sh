#!/bin/bash


VERSION="0.2.0"


##------------------------------------------------------------------------------


SCRIPT_PATH=`dirname "$(readlink -f "$0")"`


##------------------------------------------------------------------------------


CONFIG_PATH="${ARGS[0]}"


CURRENT_ACTION=""
CURRENT_TASK=""


DIR_ROOT_LOCAL=""
DIR_ROOT_BACKUP=""
