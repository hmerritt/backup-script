#!/bin/bash


## Color codes
NOCOLOR="\033[0m"

## Text
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
ORANGE="\e[33m"
BLUE="\e[34m"
PURPLE="\e[35m"
CYAN="\e[36m"
LIGHTGRAY="\e[37m"
DARKGRAY="\e[90m"
LIGHTRED="\e[91m"
LIGHTGREEN="\e[92m"
YELLOW="\e[93m"
LIGHTBLUE="\e[94m"
LIGHTPURPLE="\e[95m"
LIGHTCYAN="\e[96m"
WHITE="\e[97m"

## Background
BG_RED="\e[41m${WHITE}"
BG_GREEN="\e[42m${WHITE}"
BG_YELLOW="\e[43m${WHITE}"
BG_BLUE="\e[44m${WHITE}"
BG_PURPLE="\e[45m${WHITE}"
BG_CYAN="\e[46m${WHITE}"
BG_LIGHTRED="\e[101m${WHITE}"
BG_LIGHTGREEN="\e[102m${WHITE}"
BG_WHITE="\e[107m${WHITE}"


##------------------------------------------------------------------------------


## Print colored text to the terminal
## - $1: color
## - $2: text
cprint () {
	echo -e "$1$2${NOCOLOR}"
}


##------------------------------------------------------------------------------


## Print colored text
## - $1: text
## -> output colored text with no background
white () {
	cprint $WHITE "${1}"
}

green () {
	cprint $GREEN "${1}"
}

red () {
	cprint $RED "${1}"
}

orange () {
	cprint $ORANGE "${1}"
}


##------------------------------------------------------------------------------


## Print message by named state
## - $1: text
success () {
	cprint $BG_GREEN "${1}"
}

failure () {
	cprint $BG_RED "${1}"
}

error () {
	red "${1}"
}

warning () {
	orange "${1}"
}


action () {
	CURRENT_ACTION="${1}"
	echo -ne "${1}  : "
}

actionsub () {
	action "  *  ${1}"
	CURRENT_ACTION="${1}"
}

task () {
	CURRENT_TASK="${1}"
	echo -e "${1}"
}

result () {
	if [ "${1}" == "done" ] || [ "${1}" == "ok" ]; then
		green "DONE"
	else
		error "ERROR"
	fi
}


##------------------------------------------------------------------------------


## Print script title & version number
title () {
	green "Backup [Version ${VERSION}]\n"
}
