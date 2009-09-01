#!/bin/bash
source utils.sh

## Look to see if .bashrc is installed
echo " --- Installing screen ---"
addpkg screen screen
cd ~
addfile .screenrc $GOOGLECODE/$UNIX/.screenrc

