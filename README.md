# Backup.sh

[![Build Status](https://travis-ci.org/hmerritt/backup-script.svg?branch=master)](https://travis-ci.org/hmerritt/backup-script)

A simple script that compresses files/folders and moves them to a backup location




## Install

### Prerequisites
- [pigz](https://zlib.net/pigz/) `apt-get install pigz -y`

### Bash on Windows
Thanks to `WSL`, you can run bash scripts on windows!

- [Enable WSL (Windows Subsystem for Linux)](https://docs.microsoft.com/en-us/windows/wsl/install-win10)




## Usage

### Add files/folders to backup

- Open `backup.sh` and find the *`ENTER FOLDERS TO BACKUP HERE`* text
- Add a file/folder by following the syntax guide below

```bash
main () {

	DIR_ROOT_LOCAL=""
	DIR_ROOT_BACKUP=""

	# ENTER FOLDERS TO BACKUP HERE
	##############################
	# backup "name-of-folder" "/directory-of-parent-folder/" "/directory-of-parent-backup-folder/"
	# backup "profile-images" "/my/images/" "/my/backup/google-drive/images/"

	backup "name of file/folder" "full path to folder" "full path to backup location"


	# Lets try a more real example

	# We are backing up a folder called "music" that exists in our "documents" folder
	# This is then packaged up and moved to the "backup" directory

	backup "music" "/home/user/documents/" "/home/user/backup/documents/"

	# Original     "/home/user/documents/music/"
	# Backed-up                            "/home/user/backup/documents/music.tar.gz"

}
```
