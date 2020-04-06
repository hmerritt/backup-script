#!/bin/bash


## Script path
SCRIPT_PATH=`dirname "$(readlink -f "$0")"`
BUILD_PATH="${SCRIPT_PATH}/build"
SRC_PATH="${SCRIPT_PATH}/src"
MODULES_PATH="${SRC_PATH}/modules"


## Import modules
source "${MODULES_PATH}/global.sh"
source "${MODULES_PATH}/interface.sh"
source "${MODULES_PATH}/process.sh"


##
title


##------------------------------------------------------------------------------


action "Setup build"
task "Make build/ directory"
if [ ! -d "${BUILD_PATH}" ]; then
	mkdir --verbose "${BUILD_PATH}"
fi
onfail
