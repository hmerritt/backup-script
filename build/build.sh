#!/bin/bash


## Script vars
SCRIPT_PATH=`dirname "$(readlink -f "$0")"`
BUILD_PATH="${SCRIPT_PATH}/bin"
SRC_PATH="${SCRIPT_PATH}/../src"
MODULES_PATH="${SRC_PATH}/modules"


## Import modules
source "${MODULES_PATH}/module-loader.sh"
loadmodules "${modules}" "${MODULES_PATH}"


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
sed -r "s/source .*modules\/.*//g" "${SRC_PATH}/backup.sh" > "${BUILD_PATH}/backup.sh"
onfail

task "Remove loadmodules"
sed -i "s/loadmodules .*//g" "${BUILD_PATH}/backup.sh"
onfail


action "Bundle source modules"

for mod in "${modules[@]}"
do
	task "Add ${mod} to bundle"
	cat "${MODULES_PATH}/${mod}.sh" >> "${BUILD_PATH}/modules.sh"
	onfail
done

task "Remove development code from module bundle"
sed -i "s/\#\!\/bin\/bash//g" "${BUILD_PATH}/modules.sh"
onfail


action "Build singular backup.sh"

task "Merge module bundle with main backup.sh"
sed -i "/\# Import modules/r"<(cat "${BUILD_PATH}/modules.sh") "${BUILD_PATH}/backup.sh"
onfail


action "Clean bin/ directory"
rm "${BUILD_PATH}/modules.sh" --verbose
onfail


echo
success "Build complete"
