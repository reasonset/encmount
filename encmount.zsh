#!/usr/bin/zsh

# This script needs encfs
if ! type encfs > /dev/null
then
  print "Encfs is no found." &> 2
fi

typeset -A encmap # name, path, mountpoint mapping assoc.

# Check configuration file.
if [[ ! -f ~/.yek/encmap ]]
then
  print "No mapping file." &>2
  exit 1
fi

# Read the configuration file.
while read name epath dest 
do
  encmap[$name]="$epath::$dest"
done < ~/.yek/encmap

# Decryption.
encfs ${encmap[$1]%::*} ${encmap[$1]#*::}