#!/bin/bash

#Welcome to the macOS Creator Script
#This is where the script code is located
#Caution: Modifying the script may cause it to break!

#Version 5.0
#Release notes:
#              V5.0 Completely changes the structure of the script for much better stability and future improvements.
#                   Introduces a new verbose mode for troubleshooting.
#                   Introduces a new safe mode in order to run the script on any Mac.
#                   When searching for installers in Applications folder, the script will now search newest to oldest macOS Versions. If you have multiple versions of macOS, the script will choose the newest version.
#                   Providing the installer path manually has been rewritten and is now more stable and secure than ever.
#                   Now introduces a new clean up tool. This cleans up any temporary files the script may have created during an operation.
#                   Brand-new UI. The macOS Creator now has a much more modern look and feel. Colors have been scientifically adjusted for best legibility.
#                   Now shows a list of available drives. You can now either drag the drive or simply choose it from the menu.
#                   Introduces support for Apple Silicone (BETA).
#                   Introduces support for Mac OS X Lion and OS X Mountain Lion (BETA).
#                   Introduces a brand new color for the UI settings called Forest Green. It now also includes an exclusive Apple Silicone, rainbow color.
#                   Lays the foundation for future releases of the macOS Creator.
#                   Script would not detect if macOS is compatible with version wished to download, fixed.
#                   Fixes several issues with downloading macOS: Script would report succeeded even if failed, now removes other version of macOS before download.
#                   Fixed an issue where macOS Sonoma would not download.
#
#
#                   To see older release notes, go to Github.com


#Script

#PreRun Commands
#This step will save temporary commands that will be used later throughout the script
#Sets parameters for Verbose Mode
PARAMETERS="${1}${2}${3}${4}${5}${6}${7}${8}${9}"
if [[ $PARAMETERS == *"-v"* || $PARAMETERS == *"-verbose"* ]]; then
	verbose="1"
elif [[ $PARAMETERS == *"-V"* || $PARAMETERS == *"-Verbose"* ]]; then
	verbose="1"
	set -x
fi
if [[ $PARAMETERS == *"-s"* || $PARAMETERS == *"-safe"* ]]; then
	safe="1"
elif [[ $PARAMETERS == *"-S"* || $PARAMETERS == *"-Safe"* ]]; then
	safe="1"
	set -x
fi
Output()
{
	if [[ $verbose == "1" ]]; then
		"$@"
	else
		"$@" &>/dev/null
	fi
}
#Determines Script Path
SCRIPTPATH="${0}"
SCRIPTPATHMAIN="${0%/*}"

PreRunOS()
{
	#Check Mac model
	MACVERSION=$(sysctl hw.model | awk '{ print $2 }')
	
	#Check macOS Version
	MACOSVERSION=$(sw_vers -productVersion | cut -d '.' -f 1,2)
}
PreRun()
{
	#Sets UI Colors
	if [[ "$MACOSVERSION" == 10.5 || "$MACOSVERSION" == 10.6 || "$MACOSVERSION" == 10.7 || "$MACOSVERSION" == 10.8 || "$MACOSVERSION" == 10.9 || "$MACOSVERSION" == 10.10 || "$MACOSVERSION" == 10.11 || "$MACOSVERSION" == 10.12 || "$MACOSVERSION" == 10.13 ]]; then
		APP='\033["38;5;23m'
		TITLE='\033["38;5;24m'
		BODY='\033["38;5;23m'
		PROMPTSTYLE='\033["38;5;65m'
		OSFOUND='\033["38;5;67m'
		WARNING='\033["38;5;160m'
		ERROR='\033["38;5;9m'
		CANCEL='\033["38;5;132m'
		BOLD='\033[1m'
		RESET='\033[0m'
	else
		UIAPPEARANCE=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
		if [[ "$UIAPPEARANCE" == "Dark" ]]; then
			APP='\033["38;5;158m'
			TITLE='\033["38;5;153m'
			BODY='\033["38;5;158m'
			PROMPTSTYLE='\033["38;5;150m'
			OSFOUND='\033["38;5;111m'
			WARNING='\033["38;5;160m'
			ERROR='\033["38;5;196m'
			CANCEL='\033["38;5;175m'
			BOLD='\033[1m'
			RESET='\033[0m'
		else
			APP='\033["38;5;23m'
			TITLE='\033["38;5;24m'
			BODY='\033["38;5;23m'
			PROMPTSTYLE='\033["38;5;65m'
			OSFOUND='\033["38;5;67m'
			WARNING='\033["38;5;160m'
			ERROR='\033["38;5;9m'
			CANCEL='\033["38;5;132m'
			BOLD='\033[1m'
			RESET='\033[0m'
		fi
	fi
	
	#Settings Preview
	if [[ "$MACOSVERSION" == 10.5 || "$MACOSVERSION" == 10.6 || "$MACOSVERSION" == 10.7 || "$MACOSVERSION" == 10.8 || "$MACOSVERSION" == 10.9 || "$MACOSVERSION" == 10.10 || "$MACOSVERSION" == 10.11 || "$MACOSVERSION" == 10.12 || "$MACOSVERSION" == 10.13 ]]; then
		DEFAULTBLUE='\033[38;5;23m'
		DESERT='\033[38;5;130m'
		FOREST='\033[38;5;22m'
		CLASSICBLACK='\033[38;5;0m'
		CLASSICBLACKBW="Classic Black...................(4)"
	else
		if [[ "$UIAPPEARANCE" == "Dark" ]]; then
			DEFAULTBLUE='\033[38;5;158m'
			DESERT='\033[38;5;180m'
			FOREST='\033[38;5;108m'
			CLASSICBLACK='\033[38;5;255m'
			APPLECHIP="\033[38;5;117mApp\033[38;5;111mle \033[38;5;135mSili\033[38;5;207mcone.......\033[38;5;208m...........\033[38;5;11m(5)"
			CLASSICBLACKBW="Classic White...................(4)"
		else
			DEFAULTBLUE='\033[38;5;23m'
			DESERT='\033[38;5;130m'
			FOREST='\033[38;5;22m'
			CLASSICBLACK='\033[38;5;0m'
			APPLECHIP="\033[38;5;33mApp\033[38;5;63mle \033[38;5;129mSili\033[38;5;163mcone.......\033[38;5;209m...........\033[38;5;214m(5)"
			CLASSICBLACKBW="Classic Black...................(4)"
		fi
	fi
	if [[ "$APP" == '\033["38;5;23m' || "$APP" == '\033["38;5;158m' ]]; then
		SETTINGCOLOR="Default Blue"
	elif [[ "$APP" == '\033["38;5;130m' || "$APP" == '\033["38;5;180m' ]]; then
		SETTINGCOLOR="Desert Sands"
	elif [[ "$APP" == '\033["38;5;22m' || "$APP" == '\033["38;5;108m' ]]; then
		SETTINGCOLOR="Forest Green"
	elif [[ "$APP" == '\033["38;5;0m' || "$APP" == '\033["38;5;255m' ]]; then
		if [[ "$MACOSVERSION" == 10.5 || "$MACOSVERSION" == 10.6 || "$MACOSVERSION" == 10.7 || "$MACOSVERSION" == 10.8 || "$MACOSVERSION" == 10.9 || "$MACOSVERSION" == 10.10 || "$MACOSVERSION" == 10.11 || "$MACOSVERSION" == 10.12 || "$MACOSVERSION" == 10.13 ]]; then
			SETTINGCOLOR="Classic Black"
		else
			if [[ "$UIAPPEARANCE" == "Dark" ]]; then
				SETTINGCOLOR="Classic White"
			else
				SETTINGCOLOR="Classic Black"
			fi
		fi
	elif [[ "$APP" == '\033["38;5;214m' || "$APP" == '\033["38;5;185m' ]]; then
		if [[ $(uname -m) == "arm64" ]]; then
			SETTINGCOLOR="Apple Silicone"
		else
			COLORCLASSIC
		fi
	else
		SETTINGCOLOR="Unknown Configuration. This feature will not work!"
	fi
	if [[ $(uname -m) == "arm64" ]]; then
		APPLESILICONE="YES"
		if [[ ! -d "$("xcode-select" -p)" ]]; then
			echo -e "${RESET}${ERROR}You are running on Apple Silicone without Xcode tools."
			echo -e "${RESET}${BODY}You need these tools to install older versions of macOS."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Would you like to install them now? (Press any key to skip install)... "
			read -n 1 input
			if [[ $input == 'y' || $input == 'Y' ]]; then
				xcode-select --install
				echo -e "${RESET}${TITLE}Once installed, please run this script again."
				exit
			else
				echo -e ""
			fi
		fi
	fi
}

#Text and commands
WINDOWBAR()
{
	clear
	if [[ $verbose == '1' && $safe == '1' ]]; then
		echo -e "${APP}${BOLD}                     macOS Creator V5.0 ${WARNING}(Verbose & Safe Mode)${APP}${BOLD}"
	elif [[ $verbose == '1' ]]; then
		echo -e "${APP}${BOLD}                           macOS Creator V5.0 ${WARNING}(Verbose)${APP}${BOLD}"
	elif [[ $safe == '1' ]]; then
		echo -e "${APP}${BOLD}                         macOS Creator V5.0 ${WARNING}(Safe Mode)${APP}${BOLD}"
	else
		echo -e "${APP}${BOLD}                               macOS Creator V5.0"
	fi
	echo -e "••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••"
}
WINDOWBAREND()
{
	echo -e ""
	echo -e "${RESET}${CANCEL}${BOLD}Operation Canceled"
	echo -e "${RESET}${APP}${BOLD}"
	echo -e "••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••"
	echo -e "${RESET}"
	exit
}
WINDOWERROR()
{
	echo -e ""
	echo -e "${RESET}${ERROR}${BOLD}"
	echo -n "Invalid command. Press any key to try again... "
	read -n 1
	echo -e "${RESET}"
}
WINDOWERRORDRIVE()
{
	echo -e "${RESET}${ERROR}${BOLD}"
	echo -n "This is not a valid drive, press any key to try again... "
	read -n 1
	echo -e "${RESET}"
}
WINDOWBARENDANY()
{
	echo -e ""
	echo -e ""
	echo -e "${RESET}${CANCEL}${BOLD}Operation Canceled."
	echo -e "${RESET}${APP}${BOLD}"
	echo -e "••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••"
	echo -e "${RESET}"
	exit
}
SUCCESS()
{
	echo -e ""
	echo -e ""
	echo -e "${RESET}${CANCEL}${BOLD}Thank you for using the macOS Creator."
	echo -e "${RESET}${APP}${BOLD}"
	echo -e "••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••"
	echo -e "${RESET}"
	exit
}
SUCCESSRETURN()
{
	echo -e ""
	echo -e "${RESET}${CANCEL}${BOLD}Thank you for using the macOS Creator."
	echo -e "${RESET}${APP}${BOLD}"
	echo -e "••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••"
	echo -e "${RESET}"
	exit
}
TROUBLESHOOTGUIDE()
{
	WINDOWBAR
	echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
	echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map)"
	echo -e "3) Try using a different drive"
	echo -e "4) Try redownloading the macOS Installer"
	echo -e "5) Restart your Mac${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Press any key to cancel... "
	read -n 1 prompt
	if [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
		break 2
	elif [[ "$prompt" == '' ]]; then
		WINDOWBAREND
	else
		WINDOWBARENDANY
	fi
}
TROUBLESHOOTGUIDEMAIN()
{
	WINDOWBAR
	echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
	echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map)"
	echo -e "3) Try using a different drive"
	echo -e "4) Try redownloading the macOS Installer"
	echo -e "5) Make sure your macOS Installer is inside of your Applications folder."
	echo -e "6) Make sure your macOS Installer has not been modified. (i.e. name changed)"
	echo -e "7) Restart your Mac${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Press any key to return home... "
	read -n 1
	echo -e ""
}
CLEANUP()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Cleaning up..."
	Output sudo rm -R /private/tmp/InstallAssistant.pkg
	Output sudo rm -R /private/tmp/InstallmacOS.dmg
	Output sudo rm -R /private/tmp/InstallmacOS.iso
	Output sudo rm -R /private/tmp/InstallmacOS.zip
	echo -e "${RESET}${TITLE}Script has cleaned up all files."
	echo -e "${PROMPTSTYLE}"
	echo -n "Press any key to return home... "
	read -n 1
	echo -e ""
}
MAINMENU()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}Welcome to the macOS Creator${RESET}"
	echo -e "${RESET}${TITLE}${BOLD}Script made by Encore Platforms${RESET}"
	echo -e "${TITLE}The All-In-One script that creates a bootable installer for macOS${RESET}"
	echo -e "${CANCEL}To show the Help menu, press the ${BOLD}? ${RESET}${CANCEL}key${RESET}"
	echo -e "${CANCEL}To cancel, press the ${BOLD}return ${RESET}${CANCEL}key.${RESET} ${CANCEL}To return home, press the ${BOLD}Q ${RESET}${CANCEL}key${RESET}"
	echo -e ""
	echo -e "${TITLE}${BOLD}Please choose an option:${RESET}"
	echo -e "${BODY}Automatically find macOS installer in your Applications folder.............(1)"
	echo -e "Manually provide a path to create the bootable installer...................(2)"
	echo -e "Download macOS Installer...................................................(3)"
	echo -e "Identify Mac model.........................................................(4)"
	echo -e "Review troubleshooting guide...............................................(5)"
	echo -e "Change Script Colors.......................................................(6)"
	echo -e "Clean up...................................................................(7)${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Enter your option here... "
}

