#!/bin/bash


## Create a compressed tar (uses parallel cpu multi-threading)
## - $1: name of new tar
## - $2: path of file/directory to tar
compress () {
	tar --use-compress-program="pigz --best --recursive --no-time" -cf "${1}.tar.gz" "${2}"
}
