#!/bin/bash

#Welcome to the App Build Script
#This is where the script code is located
#Caution: Modifying the script may cause it to break!

PARAMETERS="${1}${2}${3}${4}${5}${6}${7}${8}${9}"

if [[ $PARAMETERS == *"-udfms"* ]]; then
	update="1"
fi

#Determines Script Path
SCRIPTPATH="${0}"
SCRIPTPATHMAIN="${0%/*}"

#Determines macOS Version (Cancels if not compatible)
MACOSVERSION=$(sw_vers -productVersion | cut -d '.' -f 1,2)
if [[ "$MACOSVERSION" == '10.5' || "$MACOSVERSION" == '10.6' || "$MACOSVERSION" == '10.7' || "$MACOSVERSION" == '10.8' ]]; then
	echo -e ""
	echo -e "                       The app cannot be built on this Mac"
	echo -e "                         You need OS X Mavericks or later"
	echo -e "    Scroll to the bottom of the disk image and open the macOS Creator script"
	echo -e ""
	exit
fi
BUILDAPP()
{
	if [[ $update == '1' ]]; then
		touch /private/tmp/.macOSCreatorUpdate
		sudo rm -R /$HOME/macOS\ Creator/macOS\ Creator.command
		sudo cp -R "$SCRIPTPATHMAIN/macOS Creator.command" /$HOME/macOS\ Creator/
		sudo chmod +x /$HOME/macOS\ Creator/macOS\ Creator.command
		sed -i '' '8755s/MAINMENU/FIRSTTIME/' $HOME/macOS\ Creator/macOS\ Creator.command
		sed -i '' '8754s/FALSE/TRUE/' $HOME/macOS\ Creator/macOS\ Creator.command
		if [[ -e /$HOME/macOS\ Creator/macOS\ Creator.command && -d /Applications/macOS\ Creator.app ]]; then
			echo -e ""
			echo -e "                    The script has been updated sucessfully"
			echo -e ""
			echo -n "                         Press any key to continue... "
			read -n 1
			$HOME/macOS\ Creator/macOS\ Creator.command && exit
		else
			echo -e ""
			echo -e "                    App creation failed. Please try again..."
			echo -e ""
			exit
		fi
	fi
	if [[ ! -d "$SCRIPTPATHMAIN/app_files" ]]; then
		echo -e ""
		echo -e "                        Cannot find files to build app..."
		echo -e ""
		exit
	fi
	if [[ $UPGRADE == 'YES' ]]; then
		touch /private/tmp/.macOSCreatorUpdate
		sudo rm -R /Applications/macOS\ Creator.app
		echo -e "                          Removing previous versions..."
		sudo rm -R /$HOME/macOS\ Creator/macOS\ Creator.command
		rm -R /$HOME/macOS\ Creator/.version*
		touch /$HOME/macOS\ Creator/.version62
	fi
	if [[ ! $UPGRADE == 'YES' ]]; then
		mkdir /$HOME/macOS\ Creator
	fi
	sudo mkdir /Applications/macOS\ Creator.app
	echo -e "                               Building the app..."
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
		else
			sudo cp -R "$SCRIPTPATHMAIN/app_files/macOS Creator App Files One/" /Applications/macOS\ Creator.app/
		fi
	else
		sudo cp -R "$SCRIPTPATHMAIN/app_files/macOS Creator App Files One/" /Applications/macOS\ Creator.app/
	fi
	echo -e "                            Copying macOS Creator..."
	sudo cp -R "$SCRIPTPATHMAIN/macOS Creator.command" /$HOME/macOS\ Creator/
	sudo cp -R "$SCRIPTPATHMAIN/License Agreement.txt" /$HOME/macOS\ Creator/
	echo -e "                              Fixing Permissions..."
	sudo chmod -R u+w /Applications/macOS\ Creator.app
	sudo chmod +x /Applications/macOS\ Creator.app
	sudo chmod +x /$HOME/macOS\ Creator/macOS\ Creator.command
	chflags hidden /$HOME/macOS\ Creator
	touch /$HOME/macOS\ Creator/.homeuser
	sed -i '' '8755s/MAINMENU/FIRSTTIME/' $HOME/macOS\ Creator/macOS\ Creator.command
	sed -i '' '8754s/FALSE/TRUE/' $HOME/macOS\ Creator/macOS\ Creator.command
	if [[ ! $UPGRADE == 'YES' ]]; then
		if [[ $(uname -m) == "arm64" ]]; then
			touch /$HOME/macOS\ Creator/.colorm1setting
		fi
	fi
	cp -R "$SCRIPTPATHMAIN/app_files/onelaunch" /$HOME/macOS\ Creator/
	cp -R "$SCRIPTPATHMAIN/app_files/normallaunch" /$HOME/macOS\ Creator/
	rm -R /$HOME/macOS\ Creator/.version*
	touch /$HOME/macOS\ Creator/.version62
	if [[ -e /$HOME/macOS\ Creator/macOS\ Creator.command && -d /Applications/macOS\ Creator.app ]]; then
		echo -e ""
		echo -e "                     The app has been created sucessfully"
		echo -e ""
		exit
	else
		echo -e ""
		echo -e "                    App creation failed. Please try again..."
		echo -e ""
		exit
	fi
}

#Build App
UPDATEINSTALL()
{
	if [[ $update == '1' ]]; then
		echo -n "                     Press Y to update the macOS Creator... "
		read -n 1 input
		echo -e ""
		if [[ $input == 'y' || $input == 'Y' ]]; then
			BUILDAPP
		else
			exit
		fi
	fi
	if [[ $VersionUpdate == 'TRUE' ]]; then
		if [[ -e /$HOME/macOS\ Creator/.version62 || -e /$HOME/macOS\ Creator/.version61 ]]; then
			echo ""
			echo "               An older version of the macOS Creator already exits"
			echo -n "                       Press Y to upgade/reinstall it..."
			read -n 1 input
			echo -e ""
			if [[ $input == 'y' || $input == 'Y' ]]; then
				BUILDAPP
			else
				exit
			fi
		else
			echo -e ""
			echo -e "            A newer version of the macOS Creator is already installed"
			echo -e "                    You cannot downgrade your current version"
			echo -e ""
			exit
		fi
	else
		echo ""
		echo "               An older version of the macOS Creator already exits"
		echo -n "                       Press Y to upgade/reinstall it..."
		read -n 1 input
		echo -e ""
		if [[ $input == 'y' || $input == 'Y' ]]; then
			BUILDAPP
		else
			exit
		fi
	fi
}

for file in /$HOME/macOS\ Creator/.version*; do
    if [[ -e "$file" ]]; then
        VersionUpdate=TRUE
    fi
done

if [[ -e /$HOME/macOS\ Creator/macOS\ Creator.command || -d /Applications/macOS\ Creator.app ]]; then
	UPGRADE="YES"
	UPDATEINSTALL
fi

echo -e ""
echo -e "             This script will install the macOS Creator onto your Mac"
echo -n "                             Press Y to install..."
read -n 1 input
echo -e ""
if [[ $input == 'y' || $input == 'Y' ]]; then
	UPGRADE="NO"
	BUILDAPP
else
	exit
fi