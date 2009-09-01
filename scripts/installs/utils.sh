#!/bin/bash

## REPOSITORY VARIABLES
GOOGLECODE=http://danbrooks.googlecode.com/svn/trunk
UNIX=code/unix

function addfile {
## $1 local file path
## $2 remote file path
 if [ -e $1 ]; then
   echo " * Found file '$1'...  To replace this file, delete it and re-run script."
 else
   echo " * Fetching $1 from the cloud..."
   wget $2
 fi
}

function addfolder {
## $1 folder name
  if [ -e $1 ]; then
    echo " * Found Folder '$1'...  No need to make this folder."
  else
    echo " * Adding folder '$1' to $PWD"
    mkdir $1
  fi
}

function addpkg {
## $1 binary name
## $2 package name
  if ! which $1 >/dev/null; then
      echo " * Binary '$1' not found...  Installing package '$2'"
      sudo apt-get install $2
  else
    echo " * Found binary '$1'..." 
  fi
}


