#!/bin/bash


## Load a modules array
## - $1: array of modules
## - $2: path to modules directory
loadmodules () {
	## Loop modules array
	for mod in "${modules[@]}"; do
		source "${2}/${mod}.sh" || exit 1
	done
}


##------------------------------------------------------------------------------


## Default modules to load
declare -a modules=(
	"global"
	"interface" 
	"process"
	"files"
)
