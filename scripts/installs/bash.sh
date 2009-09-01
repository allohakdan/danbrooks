#!/bin/bash
source utils.sh

## Look to see if .bashrc is installed
echo " --- Installing .bashrc ---"
cd ~
addfile .bashrc $GOOGLECODE/$UNIX/.bashrc

