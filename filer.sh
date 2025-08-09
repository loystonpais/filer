#!/usr/bin/bash

#### Filer command code ####

# Utility functions

# Helper function to check if the string is a help command or not
is_help_command() {
   [ "$1" == "--help" ] || 
   [ "$1" == "-h" ]     || 
   [ "$1" == "help" ]   ||
   [ -z "$1" ];

   return $?
}

# Helper function to check if file(s) exist or not
# Returns a boolean
file_exists() {
  for f in $@; do
    if [ ! -e "$f" ]; then
      return 1
    fi
  done

  return 0
}

# Show help instructions
show_help() {
  echo "Usage $0 [SUBCOMMAND] [FILES]...

These are the commands that filer supports:

  backup    Backs up the given file(s) (Renames them with .bak prefixes)
  restore   Restores backed up file(s) (Removes .bak suffix)
  organize  Organizes given file(s) by moving them to respective dirs  

Do $0 SUBCOMMAND --help for more help."
}

# Extract file extension
# using awk command
get_extension() {
  echo "$1" | awk -F '.' '{print $NF}'
}





# Show help if "--help", "-h", "help" or nothing is given as argument
if is_help_command $1; then
  show_help
  
  # Exit after printing help
  exit
fi


# Handle backup subcommand
if [ "$1" == "backup" ]; then 
  shift # Shifts the arguments for ease of use

  # Check for help
  if is_help_command $1; then
    echo "Usage: backup [FILE]...
Example:
  filer backup foo.sh"
    exit 1
  fi


  # Backup the given file(s) by iterating through them using
  # a for loop
  for f in $@; do
    
    # Check if given file exists before backing up
    if [ -e "$f" ]; then 
      mv "$f" "$f.bak" || exit 1
      echo "Backed up $f"
    else
      echo "Error: no such file or directory $f"
    fi
  done

# Handle restore subcommand
elif [ "$1" == "restore" ]; then 
  shift # Shifts the arguments for ease of use

  # Check for help
  if is_help_command $1; then
    echo "Usage: restore [FILE]...
Example:
  filer restore foo.sh"
    exit 1
  fi


  # Restore the given file(s) by iterating through them using
  # a for loop
  for f in $@; do
    
    # Check if given file (with .bak) exists before restoring
    if [ -e "$f.bak" ]; then 
      mv "$f.bak" "$f" || exit 1
      echo "Restored $f"
    else
      echo "Error: no backup found for $f"
    fi
  done

# Handle organize subcommand
elif [ "$1" == "organize" ]; then
  shift

  # Check for help
  if is_help_command $1; then
    echo "Usage: organize [FILE]...
Example:
  filer organize foo.txt bar.sh baz.txt"
    exit 1
  fi

  # Iter through the file(s)
  for f in $@; do
    # Skip if the argument is not a file
    # or if it does not exist
    
    if [ ! -e "$f" ] || [ ! -f "$f" ]; then 
      echo "Error: cannot organize $f"
    else
      # Grab the file extension using
      # the helper function
      ext=$( get_extension "$f" )

      # Create the dir
      mkdir -p "$ext"
      
      # Move the file to the newly created dir
      mv "$f" "$ext"
    fi
  done


# If the subcommand is not recognized then
# just print help and exit
else 
  show_help
  exit 1
fi