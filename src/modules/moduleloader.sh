#!/bin/bash


## Default modules to load
declare -a modules=(
	"global"
	"interface" 
	"process"
	"files"
)


##------------------------------------------------------------------------------


## Load modules array
## - $1: array of modules
## - $2: dir of modules
loadmodules () {
	## Loop modules array
	for mod in "${modules[@]}"; do
		source "${2}/${mod}.sh"
	done
}
