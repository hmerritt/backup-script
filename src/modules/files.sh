#!/bin/bash


# Move a file to another location
# - $1: path to original file
# - $2: path of new file
move () {
	mv "${1}" "${2}"
}


##------------------------------------------------------------------------------


# Create a compressed tar (uses parallel cpu multi-threading)
# - $1: name of new tar
# - $2: path of file/directory to tar
compress () {
	tar --use-compress-program="pigz --best --recursive" -cvf "${1}.tar.gz" "${2}"
}
