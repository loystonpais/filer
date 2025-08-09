#!/usr/bin/bash

### Filer command installation script

# Installation process involves moving the command script to user's local bin located at
# $HOME/.local/bin

# Before moving check if the command script exists or not
if [ ! -e filer.sh ]; then
  echo "Installation failed. filer.sh does not exist"
  echo "Please run install script in project root"
  exit 1
fi

# Make sure the directory exists
mkdir -p $HOME/.local/bin


# Check if filer already exists. If it does, inform user that we are reinstalling
if [ -f $HOME/.local/bin/filer ]; then 
  echo "Filer is already installed. Reinstalling.."
fi 

# Copy the file to bin while removing the .sh extension
cp filer.sh $HOME/.local/bin/filer

# Make the file executable
chmod +x $HOME/.local/bin/filer

echo "Filer installed successfully."



