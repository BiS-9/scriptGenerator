#!/usr/bin/env bash
#			 ___  _
#			| . ><_> ||_
#			| . \| |<_-<
#			|___/|_|/__/
#				 	 ||
#
#---------------------------------------------------------------------------------
# Script     : scriptGeneratorV0.2.sh
# Description: Script generator
# Version    : 0.2
# Author     : Bi$ https://github.com/BiS-9
# Date       : 2021-09-11
# License    : GNU/GPL v3.0
#---------------------------------------------------------------------------------
# Use        : ./scriptGeneratorV0.2.sh + scriptName or ./PATH/scriptGeneratorV0.2.sh + scriptName
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
# Variables
use="$0 + scriptName"

# Main program
# Check if the user typed the necessary number of arguments, (only 1)
[[ $# -ne 1 ]] && echo -e "\n"$YB"Oops, I need the name for the file, only one argument..."$NC"\n"$YB"Example ->"$NC" "$CB"$use"$NC"\n"$YB"Exiting..."$NC"" && exit 1

# Check that file dont exist
[[ -f $1 ]] && echo -e "\n"$YB"Oops, the file already exists..."$NC"\n"$YB"Example ->"$NC" "$CB"$use"$NC"\n"$YB"Exiting..."$NC"" && exit 1

# Check that the editor is installed, create the new script, give execution permissions and open for editing
echo -e "\n"$YB"Enter the editor name of your choice..."$NC"\n"

read name
function checker() {
    which $name | grep -o $name > /dev/null && return 0 || return 1
}

if checker $name == 0; then
    echo "$header" > $1
    chmod +x $1
    $name $1
else
	echo -e "\n"$CB""$name""$NC" "$YB"it´s not installed on your OS, exiting..."$NC""
fi

exit 0
