#!/bin/bash

#Welcome to the App Build Script
#This is where the script code is located
#Caution: Modifying the script may cause it to break!

#Determines Script Path
SCRIPTPATH="${0}"
SCRIPTPATHMAIN="${0%/*}"

#Build App
echo -e ""
echo -n "Are you ready to build the macOS Creator application?... "
read -n 1 input
if [[ $input == 'y' || $input == 'Y' ]]; then
	echo -e ""
	sudo echo "Determining app path..."
	sudo cp -R "$SCRIPTPATHMAIN/macOS Creator.command" /private/tmp/macOS\ Creator.command
	echo -e "Building the app..."
	mkdir /$HOME/macOS\ Creator
	sudo mkdir /Applications/macOS\ Creator.app
	sudo cp -R "$SCRIPTPATHMAIN/macOS Creator App Files/" /Applications/macOS\ Creator.app/
	echo -e "Copying macOS Creator..."
	cp -R /private/tmp/macOS\ Creator.command /$HOME/macOS\ Creator/
	echo -e "Fixing Permissions..."
	sudo chmod -R u+w /Applications/macOS\ Creator.app
	chflags hidden /$HOME/macOS\ Creator
	if [[ -e /$HOME/macOS\ Creator/macOS\ Creator.command && -d /Applications/macOS\ Creator.app ]]; then
		echo -e ""
		echo -e "The app has been created sucessfully."
		sudo rm -R /private/tmp/macOS\ Creator.command
		echo -e ""
		exit
	else
		echo -e ""
		echo -e "App creation failed. Please try again..."
		sudo rm -R /private/tmp/macOS\ Creator.command
		echo -e ""
		exit
	fi
else
	exit
fi
	
