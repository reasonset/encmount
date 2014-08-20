#!/usr/bin/zsh

# This script takes argument as name.
if [[ -z $1 ]]
then
  print "You need give mount name." &> 2
  exit1
fi

# This script needs encfs
if ! type encfs > /dev/null
then
  print "Encfs is no found." &> 2
  exit 1
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

# Abort if the name is not exit.
if [[ -z encmap[$name] ]]
then
  print "$name is not exit in encmap file. Abort." &>2
  exit 1
fi

# Decryption.
encfs ${encmap[$1]%::*} ${encmap[$1]#*::}