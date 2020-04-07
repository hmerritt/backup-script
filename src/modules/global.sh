#!/bin/bash


VERSION="0.1.3"


##------------------------------------------------------------------------------


SCRIPT_PATH=`dirname "$(readlink -f "$0")"`

ARGS=("$@")


##------------------------------------------------------------------------------


CURRENT_ACTION=""
CURRENT_TASK=""


DIR_ROOT_LOCAL=""
DIR_ROOT_BACKUP=""
