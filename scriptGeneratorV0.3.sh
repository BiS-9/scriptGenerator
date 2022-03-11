#!/usr/bin/env bash
#			 ___  _
#			| . ><_> ||_
#			| . \| |<_-<
#			|___/|_|/__/
#				 ||
#
#---------------------------------------------------------------------------------
# Script     : scriptGeneratorV0.3.sh
# Description: Script generator
# Version    : 0.3
# Author     : Bi$ https://github.com/BiS-9
# Date       : 2021-09-12
# License    : GNU/GPL v3.0
#---------------------------------------------------------------------------------
# Use        : ./scriptGeneratorV0.3.sh + scriptName or ./PATH/scriptGeneratorV0.3.sh + scriptName
#---------------------------------------------------------------------------------

# Colours
b=$'\e[0;30'    # Black
R=$'\e[0;31m'   # Red
G=$'\e[0;32m'   # Green
Y=$'\e[0;33m'   # Yellow
B=$'\e[0;34m'   # Blue
P=$'\e[0;35m'   # Purple
C=$'\e[0;36m'   # Cyan
W=$'\e[0;37m'   # White
NC=$'\e[0m'     # No colour

# Bold colours
bB=$'\e[1;30'   # Black
RB=$'\e[1;31m'  # Red
GB=$'\e[1;32m'  # Green
YB=$'\e[1;33m'  # Yellow
BB=$'\e[1;34m'  # Blue
PB=$'\e[1;35m'  # Purple
CB=$'\e[1;36m'  # Cyan
WB=$'\e[1;37m'  # White
NC=$'\e[0m'     # No colour
#---------------------------------------------------------------------------------

# Default header
header="#!/usr/bin/env bash
#---------------------------------------------------------------------------------
# Script     : $1
# Description:
# Version    : 0.1
# Author     :
# Date       : $(date +'%F')
# License    : GNU/GPL v3.0
#---------------------------------------------------------------------------------
# Use        : ./$1 or ./PATH/$1
#---------------------------------------------------------------------------------

# Colours
b=$'\e[0;30'    # Black
R=$'\e[0;31m'   # Red
G=$'\e[0;32m'   # Green
Y=$'\e[0;33m'   # Yellow
B=$'\e[0;34m'   # Blue
P=$'\e[0;35m'   # Purple
C=$'\e[0;36m'   # Cyan
W=$'\e[0;37m'   # White
NC=$'\e[0m'     # No colour

# Bold colours
bB=$'\e[1;30'   # Black
RB=$'\e[1;31m'  # Red
GB=$'\e[1;32m'  # Green
YB=$'\e[1;33m'  # Yellow
BB=$'\e[1;34m'  # Blue
PB=$'\e[1;35m'  # Purple
CB=$'\e[1;36m'  # Cyan
WB=$'\e[1;37m'  # White
NC=$'\e[0m'     # No colour

set -o errexit      # The script ends if a command fails
set -o nounset      # The script ends if it uses an undeclared variable
set -o pipefail     # The script ends if a command fails in a pipe
# set -o xtrace     # If you want to debug
#---------------------------------------------------------------------------------
"

# Command to abort Ctrl+C
trap ctrl_c INT
function ctrl_c(){
	echo -e "\n"$YB"[*] Script creation aborted, exiting..."$NC""
	echo -e ""$CB"		 ___  _"$NC""
	echo -e ""$CB"		| . ><_> ||_"$NC""
	echo -e ""$CB"		| . \| |<_-<"$NC""
	echo -e ""$CB"		|___/|_|/__/"$NC""
	echo -e ""$CB"			 ||"$NC""
	tput cnorm; exit 0
}

# Variable
use="$0 + scriptName"

# Help panel
function help_panel(){
	echo -e "\n"$PB"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"$NC""
	echo -e "\n"$CB" Wellcome to scriptGeneratorV0.3.sh..."$NC" "$PB"~ by Bi$ ~"$NC""
	echo -e "\n"$GB"[*]"$NC""$YB" How to use ->"$NC" "$CB"$use"$NC""
	echo -e "\n"$YB" Write only one argument as a name for the new script. Example ->"$NC" "$CB"myScript"$NC"\n"
	exit 0
}

# CLI editors. Check a list of command line editors
function dependencies(){
	tput civis
	clear; dependencies=(diakonos ed emacs fte jed joe le mcedit nano ne nefte pico setedit vi vim)

	echo -e ""$YB"[*]"$NC""$CB" Checking installed command line editors..."$NC""
	sleep 1

	for program in "${dependencies[@]}"; do
		echo -ne "\n"$YB"[*] Editor"$NC""$CB" $program"$NC""$YB" ->"$NC" "

		test -f /usr/bin/$program

		if [ "$(echo $?)" == "0" ]; then
			echo -e ""$GB"OK"$NC""
		else
			echo -e ""$RB"X"$NC""
		fi
	done
}

# Check  function
function checker() {
	test -f  /usr/bin/$dependencies
}

# Main program
# Check if the user typed the required number of arguments, (only 1) -> [[ $# -ne 1 ]]
# Check that the file dont exist [[ -f $1 ]]

if [[ $# -ne 1 ]] || [[ -f $1 ]]; then
	echo -e "\n"$YB" Oops, the file already exists or you forgot to write a name..."$NC""
	help_panel
else
	while dependencies; do
		echo -e "\n"$YB"Enter the editor name of your choice..."$NC"\n"
		tput cnorm
		read dependencies
		# Check that the editor is installed, create the new script, give execution permissions and open for editing
		if checker $dependencies == 0; then
			echo "$header" > $1
   			chmod +x $1
   			$dependencies $1
   			exit 0
		else
			checker $dependencies == 1
			echo -e "\n"$CB"$dependencies"$NC" "$YB"it´s not installed on your OS, wait..."$NC""
			sleep 2
		fi
	done
fi
