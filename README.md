# Filer

Filer is a simple utility command to experiment with files. Written in bash.


## Features
### 1. Backups / Restores
Filer allows backing up files using `backup` sub-command.

Example:
```sh
filer backup foo.txt
```

To restore the file use `restore` sub-command.

Example:
```sh
filer restore foo.txt
```

### 2. Origanize
Use `organize` subcommand to organize given files into their respective folders based on their file extensions.

Example:
```sh
filer organize . # organizes all files in the given directory

filer organize foo.txt bar.sh baz.sh # organize list of files
```


## Installation (Linux)
```sh
chmod +x install.sh 
./install.sh
```

## Uninstallation
```sh
chmod +x uninstall.sh
./uninstall.sh
```


> This project is a part of SmartEd internship