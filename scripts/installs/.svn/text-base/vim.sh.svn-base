#!/bin/bash
source utils.sh

## GOOGLE PATH VARIABLES
VIM=vim
PLUGINS=.vim/plugin

## Check to see if packages are installed 
echo " --- Installing required packages ---"
addpkg vim vim
addpkg ctags exuberant-ctags

## Look to see if .vimrc is installed
echo " --- Installing .vimrc ---"
cd ~
addfile .vimrc $GOOGLECODE/$UNIX/$VIM/.vimrc

## Setup directories
echo " --- Setting up directory structure ---"
addfolder .vim
addfolder vimbkup
cd .vim
addfolder plugin
cd plugin

## Install Plugins
echo " --- Installing plugins... ---"
addfile diffchanges.vim $GOOGLECODE/$UNIX/$VIM/$PLUGINS/diffchanges.vim
addfile minibufexpl.vim $GOOGLECODE/$UNIX/$VIM/$PLUGINS/minibufexpl.vim
addfile taglist.vim $GOOGLECODE/$UNIX/$VIM/$PLUGINS/taglist.vim

