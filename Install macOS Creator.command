#!/bin/bash

#Welcome to the App Build Script
#This is where the script code is located
#Caution: Modifying the script may cause it to break!

#Determines Script Path
SCRIPTPATH="${0}"
SCRIPTPATHMAIN="${0%/*}"

#Determines macOS Version (Cancels if not compatible)
MACOSVERSION=$(sw_vers -productVersion | cut -d '.' -f 1,2)
if [[ "$MACOSVERSION" == '10.5' || "$MACOSVERSION" == '10.6' || "$MACOSVERSION" == '10.7' || "$MACOSVERSION" == '10.8' ]]; then
	echo -e ""
	echo -e "The app cannot be built on this Mac."
	echo -e "You need OS X Mavericks or later."
	echo -e ""
	exit
fi
BUILDAPP()
{
	if [[ ! -d "$SCRIPTPATHMAIN/app_files" ]]; then
		echo -e ""
		echo -e "Cannot Find Files to build app..."
		echo -e ""
		exit
	fi
	if [[ $UPGRADE == 'YES' ]]; then
		touch /private/tmp/.macOSCreatorUpdate
		sudo rm -R /Applications/macOS\ Creator.app
		echo -e "Removing previous versions..."
		sudo rm -R /$HOME/macOS\ Creator/macOS\ Creator.command
		sudo rm -R /$HOME/macOS\ Creator/normallaunch
		sudo rm -R /$HOME/macOS\ Creator/onelaunch
	fi
	if [[ ! $UPGRADE == 'YES' ]]; then
		mkdir /$HOME/macOS\ Creator
	fi
	sudo mkdir /Applications/macOS\ Creator.app
	echo -e "Building the app..."
	if [[ $UPGRADE == 'YES' ]]; then
		if [[ -e /$HOME/macOS\ Creator/.launchall ]]; then
			if [[ -e /$HOME/macOS\ Creator/.verbose ]]; then
				sudo cp -R "$SCRIPTPATHMAIN/app_files/macOS Creator App Files Verbose/" /Applications/macOS\ Creator.app/
			elif [[ -e /$HOME/macOS\ Creator/.safe ]]; then
				sudo cp -R "$SCRIPTPATHMAIN/app_files/macOS Creator App Files Safe/" /Applications/macOS\ Creator.app/
			elif [[ -e /$HOME/macOS\ Creator/.verbosesafe ]]; then
				sudo cp -R "$SCRIPTPATHMAIN/app_files/macOS Creator App Files Verbose Safe/" /Applications/macOS\ Creator.app/
			elif [[ -e /$HOME/macOS\ Creator/.normal ]]; then
				sudo cp -R "$SCRIPTPATHMAIN/app_files/macOS Creator App Files/" /Applications/macOS\ Creator.app/
			else
				sudo cp -R "$SCRIPTPATHMAIN/app_files/macOS Creator App Files/" /Applications/macOS\ Creator.app/
			fi
		elif [[ -e /$HOME/macOS\ Creator/.launchonce ]]; then
			sudo cp -R "$SCRIPTPATHMAIN/app_files/macOS Creator App Files One/" /Applications/macOS\ Creator.app/
		else
			sudo cp -R "$SCRIPTPATHMAIN/app_files/macOS Creator App Files/" /Applications/macOS\ Creator.app/
		fi
	else
		sudo cp -R "$SCRIPTPATHMAIN/app_files/macOS Creator App Files/" /Applications/macOS\ Creator.app/
	fi
	echo -e "Copying macOS Creator..."
	sudo cp -R "$SCRIPTPATHMAIN/macOS Creator.command" /$HOME/macOS\ Creator/
	echo -e "Fixing Permissions..."
	sudo chmod -R u+w /Applications/macOS\ Creator.app
	sudo chmod +x /Applications/macOS\ Creator.app
	sudo chmod +x /$HOME/macOS\ Creator/macOS\ Creator.command
	chflags hidden /$HOME/macOS\ Creator
	touch /$HOME/macOS\ Creator/.homeuser
	sed -i '' '8208s/MAINMENU/FIRSTTIME/' $HOME/macOS\ Creator/macOS\ Creator.command
	sed -i '' '8207s/FALSE/TRUE/' $HOME/macOS\ Creator/macOS\ Creator.command
	if [[ ! $UPGRADE == 'YES' ]]; then
		if [[ $(uname -m) == "arm64" ]]; then
			touch /$HOME/macOS\ Creator/.colorm1setting
		fi
	fi
	cp -R "$SCRIPTPATHMAIN/app_files/onelaunch" /$HOME/macOS\ Creator/
	cp -R "$SCRIPTPATHMAIN/app_files/normallaunch" /$HOME/macOS\ Creator/
	if [[ -e /$HOME/macOS\ Creator/macOS\ Creator.command && -d /Applications/macOS\ Creator.app ]]; then
		echo -e ""
		echo -e "The app has been created sucessfully."
		echo -e ""
		exit
	else
		echo -e ""
		echo -e "App creation failed. Please try again..."
		echo -e ""
		exit
	fi
}

#Build App
if [[ -e /$HOME/macOS\ Creator/macOS\ Creator.command || -d /Applications/macOS\ Creator.app ]]; then
	echo ""
	echo "An older version of the script already exits."
	echo -n "Would you like to upgade/reinstall it?..."
	read -n 1 input
	echo -e ""
	if [[ $input == 'y' || $input == 'Y' ]]; then
		UPGRADE="YES"
		BUILDAPP
	else
		exit
	fi
fi
echo -e ""
echo -n "Are you ready to build the macOS Creator application?... "
read -n 1 input
echo -e ""
if [[ $input == 'y' || $input == 'Y' ]]; then
	UPGRADE="NO"
	BUILDAPP
else
	exit
fi
	
