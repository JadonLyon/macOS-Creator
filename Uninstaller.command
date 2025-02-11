#!/bin/bash

#Welcome to the App Build Script
#This is where the script code is located
#Caution: Modifying the script may cause it to break!

#Determines Script Path
SCRIPTPATH="${0}"
SCRIPTPATHMAIN="${0%/*}"

#Build App
echo -e ""
echo -n "Are you ready to uninstall the macOS Creator?... "
read -n 1 input
if [[ $input == 'y' || $input == 'Y' ]]; then
	echo -e ""
	sudo echo "Removing the app..."
	sudo rm -R /Applications/macOS\ Creator.app
	echo -e "Removing the script..."
	sudo rm -R /$HOME/macOS\ Creator/macOS\ Creator.command
	sudo rm -R /$HOME/macOS\ Creator
	if [[ -e /$HOME/macOS\ Creator/macOS\ Creator.command || -d /Applications/macOS\ Creator.app ]]; then
		echo -e ""
		echo -e "The app could not be removed. Please try again..."
		echo -e ""
		exit
	else
		echo -e ""
		echo -e "The macOS Creator has been successfully removed."
		echo -e ""
		exit
	fi
else
	exit
fi