#Help
GUIDE()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}Welcome to the user guide."
		echo -e "${RESET}${TITLE}This quick guide will show you how to use the macOS Creator."
		echo -e ""
		echo -e "${RESET}${BODY}Commands will be listed like this.........................................(1)"
		echo -e "${RESET}${BODY}Simply find the number corresponding to that command......................(2)"
		echo -e "${RESET}${BODY}To begin, choose this command here........................................(3)"
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "When choosing a command, type the number corresponding to that command: "
		read -n 1 prompt
		if [[ "$prompt" == '3' ]]; then
			while true; do
				clear
				WINDOWBAR
				echo -e "${RESET}${TITLE}${BOLD}Perfect"
				echo -e "${RESET}${TITLE}If you wish to cancel at any point, press the return key."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press the return key now: "
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}Operation Canceled."
					echo -e ""
					echo -e "${RESET}${BODY}When you press the return key, this will appear and the script will close."
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to continue: "
					read -n 1
					while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}If you wish to return to the home menu, press Q at any point:"
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press Q now: "
						read -n 1 prompt
						if [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
							echo -e ""
							echo -e "${RESET}${BODY}This will take you back to the first screen and start over."
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to continue: "
							read -n 1
							WINDOWBAR
							echo -e "${RESET}${BODY}The script may ask you to drag a file or drive into this window."
							echo -e "${RESET}${BODY}Simply drag the item from the Finder into this window."
							echo -e "${RESET}${BODY}Once finished, press the return key for the script to accept the item."
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to continue: "
							read -n 1
							WINDOWBAR
							echo -e "${RESET}${TITLE}This is all you need to know to use the macOS Creator."
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home: "
							read -n 1
							echo -e ""
							break 3
						else
							WINDOWERROR
						fi
					done
				else
					WINDOWERROR
				fi
			done
		else
			echo -e "${RESET}${ERROR}"
			echo -e "Invalid Command."
			echo -e ""
			echo -e "${RESET}${BODY}If you do enter a number that is not valid, this will appear."
			echo -e "${RESET}${BODY}If this happens, simply press any key to try again."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to try again: "
			read -n 1
			echo -e ""
		fi
	done
}
HELPOSFOUND()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Press (Y) to continue with the drive creation process"
	echo -e ""
	echo -e "Press (Q) to return back home"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}"
	echo -n "Press any key to return... "
	read -n 1
	echo -e ""
}
HELPOSFOUNDLEGACY()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}This installer may fail, but due to lack of devolopment in this script."
	echo -e "If you do notice issues, you can report them at GitHub."
	echo -e "Press (Y) to continue with the drive creation process"
	echo -e ""
	echo -e "Press (Q) to return back home"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}"
	echo -n "Press any key to return... "
	read -n 1
	echo -e ""
}
HELPDRIVE()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Choose a drive listed to continue."
	echo -e "If your drive is not listed, press (S) to manually provide the drive."
	echo -e ""
	echo -e "Press (Q) to return back home"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}"
	echo -n "Press any key to return... "
	read -n 1
	echo -e ""
}
HELPDRAGDRIVE()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Drag a drive from the Finder into this window."
	echo -e "When finished, press the return key to continue."
	echo -e ""
	echo -e "Press (Q) to return back home"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}"
	echo -n "Press any key to return... "
	read -n 1
	echo -e ""
}
HELPOSNONE()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}The script did not find any versions of macOS in your Applications folder."
	echo -e "Make sure you have a valid macOS installer and press (S)."
	echo -e "If you have a version of macOS somewhere else, you can provide it manually."
	echo -e "Press (Q) to go home and manually provide the installer."
	echo -e ""
	echo -e "Press (Q) to return back home"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}"
	echo -n "Press any key to return... "
	read -n 1
	echo -e ""
}
BETAHELP()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}BETA Builds are tools that are still in active development."
	echo -e "You may or may not notice any issues while using this tool."
	echo -e "If you do notice issues, you can report them at GitHub."
	echo -e "Press (Y) to continue."
	echo -e ""
	echo -e "Press (Q) to return back home"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}"
	echo -n "Press any key to return... "
	read -n 1
	echo -e ""
}
HELPID()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}If you wish to install macOS on this Mac, press (1)."
	echo -e "If you wish to install macOS on another Mac, press (2)."
	echo -e ""
	echo -e "Press (Q) to return back home"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}"
	echo -n "Press any key to return... "
	read -n 1
	echo -e ""
}
HELPIDMAC()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Choose the option that is equivalent to the Mac"
	echo -e ""
	echo -e "Press (Q) to return back home"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}"
	echo -n "Press any key to return... "
	read -n 1
	echo -e ""
}
HELPMANUAL()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Drag the macOS Installer from the finder into this window."
	echo -e "When finished, press the return key."
	echo -e ""
	echo -e "Press (Q) to return back home"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}"
	echo -n "Press any key to return... "
	read -n 1
	echo -e ""
}

#Search for macOS
APPLICATIONSCREATE()
{
	echo -e ""
	echo -e "${TITLE}Checking for valid macOS Installers...${RESET}"
	if [[ -d /Applications/Install\ macOS\ Sequoia.app ]]; then
		OSSEQUOIA
	elif [[ -d /Applications/Install\ macOS\ Sonoma.app ]]; then
		OSSONOMA
	elif [[ -d /Applications/Install\ macOS\ Ventura.app ]]; then
		OSVENTURA
	elif [[ -d /Applications/Install\ macOS\ Monterey.app ]]; then
		OSMONTEREY
	elif [[ -d /Applications/Install\ macOS\ Big\ Sur.app ]]; then
		OSBIGSUR
	elif [[ -d /Applications/Install\ macOS\ Catalina.app ]]; then
		OSCATALINA
	elif [[ -d /Applications/Install\ macOS\ Mojave.app ]]; then
		OSMOJAVE
	elif [[ -d /Applications/Install\ macOS\ High\ Sierra.app ]]; then
		OSHIGHSIERRA
	elif [[ -d /Applications/Install\ macOS\ Sierra.app ]]; then
		OSSIERRA
	elif [[ -d /Applications/Install\ OS\ X\ El\ Capitan.app ]]; then
		OSELCAPITAN
	elif [[ -d /Applications/Install\ OS\ X\ Yosemite.app ]]; then
		OSYOSEMITE
	elif [[ -d /Applications/Install\ OS\ X\ Mavericks.app ]]; then
		OSMAVERICKS
	elif [[ -d /Applications/Install\ OS\ X\ Mountain\ Lion.app ]]; then
		OSML
	elif [[ -d /Applications/Install\ Mac\ OS\ X\ Lion.app ]]; then
		OSL
	else
		OSNONE
	fi
}

#OS Found
OSMAVERICKS()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}OS X Mavericks was found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to use this Installer?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install OS X Mavericks.app"
		FINDDRIVE
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSYOSEMITE()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}OS X Yosemite was found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to use this Installer?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install OS X Yosemite.app"
		FINDDRIVE
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSELCAPITAN()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}OS X El Capitan was found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to use this Installer?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install OS X El Capitan.app"
		FINDDRIVE
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSSIERRA()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}macOS Sierra was found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to use this Installer?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}Currently you cannot install macOS Sierra with this Mac."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			fi
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}You need OS X Mountain Lion or later to install macOS Sierra."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home..."
			read -n 1
			break
		else
			installpath="/Applications/Install macOS Sierra.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSHIGHSIERRA()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}macOS High Sierra was found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to use this Installer?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $APPLESILICONE == 'YES' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac has the Apple Silicone chip${RESET}"
			echo -e "${ERROR}Currently you cannot install macOS High Sierra with this Mac."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		fi
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}You need OS X Mountain Lion or later to install macOS High Sierra."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		else
			installpath="/Applications/Install macOS High Sierra.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSMOJAVE()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}macOS Mojave was found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to use this Installer?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $APPLESILICONE == 'YES' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac has the Apple Silicone chip${RESET}"
			echo -e "${ERROR}Currently you cannot install macOS Mojave with this Mac."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		fi
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}You need OS X Mountain Lion or later to install macOS Mojave."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		else
			installpath="/Applications/Install macOS Mojave.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSCATALINA()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}macOS Catalina was found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to use this Installer?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $APPLESILICONE == 'YES' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac has the Apple Silicone chip${RESET}"
			echo -e "${ERROR}Currently you cannot install macOS Catalina with this Mac."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		fi
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}You need OS X Mavericks or later to install macOS Catalina."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.8' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X Mountain Lion${RESET}"
			echo -e "${ERROR}You need OS X Mavericks or later to install macOS Catalina."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		else
			installpath="/Applications/Install macOS Catalina.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSBIGSUR()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}macOS Big Sure was found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to use this Installer?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}You need OS X Mavericks or later to install macOS Big Sur."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.8' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X Mountain Lion${RESET}"
			echo -e "${ERROR}You need OS X Mavericks or later to install macOS Big Sur."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		else
			installpath="/Applications/Install macOS Big Sur.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSMONTEREY()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}macOS Monterey was found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to use this Installer?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}You need OS X Mavericks or later to install macOS Monterey."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.8' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X Mountain Lion${RESET}"
			echo -e "${ERROR}You need OS X Mavericks or later to install macOS Monterey."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		else
			installpath="/Applications/Install macOS Monterey.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSVENTURA()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}macOS Ventura was found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to use this Installer?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.8' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X Mountain Lion${RESET}"
			echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.9' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X Mavericks${RESET}"
			echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.10' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X Yosemite${RESET}"
			echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.11' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X El Capitan${RESET}"
			echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		else
			installpath="/Applications/Install macOS Ventura.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSSONOMA()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}macOS Sonoma was found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to use this Installer?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.8' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X Mountain Lion${RESET}"
			echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.9' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X Mavericks${RESET}"
			echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.10' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X Yosemite${RESET}"
			echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.11' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X El Capitan${RESET}"
			echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.12' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running macOS Sierra${RESET}"
			echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		else
			installpath="/Applications/Install macOS Sonoma.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSSEQUOIA()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}macOS Sequoia was found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to use this Installer?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.8' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X Mountain Lion${RESET}"
			echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.9' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X Mavericks${RESET}"
			echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.10' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X Yosemite${RESET}"
			echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.11' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running OS X El Capitan${RESET}"
			echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		elif [[ $MACOSVERSION == '10.12' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "This Mac is running macOS Sierra${RESET}"
			echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Press any key to go home... "
			read -n 1
			break
		else
			installpath="/Applications/Install macOS Sequoia.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSML()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}OS X Mountain Lion was found.${RESET}"
	echo -e "${RESET}${WARNING}This installer is still in devolopment and may not work.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to continue?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install OS X Mountain Lion.app"
		FINDDRIVE
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUNDLEGACY
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSL()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}Mac OS X Lion was found.${RESET}"
	echo -e "${RESET}${WARNING}This installer is still in devolopment and may not work.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Would you like to continue?... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install Mac OS X Lion.app"
		FINDDRIVE
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSFOUNDLEGACY
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSNONE()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}No versions of macOS were found.${RESET}"
	echo -e "${PROMPTSTYLE}"
	echo -n "Press S to search again... "
	read -n 1 input
	if [[ $input == 's' || $input == 'S' ]]; then
		echo -e "${RESET}"
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		break
	elif [[ $input == '?' ]]; then
		HELPOSNONE
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}

