#!/bin/bash

# macOS Creator Base Code
# WARNING: Modifying this code may break the script!

# macOS Creator Version 7.0 - Release Notes
#   - Completely rewrites the base code for ultimate stability and bug fix
#   - Updates all internet links to redirect to GitHub
#   - Updates the UI for easiest control
#   - Introduces minor support for macOS Tahoe Beta
#   - Makes several improvements to Safe Install
#
#
# To see older release notes, go to GitHub.com




# - Script Base Code -

# - Prelaunch commands (Saves information such as Mac Model, etc.) -
ARGUMENTS="${1}${2}${3}${4}${5}${6}${7}${8}${9}"
if [[ $ARGUMENTS == *"-v"* || $ARGUMENTS == *"-verbose"* ]]; then
	verbose="1"
elif [[ $ARGUMENTS == *"-V"* || $ARGUMENTS == *"-Verbose"* ]]; then
	verbose="1"
	set -x
fi
if [[ $ARGUMENTS == *"-S"* || $ARGUMENTS == *"-Safe"* ]]; then
	safe="1"
elif [[ $ARGUMENTS == *"-s"* || $ARGUMENTS == *"-safe"* ]]; then
	safe="2"
fi
if [[ $ARGUMENTS == *"-hmsrlnch0"* ]]; then
	HOMEUSER="YES"
fi
Output()
{
	if [[ $verbose == "1" ]]; then
		"$@"
	else
		"$@" &>/dev/null
	fi
}
PreRunOS()
{
	MACOSVERSION=$(sw_vers -productVersion | cut -d '.' -f 1,2)
}
SCRIPTPATH="${0}"
SCRIPTPATHMAIN="${0%/*}"
VERSION_URL="https://raw.githubusercontent.com/JadonLyon/macOS-Creator-Resources/refs/heads/main/macOS%20Creator%20Version.txt"
CURRENT_VERSION="7.0"
LATEST_VERSION=$(curl -s https://raw.githubusercontent.com/JadonLyon/macOS-Creator-Resources/refs/heads/main/macOS%20Creator%20Version.txt)
PreRunUpdate()
{
	if [[ $RUNUPDATE == 'TRUE' ]]; then
		if [[ ! "$CURRENT_VERSION" == "$LATEST_VERSION" ]]; then
			echo "New Version Available: $LATEST_VERSION"
			exit
		else
			echo "Updated"
			exit
		fi
	fi
}
PreRunUpdate