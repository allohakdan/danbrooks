#!/bin/bash
# can - rm, with forgiveness (a bashcan)
# Usage: can FILE(s)... DIRECTORY(ies)...
# 
# Description:
# can removes each specified file and/or directory. Copies of all removed files and directories are written to a "canned" file, normally located in the users home directory. These files may then be browsed and permanently deleted at a later time using the rm command. Currently the files are 'copied' to the canned file and then 'removed'(unlinked) from their current location. An alternative way to do this would be to simply 'move' the files to the canned file. can should take the place of using 'rm' on a regular basis.   
#
# Setup: 
# No Install required-hopefully you already knew that. Otherwise you REALLY need to be using this program. 
# 	1) run "chmod 755 can.sh" from the directory this file is in
#	2) add the following lines to your .bashrc file (in your home directory)
#	   where '/home/user/myscripts' is the directory this file is located in
#			export PATH=$PATH:/home/user/myscripts
#			alias can='can.sh'
# 	3) restart bash
# 
# TO-DO:
# - Understand the * option applied to operands
# - create 'empty can' and 'archive can' options
#
# Version
# 1.1	08/03/07	Fixed cp "Spaced Name" problem 
# 1.0	08/03/07	Initial version
#
# About:
# BashCan 1.1
# This code has been commented for your convenience,
# feel free to make changes to better suit your needs.
# Please send bugs and fixes to <allohakdan@gmail.com>
# [db]	08/03/07	allohakdan@gmail.com
#
#
# OPTIONS (uncomment desired options)
# Set location of canned file (default is /home/USERNAME)
#HOME="/cygdrive/u"
#
#
#

##########################################################
#			Subroutines			 #
##########################################################
#check to see if this directory pattern exists in canned file
makepath(){
	#echo ""
	if [ ! -d "$HOME/canned$THISPATH" ]; then
		#echo "can: using existing directories"; else
		p=$THISPATH 
		trail=""
		#echo "can: creating new directories"
		until [ "$p" = "$d" ]; do		
			p=${p#*/}; d=${p%%/*}; trail="$trail/$d"
			echo "$HOME/canned$trail"
			mkdir -p "$HOME/canned$trail"
		done
	fi
}
#fixnames(){
#	p=$THISPATH
#	until [ "$p" = "$d" ]; do
#		#p=${p#*\ }; d=${p%%\ *}; trail="$trail\\ $d"
#		d=${p%%\ *}; p=${p#*\ }; trail="$trail$d\\ "
#		#echo "$trail"
#	done
#	THISPATH_ESC="${trail%*\\*}"
#}
##########################################################
#			Begin Code			 #
##########################################################

#get current location
THISPATH=$PWD;

#discover or create a new canned file
if [ ! -d "$HOME/canned" ]; then
	#echo "can: found canned file!"; else
	echo "can: creating canned file"
	mkdir $HOME/canned
fi
for arg in $*; do
	if [ "$arg" ]; then #Test to see if a file is specified at all
		if [ -e "$arg" ]; then #test to see if file exists
			echo acp $arg "$HOME/canned$THISPATH"
			printf "can: remove "
			if [ -d "$arg" ]; then #is it a directory
				printf "directory \'$arg\'? "
				until [ "$IN" != "" ]; do read IN; done
				if [[ $IN == y* ]]; then
					makepath
					cp -r $arg "$HOME/canned$THISPATH"
					rm -r $arg
				else echo "can:celling"; fi
			elif [ -f "$arg" ]; then #is it a file
				printf "file \'$arg\'? "
				until [ "$IN" != "" ]; do read IN; done
				if [[ $IN == y* ]]; then
					makepath
					cp $arg "$HOME/canned$THISPATH"
					rm $arg
				else echo "can:celling"; fi
			elif [ -L "$arg" ]; then #is it a link
				printf  "link \'$arg\'? "
				until [ "$IN" != "" ]; do read IN; done
				if [[ $IN == y* ]]; then
					makepath
					cp $arg "$HOME/canned$THISPATH"
					rm $arg
				else echo "can:celling"; fi
			else #we dont know what it is
				printf "unrecognized file type \'$arg\'? "
				until [ "$IN" != "" ]; do read IN; done
				if [[ $IN == y* ]]; then
					makepath
					cp $arg "$HOME/canned$THISPATH"
					rm $arg
				else echo "can:celling"; fi
			fi
		else #the file doesnt really exist
			echo "can: cannot remove '$arg': No such file or directory"
		fi
	else
		echo "can: missing operand"
	fi
	IN= #reset input so we dont assume the same answer for each file
done

exit 0

# least i forget these AGAIN
#
#
#
# ${var%pattern} 
# trim the shortest match from the end
#
# ${var##pattern}
# trim the longest match from the beginning
# 
# ${var%%pattern}
# trim the longest match from the end
# 
# ${var#pattern}
# trim the shortest match from the begining
#
#
#
# [[ $a == z* ]]    
# True if $a starts with an "z" (pattern matching).
#
# [[ $a == "z*" ]]  
# True if $a is equal to z* (literal matching).
#
# [ $a == z* ]      
# File globbing and word splitting take place.
#
# [ "$a" == "z*" ]  
# True if $a is equal to z* (literal matching).

