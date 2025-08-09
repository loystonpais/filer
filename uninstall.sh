#!/usr/bin/bash

# Uninstall script for filer command
# Filer is installed in user's local bin directory -- $HOME/.local/bin

# Check if filer exists or not
# If it doesnt exist then inform the user and exit
if [ ! -e $HOME/.local/filer ]; then 
  echo "Filer command doesn't exist. Quitting uninstallation"
  exit 1
fi

# Remove filer command
rm $HOME/.local/filer