#Get Drive Path
FINDDRIVE()
{
	if [[ -d /Volumes/Untitled ]]; then
		installer_volume_path="/Volumes/Untitled/"
		OSDRIVECREATION
	else
		while true; do
			WINDOWBAR
			echo -e "${RESET}${TITLE}Choose the drive to create the installer."
			echo -e "Drive not listed? Press S to manually provide a drive."
			echo -e "${RESET}${WARNING}${BOLD}WARNING! All data on the drive will be lost!"
			echo -e "${RESET}${BODY}"
			for volume_path in /Volumes/*; do
				volume_name="${volume_path#/Volumes/}"
				if [[ ! "$volume_name" == com.apple* ]]; then
					volume_number=$(($volume_number + 1))
					declare volume_$volume_number="$volume_name"
					echo -e "(${volume_number}) ..... ${volume_name}" | sort
				fi
			done
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Enter your option here... "
			read -n 1 installer_volume_number
			if [[ $installer_volume_number == '' ]]; then
				WINDOWBAREND
			else
				if [[ $installer_volume_number == *'1'* || $installer_volume_number == *'2'* || $installer_volume_number == *'3'* || $installer_volume_number == *'4'* || $installer_volume_number == *'5'* || $installer_volume_number == *'6'* || $installer_volume_number == *'7'* || $installer_volume_number == *'8'* || $installer_volume_number == *'9'* || $installer_volume_number == *'q'* || $installer_volume_number == *'Q'* || $installer_volume_number == *'?'* || $installer_volume_number == *'s'* || $installer_volume_number == *'S'* ]]; then
					if [[ $installer_volume_number == 's' || $installer_volume_number == 'S' ]]; then
						PROVIDEDRIVE
					elif [[ $installer_volume_number == 'q' || $installer_volume_number == 'Q' ]]; then
						break 2
					elif [[ $installer_volume_number == '?' ]]; then
						HELPDRIVE
					else
						installer_volume="volume_$installer_volume_number"
						installer_volume_name="${!installer_volume}"
						installer_volume_path="/Volumes/$installer_volume_name"
						installer_volume_identifier="$(diskutil info "$installer_volume_name"|grep "Device Identifier"|sed 's/.*\ //')"
						OSDRIVECREATION
					fi
				else
					WINDOWERROR
				fi
			fi
		done
	fi
}
PROVIDEDRIVE()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}Please drag the drive from the Finder into this window:"
		echo -e "${RESET}${WARNING}${BOLD}WARNING! All data on the drive will be lost!"
		echo -e "${RESET}${BODY}"
		read -p "Drive path: " installer_volume_path
		if [[ $installer_volume_path = '' ]]; then
			WINDOWBAREND
		elif [[ $installer_volume_path = '?' ]]; then
			HELPDRAGDRIVE
		elif [[ $installer_volume_path = 'q' || $installer_volume_path = 'Q' ]]; then
			break 3
		else
			if [[ $installer_volume_path = *"/Volumes/"* ]]; then
				OSDRIVECREATION
			else
				WINDOWERRORDRIVE
			fi
		fi
	done
}

#Pre-Create Drive
OSDRIVECREATION()
{
	if [[ "$installpath" == *'Mavericks.app'* ]]; then
		MAVERICKSDRIVECREATION
	elif [[ "$installpath" == *'Yosemite.app'* ]]; then
		YOSEMITEDRIVECREATION
	elif [[ "$installpath" == *'Capitan.app'* ]]; then
		ELCAPITANDRIVECREATION
	elif [[ "$installpath" == *'macOS Sierra.app'* ]]; then
		SIERRADRIVECREATION
	elif [[ "$installpath" == *'High Sierra.app'* ]]; then
		HIGHSIERRADRIVECREATION
	elif [[ "$installpath" == *'Mojave.app'* ]]; then
		MOJAVEDRIVECREATION
	elif [[ "$installpath" == *'Catalina.app'* ]]; then
		CATALINADRIVECREATION
	elif [[ "$installpath" == *'Sur.app'* ]]; then
		BIGSURDRIVECREATION
	elif [[ "$installpath" == *'Monterey.app'* ]]; then
		MONTEREYDRIVECREATION
	elif [[ "$installpath" == *'Ventura.app'* ]]; then
		VENTURADRIVECREATION
	elif [[ "$installpath" == *'Sonoma.app'* ]]; then
		SONOMADRIVECREATION
	elif [[ "$installpath" == *'Sequoia.app'* ]]; then
		SEQUOIADRIVECREATION
	elif [[ "$installpath" == *'Mountain Lion.app'* ]]; then
		MLDRIVECREATION
	elif [[ "$installpath" == *'OS X Lion.app'* ]]; then
		LDRIVECREATION
	else
		clear
		echo -e ""
		echo -e "${RESET}${ERROR}${BOLD}The script has encountered an error. Please try running this script again... ${RESET}"
		echo -e ""
		exit
	fi
}

#Create Drive
MAVERICKSDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for ${BOLD}OS X Mavericks${RESET}${TITLE}. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --applicationpath /Applications/Install\ OS\ X\ Mavericks.app --nointeraction
	if [[ -d /Volumes/Install\ OS\ X\ Mavericks/Install\ OS\ X\ Mavericks.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
YOSEMITEDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for OS X Yosemite. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --applicationpath /Applications/Install\ OS\ X\ Yosemite.app --nointeraction
	if [[ -d /Volumes/Install\ OS\ X\ Yosemite/Install\ OS\ X\ Yosemite.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
ELCAPITANDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for OS X El Capitan. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app --nointeraction
	if [[ -d /Volumes/Install\ OS\ X\ El\ Capitan/Install\ OS\ X\ El\ Capitan.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
SIERRADRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for macOS Sierra. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --applicationpath /Applications/Install\ macOS\ Sierra.app --nointeraction
	if [[ -d /Volumes/Install\ macOS\ Sierra/Install\ macOS\ Sierra.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
HIGHSIERRADRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for macOS High Sierra. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction
	if [[ -d /Volumes/Install\ macOS\ High\ Sierra/Install\ macOS\ High\ Sierra.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
MOJAVEDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for macOS Mojave. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction
	if [[ -d /Volumes/Install\ macOS\ Mojave/Install\ macOS\ Mojave.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
CATALINADRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for macOS Catalina. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction
	if [[ -d /Volumes/Install\ macOS\ Catalina/Install\ macOS\ Catalina.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
BIGSURDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for macOS Big Sur. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction
	if [[ -d /Volumes/Install\ macOS\ Big\ Sur/Install\ macOS\ Big\ Sur.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
MONTEREYDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for macOS Monterey. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction
	if [[ -d /Volumes/Install\ macOS\ Monterey/Install\ macOS\ Monterey.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
VENTURADRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for macOS Ventura. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction
	if [[ -d /Volumes/Install\ macOS\ Ventura/Install\ macOS\ Ventura.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
SONOMADRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for macOS Sonoma. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction
	if [[ -d /Volumes/Install\ macOS\ Sonoma/Install\ macOS\ Sonoma.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
SEQUOIADRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for macOS Sequoia. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction
	if [[ -d /Volumes/Install\ macOS\ Sequoia/Install\ macOS\ Sequoia.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
MLDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for ${BOLD}OS X Mountain Lion${RESET}${TITLE}. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo asr restore -source "$installpath/Contents/SharedSupport/InstallESD.dmg" -target "$installer_volume_path" -noprompt -noverify -erase
	if [[ -d /Volumes/Mac\ OS\ X\ Install\ ESD/Install\ OS\ X\ Mountain\ Lion.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}
LDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}Creating the drive for ${BOLD}Mac OS X Lion${RESET}${TITLE}. Please Enter Your "
	sudo echo ""
	echo -e "${RESET}${BODY}Please wait... "
	Output sudo asr restore -source "$installpath/Contents/SharedSupport/InstallESD.dmg" -target "$installer_volume_path" -noprompt -noverify -erase
	if [[ -d /Volumes/Mac\ OS\ X\ Install\ ESD/Install\ Mac\ OS\ X\ Lion.app ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "The drive has been created successfully. Press any key to quit..."
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}"
		echo -e "Operation Failed."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Would you like to review troubleshooting steps? (Press any key to quit)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			break 2
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWBARENDANY
		fi
	fi
}

#Manually Create Drive
MANUALCREATE()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}Manually provide the macOS Installer"
		echo -e "${RESET}${BODY}Please drag the installer into this window and press the return key... "
		echo -e "${RESET}${PROMPTSTYLE}"
		read -p "Installer path(" installpath
		if [[ "$installpath" == *'Mavericks.app'* ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}OS X Mavericks"
			echo -e -n "${RESET}${TITLE}Press any key to continue... "
			read -n 1
			FINDDRIVE
		elif [[ "$installpath" == *'Yosemite.app'* ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}OS X Yosemite"
			echo -e -n "${RESET}${TITLE}Press any key to continue... "
			read -n 1
			FINDDRIVE
		elif [[ "$installpath" == *'Capitan.app'* ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}OS X El Capitan"
			echo -e -n "${RESET}${TITLE}Press any key to continue... "
			read -n 1
			FINDDRIVE
		elif [[ "$installpath" == *'macOS Sierra.app'* ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}Currently you cannot install macOS Sierra with this Mac."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need OS X Mountain Lion or later to install macOS Sierra."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home..."
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Sierra"
				echo -e -n "${RESET}${TITLE}Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'High Sierra.app'* ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}Currently you cannot install macOS High Sierra with this Mac."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need OS X Mountain Lion or later to install macOS High Sierra."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS High Sierra"
				echo -e -n "${RESET}${TITLE}Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Mojave.app'* ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}Currently you cannot install macOS Mojave with this Mac."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need OS X Mountain Lion or later to install macOS Mojave."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Mojave"
				echo -e -n "${RESET}${TITLE}Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Catalina.app'* ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}Currently you cannot install macOS Catalina with this Mac."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need OS X Mavericks or later to install macOS Catalina."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}You need OS X Mavericks or later to install macOS Catalina."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Catalina"
				echo -e -n "${RESET}${TITLE}Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Sur.app'* ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need OS X Mavericks or later to install macOS Big Sur."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}You need OS X Mavericks or later to install macOS Big Sur."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Big Sur"
				echo -e -n "${RESET}${TITLE}Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Monterey.app'* ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need OS X Mavericks or later to install macOS Monterey."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}You need OS X Mavericks or later to install macOS Monterey."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Monterey"
				echo -e -n "${RESET}${TITLE}Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Ventura.app'* ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.9' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mavericks${RESET}"
				echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.10' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Yosemite${RESET}"
				echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.11' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X El Capitan${RESET}"
				echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Ventura"
				echo -e -n "${RESET}${TITLE}Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Sonoma.app'* ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.9' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mavericks${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.10' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Yosemite${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.11' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X El Capitan${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.12' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running macOS Sierra${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Sonoma"
				echo -e -n "${RESET}${TITLE}Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Sequoia.app'* ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.9' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mavericks${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.10' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Yosemite${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.11' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X El Capitan${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.12' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running macOS Sierra${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Sequoia"
				echo -e -n "${RESET}${TITLE}Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Mountain Lion.app'* ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}OS X Mountain Lion.${RESET}"
			echo -e "${RESET}${WARNING}This installer is still in devolopment and may not work.${RESET}"
			echo -e "${PROMPTSTYLE}"
			echo -n "Press any key to continue... "
			read -n 1
			FINDDRIVE
		elif [[ "$installpath" == *'Mac OS X Lion.app'* ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}Mac OS X Lion.${RESET}"
			echo -e "${RESET}${WARNING}This installer is still in devolopment and may not work.${RESET}"
			echo -e "${PROMPTSTYLE}"
			echo -n "Press any key to continue... "
			read -n 1
			FINDDRIVE
		elif [[ $installpath == 'q' || $installpath == 'Q' ]]; then
			break
		elif [[ $installpath == '?' ]]; then
			HELPMANUAL
		elif [[ $installpath == '' ]]; then
			WINDOWBAREND
		else
			echo -e "${RESET}${ERROR}"
			echo -e "This is not a valid macOS Installer. Press any key to try again... "
			read -n 1
		fi
	done
}

#Download macOS
DOWNLOADMACOS()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}Choose the version of macOS you wish to download..."
		echo -e "${RESET}${TITLE}You can also type the macOS version number (i.e. 10.13)"
		echo -e "${RESET}${TITLE}Or type out the name of the macOS version (i.e. High Sierra)"
		echo -e "${RESET}${BODY}Press the return key when finished."
		echo -e "${RESET}${BODY}"
		echo -e "OS X Mavericks.....(1)"
		echo -e "OS X Yosemite......(2)"
		echo -e "OS X El Capitan....(3)"
		echo -e "macOS Sierra.......(4)"
		echo -e "macOS High Sierra..(5)"
		echo -e "macOS Mojave.......(6)"
		echo -e "macOS Catalina.....(7)"
		echo -e "macOS Big Sur......(8)"
		echo -e "Next page..........(9)"
		echo -e "${RESET}${PROMPTSTYLE}"
		read -p "Enter your option here... " prompt
		if [[ "$prompt" == '1' || "$prompt" == '10.9' || "$prompt" == 'Mavericks' || "$prompt" == 'mavericks' ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}OS X Mavericks"
			echo -e -n "${RESET}${TITLE}Press any key to download... "
			read -n 1
			DOWNLOADMAVERICKS
		elif [[ "$prompt" == '2' || "$prompt" == '10.10' || "$prompt" == 'Yosemite' || "$prompt" == 'yosemite' ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}OS X Yosemite"
			echo -e -n "${RESET}${TITLE}Press any key to download... "
			read -n 1
			DOWNLOADYOSEMITE
		elif [[ "$prompt" == '3' || "$prompt" == '10.11' || "$prompt" == 'El Capitan' || "$prompt" == 'el capitan' || "$prompt" == 'El capitan' || "$prompt" == 'el Capitan' ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}OS X El Capitan"
			echo -e -n "${RESET}${TITLE}Press any key to download... "
			read -n 1
			DOWNLOADELCAPITAN
		elif [[ "$prompt" == '4' || "$prompt" == '10.12' || "$prompt" == 'Sierra' || "$prompt" == 'sierra' ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}Currently you cannot install macOS Sierra with this Mac."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need OS X Mountain Lion or later to install macOS Sierra."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home..."
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Sierra"
				echo -e -n "${RESET}${TITLE}Press any key to download... "
				read -n 1
				DOWNLOADSIERRA
			fi
		elif [[ "$prompt" == '5' || "$prompt" == '10.13' || "$prompt" == 'High Sierra' || "$prompt" == 'high sierra' || "$prompt" == 'High sierra' || "$prompt" == 'high Sierra' ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}Currently you cannot install macOS High Sierra with this Mac."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need OS X Mountain Lion or later to install macOS High Sierra."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS High Sierra"
				echo -e -n "${RESET}${TITLE}Press any key to download... "
				read -n 1
				DOWNLOADHIGHSIERRA
			fi
		elif [[ "$prompt" == '6' || "$prompt" == '10.14' || "$prompt" == 'Mojave' || "$prompt" == 'mojave' ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}Currently you cannot install macOS Mojave with this Mac."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need OS X Mountain Lion or later to install macOS Mojave."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Mojave"
				echo -e -n "${RESET}${TITLE}Press any key to download... "
				read -n 1
				DOWNLOADMOJAVE
			fi
		elif [[ "$prompt" == '7' || "$prompt" == '10.15' || "$prompt" == 'Catalina' || "$prompt" == 'catalina' ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}Currently you cannot install macOS Catalina with this Mac."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need OS X Mavericks or later to install macOS Catalina."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}You need OS X Mavericks or later to install macOS Catalina."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Catalina"
				echo -e -n "${RESET}${TITLE}Press any key to download... "
				read -n 1
				DOWNLOADCATALINA
			fi
		elif [[ "$prompt" == '8' || "$prompt" == '11' || "$prompt" == 'Big Sur' || "$prompt" == 'big sur' || "$prompt" == 'Big sur' || "$prompt" == 'big Sur' ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need OS X Mavericks or later to install macOS Big Sur."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}You need OS X Mavericks or later to install macOS Big Sur."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Big Sur"
				echo -e -n "${RESET}${TITLE}Press any key to download... "
				read -n 1
				DOWNLOADBIGSUR
			fi
		elif [[ "$prompt" == '12' || "$prompt" == 'Monterey' || "$prompt" == 'monterey' ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need OS X Mavericks or later to install macOS Monterey."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}You need OS X Mavericks or later to install macOS Monterey."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Monterey"
				echo -e -n "${RESET}${TITLE}Press any key to download... "
				read -n 1
				DOWNLOADMONTEREY
			fi
		elif [[ "$prompt" == '13' || "$prompt" == 'Ventura' || "$prompt" == 'ventura' ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.9' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mavericks${RESET}"
				echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.10' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Yosemite${RESET}"
				echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.11' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X El Capitan${RESET}"
				echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Ventura"
				echo -e -n "${RESET}${TITLE}Press any key to download... "
				read -n 1
				DOWNLOADVENTURA
			fi
		elif [[ "$prompt" == '14' || "$prompt" == 'Sonoma' || "$prompt" == 'sonoma' ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.9' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mavericks${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.10' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Yosemite${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.11' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X El Capitan${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.12' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running macOS Sierra${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Sonoma"
				echo -e -n "${RESET}${TITLE}Press any key to download... "
				read -n 1
				DOWNLOADSONOMA
			fi
		elif [[ "$prompt" == '15' || "$prompt" == 'Sequoia' || "$prompt" == 'sequoia' ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.9' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Mavericks${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.10' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X Yosemite${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.11' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running OS X El Capitan${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			elif [[ $MACOSVERSION == '10.12' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "This Mac is running macOS Sierra${RESET}"
				echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Press any key to go home... "
				read -n 1
				break
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}macOS Sequoia"
				echo -e -n "${RESET}${TITLE}Press any key to continue... "
				read -n 1
				DOWNLOADSEQUOIA
			fi
		elif [[ "$prompt" == '9' ]]; then
			while true; do
				WINDOWBAR
				echo -e "${RESET}${TITLE}Choose the version of macOS you wish to download..."
				echo -e "${RESET}${BODY}"
				echo -e "macOS Monterey.....(1)"
				echo -e "macOS Ventura......(2)"
				echo -e "macOS Sonoma.......(3)"
				echo -e "macOS Sequoia......(4)"
				echo -e "${RESET}${PROMPTSTYLE}"
				read -p "Enter your option here... " prompt
				if [[ "$prompt" == '1' || "$prompt" == '12' || "$prompt" == 'Monterey' || "$prompt" == 'monterey' ]]; then
					if [[ $MACOSVERSION == '10.7' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running Mac OS X Lion${RESET}"
						echo -e "${ERROR}You need OS X Mavericks or later to install macOS Monterey."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.8' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X Mountain Lion${RESET}"
						echo -e "${ERROR}You need OS X Mavericks or later to install macOS Monterey."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					else
						echo -e ""
						echo -e "${RESET}${OSFOUND}${BOLD}macOS Monterey"
						echo -e -n "${RESET}${TITLE}Press any key to download... "
						read -n 1
						DOWNLOADMONTEREY
					fi
				elif [[ "$prompt" == '2' || "$prompt" == '13' || "$prompt" == 'Ventura' || "$prompt" == 'ventura' ]]; then
					if [[ $MACOSVERSION == '10.7' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running Mac OS X Lion${RESET}"
						echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.8' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X Mountain Lion${RESET}"
						echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.9' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X Mavericks${RESET}"
						echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.10' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X Yosemite${RESET}"
						echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.11' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X El Capitan${RESET}"
						echo -e "${ERROR}You need macOS Sierra or later to install macOS Ventura."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					else
						echo -e ""
						echo -e "${RESET}${OSFOUND}${BOLD}macOS Ventura"
						echo -e -n "${RESET}${TITLE}Press any key to download... "
						read -n 1
						DOWNLOADVENTURA
					fi
				elif [[ "$prompt" == '3' || "$prompt" == '14' || "$prompt" == 'Sonoma' || "$prompt" == 'sonoma' ]]; then
					if [[ $MACOSVERSION == '10.7' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running Mac OS X Lion${RESET}"
						echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.8' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X Mountain Lion${RESET}"
						echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.9' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X Mavericks${RESET}"
						echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.10' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X Yosemite${RESET}"
						echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.11' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X El Capitan${RESET}"
						echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.12' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running macOS Sierra${RESET}"
						echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sonoma."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					else
						echo -e ""
						echo -e "${RESET}${OSFOUND}${BOLD}macOS Sonoma"
						echo -e -n "${RESET}${TITLE}Press any key to download... "
						read -n 1
						DOWNLOADSONOMA
					fi
				elif [[ "$prompt" == '4' || "$prompt" == '15' || "$prompt" == 'Sequoia' || "$prompt" == 'sequoia' ]]; then
					if [[ $MACOSVERSION == '10.7' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running Mac OS X Lion${RESET}"
						echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.8' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X Mountain Lion${RESET}"
						echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.9' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X Mavericks${RESET}"
						echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.10' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X Yosemite${RESET}"
						echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.11' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running OS X El Capitan${RESET}"
						echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					elif [[ $MACOSVERSION == '10.12' ]]; then
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "This Mac is running macOS Sierra${RESET}"
						echo -e "${ERROR}You need macOS High Sierra or later to install macOS Sequoia."
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Press any key to go home... "
						read -n 1
						break 2
					else
						echo -e ""
						echo -e "${RESET}${OSFOUND}${BOLD}macOS Sequoia"
						echo -e -n "${RESET}${TITLE}Press any key to continue... "
						read -n 1
						DOWNLOADSEQUOIA
					fi
				elif [[ $prompt == 'q' || $prompt == 'Q' ]]; then
					break 2
				elif [[ $prompt == '' ]]; then
					WINDOWBAREND
				else
					WINDOWERROR
				fi
			done
		elif [[ $prompt == 'q' || $prompt == 'Q' ]]; then
			break
		elif [[ $prompt == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
	done
}
DOWNLOADMAVERICKS()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}Downloading OS X Mavericks...${RESET}${BODY}"
		if [[ -e /private/tmp/InstallmacOS.zip ]]; then
			sudo rm -R /private/tmp/InstallmacOS.zip
		fi
		sudo curl https://ia801805.us.archive.org/35/items/os-x-mavericks/Install%20OS%20X%20Mavericks.zip -o /private/tmp/InstallmacOS.zip
		if [ $? -eq 0 ]; then
			if [[ -e /private/tmp/InstallmacOS.zip ]]; then
				sudo open /private/tmp/InstallmacOS.zip
				echo -e "${RESET}${TITLE}"
				echo -e "Copy the macOS Installer into your Applications folder..."
				echo -n "Once completed, press any key to return home, or the return key to cancel..."
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					break 2
				fi
			else
				DOWNLOADFAIL
			fi
		else
			DOWNLOADFAIL
		fi
	done
}
DOWNLOADYOSEMITE()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}Downloading OS X Yosemite...${RESET}${BODY}"
		if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
			sudo rm -R /private/tmp/InstallmacOS.dmg
		fi
		sudo curl http://updates-http.cdn-apple.com/2019/cert/061-41343-20191023-02465f92-3ab5-4c92-bfe2-b725447a070d/InstallMacOSX.dmg -o /private/tmp/InstallmacOS.dmg
		if [ $? -eq 0 ]; then
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				sudo open /private/tmp/InstallmacOS.dmg
				echo -e "${RESET}${TITLE}"
				echo -e "Follow the on-screen instructions to install..."
				echo -n "Once completed, press any key to return home, or the return key to cancel..."
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					break 2
				fi
			else
				DOWNLOADFAIL
			fi
		else
			DOWNLOADFAIL
		fi
	done
}
DOWNLOADELCAPITAN()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}Downloading OS X El Capitan...${RESET}${BODY}"
		if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
			sudo rm -R /private/tmp/InstallmacOS.dmg
		fi
		sudo curl http://updates-http.cdn-apple.com/2019/cert/061-41424-20191024-218af9ec-cf50-4516-9011-228c78eda3d2/InstallMacOSX.dmg -o /private/tmp/InstallmacOS.dmg
		if [ $? -eq 0 ]; then
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				sudo open /private/tmp/InstallmacOS.dmg
				echo -e "${RESET}${TITLE}"
				echo -e "Follow the on-screen instructions to install..."
				echo -n "Once completed, press any key to return home, or the return key to cancel..."
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					break 2
				fi
			else
				DOWNLOADFAIL
			fi
		else
			DOWNLOADFAIL
		fi
	done
}
DOWNLOADSIERRA()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}Downloading macOS Sierra...${RESET}${BODY}"
		if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
			sudo rm -R /private/tmp/InstallmacOS.dmg
		fi
		sudo curl http://updates-http.cdn-apple.com/2019/cert/061-39476-20191023-48f365f4-0015-4c41-9f44-39d3d2aca067/InstallOS.dmg -o /private/tmp/InstallmacOS.dmg
		if [ $? -eq 0 ]; then
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				sudo open /private/tmp/InstallmacOS.dmg
				echo -e "${RESET}${TITLE}"
				echo -e "Follow the on-screen instructions to install..."
				echo -n "Once completed, press any key to return home, or the return key to cancel..."
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					break 2
				fi
			else
				DOWNLOADFAIL
			fi
		else
			DOWNLOADFAIL
		fi
	done
}
DOWNLOADHIGHSIERRA()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}Downloading macOS High Sierra...${RESET}${BODY}"
		if [[ -e /private/tmp/InstallmacOS.iso ]]; then
			sudo rm -R /private/tmp/InstallmacOS.iso
		fi
		sudo curl https://dn720208.ca.archive.org/0/items/mac-os-high-sierra-10.13.5/macOS%20High%20Sierra%2010.13.5.iso -o /private/tmp/InstallmacOS.iso
		if [ $? -eq 0 ]; then
			if [[ -e /private/tmp/InstallmacOS.iso ]]; then
				sudo open /private/tmp/InstallmacOS.iso
				echo -e "${RESET}${TITLE}"
				echo -e "Copy the macOS Installer into your Applications folder..."
				echo -n "Once completed, press any key to return home, or the return key to cancel..."
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					break 2
				fi
			else
				DOWNLOADFAIL
			fi
		else
			DOWNLOADFAIL
		fi
	done
}
DOWNLOADMOJAVE()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}Downloading macOS Mojave...${RESET}${BODY}"
		if [[ -e /private/tmp/InstallmacOS.iso ]]; then
			sudo rm -R /private/tmp/InstallmacOS.iso
		fi
		sudo curl https://dn720002.ca.archive.org/0/items/mac-os-mojave-10.14/macOS%20Mojave%2010.14.iso -o /private/tmp/InstallmacOS.iso
		if [ $? -eq 0 ]; then
			if [[ -e /private/tmp/InstallmacOS.iso ]]; then
				sudo open /private/tmp/InstallmacOS.iso
				echo -e "${RESET}${TITLE}"
				echo -e "Copy the macOS Installer into your Applications folder..."
				echo -n "Once completed, press any key to return home, or the return key to cancel..."
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					break 2
				fi
			else
				DOWNLOADFAIL
			fi
		else
			DOWNLOADFAIL
		fi
	done
}
DOWNLOADCATALINA()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}Downloading macOS Catalina...${RESET}${BODY}"
		if [[ -e /private/tmp/InstallmacOS.iso ]]; then
			sudo rm -R /private/tmp/InstallmacOS.iso
		fi
		sudo curl https://dn720003.ca.archive.org/0/items/macOS-Catalina-IOS/macOSCatalina.iso -o /private/tmp/InstallmacOS.iso
		if [ $? -eq 0 ]; then
			if [[ -e /private/tmp/InstallmacOS.iso ]]; then
				sudo open /private/tmp/InstallmacOS.iso
				echo -e "${RESET}${TITLE}"
				echo -e "Copy the macOS Installer into your Applications folder..."
				echo -n "Once completed, press any key to return home, or the return key to cancel..."
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					break 2
				fi
			else
				DOWNLOADFAIL
			fi
		else
			DOWNLOADFAIL
		fi
	done
}
DOWNLOADBIGSUR()
{
	while true; do
		WINDOWBAR
		if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
			sudo rm -R /private/tmp/InstallAssistant.pkg
		fi
		echo -e "${RESET}${TITLE}Downloading macOS Big Sur...${RESET}${BODY}"
		sudo curl https://swcdn.apple.com/content/downloads/14/38/042-45246-A_NLFOFLCJFZ/jk992zbv98sdzz3rgc7mrccjl3l22ruk1c/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
		if [ $? -eq 0 ]; then
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				sudo open /private/tmp/InstallAssistant.pkg
				echo -e "${RESET}${TITLE}"
				echo -e "Follow the on-screen instructions to install..."
				echo -n "Once completed, press any key to return home, or the return key to cancel..."
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					break 2
				fi
			else
				DOWNLOADFAIL
			fi
		else
			DOWNLOADFAIL
		fi
	done
}
DOWNLOADMONTEREY()
{
	while true; do
		WINDOWBAR
		if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
			sudo rm -R /private/tmp/InstallAssistant.pkg
		fi
		echo -e "${RESET}${TITLE}Downloading macOS Monterey...${RESET}${BODY}"
		sudo curl https://swcdn.apple.com/content/downloads/46/57/052-60131-A_KM2RH04C2D/9yzvba1uvpem2wuo95r459qno57qaizwf2/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
		if [ $? -eq 0 ]; then
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				sudo open /private/tmp/InstallAssistant.pkg
				echo -e "${RESET}${TITLE}"
				echo -e "Follow the on-screen instructions to install..."
				echo -n "Once completed, press any key to return home, or the return key to cancel..."
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					break 2
				fi
			else
				DOWNLOADFAIL
			fi
		else
			DOWNLOADFAIL
		fi
	done
}
DOWNLOADVENTURA()
{
	while true; do
		WINDOWBAR
		if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
			sudo rm -R /private/tmp/InstallAssistant.pkg
		fi
		echo -e "${RESET}${TITLE}Downloading macOS Ventura...${RESET}${BODY}"
		sudo curl https://swcdn.apple.com/content/downloads/29/47/072-09024-A_8G5EY3SPX2/l6ecgngkrhhbc6q4mae5cwe42pxp49co7w/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
		if [ $? -eq 0 ]; then
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				sudo open /private/tmp/InstallAssistant.pkg
				echo -e "${RESET}${TITLE}"
				echo -e "Follow the on-screen instructions to install..."
				echo -n "Once completed, press any key to return home, or the return key to cancel..."
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					break 2
				fi
			else
				DOWNLOADFAIL
			fi
		else
			DOWNLOADFAIL
		fi
	done
}
DOWNLOADSONOMA()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}Downloading macOS Sonoma...${RESET}${BODY}"
		if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
			sudo rm -R /private/tmp/InstallAssistant.pkg
		fi
		sudo curl https://swcdn.apple.com/content/downloads/43/40/072-61299-A_Y6TZ03D5E8/dpzudbub2uj7lqy3cko50k4moqsu2lq5ui/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
		if [ $? -eq 0 ]; then
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				sudo open /private/tmp/InstallAssistant.pkg
				echo -e "${RESET}${TITLE}"
				echo -e "Follow the on-screen instructions to install..."
				echo -n "Once completed, press any key to return home, or the return key to cancel..."
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					break 2
				fi
			else
				DOWNLOADFAIL
			fi
		else
			DOWNLOADFAIL
		fi
	done
}
DOWNLOADSEQUOIA()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}Downloading macOS Sequoia...${RESET}${BODY}"
		if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
			sudo rm -R /private/tmp/InstallAssistant.pkg
		fi
		sudo curl https://swcdn.apple.com/content/downloads/08/08/072-12353-A_IUBHH68MQT/sv48ma68gmhl96fa9anqfj3i2fnb1ur2wh/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
		if [ $? -eq 0 ]; then
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				sudo open /private/tmp/InstallAssistant.pkg
				echo -e "${RESET}${TITLE}"
				echo -e "Follow the on-screen instructions to install..."
				echo -n "Once completed, press any key to return home, or the return key to cancel..."
				read -n 1 prompt
				if [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					break 2
				fi
			else
				DOWNLOADFAIL
			fi
		else
			DOWNLOADFAIL
		fi
	done
}
DOWNLOADFAIL()
{
	echo -e ""
	echo -e "${RESET}${ERROR}${BOLD}Download failed."
	echo -e "${RESET}${ERROR}Make sure you have an internet connection.${RESET}${PROMPTSTYLE}"
	echo -e ""
	echo -n "Press any key to cancel. Press S to try again. Press Q to return home."
	read -n 1 prompt
	if [[ "$prompt" == 's' || "$prompt" == 'S' ]]; then
		echo ""
	elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
		break 2
	elif [[ "$prompt" == '' ]]; then
		WINDOWBAREND
	else
		WINDOWBARENDANY
	fi
}

#Script Color Change
CHANGECOLORS()
{
	if [[ $safe == "1" ]]; then
		WINDOWBAR
		echo -e "You cannot change script colors in Safe Mode."
		echo -e ""
		echo -n "Press any key to return home..."
		read -n 1
	else
		if [[ $APPLESILICONE == 'YES' ]]; then
			if [[ -e "$SCRIPTPATHMAIN/macOS Creator.command" ]]; then
				while true; do
					WINDOWBAR
					echo -e "${RESET}${TITLE}${BOLD}Choose the color style you like:"
					echo -e ""
					echo -e "${RESET}${DEFAULTBLUE}Default Blue....................(1)"
					echo -e "${RESET}${DESERT}Desert Sands....................(2)"
					echo -e "${RESET}${FOREST}Forest Green....................(3)"
					echo -e "${RESET}${CLASSICBLACK}$CLASSICBLACKBW"
					echo -e "${RESET}$APPLECHIP"
					echo -e ""
					echo -e "${RESET}${TITLE}Current color:${APP} $SETTINGCOLOR"
					echo -e "${PROMPTSTYLE}"
					echo -n "Enter your option here... "
					read -n 1 input
					if [[ $input == '1' ]]; then
						COLORBLUE
					elif [[ $input == '2' ]]; then
						COLORSANDS
					elif [[ $input == '3' ]]; then
						COLORFOREST
					elif [[ $input == '4' ]]; then
						COLORCLASSIC
					elif [[ $input == '5' ]]; then
						COLORM1
					elif [[ $input == 'q' || $input == 'Q' ]]; then
						break
					elif [[ $input == '' ]]; then
						WINDOWBAREND
					else
						WINDOWERROR
					fi
				done
			else
				WINDOWBAR
				echo -e "${RESET}${ERROR}${BOLD}Script name has been modified, you cannot change colors.${RESET}"
				echo -e "${PROMPTSTYLE}"
				echo -n "Press any key to return home..."
				read -n 1
			fi
		else
			if [[ -e "$SCRIPTPATHMAIN/macOS Creator.command" ]]; then
				while true; do
					WINDOWBAR
					echo -e "${RESET}${TITLE}${BOLD}Choose the color style you like:"
					echo -e ""
					echo -e "${RESET}${DEFAULTBLUE}Default Blue....................(1)"
					echo -e "${RESET}${DESERT}Desert Sands....................(2)"
					echo -e "${RESET}${FOREST}Forest Green....................(3)"
					echo -e "${RESET}${CLASSICBLACK}$CLASSICBLACKBW"
					echo -e ""
					echo -e "${RESET}${TITLE}Current color:${APP} $SETTINGCOLOR"
					echo -e "${PROMPTSTYLE}"
					echo -n "Enter your option here... "
					read -n 1 input
					if [[ $input == '1' ]]; then
						COLORBLUE
					elif [[ $input == '2' ]]; then
						COLORSANDS
					elif [[ $input == '3' ]]; then
						COLORFOREST
					elif [[ $input == '4' ]]; then
						COLORCLASSIC
					elif [[ $input == 'q' || $input == 'Q' ]]; then
						break
					elif [[ $input == '' ]]; then
						WINDOWBAREND
					else
						WINDOWERROR
					fi
				done
			else
				WINDOWBAR
				echo -e "${RESET}${ERROR}${BOLD}Script name has been modified, you cannot change colors.${RESET}"
				echo -e "${PROMPTSTYLE}"
				echo -n "Press any key to return home..."
				read -n 1
			fi
		fi
	fi
}
COLORBLUE()
{
	cd "$SCRIPTPATHMAIN"
	sed -i '' '71s/"38;5;130m/"38;5;23m/' macOS\ Creator.command && sed -i '' '71s/"38;5;0m/"38;5;23m/' macOS\ Creator.command && sed -i '' '71s/"38;5;22m/"38;5;23m/' macOS\ Creator.command
	sed -i '' '72s/"38;5;172m/"38;5;24m/' macOS\ Creator.command && sed -i '' '72s/"38;5;0m/"38;5;24m/' macOS\ Creator.command && sed -i '' '72s/"38;5;65m/"38;5;24m/' macOS\ Creator.command
	sed -i '' '73s/"38;5;130m/"38;5;23m/' macOS\ Creator.command && sed -i '' '73s/"38;5;0m/"38;5;23m/' macOS\ Creator.command && sed -i '' '73s/"38;5;22m/"38;5;23m/' macOS\ Creator.command
	sed -i '' '74s/"38;5;208m/"38;5;65m/' macOS\ Creator.command && sed -i '' '74s/"38;5;0m/"38;5;65m/' macOS\ Creator.command && sed -i '' '74s/"38;5;58m/"38;5;65m/' macOS\ Creator.command
	sed -i '' '75s/"38;5;166m/"38;5;67m/' macOS\ Creator.command && sed -i '' '75s/"38;5;0m/"38;5;67m/' macOS\ Creator.command && sed -i '' '75s/"38;5;64m/"38;5;67m/' macOS\ Creator.command
	sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;0m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;0m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command
	sed -i '' '78s/"38;5;1m/"38;5;132m/' macOS\ Creator.command && sed -i '' '78s/"38;5;0m/"38;5;132m/' macOS\ Creator.command && sed -i '' '78s/"38;5;88m/"38;5;132m/' macOS\ Creator.command
	sed -i '' '84s/"38;5;180m/"38;5;158m/' macOS\ Creator.command && sed -i '' '84s/"38;5;255m/"38;5;158m/' macOS\ Creator.command && sed -i '' '84s/"38;5;108m/"38;5;158m/' macOS\ Creator.command && sed -i '' '84s/"38;5;185m/"38;5;158m/' macOS\ Creator.command
	sed -i '' '85s/"38;5;215m/"38;5;153m/' macOS\ Creator.command && sed -i '' '85s/"38;5;255m/"38;5;153m/' macOS\ Creator.command && sed -i '' '85s/"38;5;193m/"38;5;153m/' macOS\ Creator.command && sed -i '' '85s/"38;5;209m/"38;5;153m/' macOS\ Creator.command
	sed -i '' '86s/"38;5;180m/"38;5;158m/' macOS\ Creator.command && sed -i '' '86s/"38;5;255m/"38;5;158m/' macOS\ Creator.command && sed -i '' '86s/"38;5;108m/"38;5;158m/' macOS\ Creator.command && sed -i '' '86s/"38;5;201m/"38;5;158m/' macOS\ Creator.command
	sed -i '' '87s/"38;5;208m/"38;5;150m/' macOS\ Creator.command && sed -i '' '87s/"38;5;255m/"38;5;150m/' macOS\ Creator.command && sed -i '' '87s/"38;5;150m/"38;5;150m/' macOS\ Creator.command && sed -i '' '87s/"38;5;123m/"38;5;150m/' macOS\ Creator.command
	sed -i '' '88s/"38;5;166m/"38;5;111m/' macOS\ Creator.command && sed -i '' '88s/"38;5;255m/"38;5;111m/' macOS\ Creator.command && sed -i '' '88s/"38;5;194m/"38;5;111m/' macOS\ Creator.command && sed -i '' '88s/"38;5;156m/"38;5;111m/' macOS\ Creator.command
	sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;255m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;106m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;106m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;255m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command
	sed -i '' '91s/"38;5;197m/"38;5;175m/' macOS\ Creator.command && sed -i '' '91s/"38;5;255m/"38;5;175m/' macOS\ Creator.command && sed -i '' '91s/"38;5;187m/"38;5;175m/' macOS\ Creator.command && sed -i '' '91s/"38;5;135m/"38;5;175m/' macOS\ Creator.command
	sed -i '' '95s/"38;5;130m/"38;5;23m/' macOS\ Creator.command && sed -i '' '95s/"38;5;0m/"38;5;23m/' macOS\ Creator.command && sed -i '' '95s/"38;5;22m/"38;5;23m/' macOS\ Creator.command && sed -i '' '95s/"38;5;214m/"38;5;23m/' macOS\ Creator.command
	sed -i '' '96s/"38;5;172m/"38;5;24m/' macOS\ Creator.command && sed -i '' '96s/"38;5;0m/"38;5;24m/' macOS\ Creator.command && sed -i '' '96s/"38;5;65m/"38;5;24m/' macOS\ Creator.command && sed -i '' '96s/"38;5;209m/"38;5;24m/' macOS\ Creator.command
	sed -i '' '97s/"38;5;130m/"38;5;23m/' macOS\ Creator.command && sed -i '' '97s/"38;5;0m/"38;5;23m/' macOS\ Creator.command && sed -i '' '97s/"38;5;22m/"38;5;23m/' macOS\ Creator.command && sed -i '' '97s/"38;5;163m/"38;5;23m/' macOS\ Creator.command
	sed -i '' '98s/"38;5;208m/"38;5;65m/' macOS\ Creator.command && sed -i '' '98s/"38;5;0m/"38;5;65m/' macOS\ Creator.command && sed -i '' '98s/"38;5;58m/"38;5;65m/' macOS\ Creator.command && sed -i '' '98s/"38;5;38m/"38;5;65m/' macOS\ Creator.command
	sed -i '' '99s/"38;5;166m/"38;5;67m/' macOS\ Creator.command && sed -i '' '99s/"38;5;0m/"38;5;67m/' macOS\ Creator.command && sed -i '' '99s/"38;5;64m/"38;5;67m/' macOS\ Creator.command && sed -i '' '99s/"38;5;34m/"38;5;67m/' macOS\ Creator.command
	sed -i '' '100s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '100s/"38;5;0m/"38;5;160m/' macOS\ Creator.command && sed -i '' '100s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '100s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '101s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '101s/"38;5;0m/"38;5;9m/' macOS\ Creator.command && sed -i '' '101s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '101s/"38;5;9m/"38;5;9m/' macOS\ Creator.command
	sed -i '' '102s/"38;5;1m/"38;5;132m/' macOS\ Creator.command && sed -i '' '102s/"38;5;0m/"38;5;132m/' macOS\ Creator.command && sed -i '' '102s/"38;5;88m/"38;5;132m/' macOS\ Creator.command && sed -i '' '102s/"38;5;55m/"38;5;132m/' macOS\ Creator.command
	"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
}
COLORSANDS()
{
	cd "$SCRIPTPATHMAIN"
	sed -i '' '71s/"38;5;23m/"38;5;130m/' macOS\ Creator.command && sed -i '' '71s/"38;5;0m/"38;5;130m/' macOS\ Creator.command && sed -i '' '71s/"38;5;22m/"38;5;130m/' macOS\ Creator.command
	sed -i '' '72s/"38;5;24m/"38;5;172m/' macOS\ Creator.command && sed -i '' '72s/"38;5;0m/"38;5;172m/' macOS\ Creator.command && sed -i '' '72s/"38;5;65m/"38;5;172m/' macOS\ Creator.command
	sed -i '' '73s/"38;5;23m/"38;5;130m/' macOS\ Creator.command && sed -i '' '73s/"38;5;0m/"38;5;130m/' macOS\ Creator.command && sed -i '' '73s/"38;5;22m/"38;5;130m/' macOS\ Creator.command
	sed -i '' '74s/"38;5;65m/"38;5;208m/' macOS\ Creator.command && sed -i '' '74s/"38;5;0m/"38;5;208m/' macOS\ Creator.command && sed -i '' '74s/"38;5;58m/"38;5;208m/' macOS\ Creator.command
	sed -i '' '75s/"38;5;67m/"38;5;166m/' macOS\ Creator.command && sed -i '' '75s/"38;5;0m/"38;5;166m/' macOS\ Creator.command && sed -i '' '75s/"38;5;64m/"38;5;166m/' macOS\ Creator.command
	sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;0m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;0m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command
	sed -i '' '78s/"38;5;132m/"38;5;1m/' macOS\ Creator.command && sed -i '' '78s/"38;5;0m/"38;5;1m/' macOS\ Creator.command && sed -i '' '78s/"38;5;88m/"38;5;1m/' macOS\ Creator.command
	sed -i '' '84s/"38;5;158m/"38;5;180m/' macOS\ Creator.command && sed -i '' '84s/"38;5;255m/"38;5;180m/' macOS\ Creator.command && sed -i '' '84s/"38;5;108m/"38;5;180m/' macOS\ Creator.command && sed -i '' '84s/"38;5;185m/"38;5;180m/' macOS\ Creator.command
	sed -i '' '85s/"38;5;153m/"38;5;215m/' macOS\ Creator.command && sed -i '' '85s/"38;5;255m/"38;5;215m/' macOS\ Creator.command && sed -i '' '85s/"38;5;193m/"38;5;215m/' macOS\ Creator.command && sed -i '' '85s/"38;5;209m/"38;5;215m/' macOS\ Creator.command
	sed -i '' '86s/"38;5;158m/"38;5;180m/' macOS\ Creator.command && sed -i '' '86s/"38;5;255m/"38;5;180m/' macOS\ Creator.command && sed -i '' '86s/"38;5;108m/"38;5;180m/' macOS\ Creator.command && sed -i '' '86s/"38;5;201m/"38;5;180m/' macOS\ Creator.command
	sed -i '' '87s/"38;5;150m/"38;5;208m/' macOS\ Creator.command && sed -i '' '87s/"38;5;255m/"38;5;208m/' macOS\ Creator.command && sed -i '' '87s/"38;5;150m/"38;5;208m/' macOS\ Creator.command && sed -i '' '87s/"38;5;123m/"38;5;208m/' macOS\ Creator.command
	sed -i '' '88s/"38;5;111m/"38;5;166m/' macOS\ Creator.command && sed -i '' '88s/"38;5;255m/"38;5;166m/' macOS\ Creator.command && sed -i '' '88s/"38;5;194m/"38;5;166m/' macOS\ Creator.command && sed -i '' '88s/"38;5;156m/"38;5;166m/' macOS\ Creator.command
	sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;255m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;106m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;106m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;255m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command
	sed -i '' '91s/"38;5;175m/"38;5;197m/' macOS\ Creator.command && sed -i '' '91s/"38;5;255m/"38;5;197m/' macOS\ Creator.command && sed -i '' '91s/"38;5;187m/"38;5;197m/' macOS\ Creator.command && sed -i '' '91s/"38;5;135m/"38;5;197m/' macOS\ Creator.command
	sed -i '' '95s/"38;5;23m/"38;5;130m/' macOS\ Creator.command && sed -i '' '95s/"38;5;0m/"38;5;130m/' macOS\ Creator.command && sed -i '' '95s/"38;5;22m/"38;5;130m/' macOS\ Creator.command && sed -i '' '95s/"38;5;214m/"38;5;130m/' macOS\ Creator.command
	sed -i '' '96s/"38;5;24m/"38;5;172m/' macOS\ Creator.command && sed -i '' '96s/"38;5;0m/"38;5;172m/' macOS\ Creator.command && sed -i '' '96s/"38;5;65m/"38;5;172m/' macOS\ Creator.command && sed -i '' '96s/"38;5;209m/"38;5;172m/' macOS\ Creator.command
	sed -i '' '97s/"38;5;23m/"38;5;130m/' macOS\ Creator.command && sed -i '' '97s/"38;5;0m/"38;5;130m/' macOS\ Creator.command && sed -i '' '97s/"38;5;22m/"38;5;130m/' macOS\ Creator.command && sed -i '' '97s/"38;5;163m/"38;5;130m/' macOS\ Creator.command
	sed -i '' '98s/"38;5;65m/"38;5;208m/' macOS\ Creator.command && sed -i '' '98s/"38;5;0m/"38;5;208m/' macOS\ Creator.command && sed -i '' '98s/"38;5;58m/"38;5;208m/' macOS\ Creator.command && sed -i '' '98s/"38;5;38m/"38;5;208m/' macOS\ Creator.command
	sed -i '' '99s/"38;5;67m/"38;5;166m/' macOS\ Creator.command && sed -i '' '99s/"38;5;0m/"38;5;166m/' macOS\ Creator.command && sed -i '' '99s/"38;5;64m/"38;5;166m/' macOS\ Creator.command && sed -i '' '99s/"38;5;34m/"38;5;166m/' macOS\ Creator.command
	sed -i '' '100s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '100s/"38;5;0m/"38;5;160m/' macOS\ Creator.command && sed -i '' '100s/"160;5;0m/"38;5;160m/' macOS\ Creator.command && sed -i '' '100s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '101s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '101s/"38;5;0m/"38;5;9m/' macOS\ Creator.command && sed -i '' '101s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '101s/"38;5;9m/"38;5;9m/' macOS\ Creator.command
	sed -i '' '102s/"38;5;132m/"38;5;1m/' macOS\ Creator.command && sed -i '' '102s/"38;5;0m/"38;5;1m/' macOS\ Creator.command && sed -i '' '102s/"38;5;88m/"38;5;1m/' macOS\ Creator.command && sed -i '' '102s/"38;5;55m/"38;5;1m/' macOS\ Creator.command
	"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
}
COLORFOREST()
{
	cd "$SCRIPTPATHMAIN"
	sed -i '' '71s/"38;5;130m/"38;5;22m/' macOS\ Creator.command && sed -i '' '71s/"38;5;0m/"38;5;22m/' macOS\ Creator.command && sed -i '' '71s/"38;5;23m/"38;5;22m/' macOS\ Creator.command
	sed -i '' '72s/"38;5;172m/"38;5;65m/' macOS\ Creator.command && sed -i '' '72s/"38;5;0m/"38;5;65m/' macOS\ Creator.command && sed -i '' '72s/"38;5;24m/"38;5;65m/' macOS\ Creator.command
	sed -i '' '73s/"38;5;130m/"38;5;22m/' macOS\ Creator.command && sed -i '' '73s/"38;5;0m/"38;5;22m/' macOS\ Creator.command && sed -i '' '73s/"38;5;23m/"38;5;22m/' macOS\ Creator.command
	sed -i '' '74s/"38;5;208m/"38;5;58m/' macOS\ Creator.command && sed -i '' '74s/"38;5;0m/"38;5;58m/' macOS\ Creator.command && sed -i '' '74s/"38;5;65m/"38;5;58m/' macOS\ Creator.command
	sed -i '' '75s/"38;5;166m/"38;5;64m/' macOS\ Creator.command && sed -i '' '75s/"38;5;0m/"38;5;64m/' macOS\ Creator.command && sed -i '' '75s/"38;5;67m/"38;5;64m/' macOS\ Creator.command
	sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;0m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;0m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command
	sed -i '' '78s/"38;5;1m/"38;5;88m/' macOS\ Creator.command && sed -i '' '78s/"38;5;0m/"38;5;88m/' macOS\ Creator.command && sed -i '' '78s/"38;5;132m/"38;5;88m/' macOS\ Creator.command
	sed -i '' '84s/"38;5;180m/"38;5;108m/' macOS\ Creator.command && sed -i '' '84s/"38;5;255m/"38;5;108m/' macOS\ Creator.command && sed -i '' '84s/"38;5;158m/"38;5;108m/' macOS\ Creator.command && sed -i '' '84s/"38;5;185m/"38;5;108m/' macOS\ Creator.command
	sed -i '' '85s/"38;5;215m/"38;5;193m/' macOS\ Creator.command && sed -i '' '85s/"38;5;255m/"38;5;193m/' macOS\ Creator.command  && sed -i '' '85s/"38;5;153m/"38;5;193m/' macOS\ Creator.command && sed -i '' '85s/"38;5;209m/"38;5;193m/' macOS\ Creator.command
	sed -i '' '86s/"38;5;180m/"38;5;108m/' macOS\ Creator.command && sed -i '' '86s/"38;5;255m/"38;5;108m/' macOS\ Creator.command && sed -i '' '86s/"38;5;158m/"38;5;108m/' macOS\ Creator.command && sed -i '' '86s/"38;5;201m/"38;5;108m/' macOS\ Creator.command
	sed -i '' '87s/"38;5;208m/"38;5;150m/' macOS\ Creator.command && sed -i '' '87s/"38;5;255m/"38;5;150m/' macOS\ Creator.command && sed -i '' '87s/"38;5;150m/"38;5;150m/' macOS\ Creator.command && sed -i '' '87s/"38;5;123m/"38;5;150m/' macOS\ Creator.command
	sed -i '' '88s/"38;5;166m/"38;5;194m/' macOS\ Creator.command && sed -i '' '88s/"38;5;255m/"38;5;194m/' macOS\ Creator.command && sed -i '' '88s/"38;5;111m/"38;5;194m/' macOS\ Creator.command && sed -i '' '88s/"38;5;156m/"38;5;194m/' macOS\ Creator.command
	sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;255m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;106m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;255m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command
	sed -i '' '91s/"38;5;197m/"38;5;187m/' macOS\ Creator.command && sed -i '' '91s/"38;5;255m/"38;5;187m/' macOS\ Creator.command && sed -i '' '91s/"38;5;175m/"38;5;187m/' macOS\ Creator.command && sed -i '' '91s/"38;5;135m/"38;5;187m/' macOS\ Creator.command
	sed -i '' '95s/"38;5;130m/"38;5;22m/' macOS\ Creator.command && sed -i '' '95s/"38;5;0m/"38;5;22m/' macOS\ Creator.command && sed -i '' '95s/"38;5;23m/"38;5;22m/' macOS\ Creator.command && sed -i '' '95s/"38;5;214m/"38;5;22m/' macOS\ Creator.command
	sed -i '' '96s/"38;5;172m/"38;5;65m/' macOS\ Creator.command && sed -i '' '96s/"38;5;0m/"38;5;65m/' macOS\ Creator.command && sed -i '' '96s/"38;5;24m/"38;5;65m/' macOS\ Creator.command && sed -i '' '96s/"38;5;209m/"38;5;65m/' macOS\ Creator.command
	sed -i '' '97s/"38;5;130m/"38;5;22m/' macOS\ Creator.command && sed -i '' '97s/"38;5;0m/"38;5;22m/' macOS\ Creator.command && sed -i '' '97s/"38;5;23m/"38;5;22m/' macOS\ Creator.command && sed -i '' '97s/"38;5;163m/"38;5;22m/' macOS\ Creator.command
	sed -i '' '98s/"38;5;208m/"38;5;58m/' macOS\ Creator.command && sed -i '' '98s/"38;5;0m/"38;5;58m/' macOS\ Creator.command && sed -i '' '98s/"38;5;65m/"38;5;58m/' macOS\ Creator.command && sed -i '' '98s/"38;5;38m/"38;5;58m/' macOS\ Creator.command
	sed -i '' '99s/"38;5;166m/"38;5;64m/' macOS\ Creator.command && sed -i '' '99s/"38;5;0m/"38;5;64m/' macOS\ Creator.command && sed -i '' '99s/"38;5;67m/"38;5;64m/' macOS\ Creator.command && sed -i '' '99s/"38;5;34m/"38;5;64m/' macOS\ Creator.command
	sed -i '' '100s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '100s/"38;5;0m/"38;5;160m/' macOS\ Creator.command && sed -i '' '100s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '100s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '101s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '101s/"38;5;0m/"38;5;9m/' macOS\ Creator.command && sed -i '' '101s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '101s/"38;5;9m/"38;5;9m/' macOS\ Creator.command
	sed -i '' '102s/"38;5;1m/"38;5;88m/' macOS\ Creator.command && sed -i '' '102s/"38;5;0m/"38;5;88m/' macOS\ Creator.command && sed -i '' '102s/"38;5;132m/"38;5;88m/' macOS\ Creator.command && sed -i '' '102s/"38;5;55m/"38;5;88m/' macOS\ Creator.command
	"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
}
COLORCLASSIC()
{
	cd "$SCRIPTPATHMAIN"
	sed -i '' '71s/"38;5;23m/"38;5;0m/' macOS\ Creator.command && sed -i '' '71s/"38;5;130m/"38;5;0m/' macOS\ Creator.command && sed -i '' '71s/"38;5;22m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '72s/"38;5;24m/"38;5;0m/' macOS\ Creator.command && sed -i '' '72s/"38;5;172m/"38;5;0m/' macOS\ Creator.command && sed -i '' '72s/"38;5;65m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '73s/"38;5;23m/"38;5;0m/' macOS\ Creator.command && sed -i '' '73s/"38;5;130m/"38;5;0m/' macOS\ Creator.command && sed -i '' '73s/"38;5;22m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '74s/"38;5;65m/"38;5;0m/' macOS\ Creator.command && sed -i '' '74s/"38;5;208m/"38;5;0m/' macOS\ Creator.command && sed -i '' '74s/"38;5;58m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '75s/"38;5;67m/"38;5;0m/' macOS\ Creator.command && sed -i '' '75s/"38;5;166m/"38;5;0m/' macOS\ Creator.command && sed -i '' '75s/"38;5;64m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '76s/"38;5;160m/"38;5;0m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;0m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '77s/"38;5;9m/"38;5;0m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;0m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '78s/"38;5;132m/"38;5;0m/' macOS\ Creator.command && sed -i '' '78s/"38;5;1m/"38;5;0m/' macOS\ Creator.command && sed -i '' '78s/"38;5;88m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '84s/"38;5;158m/"38;5;255m/' macOS\ Creator.command && sed -i '' '84s/"38;5;180m/"38;5;255m/' macOS\ Creator.command && sed -i '' '84s/"38;5;108m/"38;5;255m/' macOS\ Creator.command && sed -i '' '84s/"38;5;185m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '85s/"38;5;153m/"38;5;255m/' macOS\ Creator.command && sed -i '' '85s/"38;5;215m/"38;5;255m/' macOS\ Creator.command && sed -i '' '85s/"38;5;193m/"38;5;255m/' macOS\ Creator.command && sed -i '' '85s/"38;5;209m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '86s/"38;5;158m/"38;5;255m/' macOS\ Creator.command && sed -i '' '86s/"38;5;180m/"38;5;255m/' macOS\ Creator.command && sed -i '' '86s/"38;5;108m/"38;5;255m/' macOS\ Creator.command && sed -i '' '86s/"38;5;201m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '87s/"38;5;150m/"38;5;255m/' macOS\ Creator.command && sed -i '' '87s/"38;5;208m/"38;5;255m/' macOS\ Creator.command && sed -i '' '87s/"38;5;150m/"38;5;255m/' macOS\ Creator.command && sed -i '' '87s/"38;5;123m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '88s/"38;5;111m/"38;5;255m/' macOS\ Creator.command && sed -i '' '88s/"38;5;166m/"38;5;255m/' macOS\ Creator.command && sed -i '' '88s/"38;5;194m/"38;5;255m/' macOS\ Creator.command && sed -i '' '88s/"38;5;156m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '89s/"38;5;160m/"38;5;255m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;255m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;255m/' macOS\ Creator.command && sed -i '' '89s/"38;5;106m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '90s/"38;5;196m/"38;5;255m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;255m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;255m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '91s/"38;5;175m/"38;5;255m/' macOS\ Creator.command && sed -i '' '91s/"38;5;197m/"38;5;255m/' macOS\ Creator.command && sed -i '' '91s/"38;5;187m/"38;5;255m/' macOS\ Creator.command && sed -i '' '91s/"38;5;135m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '95s/"38;5;23m/"38;5;0m/' macOS\ Creator.command && sed -i '' '95s/"38;5;130m/"38;5;0m/' macOS\ Creator.command && sed -i '' '95s/"38;5;22m/"38;5;0m/' macOS\ Creator.command && sed -i '' '95s/"38;5;214m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '96s/"38;5;24m/"38;5;0m/' macOS\ Creator.command && sed -i '' '96s/"38;5;172m/"38;5;0m/' macOS\ Creator.command && sed -i '' '96s/"38;5;65m/"38;5;0m/' macOS\ Creator.command && sed -i '' '96s/"38;5;209m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '97s/"38;5;23m/"38;5;0m/' macOS\ Creator.command && sed -i '' '97s/"38;5;130m/"38;5;0m/' macOS\ Creator.command && sed -i '' '97s/"38;5;22m/"38;5;0m/' macOS\ Creator.command && sed -i '' '97s/"38;5;163m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '98s/"38;5;65m/"38;5;0m/' macOS\ Creator.command && sed -i '' '98s/"38;5;208m/"38;5;0m/' macOS\ Creator.command && sed -i '' '98s/"38;5;58m/"38;5;0m/' macOS\ Creator.command && sed -i '' '98s/"38;5;38m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '99s/"38;5;67m/"38;5;0m/' macOS\ Creator.command && sed -i '' '99s/"38;5;166m/"38;5;0m/' macOS\ Creator.command && sed -i '' '99s/"38;5;64m/"38;5;0m/' macOS\ Creator.command && sed -i '' '99s/"38;5;34m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '100s/"38;5;160m/"38;5;0m/' macOS\ Creator.command && sed -i '' '100s/"38;5;160m/"38;5;0m/' macOS\ Creator.command && sed -i '' '100s/"38;5;160m/"38;5;0m/' macOS\ Creator.command && sed -i '' '100s/"38;5;160m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '101s/"38;5;9m/"38;5;0m/' macOS\ Creator.command && sed -i '' '101s/"38;5;9m/"38;5;0m/' macOS\ Creator.command && sed -i '' '101s/"38;5;9m/"38;5;0m/' macOS\ Creator.command && sed -i '' '101s/"38;5;9m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '102s/"38;5;132m/"38;5;0m/' macOS\ Creator.command && sed -i '' '102s/"38;5;1m/"38;5;0m/' macOS\ Creator.command && sed -i '' '102s/"38;5;88m/"38;5;0m/' macOS\ Creator.command && sed -i '' '102s/"38;5;55m/"38;5;0m/' macOS\ Creator.command
	"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
}
COLORM1()
{
	cd "$SCRIPTPATHMAIN"
	sed -i '' '71s/"38;5;23m/"38;5;0m/' macOS\ Creator.command && sed -i '' '71s/"38;5;130m/"38;5;0m/' macOS\ Creator.command && sed -i '' '71s/"38;5;22m/"38;5;0m/' macOS\ Creator.command && sed -i '' '71s/"38;5;0m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '72s/"38;5;24m/"38;5;0m/' macOS\ Creator.command && sed -i '' '72s/"38;5;172m/"38;5;0m/' macOS\ Creator.command && sed -i '' '72s/"38;5;65m/"38;5;0m/' macOS\ Creator.command && sed -i '' '72s/"38;5;0m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '73s/"38;5;23m/"38;5;0m/' macOS\ Creator.command && sed -i '' '73s/"38;5;130m/"38;5;0m/' macOS\ Creator.command && sed -i '' '73s/"38;5;22m/"38;5;0m/' macOS\ Creator.command && sed -i '' '73s/"38;5;0m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '74s/"38;5;65m/"38;5;0m/' macOS\ Creator.command && sed -i '' '74s/"38;5;208m/"38;5;0m/' macOS\ Creator.command && sed -i '' '74s/"38;5;58m/"38;5;0m/' macOS\ Creator.command && sed -i '' '74s/"38;5;0m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '75s/"38;5;67m/"38;5;0m/' macOS\ Creator.command && sed -i '' '75s/"38;5;166m/"38;5;0m/' macOS\ Creator.command && sed -i '' '75s/"38;5;64m/"38;5;0m/' macOS\ Creator.command && sed -i '' '75s/"38;5;0m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '76s/"38;5;160m/"38;5;0m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;0m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;0m/' macOS\ Creator.command && sed -i '' '76s/"38;5;0m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '77s/"38;5;9m/"38;5;0m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;0m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;0m/' macOS\ Creator.command && sed -i '' '77s/"38;5;0m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '78s/"38;5;132m/"38;5;0m/' macOS\ Creator.command && sed -i '' '78s/"38;5;1m/"38;5;0m/' macOS\ Creator.command && sed -i '' '78s/"38;5;88m/"38;5;0m/' macOS\ Creator.command && sed -i '' '78s/"38;5;0m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '84s/"38;5;158m/"38;5;185m/' macOS\ Creator.command && sed -i '' '84s/"38;5;180m/"38;5;185m/' macOS\ Creator.command && sed -i '' '84s/"38;5;108m/"38;5;185m/' macOS\ Creator.command && sed -i '' '84s/"38;5;255m/"38;5;185m/' macOS\ Creator.command
	sed -i '' '85s/"38;5;153m/"38;5;209m/' macOS\ Creator.command && sed -i '' '85s/"38;5;215m/"38;5;209m/' macOS\ Creator.command && sed -i '' '85s/"38;5;193m/"38;5;209m/' macOS\ Creator.command && sed -i '' '85s/"38;5;255m/"38;5;209m/' macOS\ Creator.command
	sed -i '' '86s/"38;5;158m/"38;5;201m/' macOS\ Creator.command && sed -i '' '86s/"38;5;180m/"38;5;201m/' macOS\ Creator.command && sed -i '' '86s/"38;5;108m/"38;5;201m/' macOS\ Creator.command && sed -i '' '86s/"38;5;255m/"38;5;201m/' macOS\ Creator.command
	sed -i '' '87s/"38;5;150m/"38;5;123m/' macOS\ Creator.command && sed -i '' '87s/"38;5;208m/"38;5;123m/' macOS\ Creator.command && sed -i '' '87s/"38;5;150m/"38;5;123m/' macOS\ Creator.command && sed -i '' '87s/"38;5;255m/"38;5;123m/' macOS\ Creator.command
	sed -i '' '88s/"38;5;111m/"38;5;156m/' macOS\ Creator.command && sed -i '' '88s/"38;5;166m/"38;5;156m/' macOS\ Creator.command && sed -i '' '88s/"38;5;194m/"38;5;156m/' macOS\ Creator.command && sed -i '' '88s/"38;5;255m/"38;5;156m/' macOS\ Creator.command
	sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;255m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;255m/"38;5;196m/' macOS\ Creator.command
	sed -i '' '91s/"38;5;175m/"38;5;135m/' macOS\ Creator.command && sed -i '' '91s/"38;5;197m/"38;5;135m/' macOS\ Creator.command && sed -i '' '91s/"38;5;187m/"38;5;135m/' macOS\ Creator.command && sed -i '' '91s/"38;5;255m/"38;5;135m/' macOS\ Creator.command
	sed -i '' '95s/"38;5;23m/"38;5;214m/' macOS\ Creator.command && sed -i '' '95s/"38;5;130m/"38;5;214m/' macOS\ Creator.command && sed -i '' '95s/"38;5;22m/"38;5;214m/' macOS\ Creator.command && sed -i '' '95s/"38;5;0m/"38;5;214m/' macOS\ Creator.command
	sed -i '' '96s/"38;5;24m/"38;5;209m/' macOS\ Creator.command && sed -i '' '96s/"38;5;172m/"38;5;209m/' macOS\ Creator.command && sed -i '' '96s/"38;5;65m/"38;5;209m/' macOS\ Creator.command && sed -i '' '96s/"38;5;0m/"38;5;209m/' macOS\ Creator.command
	sed -i '' '97s/"38;5;23m/"38;5;163m/' macOS\ Creator.command && sed -i '' '97s/"38;5;130m/"38;5;163m/' macOS\ Creator.command && sed -i '' '97s/"38;5;22m/"38;5;163m/' macOS\ Creator.command && sed -i '' '97s/"38;5;0m/"38;5;163m/' macOS\ Creator.command
	sed -i '' '98s/"38;5;65m/"38;5;38m/' macOS\ Creator.command && sed -i '' '98s/"38;5;208m/"38;5;38m/' macOS\ Creator.command && sed -i '' '98s/"38;5;58m/"38;5;38m/' macOS\ Creator.command && sed -i '' '98s/"38;5;0m/"38;5;38m/' macOS\ Creator.command
	sed -i '' '99s/"38;5;67m/"38;5;34m/' macOS\ Creator.command && sed -i '' '99s/"38;5;166m/"38;5;34m/' macOS\ Creator.command && sed -i '' '99s/"38;5;64m/"38;5;34m/' macOS\ Creator.command && sed -i '' '99s/"38;5;0m/"38;5;34m/' macOS\ Creator.command
	sed -i '' '100s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '100s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '100s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '100s/"38;5;0m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '101s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '101s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '101s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '101s/"38;5;0m/"38;5;9m/' macOS\ Creator.command
	sed -i '' '102s/"38;5;132m/"38;5;55m/' macOS\ Creator.command && sed -i '' '102s/"38;5;1m/"38;5;55m/' macOS\ Creator.command && sed -i '' '102s/"38;5;88m/"38;5;55m/' macOS\ Creator.command && sed -i '' '102s/"38;5;0m/"38;5;55m/' macOS\ Creator.command
	"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
}

#BETA Builds
IDMAC()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${WARNING}${BOLD}WARNING: This is a BETA build!"
		echo -e "${RESET}${WARNING}BETA builds may not work as expected."
		echo -e "${RESET}${TITLE}You can use this tool to identify this Mac or another one"
		echo -e "Use this tool to determine lastest macOS Version compatible for the Mac."
		echo -e "${RESET}${PROMPTSTYLE}"
		echo -n "Do you wish to continue?... "
		read -n 1 prompt
		if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
			while true; do
			WINDOWBAR
			echo -e "${RESET}${TITLE}What would you like to do?"
			echo -e "${BODY}Identify this Mac........................................................(1)"
			echo -e "${BODY}Identify another Mac.....................................................(2)"
			echo -e "${RESET}${PROMPTSTYLE}"
			echo -n "Enter your option here... "
			read -n 1 prompt
			if [[ "$prompt" == '1' ]]; then
				if [[ $MACVERSION == 'MacBook5,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (13-inch, Aluminum, Late 2008)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBook5,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (13-inch, Early 2009) + (13-inch, Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBook6,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (13-inch, Late 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBook7,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (13-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBook8,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (Retina, 12-inch, Early 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBook9,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (Retina, 12-inch, Early 2016)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBook10,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (Retina, 12-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir1,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Original)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}Mac OS X Lion ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir2,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir3,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Late 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir3,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Late 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir4,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir4,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir5,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir5,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir6,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Mid 2013) + (11-inch, Early 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir6,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Mid 2013) + (13-inch, Early 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir7,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Early 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir7,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Early 2015) + MacBook Air (13-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir8,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Retina, 13-inch, 2018)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sonoma ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir8,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Retina, 13-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sonoma ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir9,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Retina, 13-inch, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookAir10,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (M1, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac14,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (M2, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac14,15' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (15-inch, M2, 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac15,12' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, M3, 2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac15,13' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (15-inch, M3, 2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro4,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch/17-inch, Early 2008)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro5,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Late 2008)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro5,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (17-inch, Early/Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro5,5' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro5,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro7,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro6,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro6,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (17-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro8,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, Early/Late 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro8,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Early/Late 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro8,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (17-inch, Early/Late 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro9,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro9,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro10,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 15-inch, Mid 2012/Early 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro10,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 13-inch, Late 2012/Early 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro11,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 13-inch, Late 2013/Mid 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro11,2' || $MACVERSION == 'MacBookPro11,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 15-inch, Late 2013/Mid 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro12,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 13-inch, Early 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro11,4' || $MACVERSION == 'MacBookPro11,5' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 15-inch, Mid 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro13,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2016, Two Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro13,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2016, Four Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro13,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, 2016)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro14,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2017, Two Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro14,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2017, Four Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro14,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro15,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2018/2019, Four Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro15,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, 2018)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro15,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro15,4' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2019, Two Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro16,1' || $MACVERSION == 'MacBookPro16,4' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro16,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro16,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2020, Two Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro17,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, M1, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro18,1' || $MACVERSION == 'MacBookPro18,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, 2021)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacBookPro18,3' || $MACVERSION == 'MacBookPro18,4' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (14-inch, 2021)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac14,7' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, M2, 2022)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac14,6' || $MACVERSION == 'Mac14,10' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac14,5' || $MACVERSION == 'Mac14,9' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (14-inch, 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac15,7' || $MACVERSION == 'Mac15,9' || $MACVERSION == 'Mac15,11' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, Nov 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac15,6' || $MACVERSION == 'Mac15,8' || $MACVERSION == 'Mac15,10' || $MACVERSION == 'Mac15,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (14-inch, Nov 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac16,7' || $MACVERSION == 'Mac16,5' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, 2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac16,6' || $MACVERSION == 'Mac16,8' || $MACVERSION == 'Mac16,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (14-inch, 2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac9,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Early 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac10,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Late 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac11,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac11,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (27-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac12,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac12,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (27-inch, Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac13,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Late 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac13,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (27-inch, Late 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac14,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Late 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac14,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (27-inch, Late 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac14,4' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Mid 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac15,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, Late 2014/Mid 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac16,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Late 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac16,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 4K, 21.5-inch, Late 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac17,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, Late 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac18,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac18,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 4K, 21.5-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac18,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMacPro1,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac Pro (2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac19,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 4K, 21.5-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac19,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac20,1' || $MACVERSION == 'iMac20,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'iMac21,2' || $MACVERSION == 'iMac21,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, M1, 2021)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac15,4' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, 2023, Two ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac15,5' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, 2023, Four ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac16,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, 2024, Two ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac16,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, 2024, Four ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Macmini3,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Early/Late 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Macmini4,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Macmini5,1' || $MACVERSION == 'Macmini5,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Macmini6,1' || $MACVERSION == 'Macmini6,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Late 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Macmini7,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Late 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Macmini8,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (2018)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Macmini9,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (M1, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac14,12' || $MACVERSION == 'Mac14,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac16,15' || $MACVERSION == 'Mac16,10' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				
				elif [[ $MACVERSION == 'MacPro4,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (Early 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacPro5,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (Server) (Mid 2010/Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${TITLE}If you have a Metal Graphics card: ${BOLD}macOS Mojave ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacPro6,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (Late 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'MacPro7,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				elif [[ $MACVERSION == 'Mac14,8' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				else 
					WINDOWBAR
					echo -e "${RESET}${ERROR}Cannot detect Mac model."
					if [[ $safe == '1' ]]; then
						echo -e "You are running in Safe Mode"
					else
						echo -e "You may have a model that is not compatible with this script..."
					fi
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Press any key to return home... "
					read -n 1 prompt
					if [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						break 2
					fi
				fi
			elif [[ "$prompt" == '2' ]]; then
				while true; do
				WINDOWBAR
				echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
				echo -e "${BODY}Laptop...................................................................(1)"
				echo -e "Desktop..................................................................(2)"
				echo -e "${RESET}${PROMPTSTYLE}"
				echo -n "Enter your option here... "
				read -n 1 prompt
				if [[ "$prompt" == '1' ]]; then
					while true; do
					WINDOWBAR
					echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
					echo -e "${BODY}MacBook..................................................................(1)"
					echo -e "MacBook Pro..............................................................(2)"
					echo -e "MacBook Air..............................................................(3)"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Enter your option here... "
					read -n 1 prompt
					if [[ "$prompt" == '1' ]]; then
						while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}MacBook (Polycarbonate)..................................................(1)"
						echo -e "MacBook (Unibody)........................................................(2)"
						echo -e "MacBook (Retina).........................................................(3)"
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Enter your option here... "
						read -n 1 prompt
						if [[ "$prompt" == '1' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}Early 2009 / Mid 2009....................................................(1)"
							echo -e "Late 2009 / Mid 2010.....................................................(2)"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Enter your option here... "
							read -n 1 prompt
							if [[ "$prompt" == '1' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Early 2009/Mid 2009)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '2' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Late 2009/Mid 2010)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '' ]]; then
								WINDOWBAREND
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '?' ]]; then
								HELPIDMAC
							elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
								break 6
							else
								WINDOWERROR
							fi
							done
						elif [[ "$prompt" == '2' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Aluminum, Late 2008)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi
						elif [[ "$prompt" == '3' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}2015.....................................................................(1)"
							echo -e "2016.....................................................................(2)"
							echo -e "2017.....................................................................(3)"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Enter your option here... "
							read -n 1 prompt
							if [[ "$prompt" == '1' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Retina, 2015)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '2' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Retina, 2016)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '3' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Retina, 2017)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							elif [[ "$prompt" == '?' ]]; then
								HELPIDMAC
							elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
								break 6
							else
								WINDOWERROR
							fi
							done
						elif [[ "$prompt" == '?' ]]; then
							HELPIDMAC
						elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
							break 5
						elif [[ "$prompt" == '' ]]; then
							WINDOWBAREND
						else
							WINDOWERROR
						fi
						done
					elif [[ "$prompt" == '2' ]]; then
						while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}13-inch Display..........................................................(1)"
						echo -e "14-inch Display..........................................................(2)"
						echo -e "15-inch Display..........................................................(3)"
						echo -e "16-inch Display..........................................................(4)"
						echo -e "17-inch Display..........................................................(5)"
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Enter your option here... "
						read -n 1 prompt
						if [[ "$prompt" == '1' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}LCD Display..............................................................(1)"
							echo -e "Retina Display...........................................................(2)"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Enter your option here... "
							read -n 1 prompt
							if [[ "$prompt" == '1' ]]; then
								while true; do
								WINDOWBAR
								echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
								echo -e "${BODY}2009.....................................................................(1)"
								echo -e "2010-2011................................................................(2)"
								echo -e "2012.....................................................................(3)"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Enter your option here... "
								read -n 1 prompt
								if [[ "$prompt" == '1' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2009)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '2' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2010-2011)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '3' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2012)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								elif [[ "$prompt" == '?' ]]; then
									HELPIDMAC
								elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
									break 7
								else
									WINDOWERROR
								fi
								done
							elif [[ "$prompt" == '2' ]]; then
								while true; do
								WINDOWBAR
								echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
								echo -e "${BODY}2012-Early 2013..........................................................(1)"
								echo -e "Late 2013-2014...........................................................(2)"
								echo -e "2015-2016................................................................(3)"
								echo -e "2017.....................................................................(4)"
								echo -e "2018 or later............................................................(5)"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Enter your option here... "
								read -n 1 prompt
								if [[ "$prompt" == '1' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2012-2013)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '2' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2013-2014)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '3' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2015-2016)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '4' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2017)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '5' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2018 or later)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								elif [[ "$prompt" == '?' ]]; then
									HELPIDMAC
								elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
									break 7
								else
									WINDOWERROR
								fi
								done
							elif [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							elif [[ "$prompt" == '?' ]]; then
								HELPIDMAC
							elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
								break 6
							else
								WINDOWERROR
							fi
							done
						elif [[ "$prompt" == '2' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro 14-inch"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi								
						elif [[ "$prompt" == '3' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}LCD Display..............................................................(1)"
							echo -e "Retina Display...........................................................(2)"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Enter your option here... "
							read -n 1 prompt
							if [[ "$prompt" == '1' ]]; then
								while true; do
								WINDOWBAR
								echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
								echo -e "${BODY}2008-2009................................................................(1)"
								echo -e "2010-2011................................................................(2)"
								echo -e "2012.....................................................................(3)"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Enter your option here... "
								read -n 1 prompt
								if [[ "$prompt" == '1' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2008-2009)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '2' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2010-2011)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '3' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2012)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								elif [[ "$prompt" == '?' ]]; then
									HELPIDMAC
								elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
									break 7
								else
									WINDOWERROR
								fi
								done
							elif [[ "$prompt" == '2' ]]; then
								while true; do
								WINDOWBAR
								echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
								echo -e "${BODY}2012-Early 2013..........................................................(1)"
								echo -e "Late 2013-2014...........................................................(2)"
								echo -e "2015-2016................................................................(3)"
								echo -e "2017.....................................................................(4)"
								echo -e "2018 or later............................................................(5)"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Enter your option here... "
								read -n 1 prompt
									if [[ "$prompt" == '1' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2012-2013)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '2' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2013-2014)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '3' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2015-2016)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '4' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2017)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '5' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2018 or later)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}"
									echo -n "Press any key to return home... "
									read -n 1 prompt
									if [[ "$prompt" == '' ]]; then
										WINDOWBAREND
									else
										break 7
									fi								
								elif [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								elif [[ "$prompt" == '?' ]]; then
									HELPIDMAC
								elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
									break 7
								else
									WINDOWERROR
								fi
								done
							elif [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							elif [[ "$prompt" == '?' ]]; then
								HELPIDMAC
							elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
								break 6
							else
								WINDOWERROR
							fi
							done
						elif [[ "$prompt" == '4' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro 16-inch"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi								
						elif [[ "$prompt" == '5' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}2008-2009................................................................(1)"
							echo -e "2010-2011................................................................(2)"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Enter your option here... "
							read -n 1 prompt
							if [[ "$prompt" == '1' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2008-2009)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '2' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2010-2011)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							elif [[ "$prompt" == '?' ]]; then
								HELPIDMAC
							elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
								break 6
							else
								WINDOWERROR
							fi
							done
						elif [[ "$prompt" == '?' ]]; then
							HELPIDMAC
						elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
							break 5
						elif [[ "$prompt" == '' ]]; then
							WINDOWBAREND
						else
							WINDOWERROR
						fi
						done
					elif [[ "$prompt" == '3' ]]; then
						while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}11-inch Display..........................................................(1)"
						echo -e "13-inch Display..........................................................(2)"
						echo -e "15-inch Display..........................................................(3)"
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Enter your option here... "
						read -n 1 prompt
						if [[ "$prompt" == '1' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}2010-2011................................................................(1)"
							echo -e "2012.....................................................................(2)"
							echo -e "2013-2014................................................................(3)"
							echo -e "2015.....................................................................(4)"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Enter your option here... "
							read -n 1 prompt
							if [[ "$prompt" == '1' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2010-2011)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '2' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2012)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '3' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2013-2014)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '4' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2015)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '?' ]]; then
								HELPIDMAC
							elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
								break 6
							elif [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								WINDOWERROR
							fi
							done
						elif [[ "$prompt" == '2' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}2009.....................................................................(1)"
							echo -e "2010-2011................................................................(2)"
							echo -e "2012.....................................................................(3)"
							echo -e "2013-2014................................................................(4)"
							echo -e "2015-2017................................................................(5)"
							echo -e "2018-2019................................................................(6)"
							echo -e "2020 or later............................................................(7)"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Enter your option here... "
							read -n 1 prompt
							if [[ "$prompt" == '1' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2009)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '2' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2010-2011)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '3' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2012)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '4' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2013-2014)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '5' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2015 or 2017)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '6' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2018-2019)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sonoma ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '7' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2020 or later)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							elif [[ "$prompt" == '?' ]]; then
								HELPIDMAC
							elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
								break 6
							else
								WINDOWERROR
							fi
							done
						elif [[ "$prompt" == '3' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air 15-inch"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi
						elif [[ "$prompt" == '' ]]; then
							WINDOWBAREND
						elif [[ "$prompt" == '?' ]]; then
							HELPIDMAC
						elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
							break 5
						else
							WINDOWERROR
						fi
						done
					elif [[ "$prompt" == '?' ]]; then
						HELPIDMAC
					elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
						break 4
					elif [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					else
						WINDOWERROR
					fi
					done
				elif [[ "$prompt" == '2' ]]; then
					while true; do
					WINDOWBAR
					echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
					echo -e "${BODY}iMac.....................................................................(1)"
					echo -e "Mac Mini.................................................................(2)"
					echo -e "Mac Pro..................................................................(3)"
					echo -e "${RESET}${PROMPTSTYLE}"
					echo -n "Enter your option here... "
					read -n 1 prompt
					if [[ "$prompt" == '1' ]]; then
						while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}iMac.....................................................................(1)"
						echo -e "iMac Pro.................................................................(2)"
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Enter your option here... "
						read -n 1 prompt
						if [[ "$prompt" == '1' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}Early 2009...............................................................(1)"
							echo -e "Late 2009-2011...........................................................(2)"
							echo -e "2012-2013................................................................(3)"
							echo -e "2014-Mid 2015............................................................(4)"
							echo -e "Late 2015................................................................(5)"
							echo -e "2017.....................................................................(6)"
							echo -e "2029 or later............................................................(7)"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Enter your option here... "
							read -n 1 prompt
							if [[ "$prompt" == '1' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2009)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '2' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2009-2011)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '3' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2012-2013)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '4' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2014-2015)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '5' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2015)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '6' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2017)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '7' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2019 or later)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}"
								echo -n "Press any key to return home... "
								read -n 1 prompt
								if [[ "$prompt" == '' ]]; then
									WINDOWBAREND
								else
									break 6
								fi
							elif [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							elif [[ "$prompt" == '?' ]]; then
								HELPIDMAC
							elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
								break 6
							else
								WINDOWERROR
							fi
							done
						elif [[ "$prompt" == '2' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac Pro"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi						
						elif [[ "$prompt" == '' ]]; then
							WINDOWBAREND
						elif [[ "$prompt" == '?' ]]; then
							HELPIDMAC
						elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
							break 5
						else
							WINDOWERROR
						fi
						done
					elif [[ "$prompt" == '2' ]]; then
						while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}2009.....................................................................(1)"
						echo -e "2010.....................................................................(2)"
						echo -e "2011.....................................................................(3)"
						echo -e "2012.....................................................................(4)"
						echo -e "2014.....................................................................(5)"
						echo -e "2018 or later............................................................(6)"
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Enter your option here... "
						read -n 1 prompt
						if [[ "$prompt" == '1' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2009)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi						
						elif [[ "$prompt" == '2' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2010)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi						
						elif [[ "$prompt" == '3' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2011)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi						
						elif [[ "$prompt" == '4' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2012)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi						
						elif [[ "$prompt" == '5' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2014)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi						
						elif [[ "$prompt" == '6' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2018 or later)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi						
						elif [[ "$prompt" == '' ]]; then
							WINDOWBAREND
						elif [[ "$prompt" == '?' ]]; then
							HELPIDMAC
						elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
							break 5
						else
							WINDOWERROR
						fi
						done
					elif [[ "$prompt" == '3' ]]; then
						while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}2009.....................................................................(1)"
						echo -e "2010-2012................................................................(2)"
						echo -e "2013.....................................................................(3)"
						echo -e "2019 or later............................................................(4)"
						echo -e "${RESET}${PROMPTSTYLE}"
						echo -n "Enter your option here... "
						read -n 1 prompt
						if [[ "$prompt" == '1' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Pro (2009)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi						
						elif [[ "$prompt" == '2' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is a Mac Pro (2010 or 2012)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
							echo -e "${RESET}${TITLE}If you have a Metal Graphics card: ${BOLD}macOS Mojave ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi						
						elif [[ "$prompt" == '3' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Pro (2013)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi						
						elif [[ "$prompt" == '4' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2019 or later)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}"
							echo -n "Press any key to return home... "
							read -n 1 prompt
							if [[ "$prompt" == '' ]]; then
								WINDOWBAREND
							else
								break 5
							fi						
						elif [[ "$prompt" == '' ]]; then
							WINDOWBAREND
						elif [[ "$prompt" == '?' ]]; then
							HELPIDMAC
						elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
							break 5
						else
							WINDOWERROR
						fi
						done
					elif [[ "$prompt" == '' ]]; then
						WINDOWBAREND
					elif [[ "$prompt" == '?' ]]; then
						HELPIDMAC
					elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
						break 4
					else
						WINDOWERROR
					fi
					done
				elif [[ "$prompt" == '?' ]]; then
					HELPIDMAC
				elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
					break 3
				elif [[ "$prompt" == '' ]]; then
					WINDOWBAREND
				else
					WINDOWERROR
				fi
				done
			elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
				break 2
			elif [[ "$prompt" == '?' ]]; then
				HELPID
			elif [[ "$prompt" == '' ]]; then
				WINDOWBAREND
			else
				WINDOWERROR
			fi
			done
		elif [[ "$prompt" == '?' ]]; then
			BETAHELP
		elif [[ "$prompt" == 'q' || "$prompt" == 'Q' ]]; then
			break
		elif [[ "$prompt" == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
		done
}

#Script Layout
SCRIPTLAYOUT()
{
	if [[ "$MACOSVERSION" == 10.6 ]]; then
		clear
		echo ""
		echo "This Mac is running Mac OS X Snow Leopard"
		echo "This script requires Mac OS X Lion or later"
		echo "You can use V2.3 if you wish to use this script."
		echo ""
		echo "Press any key to cancel... "
		read -n 1
		exit
	elif [[ "$MACOSVERSION" == 10.5 ]]; then
		clear
		echo ""
		echo "This Mac is running Mac OS X Leopard"
		echo "This script requires Mac OS X Lion or later"
		echo ""
		echo "Press any key to cancel... "
		read -n 1
		exit
	else
		while true; do
			MAINMENU
			read -n 1 input
			if [[ $input == '1' ]]; then
				while true; do
					APPLICATIONSCREATE
				done
			elif [[ $input == '2' ]]; then
				MANUALCREATE
			elif [[ $input == '3' ]]; then
				DOWNLOADMACOS
			elif [[ $input == '4' ]]; then
				IDMAC
			elif [[ $input == '5' ]]; then
				TROUBLESHOOTGUIDEMAIN
			elif [[ $input == '6' ]]; then
				CHANGECOLORS
			elif [[ $input == '7' ]]; then
				CLEANUP
			elif [[ $input == '?' ]]; then
				GUIDE
			elif [[ $input == 'q' || $input == 'Q' ]]; then
				echo -e ""
			elif [[ $input == '' ]]; then
				WINDOWBAREND
			else
				WINDOWERROR
			fi
		done
	fi
}

#Script Order
if [[ $safe == "1" ]]; then
	SCRIPTLAYOUT
else
	PreRunOS
	PreRun
	SCRIPTLAYOUT
fi

#End of Script
