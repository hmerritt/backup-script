# Backup.sh

[![Build Status](https://travis-ci.org/hmerritt/backup-script.svg?branch=master)](https://travis-ci.org/hmerritt/backup-script)

A simple script that compresses files/folders and moves them to a backup location




## Getting Started


### Install Dependencies
Install script dependencies via `install` argument.

```bash
$ sudo ./backup.sh install
```

#### Bash on Windows
Thanks to `WSL`, you can run bash scripts on windows!

- [Enable WSL (Windows Subsystem for Linux)](https://docs.microsoft.com/en-us/windows/wsl/install-win10)


### Config file
#### Create config
In order to add backups, you need to create a separate config file.
```bash
$ ./backup.sh setup
```

#### Load config
You can load the config file by adding its path after `backup`: `backup <path-to-config>`
```bash
$ ./backup.sh <path-to-config>
```
> You can have as many config files as you like (this could be used to run different backups)




## Usage

```bash
$ ./backup.sh <path-to-config>
```

### Add files/folders to backup

- Open the config file (`backup-config.sh`) and find the *`ENTER FOLDERS TO BACKUP HERE`* text
- Add a file/folder by following the syntax guide below

```bash
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
```
