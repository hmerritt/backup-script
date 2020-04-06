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


action "Copy backup.sh"
task "Remove source file links"
sed -r "s/source .*//g" "${SRC_PATH}/backup.sh" > "${BUILD_PATH}/backup.sh"
onfail


action "Bundle source modules"

declare -a arr=("global.sh" "interface.sh" "process.sh" "files.sh")

for i in "${arr[@]}"
do
	task "Add ${i} to bundle"
	cat "${MODULES_PATH}/${i}" >> "${BUILD_PATH}/modules.sh"
	onfail
done

task "Remove all haashbangs from module bundle"
sed -i "s/\#\!\/bin\/bash//g" "${BUILD_PATH}/modules.sh"
onfail
