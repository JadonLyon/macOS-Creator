#!/bin/bash

#Welcome to the macOS Creator Script
#This is where the script code is located
#Caution: Modifying the script may cause it to break!


#Version 6.2
#Release notes:
#              V6.2 Introduces Safe Install, which allows macOS to install on Macs without verifications
#
#
#                   To see older release notes, go to Github.com




#Script


#PreRun Commands
#This step will save temporary commands that will be used later throughout the script


#Sets parameters for Verbose and Safe Modes

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
	safe="2"
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
	#Checks macOS Version
	MACOSVERSION=$(sw_vers -productVersion | cut -d '.' -f 1,2)
}

#Determines Script Path
SCRIPTPATH="${0}"

SCRIPTPATHMAIN="${0%/*}"

#Determines if script is running as application
if [[ -e "$SCRIPTPATHMAIN/.homeuser" ]]; then
	HOMEUSER="YES"
fi

LIGHTMODE()
{
	APP='\033["38;5;23m'
	TITLE='\033["38;5;24m'
	BODY='\033["38;5;23m'
	PROMPTSTYLE='\033["38;5;66m'
	OSFOUND='\033["38;5;67m'
	WARNING='\033["38;5;160m'
	ERROR='\033["38;5;9m'
	CANCEL='\033["38;5;31m'
	BOLD='\033[1m'
	RESET='\033[0m'
}
DARKMODE()
{
	APP='\033["38;5;158m'
	TITLE='\033["38;5;153m'
	BODY='\033["38;5;158m'
	PROMPTSTYLE='\033["38;5;152m'
	OSFOUND='\033["38;5;111m'
	WARNING='\033["38;5;160m'
	ERROR='\033["38;5;196m'
	CANCEL='\033["38;5;38m'
	BOLD='\033[1m'
	RESET='\033[0m'
}

PreRun()
{
	UIAPPEARANCE=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
	if [[ ! "$UIAPPEARANCE" == "Dark" ]]; then
		LIGHTMODE
	else
		if [[ "$MACOSVERSION" == 10.5 || "$MACOSVERSION" == 10.6 || "$MACOSVERSION" == 10.7 || "$MACOSVERSION" == 10.8 || "$MACOSVERSION" == 10.9 || "$MACOSVERSION" == 10.10 || "$MACOSVERSION" == 10.11 || "$MACOSVERSION" == 10.12 || "$MACOSVERSION" == 10.13 ]]; then
			LIGHTMODE
		else
			DARKMODE
		fi
	fi
	#Settings Preview
	if [[ "$MACOSVERSION" == 10.5 || "$MACOSVERSION" == 10.6 || "$MACOSVERSION" == 10.7 || "$MACOSVERSION" == 10.8 || "$MACOSVERSION" == 10.9 || "$MACOSVERSION" == 10.10 || "$MACOSVERSION" == 10.11 || "$MACOSVERSION" == 10.12 || "$MACOSVERSION" == 10.13 ]]; then
		DEFAULTBLUE='\033[38;5;23m'
		DESERT='\033[38;5;130m'
		FOREST='\033[38;5;22m'
		CINNAMON='\033[38;5;88m'
		CLASSICBLACK='\033[38;5;0m'
		CLASSICBLACKBW="                    Classic Black........................(5)"
		
	else
		if [[ "$UIAPPEARANCE" == "Dark" ]]; then
			DEFAULTBLUE='\033[38;5;158m'
			DESERT='\033[38;5;180m'
			FOREST='\033[38;5;108m'
			CINNAMON='\033[38;5;124m'
			CLASSICBLACK='\033[38;5;255m'
			APPLECHIP="\033[38;5;117m                    App\033[38;5;111mle \033[38;5;135mSili\033[38;5;207mcone............\033[38;5;208m...........\033[38;5;11m(1)"
			if [[ $(uname -m) == "arm64" ]]; then
				CLASSICBLACKBW="                    Classic White........................(6)"
			else
				CLASSICBLACKBW="                    Classic White........................(5)"
			fi
		else
			DEFAULTBLUE='\033[38;5;23m'
			DESERT='\033[38;5;130m'
			FOREST='\033[38;5;22m'
			CINNAMON='\033[38;5;88m'
			CLASSICBLACK='\033[38;5;0m'
			APPLECHIP="\033[38;5;33m                    App\033[38;5;63mle \033[38;5;129mSili\033[38;5;163mcone............\033[38;5;209m...........\033[38;5;214m(1)"
			if [[ $(uname -m) == "arm64" ]]; then
				CLASSICBLACKBW="                    Classic Black........................(6)"
			else
				CLASSICBLACKBW="                    Classic Black........................(5)"
			fi
		fi
	fi
	if [[ "$APP" == '\033["38;5;23m' || "$APP" == '\033["38;5;158m' ]]; then
		SETTINGCOLOR="Default Blue"
		if [[ -e "$SCRIPTPATHMAIN/.desertsandssetting" ]]; then
			COLORSANDS
		elif [[ -e "$SCRIPTPATHMAIN/.forestgreensetting" ]]; then
			COLORFOREST
		elif [[ -e "$SCRIPTPATHMAIN/.cinnamonapplecolor" ]]; then
			CINNAMONCOLOR
		elif [[ -e "$SCRIPTPATHMAIN/.classicsetting" ]]; then
			COLORCLASSIC
		elif [[ -e "$SCRIPTPATHMAIN/.colorm1setting" ]]; then
			COLORM1
		fi
	elif [[ "$APP" == '\033["38;5;130m' || "$APP" == '\033["38;5;180m' ]]; then
		SETTINGCOLOR="Desert Sands"
		if [[ -e "$SCRIPTPATHMAIN/.defaultbluesetting" ]]; then
			COLORBLUE
		elif [[ -e "$SCRIPTPATHMAIN/.forestgreensetting" ]]; then
			COLORFOREST
		elif [[ -e "$SCRIPTPATHMAIN/.cinnamonapplecolor" ]]; then
			CINNAMONCOLOR
		elif [[ -e "$SCRIPTPATHMAIN/.classicsetting" ]]; then
			COLORCLASSIC
		elif [[ -e "$SCRIPTPATHMAIN/.colorm1setting" ]]; then
			COLORM1
		fi
	elif [[ "$APP" == '\033["38;5;22m' || "$APP" == '\033["38;5;108m' ]]; then
		SETTINGCOLOR="Forest Green"
		if [[ -e "$SCRIPTPATHMAIN/.desertsandssetting" ]]; then
			COLORSANDS
		elif [[ -e "$SCRIPTPATHMAIN/.defaultbluesetting" ]]; then
			COLORBLUE
		elif [[ -e "$SCRIPTPATHMAIN/.cinnamonapplecolor" ]]; then
			CINNAMONCOLOR
		elif [[ -e "$SCRIPTPATHMAIN/.classicsetting" ]]; then
			COLORCLASSIC
		elif [[ -e "$SCRIPTPATHMAIN/.colorm1setting" ]]; then
			COLORM1
		fi
	elif [[ "$APP" == '\033["38;5;88m' || "$APP" == '\033["38;5;124m' ]]; then
		SETTINGCOLOR="Cinnamon Apple"
		if [[ -e "$SCRIPTPATHMAIN/.desertsandssetting" ]]; then
			COLORSANDS
		elif [[ -e "$SCRIPTPATHMAIN/.defaultbluesetting" ]]; then
			COLORBLUE
		elif [[ -e "$SCRIPTPATHMAIN/.forestgreensetting" ]]; then
			COLORFOREST
		elif [[ -e "$SCRIPTPATHMAIN/.classicsetting" ]]; then
			COLORCLASSIC
		elif [[ -e "$SCRIPTPATHMAIN/.colorm1setting" ]]; then
			COLORM1
		fi
	elif [[ "$APP" == '\033["38;5;0m' || "$APP" == '\033["38;5;255m' ]]; then
		if [[ "$MACOSVERSION" == 10.5 || "$MACOSVERSION" == 10.6 || "$MACOSVERSION" == 10.7 || "$MACOSVERSION" == 10.8 || "$MACOSVERSION" == 10.9 || "$MACOSVERSION" == 10.10 || "$MACOSVERSION" == 10.11 || "$MACOSVERSION" == 10.12 || "$MACOSVERSION" == 10.13 ]]; then
			SETTINGCOLOR="Classic Black"
			if [[ -e "$SCRIPTPATHMAIN/.desertsandssetting" ]]; then
				COLORSANDS
			elif [[ -e "$SCRIPTPATHMAIN/.forestgreensetting" ]]; then
				COLORFOREST
			elif [[ -e "$SCRIPTPATHMAIN/.cinnamonapplecolor" ]]; then
				CINNAMONCOLOR
			elif [[ -e "$SCRIPTPATHMAIN/.defaultbluesetting" ]]; then
				COLORBLUE
			elif [[ -e "$SCRIPTPATHMAIN/.colorm1setting" ]]; then
				COLORM1
			fi
		else
			if [[ "$UIAPPEARANCE" == "Dark" ]]; then
				SETTINGCOLOR="Classic White"
				if [[ -e "$SCRIPTPATHMAIN/.desertsandssetting" ]]; then
					COLORSANDS
				elif [[ -e "$SCRIPTPATHMAIN/.forestgreensetting" ]]; then
					COLORFOREST
				elif [[ -e "$SCRIPTPATHMAIN/.cinnamonapplecolor" ]]; then
					CINNAMONCOLOR
				elif [[ -e "$SCRIPTPATHMAIN/.defaultbluesetting" ]]; then
					COLORBLUE
				elif [[ -e "$SCRIPTPATHMAIN/.colorm1setting" ]]; then
					COLORM1
				fi
			else
				SETTINGCOLOR="Classic Black"
				if [[ -e "$SCRIPTPATHMAIN/.desertsandssetting" ]]; then
					COLORSANDS
				elif [[ -e "$SCRIPTPATHMAIN/.forestgreensetting" ]]; then
					COLORFOREST
				elif [[ -e "$SCRIPTPATHMAIN/.cinnamonapplecolor" ]]; then
					CINNAMONCOLOR
				elif [[ -e "$SCRIPTPATHMAIN/.defaultbluesetting" ]]; then
					COLORBLUE
				elif [[ -e "$SCRIPTPATHMAIN/.colorm1setting" ]]; then
					COLORM1
				fi
			fi
		fi
	elif [[ "$APP" == '\033["38;5;214m' || "$APP" == '\033["38;5;185m' ]]; then
		if [[ $(uname -m) == "arm64" ]]; then
			SETTINGCOLOR="Apple Silicone"
			if [[ -e "$SCRIPTPATHMAIN/.desertsandssetting" ]]; then
				COLORSANDS
			elif [[ -e "$SCRIPTPATHMAIN/.forestgreensetting" ]]; then
				COLORFOREST
			elif [[ -e "$SCRIPTPATHMAIN/.cinnamonapplecolor" ]]; then
				CINNAMONCOLOR
			elif [[ -e "$SCRIPTPATHMAIN/.classicsetting" ]]; then
				COLORCLASSIC
			elif [[ -e "$SCRIPTPATHMAIN/.defaultbluesetting" ]]; then
				COLORBLUE
			fi
		else
			if [[ $HOMEUSER == 'YES' ]]; then
				cd "$SCRIPTPATHMAIN"
				Output rm -R .colorm1setting
			fi
			COLORCLASSIC
		fi
	else
		MODIFIED="YES"
		SETTINGCOLOR="Unknown"
	fi
	if [[ $UIAPPEARANCE == 'Dark' ]]; then
		APPLECHIPINFO="\033[38;5;117mApp\033[38;5;111mle \033[38;5;135mSili\033[38;5;207mcone"
	else
		APPLECHIPINFO="\033[38;5;33mApp\033[38;5;63mle \033[38;5;129mSili\033[38;5;163mcone"
	fi
}
PreRunMac()
{
	#Checks Mac model
	MACVERSION=$(sysctl hw.model | awk '{ print $2 }')
	
	#Checks Startup Disk
	STARTUPDISK=$(diskutil info / | sed -n 's/^ *Volume Name: *//p')
	
	#Checks Mac type
	if [[ $(uname -m) == "arm64" ]]; then
		APPLESILICONE="YES"
		if [[ ! -d "$("xcode-select" -p)" ]]; then
			echo -e "${RESET}${ERROR}You are running on Apple Silicone without Xcode tools."
			echo -e "${RESET}${BODY}You need these tools to install older versions of macOS."
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
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
ANIMATION()
{
	local frames=("..." "   " ".  " ".. ")
		while true; do
			for frame in "${frames[@]}"; do
				echo -ne "\r                              Creating the drive$frame   "
				sleep 0.7
			done
		done
}
ANIMATIONDOWNLOAD()
{
	local frames=("..." "   " ".  " ".. ")
		while true; do
			for frame in "${frames[@]}"; do
				echo -ne "\r                                Downloading$frame   "
				sleep 0.7
			done
		done
}
WINDOWBAR()
{
	if [[ $GRAPHICSSAFE == 'YES' ]]; then
		clear
		if [[ $verbose == '1' && $safe == '1' || $verbose == '1' && $safe == '2' ]]; then
			echo -e "${APP}${BOLD}                    macOS Creator ${RESET}${APP}V6.2${BOLD} ${WARNING}(Verbose & Safe Mode)${APP}${BOLD}"
		elif [[ $verbose == '1' ]]; then
			echo -e "${APP}${BOLD}                           macOS Creator ${RESET}${APP}V6.2${BOLD} ${WARNING}(Verbose)${APP}${BOLD}"
		elif [[ $safe == '1' || $safe == '2' ]]; then
			echo -e "${APP}${BOLD}                         macOS Creator ${RESET}${APP}V6.2${BOLD} ${WARNING}(Safe Mode)${APP}${BOLD}"
		else
			echo -e "${APP}${BOLD}                               macOS Creator ${RESET}${APP}V6.2${BOLD}"
		fi
		echo -e ""
	else
		clear
		if [[ $verbose == '1' && $safe == '1' || $verbose == '1' && $safe == '2' ]]; then
			echo -e "${APP}${BOLD}                    macOS Creator ${RESET}${APP}V6.2${BOLD} ${WARNING}(Verbose & Safe Mode)${APP}${BOLD}"
		elif [[ $verbose == '1' ]]; then
			echo -e "${APP}${BOLD}                          macOS Creator ${RESET}${APP}V6.2${BOLD} ${WARNING}(Verbose)${APP}${BOLD}"
		elif [[ $safe == '1' || $safe == '2' ]]; then
			echo -e "${APP}${BOLD}                         macOS Creator ${RESET}${APP}V6.2${BOLD} ${WARNING}(Safe Mode)${APP}${BOLD}"
		else
			echo -e "${APP}${BOLD}                               macOS Creator ${RESET}${APP}V6.2${BOLD}"
		fi
		echo -e "»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»"
	fi
}
WINDOWBAREND()
{
	echo -e ""
	echo -n -e "${RESET}${CANCEL}${BOLD}                             Press Q to cancel... "
	read -n 1 input
	if [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e ""
		echo -e "\033[1A\033[0K                                Script Canceled"
		if [[ ! $GRAPHICSSAFE == 'YES' ]]; then
			echo -e "${RESET}${APP}${BOLD}"
			echo -e "»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»"
			echo -e "${RESET}"
		fi
		exit
	else
		echo -e "${RESET}"
	fi
}
WINDOWERROR()
{
	echo -e ""
	echo -e "${RESET}${ERROR}${BOLD}"
	echo -n "                 Invalid command. Press any key to try again... "
	read -n 1
	echo -e "${RESET}"
}
WINDOWERRORDRIVE()
{
	echo -e "${RESET}${ERROR}${BOLD}"
	echo -n "           This is not a valid drive. Press any key to try again... "
	read -n 1
	echo -e "${RESET}"
}
SUCCESS()
{
	echo -e ""
	echo -e ""
	echo -e "${RESET}${CANCEL}${BOLD}                     Thank you for using the macOS Creator"
	if [[ ! $GRAPHICSSAFE == 'YES' ]]; then
		echo -e "${RESET}${APP}${BOLD}"
		echo -e "»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»"
		echo -e "${RESET}"
	fi
	exit
}
SUCCESSRETURN()
{
	echo -e ""
	echo -e "${RESET}${CANCEL}${BOLD}                     Thank you for using the macOS Creator"
	if [[ ! $GRAPHICSSAFE == 'YES' ]]; then
		echo -e "${RESET}${APP}${BOLD}"
		echo -e "»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»"
		echo -e "${RESET}"
	fi
	exit
}
TROUBLESHOOTGUIDE()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
		echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map)"
		echo -e "3) Try using a different drive"
		echo -e "4) Try redownloading the macOS Installer"
		echo -e "5) Restart your Mac${RESET}"
		echo -e "${PROMPTSTYLE}${BOLD}"
		echo -n "                  Press any key to return to the Home Menu... "
		read -n 1 input
		if [[ "$input" == 'q' || "$input" == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
			break
		elif [[ "$input" == '' ]]; then
			WINDOWBAREND
		else
			SCRIPTLAYOUT
		fi
	done
}
TROUBLESHOOTGUIDEMAIN()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}                              Troubleshooting Guide"
	echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
	echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map)"
	echo -e "3) Try using a different drive"
	echo -e "4) Try redownloading the macOS Installer"
	echo -e "5) Make sure your macOS Installer is inside of your Applications folder."
	echo -e "6) Make sure your macOS Installer has not been modified. (i.e. name changed)"
	echo -e "7) Restart your Mac${RESET}"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                  Press any key to return to the Home Menu... "
	read -n 1
	echo -e ""
}
CLEANUP()
{
	while true; do
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}                                    Clean up"
	echo -e "${RESET}${BODY}                    Remove Temporary files...............(1)"
	echo -e "${RESET}${BODY}                    Remove macOS Installers..............(2)"
	echo -e "${RESET}${BODY}                    Fix drive permissions................(3)"
	echo -e "${RESET}${BODY}                    All of the above.....................(4)"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == '1' ]]; then
		echo -e ""
		echo -e ""
		echo -e "${RESET}${TITLE}${BOLD}                                 Cleaning up...${RESET}${TITLE}"
		Output sudo rm -R /private/tmp/InstallAssistant.pkg
		Output sudo rm -R /private/tmp/InstallmacOS.dmg
		Output sudo rm -R /private/tmp/InstallmacOS.iso
		Output sudo rm -R /private/tmp/InstallmacOS.zip
		echo -e "${RESET}${TITLE}${BOLD}                            Files have been removed"
		echo -e "${PROMPTSTYLE}${BOLD}"
		echo -n "                  Press any key to return to the Home Menu... "
		read -n 1
		SCRIPTLAYOUT
	elif [[ $input == '2' ]]; then
		echo -e ""
		echo -e ""
		echo -e "${RESET}${TITLE}${BOLD}                                 Cleaning up...${RESET}${TITLE}"
		Output sudo rm -R /Applications/Install\ OS\ X\ Mavericks.app
		Output sudo rm -R /Applications/Install\ OS\ X\ Yosemite.app
		Output sudo rm -R /Applications/Install\ OS\ X\ El\ Capitan.app
		Output sudo rm -R /Applications/Install\ macOS\ Sierra.app
		Output sudo rm -R /Applications/Install\ macOS\ High\ Sierra.app
		Output sudo rm -R /Applications/Install\ macOS\ Mojave.app
		Output sudo rm -R /Applications/Install\ macOS\ Catalina.app
		Output sudo rm -R /Applications/Install\ macOS\ Big\ Sur.app
		Output sudo rm -R /Applications/Install\ macOS\ Monterey.app
		Output sudo rm -R /Applications/Install\ macOS\ Ventura.app
		Output sudo rm -R /Applications/Install\ macOS\ Sonoma.app
		Output sudo rm -R /Applications/Install\ macOS\ Sequoia.app
		Output sudo rm -R /Applications/Install\ Mac\ OS\ X\ Lion.app
		Output sudo rm -R /Applications/Install\ OS\ X\ Mountain\ Lion.app
		echo -e "${RESET}${TITLE}${BOLD}                            Files have been removed"
		echo -e "${PROMPTSTYLE}${BOLD}"
		echo -n "                  Press any key to return to the Home Menu... "
		read -n 1
		SCRIPTLAYOUT
	elif [[ $input == '3' ]]; then
		echo -e ""
		echo -e ""
		echo -e "${RESET}${TITLE}${BOLD}                                 Cleaning up...${RESET}${TITLE}"
		Output sudo diskutil repairPermissions /
		Output sudo /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user
		Output sudo mdutil -E /
		echo -e "${RESET}${TITLE}${BOLD}                             Mac has been cleaned"
		echo -e "${PROMPTSTYLE}${BOLD}"
		echo -n "                  Press any key to return to the Home Menu... "
		read -n 1
		SCRIPTLAYOUT
	elif [[ $input == '4' ]]; then
		CLEANMAC
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
		HELPCLEAN
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
	done
}
RESETSCRIPT()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                                      Reset"
		echo -e "${RESET}${BODY}                    Reset App Settings...................(1)"
		echo -e "${RESET}${BODY}                    Reset Color Settings.................(2)"
		echo -e "${RESET}${BODY}                    Reset All Settings...................(3)"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                           Enter your option here: "
		read -n 1 input
		if [[ $input == '1' ]]; then
			CLEANED="TRUE"
			echo -e ""
			echo -e ""
			echo -e "${RESET}${TITLE}${BOLD}                               Clearing Settings...${RESET}${TITLE}"
			DELETEMODES
			Output sudo rm -R "$SCRIPTPATHMAIN/.launchall"
			Output sudo rm -R "$SCRIPTPATHMAIN/.launchonce"
			Output sudo rm -R /Applications/macOS\ Creator.app/Contents/document.wflow
			Output sudo cp -R "$SCRIPTPATHMAIN/normallaunch/normal.wflow" /Applications/macOS\ Creator.app/Contents/document.wflow
			echo -e "${RESET}${TITLE}${BOLD}                           App settings have been reset"
			echo -e ""
			echo -e -n "${RESET}${TITLE} Press any key to restart... "
			read -n 1
			echo -e "${RESET}"
			"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
		elif [[ $input == '2' ]]; then
			CLEANED="TRUE"
			echo -e ""
			echo -e ""
			echo -e "${RESET}${TITLE}${BOLD}                               Clearing Settings...${RESET}${TITLE}"
			Output sudo rm -R "$SCRIPTPATHMAIN/.defaultbluesetting"
			Output sudo rm -R "$SCRIPTPATHMAIN/.desertsandssetting"
			Output sudo rm -R "$SCRIPTPATHMAIN/.forestgreensetting"
			Output sudo rm -R "$SCRIPTPATHMAIN/.classicsetting"
			Output sudo rm -R "$SCRIPTPATHMAIN/.colorm1setting"
			echo -e "${RESET}${DEFAULTBLUE}${BOLD}                          Color settings have been reset"
			echo -e ""
			echo -n -e "${RESET}${DEFAULTBLUE}                           Press any key to restart... "
			read -n 1
			if [[ $APPLESILICONE == "YES" ]]; then
				COLORM1
			else
				COLORBLUE
			fi
		elif [[ $input == '3' ]]; then
			CLEANED="TRUE"
			echo -e ""
			echo -e ""
			echo -e "${RESET}${TITLE}${BOLD}                                   Resetting...${RESET}${TITLE}"
			Output sudo rm -R "$SCRIPTPATHMAIN/.defaultbluesetting"
			Output sudo rm -R "$SCRIPTPATHMAIN/.desertsandssetting"
			Output sudo rm -R "$SCRIPTPATHMAIN/.forestgreensetting"
			Output sudo rm -R "$SCRIPTPATHMAIN/.classicsetting"
			Output sudo rm -R "$SCRIPTPATHMAIN/.colorm1setting"
			DELETEMODES
			Output sudo rm -R "$SCRIPTPATHMAIN/.launchall"
			Output sudo rm -R "$SCRIPTPATHMAIN/.launchonce"
			Output sudo rm -R /Applications/macOS\ Creator.app/Contents/document.wflow
			Output sudo cp -R "$SCRIPTPATHMAIN/normallaunch/normal.wflow" /Applications/macOS\ Creator.app/Contents/document.wflow
			echo -e "${RESET}${DEFAULTBLUE}${BOLD}                      All settings have been reset to default"
			echo -e ""
			echo -n -e "${RESET}${DEFAULTBLUE}                           Press any key to restart... "
			read -n 1
			cd "$SCRIPTPATHMAIN"
			sed -i '' '8279s/MAINMENU/FIRSTTIME/' macOS\ Creator.command
			sed -i '' '8278s/FALSE/TRUE/' macOS\ Creator.command
			if [[ $APPLESILICONE == "YES" ]]; then
				COLORM1
			else
				COLORBLUE
			fi
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '?' || $input == '/' ]]; then
			HELPRESET
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
	done
}
CLEANMAC()
{
	echo -e ""
	echo -e ""
	echo -e "${RESET}${TITLE}${BOLD}                                 Cleaning up...${RESET}${TITLE}"
	Output sudo rm -R /private/tmp/InstallAssistant.pkg
	Output sudo rm -R /private/tmp/InstallmacOS.dmg
	Output sudo rm -R /private/tmp/InstallmacOS.iso
	Output sudo rm -R /private/tmp/InstallmacOS.zip
	Output sudo rm -R /Applications/Install\ OS\ X\ Mavericks.app
	Output sudo rm -R /Applications/Install\ OS\ X\ Yosemite.app
	Output sudo rm -R /Applications/Install\ OS\ X\ El\ Capitan.app
	Output sudo rm -R /Applications/Install\ macOS\ Sierra.app
	Output sudo rm -R /Applications/Install\ macOS\ High\ Sierra.app
	Output sudo rm -R /Applications/Install\ macOS\ Mojave.app
	Output sudo rm -R /Applications/Install\ macOS\ Catalina.app
	Output sudo rm -R /Applications/Install\ macOS\ Big\ Sur.app
	Output sudo rm -R /Applications/Install\ macOS\ Monterey.app
	Output sudo rm -R /Applications/Install\ macOS\ Ventura.app
	Output sudo rm -R /Applications/Install\ macOS\ Sonoma.app
	Output sudo rm -R /Applications/Install\ macOS\ Sequoia.app
	Output sudo rm -R /Applications/Install\ Mac\ OS\ X\ Lion.app
	Output sudo rm -R /Applications/Install\ OS\ X\ Mountain\ Lion.app
	Output sudo diskutil repairPermissions /
	Output sudo /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user
	Output sudo mdutil -E /
	if [[ $HOMEUSER == 'YES' ]]; then
		DELETEMODES
		Output sudo rm -R "$SCRIPTPATHMAIN/.defaultbluesetting"
		Output sudo rm -R "$SCRIPTPATHMAIN/.desertsandssetting"
		Output sudo rm -R "$SCRIPTPATHMAIN/.forestgreensetting"
		Output sudo rm -R "$SCRIPTPATHMAIN/.classicsetting"
		Output sudo rm -R "$SCRIPTPATHMAIN/.colorm1setting"
	fi
	echo -e "${RESET}${TITLE}${BOLD}                         Mac has been completely cleaned"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                  Press any key to return to the Home Menu... "
	read -n 1
	SCRIPTLAYOUT
}
MAINMENU()
{
	if [[ $FIRSTTIMEHERE=='TRUE' ]]; then
		cd "$SCRIPTPATHMAIN"
		sed -i '' '8278s/TRUE/FALSE/' macOS\ Creator.command
	fi
	FIRSTTIMEHERE="FALSE"
	ENTERHERE="TRUE"
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}                            macOS Creator Home menu${RESET}"
	echo -e "${RESET}${BODY}                        Press ${BOLD}W${RESET}${BODY} to see list of controls${RESET}"
	echo -e "${CANCEL}                     To show the help menu, press the ${BOLD}? ${RESET}${CANCEL}key${RESET}"
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}"
	echo -e "     ${BODY}Search for macOS installer in your Applications folder.............(1)"
	echo -e "     Manually provide macOS Installer...................................(2)"
	echo -e "     Download macOS Installer...........................................(3)"
	echo -e "     Identify Mac model.................................................(4)"
	echo -e "     Review troubleshooting guide.......................................(5)"
	echo -e "     Settings...........................................................(6)${RESET}"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
}
CREDITS()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}                                     Credits"
	echo -e ""
	echo -e "${RESET}${BODY} Script built and designed by ${BOLD}Encore Platforms${RESET}${BODY}."
	echo -e " Clean up tool (Repair Permissions) made by ${BOLD}Isiah Johnson${RESET}${BODY}."
	echo -e " (Output), the tool to hide commands was originally created by ${BOLD}OS X Hackers${RESET}${BODY}."
	echo -e " macOS Sierra modifications were discovered by ${BOLD}dosdude1${RESET}${BODY}."
	echo -e ""
	echo -e " Encore Platforms is not affiliated with Apple Inc."
	echo -e " Mac OS Ten (X), Mac, and all other Apple product names are trademarks or"
	echo -e " registered trademarks of Apple Inc."
	echo -e ""
	echo -e "${BOLD}                              BSD 3-Clause License"
	echo -e "${RESET}${BODY}                     Go to GitHub.com for more information"
	echo -e ""
	echo -e "${RESET}${TITLE}${BOLD}                             Encore platforms 2025"
	echo -e ""
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                  Press any key to return to the Home Menu... "
	read -n 1
}
LICENSEAGREEMENT()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                                License Agreement"
		echo -e ""
		echo -e "${RESET}${BODY}${BOLD}          By using this software, you agree to this License Agreement:"
		echo -e "${RESET}${BODY}                     Press (S) to see the License Agreement"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                  Press any key to return to the Home Menu... "
		read -n 1 input
		if [[ $input == 's' || $input == 'S' ]]; then
			if [[ -e "$SCRIPTPATHMAIN/License Agreement.txt" ]]; then
				open -a "TextEdit" "$SCRIPTPATHMAIN/License Agreement.txt"
			else
				echo -e ""
				echo -e ""
				echo -e -n "${RESET}${ERROR}${BOLD}              The License Agreement Document is not available... "
				echo -n ""
				read -n 1
			fi
		else
			break
		fi
	done
}
RELEASENOTES()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}                     macOS Creator Version 6.2 ${RESET}${TITLE}Release Notes"
	echo -e ""
	echo -e "${RESET}${BODY} • Introduces Safe Install"
	if [[ $FIRSTTIMEHERE == 'TRUE' ]]; then
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                        Press any key to get started... "
		read -n 1
		rm -R /private/tmp/.macOSCreatorUpdate
		cd "$SCRIPTPATHMAIN"
		sed -i '' '8279s/FIRSTTIME/MAINMENU/' macOS\ Creator.command
		if [[ $verbose == "1" ]]; then
			"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
		elif [[ $safe == "1" || $safe == "2" ]]; then
			"$SCRIPTPATHMAIN"/macOS\ Creator.command -S && exit
		elif [[ $verbose == '1' && $safe == '1' || $verbose == '1' && $safe == '2' ]]; then
			"$SCRIPTPATHMAIN"/macOS\ Creator.command -s -v && exit
		else
			"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
		fi
	else
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                  Press any key to return to the Home Menu... "
		read -n 1
	fi
}
MACINFO()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}                              This Mac Information "
	echo -e ""
	if [[ $safe == '1' || $MACVERIFY == 'NO' ]]; then
		echo -e "${RESET}${TITLE} • Chip Type:"
	else
		if [[ $APPLESILICONE == 'YES' ]]; then
			if [[ "$APP" == '\033["38;5;0m' || "$APP" == '\033["38;5;255m' ]]; then
				echo -e "${RESET}${TITLE} • Chip Type: ${BOLD}Apple Silicone"
			else
				echo -e "${RESET}${TITLE} • Chip Type: ${BOLD}$APPLECHIPINFO"
			fi
		else
			if [[ "$APP" == '\033["38;5;0m' || "$APP" == '\033["38;5;255m' ]]; then
				echo -e "${RESET}${TITLE} • Chip Type: ${BOLD}Intel Based Mac"
			else
				echo -e "${RESET}${TITLE} • Chip Type: ${RESET}${BOLD}\033[38;5;39mIntel Based Mac"
			fi
		fi
	fi
	if [[ $safe == '1' || $MACVERIFY == 'NO' ]]; then
		echo -e "${RESET}${TITLE} • Mac model:"
	else
		echo -e "${RESET}${TITLE} • Mac model: ${BODY}${BOLD}$MACVERSION ${RESET}${BODY}(Press I for details)"
	fi
	if [[ $MACOSVERSION == '10.7' ]]; then
		echo -e "${RESET}${TITLE} • Mac OS X Version: ${BODY}${BOLD}Mac OS X Lion ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == '10.8' ]]; then
		echo -e "${RESET}${TITLE} • OS X Version: ${BODY}${BOLD}OS X Mountain Lion ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == '10.9' ]]; then
		echo -e "${RESET}${TITLE} • OS X Version: ${BODY}${BOLD}OS X Mavericks ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == '10.10' ]]; then
		echo -e "${RESET}${TITLE} • OS X Version: ${BODY}${BOLD}OS X Yosemite ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == '10.11' ]]; then
		echo -e "${RESET}${TITLE} • OS X Version: ${BODY}${BOLD}OS X El Capitan ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == '10.12' ]]; then
		echo -e "${RESET}${TITLE} • macOS Version: ${BODY}${BOLD}macOS Sierra ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == '10.13' ]]; then
		echo -e "${RESET}${TITLE} • macOS Version: ${BODY}${BOLD}macOS High Sierra ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == '10.14' ]]; then
		echo -e "${RESET}${TITLE} • macOS Version: ${BODY}${BOLD}macOS Mojave ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == '10.15' ]]; then
		echo -e "${RESET}${TITLE} • macOS Version: ${BODY}${BOLD}macOS Catalina ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == *11* ]]; then
		echo -e "${RESET}${TITLE} • macOS Version: ${BODY}${BOLD}macOS Big Sur ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == *12* ]]; then
		echo -e "${RESET}${TITLE} • macOS Version: ${BODY}${BOLD}macOS Monterey ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == *13* ]]; then
		echo -e "${RESET}${TITLE} • macOS Version: ${BODY}${BOLD}macOS Ventura ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == *14* ]]; then
		echo -e "${RESET}${TITLE} • macOS Version: ${BODY}${BOLD}macOS Sonoma ${RESET}${BODY}($MACOSVERSION)"
	elif [[ $MACOSVERSION == *15* ]]; then
		echo -e "${RESET}${TITLE} • macOS Version: ${BODY}${BOLD}macOS Sequoia ${RESET}${BODY}($MACOSVERSION)"
	else
		echo -e "${RESET}${TITLE} • macOS Version:"
	fi
	if [[ $safe == '1' || $MACVERIFY == 'NO' ]]; then
		echo -e "${RESET}${TITLE} • Startup Drive: "
	else
		echo -e "${RESET}${TITLE} • Startup Drive: ${BODY}${BOLD}$STARTUPDISK"
	fi
	echo -e ""
	if [[ $SAFEINSTALLATION == 'FALSE' ]]; then
		echo -e "${RESET}${PROMPTSTYLE} • Safe Install Off"
	else
		echo -e "${RESET}${PROMPTSTYLE}${BOLD} • Safe Install On"
	fi
	echo -e ""
	if [[ $APPLESILICONE == 'YES' ]]; then
		echo -e "${RESET}${WARNING}    You may not be able to install older macOS Versions with Apple Silicone"
	elif [[ $MACOSVERSION == '10.7' || $MACOSVERSION == '10.8' || $MACOSVERSION == '10.9' || $MACOSVERSION == '10.10' || $MACOSVERSION == '10.11' || $MACOSVERSION == '10.12' ]]; then
		echo -e "${RESET}${WARNING}               You may not be able to install newer macOS Versions"
	else
		echo -e "${RESET}${BODY}               You should not have any issues with drive creation"
	fi
	echo -e ""
	echo -e -n "${RESET}${PROMPTSTYLE}${BOLD}                  Press any key to return to the Home Menu... "
	read -n 1 input
	if [[ $input == 'i' || $input == 'I' ]]; then
		if [[ $safe == '1' || $MACVERIFY == 'NO' ]]; then
			echo -e ""
		else
			WINDOWBAR
			system_profiler SPHardwareDataType
			echo -e -n "${RESET}${PROMPTSTYLE}${BOLD}                  Press any key to return to the Home Menu... "
			read -n 1
		fi
	else
		echo -e ""
	fi
}
FIRSTTIME()
{
	if [[ -e /private/tmp/.macOSCreatorUpdate ]]; then
		FIRSTTIMEHERE="TRUE"
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                               Upgrade successful${RESET}"
		echo -e "${RESET}${BODY}${BOLD}                      Welcome to macOS Creator Version 6.2"
		echo -e ""
		echo -e -n "${RESET}${BODY}                  Would you like to see the release notes?... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			RELEASENOTES
		else
			rm -R /private/tmp/.macOSCreatorUpdate
			cd "$SCRIPTPATHMAIN"
			sed -i '' '8279s/FIRSTTIME/MAINMENU/' macOS\ Creator.command
			if [[ $verbose == "1" ]]; then
				"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
			elif [[ $safe == "1" || $safe == "2" ]]; then
				"$SCRIPTPATHMAIN"/macOS\ Creator.command -S && exit
			elif [[ $verbose == '1' && $safe == '1' || $verbose == '1' && $safe == '2' ]]; then
				"$SCRIPTPATHMAIN"/macOS\ Creator.command -s -v && exit
			else
				"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
			fi
		fi
	else
		FIRSTTIMEHERE="TRUE"
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                          Welcome to the macOS Creator${RESET}"
		echo -e "${RESET}${BODY}          The all-in-one script for creating bootable macOS Installers"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e ""
		echo -n "                       Press any key to get started... "
		read -n 1
		WINDOWBAR
		echo -e "${RESET}${TITLE}            If you wish to go straight to the Home Menu, press Q now."
		echo -e "${BODY}                 Otherwise press any other key to continue setup"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                           Enter your option here: "
		read -n 1 input
		if [[ ! $input == 'q' || $input == 'Q' ]]; then
			cd "$SCRIPTPATHMAIN"
			sed -i '' '8279s/FIRSTTIME/CHANGECOLORS/' macOS\ Creator.command
			CHANGECOLORS
		else
			cd "$SCRIPTPATHMAIN"
			sed -i '' '8279s/FIRSTTIME/MAINMENU/' macOS\ Creator.command
			if [[ $verbose == "1" ]]; then
				"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
			elif [[ $safe == "1" || $safe == "2" ]]; then
				"$SCRIPTPATHMAIN"/macOS\ Creator.command -S && exit
			elif [[ $verbose == '1' && $safe == '1' || $verbose == '1' && $safe == '2' ]]; then
				"$SCRIPTPATHMAIN"/macOS\ Creator.command -s -v && exit
			else
				"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
			fi
		fi
	fi
}
#Help
CONTROLS()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}                           List of available controls:${RESET}"
	echo -e ""
	echo -e "${BODY}${BOLD} At any point:${RESET}${BODY}"
	echo -e " Press the return key to cancel."
	echo -e " Press the Q key to return home."
	echo -e " Press the W key to go one step backwards."
	echo -e " Press the ? key to show help if you do not understand something."
	echo -e ""
	echo -e "${BODY}${BOLD} From the Home Menu:${RESET}${BODY}"
	echo -e " Press the ? key to see the macOS Creator Guide."
	echo -e " Press the C key to see credits."
	echo -e " Press the R key to see release notes for this update."
	echo -e " Press the I key to see Mac information."
	echo -e " Press the A key to see License Agreement."
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                  Press any key to return to the Home Menu... "
	read -n 1
}
GUIDE()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                                   User Guide"
		echo -e "${RESET}${TITLE}    Review these quick steps to familiarize yourslef with the macOS Creator"
		echo -e ""
		echo -e "${RESET}${BODY}${BOLD}             First, begin by pressing a number to highlight a command"
		echo -e "${RESET}${BODY}"
		if [[ $COMMAND == '1' ]]; then
			echo -e "${RESET}${TITLE}${BOLD}     Tools and commands will be listed like this........................(1)"
		else
			echo -e "${RESET}${BODY}     Tools and commands will be listed like this........................(1)"
		fi
		if [[ $COMMAND == '2' ]]; then
			echo -e "${RESET}${TITLE}${BOLD}     Each command has a number corresponding to it......................(2)"
		else
			echo -e "${RESET}${BODY}     Each command has a number corresponding to it......................(2)"
		fi
		if [[ $COMMAND == '3' ]]; then
			echo -e "${RESET}${TITLE}${BOLD}     To choose a command, press its corresponding number................(3)"
		else
			echo -e "${RESET}${BODY}     To choose a command, press its corresponding number................(3)"
		fi
		if [[ $COMMAND == '4' ]]; then
			echo -e "${RESET}${TITLE}${BOLD}     For example, press 4 to select this command........................(4)"
		else
			echo -e "${RESET}${BODY}     For example, press 4 to select this command........................(4)"
		fi
		echo -e ""
		echo -e "${RESET}${TITLE}${BOLD}                       To move to the next step, press Y"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                           Enter your option here: "
		read -n 1 input
		if [[ $input == '1' ]]; then
			COMMAND="1"
		elif [[ $input == '2' ]]; then
			COMMAND="2"
		elif [[ $input == '3' ]]; then
			COMMAND="3"
		elif [[ $input == '4' ]]; then
			COMMAND="4"
		elif [[ $input == 'y' || $input == 'Y' ]]; then
			STEP2
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
	done
		
}
STEP2()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                                   User Guide"
		echo -e "${RESET}${TITLE}                               Confirming with Y"
		echo -e ""
		echo -e "${RESET}${BODY}${BOLD}              At some point the script may ask you this question:"
		echo -e ""
		echo -e "${RESET}${PROMPTSTYLE}                           Do you wish to continue?... "
		echo -e ""
		echo -e "${RESET}${BODY}${BOLD}         In order to continue, press the Y key. Y always refers to Yes"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                           Enter your option here: "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			STEP3
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
	done
}
STEP3()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                                   User Guide"
		echo -e "${RESET}${TITLE}                                Providing a file"
		echo -e ""
		echo -e "${RESET}${BODY}${BOLD}                   The script may ask you to provide a folder"
		echo -e "${RESET}${BODY}      This is easy, simply drag the file from the Finder into this window"
		echo -e "                   When finished, simply press the return key"
		echo -e "        If the file you provided is invalid, press any key to try again"
		echo -e ""
		echo -e "${RESET}${TITLE}${BOLD}                       To move to the next step, press Y"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                           Enter your option here: "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			STEP4
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
	done
}
STEP4()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                                   User Guide"
		echo -e "${RESET}${TITLE}                                  Getting Help"
		echo -e ""
		echo -e "${RESET}${BODY}${BOLD}        If you are ever confused about something, macOS Creator can help"
		echo -e "${RESET}${BODY}        At any point, you can press the ? or / key to show the Help Menu"
		echo -e "            This menu provides simple explinations and instructions"
		echo -e "         When finished, press any key to return back to where you were"
		echo -e ""
		echo -e "${RESET}${TITLE}${BOLD}                       To move to the next step, press Y"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                           Enter your option here: "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			LASTSTEP
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
	done
}
LASTSTEP()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                                   User Guide"
		echo -e "${RESET}${TITLE}                                   Conclusion"
		echo -e ""
		echo -e "${RESET}${BODY}${BOLD}                          This is all you need to know"
		echo -e "${RESET}${BODY}           If you have experience issues, you can report them to GitHub"
		echo -e "      You can reopen this guide at any point to review these instructions"
		echo -e "            This is the all-in-one guide for creating macOS Installer"
		echo -e ""
		echo -e "${RESET}${BODY}${BOLD}                    Thank you for choosing the macOS Creator!"
		if [[ $FIRSTTIMEHERE == 'TRUE' ]]; then
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                        Press any key to get started... "
			read -n 1
			Output rm -R /private/tmp/.macOSCreatorUpdate
			cd "$SCRIPTPATHMAIN"
			sed -i '' '8279s/GUIDE/MAINMENU/' macOS\ Creator.command
			if [[ $verbose == "1" ]]; then
				"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
			elif [[ $safe == "1" || $safe == "2" ]]; then
				"$SCRIPTPATHMAIN"/macOS\ Creator.command -S && exit
			elif [[ $verbose == '1' && $safe == '1' || $verbose == '1' && $safe == '2' ]]; then
				"$SCRIPTPATHMAIN"/macOS\ Creator.command -s -v && exit
			else
				"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
			fi
		else
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		fi
	done
}
HELPOSFOUND()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Press (Y) to continue with the drive creation process"
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPDRIVE()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Choose a drive listed to continue."
	echo -e "If your drive is not listed, press (S) to manually provide the drive."
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPDRAGDRIVE()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Drag a drive from the Finder into this window."
	echo -e "When finished, press the return key to continue."
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
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
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
BETAHELP()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}BETA Builds are tools that are still in active development."
	echo -e "You may or may not notice any issues while using this tool."
	echo -e "If you do notice issues, you can report them at GitHub."
	echo -e "This tool WILL NOT obtain the new UI until fully tested."
	echo -e "Press (Y) to continue."
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPID()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}If you wish to install macOS on this Mac, press (1)."
	echo -e "If you wish to install macOS on another Mac, press (2)."
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPIDMAC()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Choose the option that is equivalent to the Mac"
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPMANUAL()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Drag the macOS Installer from the finder into this window."
	echo -e "When finished, press the return key."
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPCHOOSEMANUAL()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}1) Open the file picker and choose the macOS Installer using your mouse."
	echo -e "2) Drag the installer into this window to provide the path."
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPCLEAN()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}1) Removes any temporary files added to your Mac."
	echo -e "2) Removes macOS Installers inside of your Applications folder."
	echo -e "3) Cleans up your Mac if files were tempered with during operation."
	echo -e "4) Runs all three of these commands."
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPRESET()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}1) Resets the way the app launches."
	echo -e "2) Resets the color settings."
	echo -e "3) Resets all settings to their defaults."
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPDOWNLOAD()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Choose the macOS Version you wish to download."
	echo -e "Use the Identify Mac Model tool to determine which version to download."
	echo -e "Press 0 to see the next page."
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPSETTINGS()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Change Colors lets you change the script colors."
	echo -e "Advanced Mode lets you start the script in Verbose or Safe Mode."
	echo -e "Clean up lets you clean any extra files that were made during the operation."
	if [[ $HOMEUSER == 'YES' ]]; then
		echo -e "App configuration determines how the app launches the script."
		echo -e "Reset allows you to reset certain settings back to their default."
	fi
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPCOLORS()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Choose the color style you prefer."
	if [[ $HOMEUSER == 'YES' ]]; then
		echo -e "You can save these settings to your Mac for future updates."
	fi
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPADVANCED()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Verbose Mode shows commands run"
	echo -e "Safe Mode skips certain checks on your Mac"
	echo -e "Safe Install skips several checks when installing macOS"
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPAPPMAIN()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}This can adjust how the app launches the script."
	echo -e "1) Adjust how the app runs the script."
	echo -e "2) Adjust advanced modes when launching (i.e. Safe Mode)."
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
HELPAPP()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}This adjusts the way terminal reads the script."
	echo -e "1) Open the script only one time."
	echo -e "2) Open Terminal window and then run the script."
	echo -e "With the first option, the script opens like an app."
	echo -e "With the second option, the script runs like a terminal command."
	echo -e ""
	echo -e "Press (Q) to return to the Home Menu"
	echo -e "Press the return key to cancel"
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	echo -e ""
}
#Search for macOS
APPLICATIONSCREATE()
{
	echo -e ""
	echo -e ""
	echo -e "${RESET}${TITLE}                     Searching for valid macOS Installers...${RESET}"
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
		sleep .4
		OSNONE
	fi
}

#OS Found
OSMAVERICKS()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                            OS X Mavericks was found${RESET}${TITLE}"
	echo -e "                        Press Y to use this OS X Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install OS X Mavericks.app"
		FINDDRIVE
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
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
	echo -e "${RESET}${OSFOUND}${BOLD}                            OS X Yosemite was found${RESET}${TITLE}"
	echo -e "                        Press Y to use this OS X Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install OS X Yosemite.app"
		FINDDRIVE
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
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
	echo -e "${RESET}${OSFOUND}${BOLD}                           OS X El Capitan was found${RESET}${TITLE}"
	echo -e "                        Press Y to use this OS X Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install OS X El Capitan.app"
		FINDDRIVE
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
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
	echo -e "${RESET}${OSFOUND}${BOLD}                             macOS Sierra was found${RESET}${TITLE}"
	echo -e "                       Press Y to use this macOS Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install macOS Sierra.app"
		FINDDRIVE
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
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
	echo -e "${RESET}${OSFOUND}${BOLD}                          macOS High Sierra was found${RESET}${TITLE}"
	echo -e "                       Press Y to use this macOS Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $APPLESILICONE == 'YES' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                      This Mac has the Apple Silicone chip${RESET}"
			echo -e "${ERROR}          Currently you cannot install macOS High Sierra with this Mac"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		fi
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}        You need OS X Mountain Lion or later to install macOS High Sierra"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		else
			installpath="/Applications/Install macOS High Sierra.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
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
	echo -e "${RESET}${OSFOUND}${BOLD}                            macOS Mojave was found${RESET}${TITLE}"
	echo -e "                       Press Y to use this macOS Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $APPLESILICONE == 'YES' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                      This Mac has the Apple Silicone chip${RESET}"
			echo -e "${ERROR}             Currently you cannot install macOS Mojave with this Mac"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		fi
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}          You need OS X Mountain Lion or later to install macOS Mojave"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		else
			installpath="/Applications/Install macOS Mojave.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
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
	echo -e "${RESET}${OSFOUND}${BOLD}                            macOS Catalina was found${RESET}${TITLE}"
	echo -e "                       Press Y to use this macOS Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $APPLESILICONE == 'YES' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                      This Mac has the Apple Silicone chip${RESET}"
			echo -e "${ERROR}             Currently you cannot install macOS Catalina with this Mac"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		fi
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Catalina"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.8' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
			echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Catalina"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		else
			installpath="/Applications/Install macOS Catalina.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
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
	echo -e "${RESET}${OSFOUND}${BOLD}                            macOS Big Sur was found${RESET}${TITLE}"
	echo -e "                       Press Y to use this macOS Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Big Sur"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.8' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
			echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Big Sur"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		else
			installpath="/Applications/Install macOS Big Sur.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
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
	echo -e "${RESET}${OSFOUND}${BOLD}                            macOS Monterey was found${RESET}${TITLE}"
	echo -e "                       Press Y to use this macOS Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Monterey"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.8' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
			echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Monterey"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		else
			installpath="/Applications/Install macOS Monterey.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
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
	echo -e "${RESET}${OSFOUND}${BOLD}                            macOS Ventura was found${RESET}${TITLE}"
	echo -e "                       Press Y to use this macOS Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.8' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
			echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.9' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running OS X Mavericks${RESET}"
			echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.10' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running OS X Yosemite${RESET}"
			echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.11' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                      This Mac is running OS X El Capitan${RESET}"
			echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		else
			installpath="/Applications/Install macOS Ventura.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
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
	echo -e "${RESET}${OSFOUND}${BOLD}                             macOS Sonoma was found${RESET}${TITLE}"
	echo -e "                       Press Y to use this macOS Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.8' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
			echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.9' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running OS X Mavericks${RESET}"
			echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.10' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running OS X Yosemite${RESET}"
			echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.11' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                      This Mac is running OS X El Capitan${RESET}"
			echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.12' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                        This Mac is running macOS Sierra${RESET}"
			echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		else
			installpath="/Applications/Install macOS Sonoma.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
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
	echo -e "${RESET}${OSFOUND}${BOLD}                            macOS Sequoia was found${RESET}${TITLE}"
	echo -e "                       Press Y to use this macOS Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		if [[ $MACOSVERSION == '10.7' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running Mac OS X Lion${RESET}"
			echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.8' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
			echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.9' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running OS X Mavericks${RESET}"
			echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.10' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                       This Mac is running OS X Yosemite${RESET}"
			echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.11' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                      This Mac is running OS X El Capitan${RESET}"
			echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		elif [[ $MACOSVERSION == '10.12' ]]; then
			echo -e ""
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e "                        This Mac is running macOS Sierra${RESET}"
			echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                  Press any key to return to the Home Menu... "
			read -n 1
			SCRIPTLAYOUT
		else
			installpath="/Applications/Install macOS Sequoia.app"
			FINDDRIVE
		fi
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
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
	echo -e "${RESET}${OSFOUND}${BOLD}                          OS X Mountain Lion was found${RESET}${TITLE}"
	echo -e "                        Press Y to use this OS X Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install OS X Mountain Lion.app"
		FINDDRIVE
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSL()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                            Mac OS X Lion was found${RESET}${TITLE}"
	echo -e "                      Press Y to use this Mac OS X Version"
	echo -e "${PROMPTSTYLE}${BOLD}"
	echo -n "                           Enter your option here: "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install Mac OS X Lion.app"
		FINDDRIVE
	elif [[ $input == 'q' || $input == 'Q' ]]; then
		echo -e "${RESET}"
		SCRIPTLAYOUT
	elif [[ $input == 'w' || $input == 'W' ]]; then
		break
	elif [[ $input == '?' || $input == '/' ]]; then
		HELPOSFOUND
	elif [[ $input == '' ]]; then
		WINDOWBAREND
	else
		WINDOWERROR
	fi
}
OSNONE()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${OSFOUND}${BOLD}                          No macOS versions were found${RESET}${TITLE}"
		echo -e "                             Press S to search again"
		echo -e "${PROMPTSTYLE}${BOLD}"
		echo -n "                           Enter your option here: "
		read -n 1 input
		if [[ $input == 's' || $input == 'S' ]]; then
			APPLICATIONSCREATE
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			echo -e "${RESET}"
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break 2
		elif [[ $input == '?' || $input == '/' ]]; then
			HELPOSNONE
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
	done
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
			echo -e "${RESET}${TITLE}${BOLD}                    Choose the drive to create the installer"
			echo -e "${RESET}${TITLE}                            Press R to refresh drives"
			echo -e "                       Press S to manually provide a drive"
			echo -e "${RESET}${WARNING}${BOLD}                  WARNING! All data on the drive will be lost!"
			echo -e "${RESET}${BODY}"
			declare -a volume_number=()
			index=1
			for volume_path in /Volumes/*; do
			volume_name="${volume_path#/Volumes/}"
			if [[ ! "$volume_name" == com.apple* && ! "$volume_name" == *"$STARTUPDISK"* ]]; then
				volume_number=$(($volume_number + 1))
				declare volume_$volume_number="$volume_name"
				if [[ ${#volume_name} -eq 1 ]]; then
					echo -e "       ${volume_name}.............................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 2 ]]; then
					echo -e "       ${volume_name}............................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 3 ]]; then
					echo -e "       ${volume_name}...........................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 4 ]]; then
					echo -e "       ${volume_name}..........................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 5 ]]; then
					echo -e "       ${volume_name}.........................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 6 ]]; then
					echo -e "       ${volume_name}........................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 7 ]]; then
					echo -e "       ${volume_name}.......................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 8 ]]; then
					echo -e "       ${volume_name}......................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 9 ]]; then
					echo -e "       ${volume_name}.....................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 10 ]]; then
					echo -e "       ${volume_name}....................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 11 ]]; then
					echo -e "       ${volume_name}...................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 12 ]]; then
					echo -e "       ${volume_name}..................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 13 ]]; then
					echo -e "       ${volume_name}.................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 14 ]]; then
					echo -e "       ${volume_name}................................................(${volume_number})"
				elif [[ ${#volume_name} -eq 15 ]]; then
					echo -e "       ${volume_name}...............................................(${volume_number})"
				elif [[ ${#volume_name} -eq 16 ]]; then
					echo -e "       ${volume_name}..............................................(${volume_number})"
				elif [[ ${#volume_name} -eq 17 ]]; then
					echo -e "       ${volume_name}.............................................(${volume_number})"
				elif [[ ${#volume_name} -eq 18 ]]; then
					echo -e "       ${volume_name}............................................(${volume_number})"
				elif [[ ${#volume_name} -eq 19 ]]; then
					echo -e "       ${volume_name}...........................................(${volume_number})"
				elif [[ ${#volume_name} -eq 20 ]]; then
					echo -e "       ${volume_name}..........................................(${volume_number})"
				elif [[ ${#volume_name} -eq 21 ]]; then
					echo -e "       ${volume_name}.........................................(${volume_number})"
				elif [[ ${#volume_name} -eq 22 ]]; then
					echo -e "       ${volume_name}........................................(${volume_number})"
				elif [[ ${#volume_name} -eq 23 ]]; then
					echo -e "       ${volume_name}.......................................(${volume_number})"
				elif [[ ${#volume_name} -eq 24 ]]; then
					echo -e "       ${volume_name}......................................(${volume_number})"
				elif [[ ${#volume_name} -eq 25 ]]; then
					echo -e "       ${volume_name}.....................................(${volume_number})"
				elif [[ ${#volume_name} -eq 26 ]]; then
					echo -e "       ${volume_name}....................................(${volume_number})"
				elif [[ ${#volume_name} -eq 27 ]]; then
					echo -e "       ${volume_name}...................................(${volume_number})"
				elif [[ ${#volume_name} -eq 28 ]]; then
					echo -e "       ${volume_name}..................................(${volume_number})"
				elif [[ ${#volume_name} -eq 29 ]]; then
					echo -e "       ${volume_name}.................................(${volume_number})"
				elif [[ ${#volume_name} -eq 30 ]]; then
					echo -e "       ${volume_name}................................(${volume_number})"
				elif [[ ${#volume_name} -eq 31 ]]; then
					echo -e "       ${volume_name}...............................(${volume_number})"
				elif [[ ${#volume_name} -eq 32 ]]; then
					echo -e "       ${volume_name}..............................(${volume_number})"
				elif [[ ${#volume_name} -eq 33 ]]; then
					echo -e "       ${volume_name}.............................(${volume_number})"
				elif [[ ${#volume_name} -eq 34 ]]; then
					echo -e "       ${volume_name}............................(${volume_number})"
				elif [[ ${#volume_name} -eq 35 ]]; then
					echo -e "       ${volume_name}...........................(${volume_number})"
				elif [[ ${#volume_name} -eq 36 ]]; then
					echo -e "       ${volume_name}..........................(${volume_number})"
				elif [[ ${#volume_name} -eq 37 ]]; then
					echo -e "       ${volume_name}.........................(${volume_number})"
				elif [[ ${#volume_name} -eq 38 ]]; then
					echo -e "       ${volume_name}........................(${volume_number})"
				elif [[ ${#volume_name} -eq 39 ]]; then
					echo -e "       ${volume_name}.......................(${volume_number})"
				elif [[ ${#volume_name} -eq 40 ]]; then
					echo -e "       ${volume_name}......................(${volume_number})"
				elif [[ ${#volume_name} -eq 41 ]]; then
					echo -e "       ${volume_name}.....................(${volume_number})"
				elif [[ ${#volume_name} -eq 42 ]]; then
					echo -e "       ${volume_name}....................(${volume_number})"
				elif [[ ${#volume_name} -eq 43 ]]; then
					echo -e "       ${volume_name}...................(${volume_number})"
				elif [[ ${#volume_name} -eq 44 ]]; then
					echo -e "       ${volume_name}..................(${volume_number})"
				elif [[ ${#volume_name} -eq 45 ]]; then
					echo -e "       ${volume_name}.................(${volume_number})"
				elif [[ ${#volume_name} -eq 46 ]]; then
					echo -e "       ${volume_name}................(${volume_number})"
				elif [[ ${#volume_name} -eq 47 ]]; then
					echo -e "       ${volume_name}...............(${volume_number})"
				elif [[ ${#volume_name} -eq 48 ]]; then
					echo -e "       ${volume_name}..............(${volume_number})"
				elif [[ ${#volume_name} -eq 49 ]]; then
					echo -e "       ${volume_name}.............(${volume_number})"
				elif [[ ${#volume_name} -eq 50 ]]; then
					echo -e "       ${volume_name}............(${volume_number})"
				elif [[ ${#volume_name} -eq 51 ]]; then
					echo -e "       ${volume_name}...........(${volume_number})"
				elif [[ ${#volume_name} -eq 52 ]]; then
					echo -e "       ${volume_name}..........(${volume_number})"
				elif [[ ${#volume_name} -eq 53 ]]; then
					echo -e "       ${volume_name}.........(${volume_number})"
				elif [[ ${#volume_name} -eq 54 ]]; then
					echo -e "       ${volume_name}........(${volume_number})"
				elif [[ ${#volume_name} -eq 55 ]]; then
					echo -e "       ${volume_name}.......(${volume_number})"
				elif [[ ${#volume_name} -eq 56 ]]; then
					echo -e "       ${volume_name}......(${volume_number})"
				elif [[ ${#volume_name} -eq 57 ]]; then
					echo -e "       ${volume_name}.....(${volume_number})"
				elif [[ ${#volume_name} -eq 58 ]]; then
					echo -e "       ${volume_name}....(${volume_number})"
				elif [[ ${#volume_name} -eq 59 ]]; then
					echo -e "       ${volume_name}...(${volume_number})"
				elif [[ ${#volume_name} -eq 60 ]]; then
					echo -e "       ${volume_name}..(${volume_number})"
				elif [[ ${#volume_name} -eq 61 ]]; then
					echo -e "       ${volume_name}.(${volume_number})"
				else
					echo -e "       ${volume_name}(${volume_number})"
				fi
			fi
			done
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "                           Enter your option here: "
			read -n 1 installer_volume_number
			echo -e ""
			if [[ $installer_volume_number == '' ]]; then
				WINDOWBAREND
			else
				if [[ $installer_volume_number == *'1'* || $installer_volume_number == *'2'* || $installer_volume_number == *'3'* || $installer_volume_number == *'4'* || $installer_volume_number == *'5'* || $installer_volume_number == *'6'* || $installer_volume_number == *'7'* || $installer_volume_number == *'8'* || $installer_volume_number == *'9'* || $installer_volume_number == *'q'* || $installer_volume_number == *'Q'* || $installer_volume_number == *'?'* || $installer_volume_number == *'/'* || $installer_volume_number == *'s'* || $installer_volume_number == *'S'* || $installer_volume_number == *'w'* || $installer_volume_number == *'W'* || $installer_volume_number == *'r'* || $installer_volume_number == *'R'* ]]; then
					if [[ $installer_volume_number == 's' || $installer_volume_number == 'S' ]]; then
						PROVIDEDRIVE
					elif [[ $installer_volume_number == 'q' || $installer_volume_number == 'Q' ]]; then
						SCRIPTLAYOUT
					elif [[ $installer_volume_number == 'w' || $installer_volume_number == 'W' ]]; then
						break
					elif [[ $installer_volume_number == 'r' || $installer_volume_number == 'R' ]]; then
						echo -e ""
					elif [[ $installer_volume_number == '?' || $installer_volume_number == '/' ]]; then
						HELPDRIVE
					else
						installer_volume="volume_$installer_volume_number"
						installer_volume_name="${!installer_volume}"
						installer_volume_path="/Volumes/$installer_volume_name"
						installer_volume_identifier="$(diskutil info "$installer_volume_name"|grep "Device Identifier"|sed 's/.*\ //')"
						if [[ ! "$installer_volume_name" == '' ]]; then
							OSDRIVECREATION
						else
							echo -e ""
							echo -e ""
							echo -e -n "${RESET}${ERROR}${BOLD}           This is not a valid drive. Press any key to try again... "
							read -n 1
							echo -e ""
							FINDDRIVE
						fi
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
		echo -e "${RESET}${TITLE}${BOLD}                    Choose the drive to create the installer"
		echo -e "       Please drag the drive into this window and press the return key... "
		echo -e "${RESET}${WARNING}${BOLD}                  WARNING! All data on the drive will be lost!"
		echo -e "${RESET}${BODY}"
		read -p " Drive path: " installer_volume_path
		if [[ $installer_volume_path = '' ]]; then
			WINDOWBAREND
		elif [[ $installer_volume_path = '?' || $installer_volume_path = '/' ]]; then
			HELPDRAGDRIVE
		elif [[ $installer_volume_path = 'q' || $installer_volume_path = 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $installer_volume_path = 'w' || $installer_volume_path = 'W' ]]; then
			break
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
		sleep 2
		clear
		echo -e ""
		echo -e "${RESET}${ERROR}${BOLD}The script has encountered an error. Refer to GitHub for more information${RESET}"
		echo -e ""
		exit
	fi
}

#Create Drive
MAVERICKSDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                    Creating the drive for ${BOLD}OS X Mavericks..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	error=$(sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --applicationpath "$installpath" --nointeraction 2>&1)
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ $verbose == "1" ]]; then
		echo -e "$error"
	fi
	if [[ "$error" == *"Done"* ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		if [[ "$error" == *"command not found"* ]]; then
			echo -e "${RESET}${ERROR}                 The Installer cannot be found Please try again"
		elif [[ "$error" == *"erasing"* || "$error" == *"mount"* ]]; then
			echo -e "${RESET}${ERROR}         The drive cannot be erased, try formating it with Disk Utility"
		elif [[ "$error" == *"large enough"* ]]; then
			echo -e "${RESET}${ERROR}        This drive is too small. Try using a drive with a larger capacity"
		elif [[ "$error" == *"installer"* ]]; then
			echo -e "${RESET}${ERROR}          The Installer has been damaged. Try redownloading a new copy"
		else
			echo -e "${RESET}${ERROR}                         An unknown error has occured"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
YOSEMITEDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                     Creating the drive for ${BOLD}OS X Yosemite..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	error=$(sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --applicationpath "$installpath" --nointeraction 2>&1)
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ $verbose == "1" ]]; then
		echo -e "$error"
	fi
	if [[ "$error" == *"Done"* ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		if [[ "$error" == *"command not found"* ]]; then
			echo -e "${RESET}${ERROR}                 The Installer cannot be found Please try again"
		elif [[ "$error" == *"erasing"* || "$error" == *"mount"* ]]; then
			echo -e "${RESET}${ERROR}         The drive cannot be erased, try formating it with Disk Utility"
		elif [[ "$error" == *"large enough"* ]]; then
			echo -e "${RESET}${ERROR}        This drive is too small. Try using a drive with a larger capacity"
		elif [[ "$error" == *"installer"* ]]; then
			echo -e "${RESET}${ERROR}          The Installer has been damaged. Try redownloading a new copy"
		else
			echo -e "${RESET}${ERROR}                         An unknown error has occured"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
ELCAPITANDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                    Creating the drive for ${BOLD}OS X El Capitan..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	error=$(sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --applicationpath "$installpath" --nointeraction 2>&1)
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ $verbose == "1" ]]; then
		echo -e "$error"
	fi
	if [[ "$error" == *"Done"* ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		if [[ "$error" == *"command not found"* ]]; then
			echo -e "${RESET}${ERROR}                 The Installer cannot be found Please try again"
		elif [[ "$error" == *"erasing"* || "$error" == *"mount"* ]]; then
			echo -e "${RESET}${ERROR}         The drive cannot be erased, try formating it with Disk Utility"
		elif [[ "$error" == *"large enough"* ]]; then
			echo -e "${RESET}${ERROR}        This drive is too small. Try using a drive with a larger capacity"
		elif [[ "$error" == *"installer"* ]]; then
			echo -e "${RESET}${ERROR}          The Installer has been damaged. Try redownloading a new copy"
		else
			echo -e "${RESET}${ERROR}                         An unknown error has occured"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
SIERRADRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                     Creating the drive for ${BOLD}macOS Sierra..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ -d /Volumes/OS\ X\ Install\ ESD/ ]]; then
		Output diskutil unmount /Volumes/OS\ X\ Install\ ESD
	fi
	echo -e ""
	echo -e "                                 Step 1 of 7..."
	Output sudo hdiutil attach "$installpath/Contents/SharedSupport/InstallESD.dmg"
	echo -e "\033[1A\033[0K                                 Step 2 of 7..."
	Output sudo asr restore -source "/Volumes/OS X Install ESD/BaseSystem.dmg" -target "$installer_volume_path" -noprompt -noverify -erase
	echo -e "\033[1A\033[0KS                                 tep 3 of 7..."
	Output rm -R /Volumes/OS\ X\ Base\ System/System/Installation/Packages
	echo -e "\033[1A\033[0K                                 Step 4 of 7..."
	Output cp -R "/Volumes/OS X Install ESD/Packages" /Volumes/OS\ X\ Base\ System/System/Installation/
	echo -e "\033[1A\033[0K                                 Step 5 of 7..."
	Output cp "/Volumes/OS X Install ESD/BaseSystem.dmg" /Volumes/OS\ X\ Base\ System/
	echo -e "\033[1A\033[0K                                 Step 6 of 7..."
	Output cp "/Volumes/OS X Install ESD/BaseSystem.chunklist" /Volumes/OS\ X\ Base\ System/
	echo -e "\033[1A\033[0K                                 Step 7 of 7..."
	Output diskutil unmount /Volumes/OS\ X\ Install\ ESD
	echo -e "\033[1A\033[0K                                    Finished"
	if [[ -d /Volumes/OS\ X\ Base\ System/System/Installation/Packages ]]; then
		echo -e "${RESET}${TITLE}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "${RESET}${ERROR}${BOLD}\033[1A\033[0K\033[1A\033[0K"
		echo -e "                                Operation Failed   "
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
HIGHSIERRADRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                   Creating the drive for ${BOLD}macOS High Sierra..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	error=$(sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction 2>&1)
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ $verbose == "1" ]]; then
		echo -e "$error"
	fi
	if [[ "$error" == *"Done"* ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		if [[ "$error" == *"command not found"* ]]; then
			echo -e "${RESET}${ERROR}                 The Installer cannot be found Please try again"
		elif [[ "$error" == *"erasing"* || "$error" == *"mount"* ]]; then
			echo -e "${RESET}${ERROR}         The drive cannot be erased, try formating it with Disk Utility"
		elif [[ "$error" == *"large enough"* ]]; then
			echo -e "${RESET}${ERROR}        This drive is too small. Try using a drive with a larger capacity"
		elif [[ "$error" == *"installer"* ]]; then
			echo -e "${RESET}${ERROR}          The Installer has been damaged. Try redownloading a new copy"
		else
			echo -e "${RESET}${ERROR}                         An unknown error has occured"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
MOJAVEDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                      Creating the drive for ${BOLD}macOS Mojave..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	error=$(sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction 2>&1)
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ $verbose == "1" ]]; then
		echo -e "$error"
	fi
	if [[ "$error" == *"Install media now available"* ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		if [[ "$error" == *"command not found"* ]]; then
			echo -e "${RESET}${ERROR}                 The Installer cannot be found Please try again"
		elif [[ "$error" == *"erasing"* || "$error" == *"mount"* ]]; then
			echo -e "${RESET}${ERROR}         The drive cannot be erased, try formating it with Disk Utility"
		elif [[ "$error" == *"large enough"* ]]; then
			echo -e "${RESET}${ERROR}        This drive is too small. Try using a drive with a larger capacity"
		elif [[ "$error" == *"installer"* ]]; then
			echo -e "${RESET}${ERROR}          The Installer has been damaged. Try redownloading a new copy"
		else
			echo -e "${RESET}${ERROR}                         An unknown error has occured"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
CATALINADRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                    Creating the drive for ${BOLD}macOS Catalina..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	error=$(sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction 2>&1)
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ $verbose == "1" ]]; then
		echo -e "$error"
	fi
	if [[ "$error" == *"Install media now available"* ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		if [[ "$error" == *"command not found"* ]]; then
			echo -e "${RESET}${ERROR}                 The Installer cannot be found Please try again"
		elif [[ "$error" == *"erasing"* || "$error" == *"mount"* ]]; then
			echo -e "${RESET}${ERROR}         The drive cannot be erased, try formating it with Disk Utility"
		elif [[ "$error" == *"large enough"* ]]; then
			echo -e "${RESET}${ERROR}        This drive is too small. Try using a drive with a larger capacity"
		elif [[ "$error" == *"installer"* ]]; then
			echo -e "${RESET}${ERROR}          The Installer has been damaged. Try redownloading a new copy"
		else
			echo -e "${RESET}${ERROR}                         An unknown error has occured"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
BIGSURDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                     Creating the drive for ${BOLD}macOS Big Sur..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	error=$(sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction 2>&1)
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ $verbose == "1" ]]; then
		echo -e "$error"
	fi
	if [[ "$error" == *"Install media now available"* ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		if [[ "$error" == *"command not found"* ]]; then
			echo -e "${RESET}${ERROR}                 The Installer cannot be found Please try again"
		elif [[ "$error" == *"erasing"* || "$error" == *"mount"* ]]; then
			echo -e "${RESET}${ERROR}         The drive cannot be erased, try formating it with Disk Utility"
		elif [[ "$error" == *"large enough"* ]]; then
			echo -e "${RESET}${ERROR}        This drive is too small. Try using a drive with a larger capacity"
		elif [[ "$error" == *"installer"* ]]; then
			echo -e "${RESET}${ERROR}          The Installer has been damaged. Try redownloading a new copy"
		else
			echo -e "${RESET}${ERROR}                         An unknown error has occured"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
MONTEREYDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                     Creating the drive for ${BOLD}macOS Monterey..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	error=$(sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction 2>&1)
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ $verbose == "1" ]]; then
		echo -e "$error"
	fi
	if [[ "$error" == *"Install media now available"* ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		if [[ "$error" == *"command not found"* ]]; then
			echo -e "${RESET}${ERROR}                 The Installer cannot be found Please try again"
		elif [[ "$error" == *"erasing"* || "$error" == *"mount"* ]]; then
			echo -e "${RESET}${ERROR}         The drive cannot be erased, try formating it with Disk Utility"
		elif [[ "$error" == *"large enough"* ]]; then
			echo -e "${RESET}${ERROR}        This drive is too small. Try using a drive with a larger capacity"
		elif [[ "$error" == *"installer"* ]]; then
			echo -e "${RESET}${ERROR}          The Installer has been damaged. Try redownloading a new copy"
		else
			echo -e "${RESET}${ERROR}                         An unknown error has occured"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
VENTURADRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                     Creating the drive for ${BOLD}macOS Ventura..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	error=$(sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction 2>&1)
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ $verbose == "1" ]]; then
		echo -e "$error"
	fi
	if [[ "$error" == *"Install media now available"* ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		if [[ "$error" == *"command not found"* ]]; then
			echo -e "${RESET}${ERROR}                 The Installer cannot be found Please try again"
		elif [[ "$error" == *"erasing"* || "$error" == *"mount"* ]]; then
			echo -e "${RESET}${ERROR}         The drive cannot be erased, try formating it with Disk Utility"
		elif [[ "$error" == *"large enough"* ]]; then
			echo -e "${RESET}${ERROR}        This drive is too small. Try using a drive with a larger capacity"
		elif [[ "$error" == *"installer"* ]]; then
			echo -e "${RESET}${ERROR}          The Installer has been damaged. Try redownloading a new copy"
		else
			echo -e "${RESET}${ERROR}                         An unknown error has occured"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
SONOMADRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                      Creating the drive for ${BOLD}macOS Sonoma..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	error=$(sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction 2>&1)
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ $verbose == "1" ]]; then
		echo -e "$error"
	fi
	if [[ "$error" == *"Install media now available"* ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		if [[ "$error" == *"command not found"* ]]; then
			echo -e "${RESET}${ERROR}                 The Installer cannot be found Please try again"
		elif [[ "$error" == *"erasing"* || "$error" == *"mount"* ]]; then
			echo -e "${RESET}${ERROR}         The drive cannot be erased, try formating it with Disk Utility"
		elif [[ "$error" == *"large enough"* ]]; then
			echo -e "${RESET}${ERROR}        This drive is too small. Try using a drive with a larger capacity"
		elif [[ "$error" == *"installer"* ]]; then
			echo -e "${RESET}${ERROR}          The Installer has been damaged. Try redownloading a new copy"
		else
			echo -e "${RESET}${ERROR}                         An unknown error has occured"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
SEQUOIADRIVECREATION()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}                     Creating the drive for ${BOLD}macOS Sequoia"
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	error=$(sudo "$installpath"/Contents/Resources/createinstallmedia --volume "$installer_volume_path" --nointeraction 2>&1)
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ $verbose == "1" ]]; then
		echo -e "$error"
	fi
	if [[ "$error" == *"Install media now available"* ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		if [[ ! "$error" == *"command not found"* ]]; then
			echo -e "${RESET}${ERROR}                 The Installer cannot be found Please try again"
		elif [[ "$error" == *"erasing"* || "$error" == *"mount"* ]]; then
			echo -e "${RESET}${ERROR}         The drive cannot be erased, try formating it with Disk Utility"
		elif [[ "$error" == *"large enough"* ]]; then
			echo -e "${RESET}${ERROR}        This drive is too small. Try using a drive with a larger capacity"
		elif [[ "$error" == *"installer"* ]]; then
			echo -e "${RESET}${ERROR}          The Installer has been damaged. Try redownloading a new copy"
		else
			echo -e "${RESET}${ERROR}                         An unknown error has occured"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
MLDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                  Creating the drive for ${BOLD}OS X Mountain Lion..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	Output sudo asr restore -source "$installpath/Contents/SharedSupport/InstallESD.dmg" -target "$installer_volume_path" -noprompt -noverify -erase
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ -d /Volumes/Mac\ OS\ X\ Install\ ESD/Install\ OS\ X\ Mountain\ Lion.app ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}
LDRIVECREATION()
{
	WINDOWBAR
	echo -e -n "${RESET}${TITLE}                     Creating the drive for ${BOLD}Mac OS X Lion..."
	echo -e ""
	echo -e -n "${RESET}${TITLE}                          Please Enter Your "
	sudo echo ""
	echo -e "\033[1A\033[0K${BODY}"
	if [[ ! $verbose == '1' ]]; then
		ANIMATION &
		anim_pid=$!
	fi
	Output sudo asr restore -source "$installpath/Contents/SharedSupport/InstallESD.dmg" -target "$installer_volume_path" -noprompt -noverify -erase
	if [[ ! $verbose == '1' ]]; then
		kill "$anim_pid" >/dev/null 2>&1
		wait "$anim_pid" 2>/dev/null
	fi
	if [[ -d /Volumes/Mac\ OS\ X\ Install\ ESD/Install\ Mac\ OS\ X\ Lion.app ]]; then
		echo -e "\033[1A\033[0K${RESET}${TITLE}${BOLD}"
		echo -n "       The drive has been created successfully. Press any key to quit... "
		read -n 1 input
		if [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '' ]]; then
			SUCCESSRETURN
		else
			SUCCESS
		fi
	else
		echo -e "\033[1A\033[0K${RESET}${ERROR}${BOLD}"
		echo -e "                                Operation Failed   "
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -e "           Press S to try again, or Y to review troubleshooting steps"
		echo -n "                     (Press any other key to go home)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			TROUBLESHOOTGUIDE
		elif [[ $input == 's' || $input == 'S' ]]; then
			OSDRIVECREATION
		else
			SCRIPTLAYOUT
		fi
	fi
}

#Manually Create Drive
MANUALCREATE()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                        Manually provide macOS Installer"
		echo -e ""
		echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
		echo -e "   Choose macOS Installer from the Finder.................................(1)"
		echo -e "   Manually provide macOS Installer path..................................(2)"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                           Enter your option here: "
		read -n 1 input
		echo -e ""
		if [[ $input == '1' ]]; then
			installpath=$(osascript <<EOF
		  	  tell application "System Events"
		    	    activate
		    	    set theFile to choose file with prompt "Select a file:"
		    	    return POSIX path of theFile
		    	end tell
EOF
)
			MANUALCREATEVERIFY
		elif [[ $input == '2' ]]; then
			MANUALCREATEPATH
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '/' || $input == '?' ]]; then
			HELPCHOOSEMANUAL
		else
			WINDOWERROR
		fi
	done

}
MANUALCREATEPATH()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                        Manually provide macOS Installer"
		echo -e ""
		echo -e "     Please drag the installer into this window and press the return key... "
		echo -e "${RESET}${BODY}"
		read -p " Installer path: " installpath
		MANUALCREATEVERIFY
	done
}
MANUALCREATEVERIFY()
{
		if [[ "$installpath" == *'Mavericks.app'* ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}                                 OS X Mavericks"
			echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
			read -n 1
			FINDDRIVE
		elif [[ "$installpath" == *'Yosemite.app'* ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}                                 OS X Yosemite"
			echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
			read -n 1
			FINDDRIVE
		elif [[ "$installpath" == *'Capitan.app'* ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}                                OS X El Capitan"
			echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
			read -n 1
			FINDDRIVE
		elif [[ "$installpath" == *'macOS Sierra.app'* ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}                                  macOS Sierra"
			echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
			read -n 1
			FINDDRIVE
		elif [[ "$installpath" == *'High Sierra.app'* ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                      This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}          Currently you cannot install macOS High Sierra with this Mac"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}        You need OS X Mountain Lion or later to install macOS High Sierra"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                               macOS High Sierra"
				echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Mojave.app'* ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                      This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}             Currently you cannot install macOS Mojave with this Mac"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}          You need OS X Mountain Lion or later to install macOS Mojave"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                                 macOS Mojave"
				echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Catalina.app'* ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                      This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}             Currently you cannot install macOS Catalina with this Mac"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Catalina"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Catalina"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                                 macOS Catalina"
				echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Sur.app'* ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Big Sur"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Big Sur"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                                 macOS Big Sur"
				echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Monterey.app'* ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Monterey"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Monterey"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                                 macOS Monterey"
				echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Ventura.app'* ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.9' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running OS X Mavericks${RESET}"
				echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.10' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running OS X Yosemite${RESET}"
				echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.11' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                      This Mac is running OS X El Capitan${RESET}"
				echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                                 macOS Ventura"
				echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Sonoma.app'* ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.9' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running OS X Mavericks${RESET}"
				echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.10' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running OS X Yosemite${RESET}"
				echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.11' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                      This Mac is running OS X El Capitan${RESET}"
				echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.12' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                        This Mac is running macOS Sierra${RESET}"
				echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                                  macOS Sonoma"
				echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Sequoia.app'* ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.9' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running OS X Mavericks${RESET}"
				echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.10' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running OS X Yosemite${RESET}"
				echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.11' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                      This Mac is running OS X El Capitan${RESET}"
				echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.12' ]]; then
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                        This Mac is running macOS Sierra${RESET}"
				echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                                 macOS Sequoia"
				echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
				read -n 1
				FINDDRIVE
			fi
		elif [[ "$installpath" == *'Mountain Lion.app'* ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}                               OS X Mountain Lion"
			echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
			read -n 1
			FINDDRIVE
		elif [[ "$installpath" == *'Mac OS X Lion.app'* ]]; then
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}                                 Mac OS X Lion"
			echo -e -n "${RESET}${TITLE}                          Press any key to continue... "
			read -n 1
			FINDDRIVE
		elif [[ $installpath == 'q' || $installpath == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $installpath == 'w' || $installpath == 'W' ]]; then
			break
		elif [[ $installpath == '?' ||  $installpath == '/' ]]; then
			HELPMANUAL
		elif [[ $installpath == '' ]]; then
			WINDOWBAREND
		else
			echo -e "${RESET}${ERROR}${BOLD}"
			echo -e -n "     This is not a valid macOS Installer. Press any key to try again... "
			read -n 1
		fi
}
#Download macOS
DOWNLOADMACOS()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                            Downlaod macOS Installer"
		echo -e "${RESET}${BODY}                     Choose one of the available Installers"
		echo -e ""
		echo -e "                    OS X Mavericks.......................(1)"
		echo -e "                    OS X Yosemite........................(2)"
		echo -e "                    OS X El Capitan......................(3)"
		echo -e "                    macOS Sierra.........................(4)"
		echo -e "                    macOS High Sierra....................(5)"
		echo -e "                    macOS Mojave.........................(6)"
		echo -e "                    macOS Catalina.......................(7)"
		echo -e "                    macOS Big Sur........................(8)"
		echo -e "                    macOS Monetery.......................(9)"
		echo -e "                    Next page............................(0)"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                           Enter your option here: "
		read -n 1 input
		if [[ "$input" == '1' ]]; then
			echo -e ""
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}                                 OS X Mavericks"
			echo -e -n "${RESET}${TITLE}            Do you want to continue? (Press any key to reselect)... "
			read -n 1 input
			if [[ $input == 'y' || $input == 'Y' ]]; then
				DOWNLOADMAVERICKS
			else
				echo -e ""
			fi
		elif [[ "$input" == '2' ]]; then
			echo -e ""
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}                                 OS X Yosemite"
			echo -e -n "${RESET}${TITLE}            Do you want to continue? (Press any key to reselect)... "
			read -n 1 input
			if [[ $input == 'y' || $input == 'Y' ]]; then
				DOWNLOADYOSEMITE
			else
				echo -e ""
			fi
		elif [[ "$input" == '3' ]]; then
			echo -e ""
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}                                OS X El Capitan"
			echo -e -n "${RESET}${TITLE}            Do you want to continue? (Press any key to reselect)... "
			read -n 1 input
			if [[ $input == 'y' || $input == 'Y' ]]; then
				DOWNLOADELCAPITAN
			else
				echo -e ""
			fi
		elif [[ "$input" == '4' ]]; then
			echo -e ""
			echo -e ""
			echo -e "${RESET}${OSFOUND}${BOLD}                                  macOS Sierra"
			echo -e -n "${RESET}${TITLE}            Do you want to continue? (Press any key to reselect)... "
			read -n 1 input
			if [[ $input == 'y' || $input == 'Y' ]]; then
				DOWNLOADSIERRA
			else
				echo -e ""
			fi
		elif [[ "$input" == '5' ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e ""
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                      This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}          Currently you cannot install macOS High Sierra with this Mac"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e ""
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}        You need OS X Mountain Lion or later to install macOS High Sierra"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                               macOS High Sierra"
				echo -e -n "${RESET}${TITLE}            Do you want to continue? (Press any key to reselect)... "
				read -n 1 input
				if [[ $input == 'y' || $input == 'Y' ]]; then
					DOWNLOADHIGHSIERRA
				else
					echo -e ""
				fi
			fi
		elif [[ "$input" == '6' ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e ""
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                      This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}             Currently you cannot install macOS Mojave with this Mac"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e ""
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}          You need OS X Mountain Lion or later to install macOS Mojave"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                                 macOS Mojave"
				echo -e -n "${RESET}${TITLE}            Do you want to continue? (Press any key to reselect)... "
				read -n 1 input
				if [[ $input == 'y' || $input == 'Y' ]]; then
					DOWNLOADMOJAVE
				else
					echo -e ""
				fi
			fi
		elif [[ "$input" == '7' ]]; then
			if [[ $APPLESILICONE == 'YES' ]]; then
				echo -e ""
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                      This Mac has the Apple Silicone chip${RESET}"
				echo -e "${ERROR}             Currently you cannot install macOS Catalina with this Mac"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			fi
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e ""
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Catalina"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e ""
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Catalina"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                                 macOS Catalina"
				echo -e -n "${RESET}${TITLE}            Do you want to continue? (Press any key to reselect)... "
				read -n 1 input
				if [[ $input == 'y' || $input == 'Y' ]]; then
					DOWNLOADCATALINA
				else
					echo -e ""
				fi
			fi
		elif [[ "$input" == '8' ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e ""
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Big Sur"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e ""
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Big Sur"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                                 macOS Big Sur"
				echo -e -n "${RESET}${TITLE}            Do you want to continue? (Press any key to reselect)... "
				read -n 1 input
				if [[ $input == 'y' || $input == 'Y' ]]; then
					DOWNLOADBIGSUR
				else
					echo -e ""
				fi
			fi
		elif [[ "$input" == '9' ]]; then
			if [[ $MACOSVERSION == '10.7' ]]; then
				echo -e ""
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                       This Mac is running Mac OS X Lion${RESET}"
				echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Monterey"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			elif [[ $MACOSVERSION == '10.8' ]]; then
				echo -e ""
				echo -e "${RESET}${ERROR}${BOLD}"
				echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
				echo -e "${ERROR}            You need OS X Mavericks or later to install macOS Monterey"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                  Press any key to return to the Home Menu... "
				read -n 1
				SCRIPTLAYOUT
			else
				echo -e ""
				echo -e ""
				echo -e "${RESET}${OSFOUND}${BOLD}                                 macOS Monterey"
				echo -e -n "${RESET}${TITLE}            Do you want to continue? (Press any key to reselect)... "
				read -n 1 input
				if [[ $input == 'y' || $input == 'Y' ]]; then
					DOWNLOADMONTEREY
				else
					echo -e ""
				fi
			fi
		elif [[ "$input" == '0' ]]; then
			while true; do
				WINDOWBAR
				echo -e "${RESET}${TITLE}${BOLD}                            Downlaod macOS Installer"
				echo -e "${RESET}${BODY}                     Choose one of the available Installers"
				echo -e ""
				echo -e "                    macOS Ventura........................(1)"
				echo -e "                    macOS Sonoma.........................(2)"
				echo -e "                    macOS Sequoia........................(3)"
				echo -e "                    Previous Page........................(0)"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                           Enter your option here: "
				read -n 1 input
				if [[ "$input" == '1' ]]; then
					if [[ $MACOSVERSION == '10.7' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                       This Mac is running Mac OS X Lion${RESET}"
						echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.8' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
						echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.9' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                       This Mac is running OS X Mavericks${RESET}"
						echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.10' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                       This Mac is running OS X Yosemite${RESET}"
						echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.11' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                      This Mac is running OS X El Capitan${RESET}"
						echo -e "${ERROR}            You need macOS Sierra or later to install macOS Ventura"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					else
						echo -e ""
						echo -e ""
						echo -e "${RESET}${OSFOUND}${BOLD}                                 macOS Ventura"
						echo -e -n "${RESET}${TITLE}            Do you want to continue? (Press any key to reselect)... "
						read -n 1 input
						if [[ $input == 'y' || $input == 'Y' ]]; then
							DOWNLOADVENTURA
						else
							echo -e ""
						fi
					fi
				elif [[ "$input" == '2' ]]; then
					if [[ $MACOSVERSION == '10.7' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                       This Mac is running Mac OS X Lion${RESET}"
						echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.8' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
						echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.9' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                       This Mac is running OS X Mavericks${RESET}"
						echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.10' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                       This Mac is running OS X Yosemite${RESET}"
						echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.11' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                      This Mac is running OS X El Capitan${RESET}"
						echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.12' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                        This Mac is running macOS Sierra${RESET}"
						echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sonoma"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					else
						echo -e ""
						echo -e ""
						echo -e "${RESET}${OSFOUND}${BOLD}                                  macOS Sonoma"
						echo -e -n "${RESET}${TITLE}            Do you want to continue? (Press any key to reselect)... "
						read -n 1 input
						if [[ $input == 'y' || $input == 'Y' ]]; then
							DOWNLOADSONOMA
						else
							echo -e ""
						fi
					fi
				elif [[ "$input" == '3' ]]; then
					if [[ $MACOSVERSION == '10.7' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                       This Mac is running Mac OS X Lion${RESET}"
						echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.8' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                     This Mac is running OS X Mountain Lion${RESET}"
						echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.9' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                       This Mac is running OS X Mavericks${RESET}"
						echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.10' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                       This Mac is running OS X Yosemite${RESET}"
						echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.11' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                      This Mac is running OS X El Capitan${RESET}"
						echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ $MACOSVERSION == '10.12' ]]; then
						echo -e ""
						echo -e "${RESET}${ERROR}${BOLD}"
						echo -e "                        This Mac is running macOS Sierra${RESET}"
						echo -e "${ERROR}           You need macOS High Sierra or later to install macOS Sequoia"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "                  Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					else
						echo -e ""
						echo -e ""
						echo -e "${RESET}${OSFOUND}${BOLD}                                 macOS Sequoia"
						echo -e -n "${RESET}${TITLE}            Do you want to continue? (Press any key to reselect)... "
						read -n 1 input
						if [[ $input == 'y' || $input == 'Y' ]]; then
							DOWNLOADSEQUOIA
						else
							echo -e ""
						fi
					fi
				elif [[ $input == 'q' || $input == 'Q' ]]; then
					SCRIPTLAYOUT
				elif [[ $input == 'w' || $input == 'W' || $input == '0' ]]; then
					break
				elif [[ $input == '?' || $input == '/' ]]; then
					HELPDOWNLOAD
				elif [[ $input == '' ]]; then
					WINDOWBAREND
				else
					WINDOWERROR
				fi
			done
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == '?' || $input == '/' ]]; then
			HELPDOWNLOAD
		elif [[ $input == '' ]]; then
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
		echo -e "${RESET}${TITLE}${BOLD}                          Downloading OS X Mavericks...${RESET}${BODY}"
		echo -e ""
		echo -e -n "${RESET}${TITLE}                          Please Enter Your "
		sudo echo ""
		echo -e "\033[1A\033[0K${BODY}"
		if [[ ! $verbose == '1' ]]; then
			ANIMATIONDOWNLOAD &
			anim_pid=$!
		fi
		if [[ -e /private/tmp/InstallmacOS.zip ]]; then
			sudo rm -R /private/tmp/InstallmacOS.zip
		fi
		Output sudo curl https://ia801805.us.archive.org/35/items/os-x-mavericks/Install%20OS%20X%20Mavericks.zip -o /private/tmp/InstallmacOS.zip
		if [ $? -eq 0 ]; then
			DOWNLOAD="YES"
		else
			DOWNLOAD="NO"
		fi
		if [[ ! $verbose == '1' ]]; then
			kill "$anim_pid" >/dev/null 2>&1
			wait "$anim_pid" 2>/dev/null
		fi
		if [ $DOWNLOAD == 'YES' ]; then
			if [[ -e /private/tmp/InstallmacOS.zip ]]; then
				open /private/tmp/InstallmacOS.dmg
				echo -e "\033[1A\033[0K\033[1A\033[0K"
				echo -e ""
				echo -e "${BOLD}                               Download Complete   "
				echo -e "${RESET}${TITLE}"
				echo -e "                 Follow the on-screen instructions to install... "
				echo -n "       Once completed, press any key to return home, or S to install... "
				read -n 1 input
				if [[ "$input" == 's' || "$input" == 'S' ]]; then
					APPLICATIONSCREATE
				else
					SCRIPTLAYOUT
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
		echo -e "${RESET}${TITLE}${BOLD}                          Downloading OS X Yosemite...${RESET}${BODY}"
		echo -e ""
		echo -e -n "${RESET}${TITLE}                          Please Enter Your "
		sudo echo ""
		echo -e "\033[1A\033[0K${BODY}"
		if [[ ! $verbose == '1' ]]; then
			ANIMATIONDOWNLOAD &
			anim_pid=$!
		fi

		if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
			sudo rm -R /private/tmp/InstallmacOS.dmg
		fi
		Output sudo curl http://updates-http.cdn-apple.com/2019/cert/061-41343-20191023-02465f92-3ab5-4c92-bfe2-b725447a070d/InstallMacOSX.dmg -o /private/tmp/InstallmacOS.dmg
		if [ $? -eq 0 ]; then
			DOWNLOAD="YES"
		else
			DOWNLOAD="NO"
		fi
		if [[ ! $verbose == '1' ]]; then
			kill "$anim_pid" >/dev/null 2>&1
			wait "$anim_pid" 2>/dev/null
		fi
		if [ $DOWNLOAD == 'YES' ]; then
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				open /private/tmp/InstallmacOS.dmg
				echo -e "\033[1A\033[0K\033[1A\033[0K"
				echo -e ""
				echo -e "${BOLD}                               Download Complete   "
				echo -e "${RESET}${TITLE}"
				echo -e "                 Follow the on-screen instructions to install... "
				echo -n "       Once completed, press any key to return home, or S to install... "
				read -n 1 input
				if [[ "$input" == 's' || "$input" == 'S' ]]; then
					APPLICATIONSCREATE
				else
					SCRIPTLAYOUT
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
		echo -e "${RESET}${TITLE}${BOLD}                          Downloading OS X El Capitan...${RESET}${BODY}"
		echo -e ""
		echo -e -n "${RESET}${TITLE}                          Please Enter Your "
		sudo echo ""
		echo -e "\033[1A\033[0K${BODY}"
		if [[ ! $verbose == '1' ]]; then
			ANIMATIONDOWNLOAD &
			anim_pid=$!
		fi
		if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
			sudo rm -R /private/tmp/InstallmacOS.dmg
		fi
		Output sudo curl http://updates-http.cdn-apple.com/2019/cert/061-41424-20191024-218af9ec-cf50-4516-9011-228c78eda3d2/InstallMacOSX.dmg -o /private/tmp/InstallmacOS.dmg
		if [ $? -eq 0 ]; then
			DOWNLOAD="YES"
		else
			DOWNLOAD="NO"
		fi
		if [[ ! $verbose == '1' ]]; then
			kill "$anim_pid" >/dev/null 2>&1
			wait "$anim_pid" 2>/dev/null
		fi
		if [ $DOWNLOAD == 'YES' ]; then
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				open /private/tmp/InstallmacOS.dmg
				echo -e "\033[1A\033[0K\033[1A\033[0K"
				echo -e ""
				echo -e "${BOLD}                               Download Complete   "
				echo -e "${RESET}${TITLE}"
				echo -e "                 Follow the on-screen instructions to install... "
				echo -n "       Once completed, press any key to return home, or S to install... "
				read -n 1 input
				if [[ "$input" == 's' || "$input" == 'S' ]]; then
					APPLICATIONSCREATE
				else
					SCRIPTLAYOUT
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
		echo -e "${RESET}${TITLE}${BOLD}                           Downloading macOS Sierra...${RESET}${BODY}"
		echo -e ""
		echo -e -n "${RESET}${TITLE}                          Please Enter Your "
		sudo echo ""
		echo -e "\033[1A\033[0K${BODY}"
		if [[ ! $verbose == '1' ]]; then
			ANIMATIONDOWNLOAD &
			anim_pid=$!
		fi
		if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
			sudo rm -R /private/tmp/InstallmacOS.dmg
		fi
		Output sudo curl http://updates-http.cdn-apple.com/2019/cert/061-39476-20191023-48f365f4-0015-4c41-9f44-39d3d2aca067/InstallOS.dmg -o /private/tmp/InstallmacOS.dmg
		if [ $? -eq 0 ]; then
			DOWNLOAD="YES"
		else
			DOWNLOAD="NO"
		fi
		if [[ ! $verbose == '1' ]]; then
			kill "$anim_pid" >/dev/null 2>&1
			wait "$anim_pid" 2>/dev/null
		fi
		if [ $DOWNLOAD == 'YES' ]; then
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				open /private/tmp/InstallmacOS.dmg
				echo -e "\033[1A\033[0K\033[1A\033[0K"
				echo -e ""
				echo -e "${BOLD}                               Download Complete   "
				echo -e "${RESET}${TITLE}"
				echo -e "                 Follow the on-screen instructions to install... "
				echo -n "       Once completed, press any key to return home, or S to install... "
				read -n 1 input
				if [[ "$input" == 's' || "$input" == 'S' ]]; then
					APPLICATIONSCREATE
				else
					SCRIPTLAYOUT
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
		echo -e "${RESET}${TITLE}${BOLD}                         Downloading macOS High Sierra...${RESET}${BODY}"
		echo -e ""
		echo -e -n "${RESET}${TITLE}                          Please Enter Your "
		sudo echo ""
		echo -e "\033[1A\033[0K${BODY}"
		if [[ ! $verbose == '1' ]]; then
			ANIMATIONDOWNLOAD &
			anim_pid=$!
		fi
		if [[ -e /private/tmp/InstallmacOS.iso ]]; then
			sudo rm -R /private/tmp/InstallmacOS.zip
		fi
		Output sudo curl https://ia803405.us.archive.org/5/items/high-sierra-installer/Install%20macOS%20High%20Sierra.zip -o /private/tmp/InstallmacOS.zip
		if [ $? -eq 0 ]; then
			DOWNLOAD="YES"
		else
			DOWNLOAD="NO"
		fi
		if [[ ! $verbose == '1' ]]; then
			kill "$anim_pid" >/dev/null 2>&1
			wait "$anim_pid" 2>/dev/null
		fi
		if [ $DOWNLOAD == 'YES' ]; then
			if [[ -e /private/tmp/InstallmacOS.zip ]]; then
				open /private/tmp/InstallmacOS.zip
				echo -e "\033[1A\033[0K\033[1A\033[0K"
				echo -e ""
				echo -e "${BOLD}                               Download Complete   "
				echo -e "${RESET}${TITLE}"
				echo -e "               Copy the installer to your Applications folder... "
				echo -n "       Once completed, press any key to return home, or S to install... "
				read -n 1 input
				if [[ "$input" == 's' || "$input" == 'S' ]]; then
					APPLICATIONSCREATE
				else
					SCRIPTLAYOUT
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
		echo -e "${RESET}${TITLE}${BOLD}                           Downloading macOS Mojave...${RESET}${BODY}"
		echo -e ""
		echo -e -n "${RESET}${TITLE}                          Please Enter Your "
		sudo echo ""
		echo -e "\033[1A\033[0K${BODY}"
		if [[ ! $verbose == '1' ]]; then
			ANIMATIONDOWNLOAD &
			anim_pid=$!
		fi
		if [[ -e /private/tmp/InstallmacOS.iso ]]; then
			sudo rm -R /private/tmp/InstallmacOS.dmg
		fi
		Output sudo curl https://dn720701.ca.archive.org/0/items/macOS_Mojave/macOS_Mojave.dmg -o /private/tmp/InstallmacOS.dmg
		if [ $? -eq 0 ]; then
			DOWNLOAD="YES"
		else
			DOWNLOAD="NO"
		fi
		if [[ ! $verbose == '1' ]]; then
			kill "$anim_pid" >/dev/null 2>&1
			wait "$anim_pid" 2>/dev/null
		fi
		if [ $DOWNLOAD == 'YES' ]; then
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				open /private/tmp/InstallmacOS.dmg
				echo -e "\033[1A\033[0K\033[1A\033[0K"
				echo -e ""
				echo -e "${BOLD}                               Download Complete   "
				echo -e "${RESET}${TITLE}"
				echo -e "               Copy the installer to your Applications folder... "
				echo -n "       Once completed, press any key to return home, or S to install... "
				read -n 1 input
				if [[ "$input" == 's' || "$input" == 'S' ]]; then
					APPLICATIONSCREATE
				else
					SCRIPTLAYOUT
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
		echo -e "${RESET}${TITLE}${BOLD}                          Downloading macOS Catalina...${RESET}${BODY}"
		echo -e ""
		echo -e -n "${RESET}${TITLE}                          Please Enter Your "
		sudo echo ""
		echo -e "\033[1A\033[0K${BODY}"
		if [[ ! $verbose == '1' ]]; then
			ANIMATIONDOWNLOAD &
			anim_pid=$!
		fi
		if [[ -e /private/tmp/InstallmacOS.iso ]]; then
			sudo rm -R /private/tmp/InstallmacOS.iso
		fi
		Output sudo curl https://dn720003.ca.archive.org/0/items/macOS-Catalina-IOS/macOSCatalina.iso -o /private/tmp/InstallmacOS.iso
		if [ $? -eq 0 ]; then
			DOWNLOAD="YES"
		else
			DOWNLOAD="NO"
		fi
		if [[ ! $verbose == '1' ]]; then
			kill "$anim_pid" >/dev/null 2>&1
			wait "$anim_pid" 2>/dev/null
		fi
		if [ $DOWNLOAD == 'YES' ]; then
			if [[ -e /private/tmp/InstallmacOS.iso ]]; then
				open /private/tmp/InstallmacOS.iso
				echo -e "\033[1A\033[0K\033[1A\033[0K"
				echo -e ""
				echo -e "${BOLD}                               Download Complete   "
				echo -e "${RESET}${TITLE}"
				echo -e "               Copy the installer to your Applications folder... "
				echo -n "       Once completed, press any key to return home, or S to install... "
				read -n 1 input
				if [[ "$input" == 's' || "$input" == 'S' ]]; then
					APPLICATIONSCREATE
				else
					SCRIPTLAYOUT
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
		echo -e "${RESET}${TITLE}${BOLD}                           Downloading macOS Big Sur...${RESET}${BODY}"
		echo -e ""
		echo -e -n "${RESET}${TITLE}                          Please Enter Your "
		sudo echo ""
		echo -e "\033[1A\033[0K${BODY}"
		if [[ ! $verbose == '1' ]]; then
			ANIMATIONDOWNLOAD &
			anim_pid=$!
		fi
		if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
			sudo rm -R /private/tmp/InstallAssistant.pkg
		fi
		Output sudo curl https://swcdn.apple.com/content/downloads/14/38/042-45246-A_NLFOFLCJFZ/jk992zbv98sdzz3rgc7mrccjl3l22ruk1c/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
		if [ $? -eq 0 ]; then
			DOWNLOAD="YES"
		else
			DOWNLOAD="NO"
		fi
		if [[ ! $verbose == '1' ]]; then
			kill "$anim_pid" >/dev/null 2>&1
			wait "$anim_pid" 2>/dev/null
		fi
		if [ $DOWNLOAD == 'YES' ]; then
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				open /private/tmp/InstallAssistant.pkg
				echo -e "\033[1A\033[0K\033[1A\033[0K"
				echo -e ""
				echo -e "${BOLD}                               Download Complete   "
				echo -e "${RESET}${TITLE}"
				echo -e "                 Follow the on-screen instructions to install... "
				echo -n "       Once completed, press any key to return home, or S to install... "
				read -n 1 input
				if [[ "$input" == 's' || "$input" == 'S' ]]; then
					APPLICATIONSCREATE
				else
					SCRIPTLAYOUT
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
		echo -e "${RESET}${TITLE}${BOLD}                          Downloading macOS Monterey...${RESET}${BODY}"
		echo -e ""
		echo -e -n "${RESET}${TITLE}                          Please Enter Your "
		sudo echo ""
		echo -e "\033[1A\033[0K${BODY}"
		if [[ ! $verbose == '1' ]]; then
			ANIMATIONDOWNLOAD &
			anim_pid=$!
		fi
		if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
			sudo rm -R /private/tmp/InstallAssistant.pkg
		fi
		Output sudo curl https://swcdn.apple.com/content/downloads/46/57/052-60131-A_KM2RH04C2D/9yzvba1uvpem2wuo95r459qno57qaizwf2/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
		if [ $? -eq 0 ]; then
			DOWNLOAD="YES"
		else
			DOWNLOAD="NO"
		fi
		if [[ ! $verbose == '1' ]]; then
			kill "$anim_pid" >/dev/null 2>&1
			wait "$anim_pid" 2>/dev/null
		fi
		if [ $DOWNLOAD == 'YES' ]; then
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				open /private/tmp/InstallAssistant.pkg
				echo -e "\033[1A\033[0K\033[1A\033[0K"
				echo -e ""
				echo -e "${BOLD}                               Download Complete   "
				echo -e "${RESET}${TITLE}"
				echo -e "                 Follow the on-screen instructions to install... "
				echo -n "       Once completed, press any key to return home, or S to install... "
				read -n 1 input
				if [[ "$input" == 's' || "$input" == 'S' ]]; then
					APPLICATIONSCREATE
				else
					SCRIPTLAYOUT
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
		echo -e "${RESET}${TITLE}${BOLD}                          Downloading macOS Ventura...${RESET}${BODY}"
		echo -e ""
		echo -e -n "${RESET}${TITLE}                          Please Enter Your "
		sudo echo ""
		echo -e "\033[1A\033[0K${BODY}"
		if [[ ! $verbose == '1' ]]; then
			ANIMATIONDOWNLOAD &
			anim_pid=$!
		fi
		if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
			sudo rm -R /private/tmp/InstallAssistant.pkg
		fi
		Output sudo curl https://swcdn.apple.com/content/downloads/61/08/082-11327-A_JKF2NNDDY8/aaxgevztdm1i5v6q6xousfc44xa90ykmk0/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
		if [ $? -eq 0 ]; then
			DOWNLOAD="YES"
		else
			DOWNLOAD="NO"
		fi
		if [[ ! $verbose == '1' ]]; then
			kill "$anim_pid" >/dev/null 2>&1
			wait "$anim_pid" 2>/dev/null
		fi
		if [ $DOWNLOAD == 'YES' ]; then
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				open /private/tmp/InstallAssistant.pkg
				echo -e "\033[1A\033[0K\033[1A\033[0K"
				echo -e ""
				echo -e "${BOLD}                               Download Complete   "
				echo -e "${RESET}${TITLE}"
				echo -e "                 Follow the on-screen instructions to install... "
				echo -n "       Once completed, press any key to return home, or S to install... "
				read -n 1 input
				if [[ "$input" == 's' || "$input" == 'S' ]]; then
					APPLICATIONSCREATE
				else
					SCRIPTLAYOUT
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
		echo -e "${RESET}${TITLE}${BOLD}                           Downloading macOS Sonoma...${RESET}${BODY}"
		echo -e ""
		echo -e -n "${RESET}${TITLE}                          Please Enter Your "
		sudo echo ""
		echo -e "\033[1A\033[0K${BODY}"
		if [[ ! $verbose == '1' ]]; then
			ANIMATIONDOWNLOAD &
			anim_pid=$!
		fi
		if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
			sudo rm -R /private/tmp/InstallAssistant.pkg
		fi
		Output sudo curl https://swcdn.apple.com/content/downloads/43/40/072-61299-A_Y6TZ03D5E8/dpzudbub2uj7lqy3cko50k4moqsu2lq5ui/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
		if [ $? -eq 0 ]; then
			DOWNLOAD="YES"
		else
			DOWNLOAD="NO"
		fi
		if [[ ! $verbose == '1' ]]; then
			kill "$anim_pid" >/dev/null 2>&1
			wait "$anim_pid" 2>/dev/null
		fi
		if [ $DOWNLOAD == 'YES' ]; then
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				open /private/tmp/InstallAssistant.pkg
				echo -e "\033[1A\033[0K\033[1A\033[0K"
				echo -e ""
				echo -e "${BOLD}                               Download Complete   "
				echo -e "${RESET}${TITLE}"
				echo -e "                 Follow the on-screen instructions to install... "
				echo -n "       Once completed, press any key to return home, or S to install... "
				read -n 1 input
				if [[ "$input" == 's' || "$input" == 'S' ]]; then
					APPLICATIONSCREATE
				else
					SCRIPTLAYOUT
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
		echo -e "${RESET}${TITLE}${BOLD}                          Downloading macOS Sequoia...${RESET}${BODY}"
		echo -e ""
		echo -e -n "${RESET}${TITLE}                          Please Enter Your "
		sudo echo ""
		echo -e "\033[1A\033[0K${BODY}"
		if [[ ! $verbose == '1' ]]; then
			ANIMATIONDOWNLOAD &
			anim_pid=$!
		fi
		if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
			sudo rm -R /private/tmp/InstallAssistant.pkg
		fi
		Output sudo curl https://swcdn.apple.com/content/downloads/09/16/082-33200-A_9FRARUF9NM/jnf31ewnvxlmf5ld7l7n7hzv6lkd6fiuz9/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
		if [ $? -eq 0 ]; then
			DOWNLOAD="YES"
		else
			DOWNLOAD="NO"
		fi
		if [[ ! $verbose == '1' ]]; then
			kill "$anim_pid" >/dev/null 2>&1
			wait "$anim_pid" 2>/dev/null
		fi
		if [ $DOWNLOAD == 'YES' ]; then
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				open /private/tmp/InstallAssistant.pkg
				echo -e "\033[1A\033[0K\033[1A\033[0K"
				echo -e ""
				echo -e "${BOLD}                               Download Complete   "
				echo -e "${RESET}${TITLE}"
				echo -e "                 Follow the on-screen instructions to install... "
				echo -n "       Once completed, press any key to return home, or S to install... "
				read -n 1 input
				if [[ "$input" == 's' || "$input" == 'S' ]]; then
					APPLICATIONSCREATE
				else
					SCRIPTLAYOUT
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
	echo -e "\033[1A\033[0K"
	echo -e "${RESET}${ERROR}${BOLD}                                Download failed   "
	echo -e "${RESET}${ERROR}                    Make sure you have an internet connection${RESET}${PROMPTSTYLE}${BOLD}"
	echo -e ""
	echo -n "      Press any key to return to the Home Menu (Press S to try again)... "
	read -n 1 input
	if [[ "$input" == 's' || "$input" == 'S' ]]; then
		echo ""
	elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
		break
	else
		SCRIPTLAYOUT
	fi
}

#Script Color Change
TESTELIGIBILITY()
{
	cd "$SCRIPTPATHMAIN"
	sed -i '' '1s/bash/bash/' macOS\ Creator.command
		if [ ! $? -eq 0 ]; then
			WINDOWBAR
			echo -e "${RESET}${ERROR}${BOLD}                         You cannot change script colors"
			echo -e "${RESET}${ERROR}                 The script is located in a read-only directory${RESET}"
			echo -e "${PROMPTSTYLE}${BOLD}"
			echo -n "                          Press any key to go back... "
			read -n 1
			SETTINGSMENU
		fi
}
SAVECOLORS()
{
	cd "$SCRIPTPATHMAIN"
	if [[ $FIRSTTIMEHERE == 'TRUE' ]]; then
		sed -i '' '8279s/CHANGECOLORS/GUIDE/' macOS\ Creator.command
	else
		sed -i '' '8279s/CHANGECOLORS/MAINMENU/' macOS\ Creator.command
	fi
	if [[ $verbose == "1" ]]; then
		"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
	else
		"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
	fi
}
CHANGECOLORS()
{
	if [[ $MODIFIED == 'YES' ]]; then
		WINDOWBAR
		echo -e "${RESET}${ERROR}${BOLD}         Script has been modified, you might not be able to change colors${RESET}"
		echo -e "${PROMPTSTYLE}${BOLD}"
		echo -n "                         Press any key to continue... "
		read -n 1
	fi
	if [[ $safe == '1' || $safe == '2' ]]; then
		WINDOWBAR
		echo -e "${RESET}${ERROR}${BOLD}                  You cannot change script colors in Safe Mode${RESET}"
		echo -e "${PROMPTSTYLE}${BOLD}"
		echo -n "                          Press any key to go back... "
		read -n 1
	else
		TESTELIGIBILITY
		if [[ $APPLESILICONE == 'YES' ]]; then
			if [[ -e "$SCRIPTPATHMAIN/macOS Creator.command" ]]; then
				while true; do
					WINDOWBAR
					if [[ $FIRSTTIMEHERE == 'TRUE' ]]; then
						echo -e "${RESET}${TITLE}${BOLD}                    To begin, choose the color style you like"
					else
						echo -e "${RESET}${TITLE}${BOLD}                         Choose the color style you like"
					fi
					echo -e ""
					echo -e "${RESET}$APPLECHIP"
					echo -e "${RESET}${DEFAULTBLUE}                    Default Blue.........................(2)"
					echo -e "${RESET}${DESERT}                    Desert Sands.........................(3)"
					echo -e "${RESET}${FOREST}                    Forest Green.........................(4)"
					echo -e "${RESET}${CINNAMON}                    Cinnamon Apple.......................(5)"
					echo -e "${RESET}${CLASSICBLACK}$CLASSICBLACKBW"
					echo -e ""
					if [[ $FIRSTTIMEHERE == 'TRUE' ]]; then
						echo -e "${RESET}${TITLE}             You can change these colors at any point from Settings"
					else
						echo -e "${RESET}${TITLE}                    Current color:${APP}${BOLD} $SETTINGCOLOR"
					fi
					if [[ ! $ENTERHERE == 'TRUE' ]]; then
						echo -e ""
						echo -e "${RESET}${TITLE}${BOLD}                               Press (S) to save"
					fi
					echo -e "${PROMPTSTYLE}${BOLD}"
					echo -n "                           Enter your option here: "
					read -n 1 input
					if [[ $input == '1' ]]; then
						echo -e ""
						echo -e ""
						if [[ $UIAPPEARANCE == 'Dark' ]]; then
							echo -e -n "${RESET}${BOLD}                                \033[38;5;117mPlease \033[38;5;111mwait... "
						else
							echo -e -n "${RESET}${BOLD}                                \033[38;5;33mPlease \033[38;5;63mwait... "
						fi
						COLORM1
					elif [[ $input == '2' ]]; then
						echo -e ""
						echo -e ""
						echo -e -n "${RESET}${DEFAULTBLUE}${BOLD}                                Please wait... "
						COLORBLUE
					elif [[ $input == '3' ]]; then
						echo -e ""
						echo -e ""
						echo -e -n "${RESET}${DESERT}${BOLD}                                Please wait... "
						COLORSANDS
					elif [[ $input == '4' ]]; then
						echo -e ""
						echo -e ""
						echo -e -n "${RESET}${FOREST}${BOLD}                                Please wait... "
						COLORFOREST
					elif [[ $input == '5' ]]; then
						echo -e ""
						echo -e ""
						echo -e -n "${RESET}${CINNAMON}${BOLD}                                Please wait... "
						CINNAMONCOLOR
					elif [[ $input == '6' ]]; then
						echo -e ""
						echo -e ""
						echo -e -n "${RESET}${CLASSICBLACK}${BOLD}                                Please wait... "
						COLORCLASSIC
					elif [[ $input == 'q' || $input == 'Q' ]]; then
						if [[ $ENTERHERE == 'TRUE' ]]; then
							SCRIPTLAYOUT
						else
							echo -e ""
							echo -e ""
							echo -n -e "${RESET}${ERROR}${BOLD}                 Please save your settings before you go back... "
							read -n 1
						fi
					elif [[ $input == 'w' || $input == 'W' ]]; then
						if [[ $ENTERHERE == 'TRUE' ]]; then
							break
						else
							echo -e ""
							echo -e ""
							echo -n -e "${RESET}${ERROR}${BOLD}                 Please save your settings before you go back... "
							read -n 1
						fi
					elif [[ $input == 's' || $input == 'S' ]]; then
						if [[ $ENTERHERE == 'TRUE' ]]; then
							WINDOWERROR
						else
							SAVECOLORS
						fi
					elif [[ $input == '?' || $input == '/' ]]; then
						HELPCOLORS
					elif [[ $input == '' ]]; then
						if [[ $ENTERHERE == 'TRUE' ]]; then
							WINDOWBAREND
						else
							echo -e ""
							echo -n -e "${RESET}${ERROR}${BOLD}                 Please save your settings before you cancel... "
							read -n 1
						fi
					else
						WINDOWERROR
					fi
				done
			else
				WINDOWBAR
				echo -e "${RESET}${ERROR}${BOLD}             Script name has been modified, you cannot change colors${RESET}"
				echo -e "${PROMPTSTYLE}${BOLD}"
				echo -n "                          Press any key to go back... "
				read -n 1
			fi
		else
			if [[ -e "$SCRIPTPATHMAIN/macOS Creator.command" ]]; then
				while true; do
					WINDOWBAR
					if [[ $FIRSTTIMEHERE == 'TRUE' ]]; then
						echo -e "${RESET}${TITLE}${BOLD}                    To begin, choose the color style you like"
					else
						echo -e "${RESET}${TITLE}${BOLD}                         Choose the color style you like"
					fi
					echo -e ""
					echo -e "${RESET}${DEFAULTBLUE}                    Default Blue.........................(1)"
					echo -e "${RESET}${DESERT}                    Desert Sands.........................(2)"
					echo -e "${RESET}${FOREST}                    Forest Green.........................(3)"
					echo -e "${RESET}${CINNAMON}                    Cinnamon Apple.......................(4)"
					echo -e "${RESET}${CLASSICBLACK}$CLASSICBLACKBW"
					echo -e ""
					if [[ $FIRSTTIMEHERE == 'TRUE' ]]; then
						echo -e "${RESET}${TITLE}             You can change these colors at any point from Settings"
					else
						echo -e "${RESET}${TITLE}                    Current color:${APP}${BOLD} $SETTINGCOLOR"
					fi
					if [[ ! $ENTERHERE == 'TRUE' ]]; then
						echo -e ""
						echo -e "${RESET}${TITLE}${BOLD}                               Press (S) to save"
					fi
					echo -e "${PROMPTSTYLE}${BOLD}"
					echo -n "                           Enter your option here: "
					read -n 1 input
					if [[ $input == '1' ]]; then
						echo -e ""
						echo -e ""
						echo -e -n "${RESET}${DEFAULTBLUE}${BOLD}                                Please wait... "
						COLORBLUE
					elif [[ $input == '2' ]]; then
						echo -e ""
						echo -e ""
						echo -e -n "${RESET}${DESERT}${BOLD}                                Please wait... "
						COLORSANDS
					elif [[ $input == '3' ]]; then
						echo -e ""
						echo -e ""
						echo -e -n "${RESET}${FOREST}${BOLD}                                Please wait... "
						COLORFOREST
					elif [[ $input == '4' ]]; then
						echo -e ""
						echo -e ""
						echo -e -n "${RESET}${CINNAMON}${BOLD}                                Please wait... "
						CINNAMONCOLOR
					elif [[ $input == '5' ]]; then
						echo -e ""
						echo -e ""
						echo -e -n "${RESET}${CLASSICBLACK}${BOLD}                                Please wait... "
						COLORCLASSIC
					elif [[ $input == 'q' || $input == 'Q' ]]; then
						if [[ $ENTERHERE == 'TRUE' ]]; then
							SCRIPTLAYOUT
						else
							echo -e ""
							echo -e ""
							echo -n -e "${RESET}${ERROR}${BOLD}                 Please save your settings before you go back... "
							read -n 1
						fi
					elif [[ $input == 'w' || $input == 'W' ]]; then
						if [[ $ENTERHERE == 'TRUE' ]]; then
							break
						else
							echo -e ""
							echo -e ""
							echo -n -e "${RESET}${ERROR}${BOLD}                 Please save your settings before you go back... "
							read -n 1
						fi
					elif [[ $input == 's' || $input == 'S' ]]; then
						if [[ $ENTERHERE == 'TRUE' ]]; then
							WINDOWERROR
						else
							SAVECOLORS
						fi
					elif [[ $input == '?' || $input == '/' ]]; then
						HELPCOLORS
					elif [[ $input == '' ]]; then
						if [[ $ENTERHERE == 'TRUE' ]]; then
							WINDOWBAREND
						else
							echo -e ""
							echo -n -e "${RESET}${ERROR}${BOLD}                 Please save your settings before you cancel... "
							read -n 1
						fi
					else
						WINDOWERROR
					fi
				done
			else
				WINDOWBAR
				echo -e "${RESET}${ERROR}${BOLD}             Script name has been modified, you cannot change colors${RESET}"
				echo -e "${PROMPTSTYLE}${BOLD}"
				echo -n "                          Press any key to go back... "
				read -n 1
			fi
		fi
	fi
}
COLORBLUE()
{
	cd "$SCRIPTPATHMAIN"
	if [[ "$HOMEUSER" == "YES" ]]; then
		Output rm -R .desertsandssetting
		Output rm -R .forestgreensetting
		Output rm -R .cinnamonapplecolor
		Output rm -R .classicsetting
		Output rm -R .colorm1setting
		touch .defaultbluesetting
	fi
	sed -i '' '8279s/MAINMENU/CHANGECOLORS/' macOS\ Creator.command
	sed -i '' '71s/"38;5;130m/"38;5;23m/' macOS\ Creator.command && sed -i '' '71s/"38;5;0m/"38;5;23m/' macOS\ Creator.command && sed -i '' '71s/"38;5;22m/"38;5;23m/' macOS\ Creator.command && sed -i '' '71s/"38;5;88m/"38;5;23m/' macOS\ Creator.command && sed -i '' '71s/"38;5;214m/"38;5;23m/' macOS\ Creator.command
	sed -i '' '72s/"38;5;172m/"38;5;24m/' macOS\ Creator.command && sed -i '' '72s/"38;5;0m/"38;5;24m/' macOS\ Creator.command && sed -i '' '72s/"38;5;65m/"38;5;24m/' macOS\ Creator.command && sed -i '' '72s/"38;5;124m/"38;5;24m/' macOS\ Creator.command && sed -i '' '72s/"38;5;209m/"38;5;24m/' macOS\ Creator.command
	sed -i '' '73s/"38;5;130m/"38;5;23m/' macOS\ Creator.command && sed -i '' '73s/"38;5;0m/"38;5;23m/' macOS\ Creator.command && sed -i '' '73s/"38;5;22m/"38;5;23m/' macOS\ Creator.command && sed -i '' '73s/"38;5;88m/"38;5;23m/' macOS\ Creator.command && sed -i '' '73s/"38;5;163m/"38;5;23m/' macOS\ Creator.command
	sed -i '' '74s/"38;5;208m/"38;5;66m/' macOS\ Creator.command && sed -i '' '74s/"38;5;0m/"38;5;66m/' macOS\ Creator.command && sed -i '' '74s/"38;5;58m/"38;5;66m/' macOS\ Creator.command && sed -i '' '74s/"38;5;1m/"38;5;66m/' macOS\ Creator.command && sed -i '' '74s/"38;5;38m/"38;5;66m/' macOS\ Creator.command
	sed -i '' '75s/"38;5;166m/"38;5;67m/' macOS\ Creator.command && sed -i '' '75s/"38;5;0m/"38;5;67m/' macOS\ Creator.command && sed -i '' '75s/"38;5;64m/"38;5;67m/' macOS\ Creator.command && sed -i '' '75s/"38;5;52m/"38;5;67m/' macOS\ Creator.command && sed -i '' '75s/"38;5;34m/"38;5;67m/' macOS\ Creator.command
	sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;0m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;0m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command
	sed -i '' '78s/"38;5;1m/"38;5;31m/' macOS\ Creator.command && sed -i '' '78s/"38;5;0m/"38;5;31m/' macOS\ Creator.command && sed -i '' '78s/"38;5;88m/"38;5;31m/' macOS\ Creator.command && sed -i '' '78s/"38;5;130m/"38;5;31m/' macOS\ Creator.command && sed -i '' '78s/"38;5;55m/"38;5;31m/' macOS\ Creator.command
	sed -i '' '84s/"38;5;180m/"38;5;158m/' macOS\ Creator.command && sed -i '' '84s/"38;5;255m/"38;5;158m/' macOS\ Creator.command && sed -i '' '84s/"38;5;108m/"38;5;158m/' macOS\ Creator.command && sed -i '' '84s/"38;5;88m/"38;5;158m/' macOS\ Creator.command && sed -i '' '84s/"38;5;185m/"38;5;158m/' macOS\ Creator.command
	sed -i '' '85s/"38;5;215m/"38;5;153m/' macOS\ Creator.command && sed -i '' '85s/"38;5;255m/"38;5;153m/' macOS\ Creator.command && sed -i '' '85s/"38;5;193m/"38;5;153m/' macOS\ Creator.command && sed -i '' '85s/"38;5;137m/"38;5;153m/' macOS\ Creator.command && sed -i '' '85s/"38;5;209m/"38;5;153m/' macOS\ Creator.command
	sed -i '' '86s/"38;5;180m/"38;5;158m/' macOS\ Creator.command && sed -i '' '86s/"38;5;255m/"38;5;158m/' macOS\ Creator.command && sed -i '' '86s/"38;5;108m/"38;5;158m/' macOS\ Creator.command && sed -i '' '86s/"38;5;88m/"38;5;158m/' macOS\ Creator.command && sed -i '' '86s/"38;5;201m/"38;5;158m/' macOS\ Creator.command
	sed -i '' '87s/"38;5;208m/"38;5;152m/' macOS\ Creator.command && sed -i '' '87s/"38;5;255m/"38;5;152m/' macOS\ Creator.command && sed -i '' '87s/"38;5;150m/"38;5;152m/' macOS\ Creator.command && sed -i '' '87s/"38;5;124m/"38;5;152m/' macOS\ Creator.command && sed -i '' '87s/"38;5;123m/"38;5;152m/' macOS\ Creator.command
	sed -i '' '88s/"38;5;166m/"38;5;111m/' macOS\ Creator.command && sed -i '' '88s/"38;5;255m/"38;5;111m/' macOS\ Creator.command && sed -i '' '88s/"38;5;194m/"38;5;111m/' macOS\ Creator.command && sed -i '' '88s/"38;5;138m/"38;5;111m/' macOS\ Creator.command && sed -i '' '88s/"38;5;156m/"38;5;111m/' macOS\ Creator.command
	sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;255m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;106m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;255m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command
	sed -i '' '91s/"38;5;197m/"38;5;38m/' macOS\ Creator.command && sed -i '' '91s/"38;5;255m/"38;5;38m/' macOS\ Creator.command && sed -i '' '91s/"38;5;187m/"38;5;38m/' macOS\ Creator.command && sed -i '' '91s/"38;5;210m/"38;5;38m/' macOS\ Creator.command && sed -i '' '91s/"38;5;135m/"38;5;38m/' macOS\ Creator.command
	if [[ $verbose == "1" ]]; then
		if [[ $CLEANED == 'TRUE' ]]; then
			"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
		else
			"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
		fi
	else
		"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
	fi
}
COLORSANDS()
{
	cd "$SCRIPTPATHMAIN"
	if [[ "$HOMEUSER" == "YES" ]]; then
		Output rm -R .defaultbluesetting
		Output rm -R .forestgreensetting
		Output rm -R .cinnamonapplecolor
		Output rm -R .classicsetting
		Output rm -R .colorm1setting
		touch .desertsandssetting
	fi
	sed -i '' '8279s/MAINMENU/CHANGECOLORS/' macOS\ Creator.command
	sed -i '' '71s/"38;5;23m/"38;5;130m/' macOS\ Creator.command && sed -i '' '71s/"38;5;0m/"38;5;130m/' macOS\ Creator.command && sed -i '' '71s/"38;5;22m/"38;5;130m/' macOS\ Creator.command && sed -i '' '71s/"38;5;88m/"38;5;130m/' macOS\ Creator.command && sed -i '' '71s/"38;5;214m/"38;5;130m/' macOS\ Creator.command
	sed -i '' '72s/"38;5;24m/"38;5;172m/' macOS\ Creator.command && sed -i '' '72s/"38;5;0m/"38;5;172m/' macOS\ Creator.command && sed -i '' '72s/"38;5;65m/"38;5;172m/' macOS\ Creator.command && sed -i '' '72s/"38;5;124m/"38;5;172m/' macOS\ Creator.command && sed -i '' '72s/"38;5;209m/"38;5;172m/' macOS\ Creator.command
	sed -i '' '73s/"38;5;23m/"38;5;130m/' macOS\ Creator.command && sed -i '' '73s/"38;5;0m/"38;5;130m/' macOS\ Creator.command && sed -i '' '73s/"38;5;22m/"38;5;130m/' macOS\ Creator.command && sed -i '' '73s/"38;5;88m/"38;5;130m/' macOS\ Creator.command && sed -i '' '73s/"38;5;163m/"38;5;130m/' macOS\ Creator.command
	sed -i '' '74s/"38;5;66m/"38;5;208m/' macOS\ Creator.command && sed -i '' '74s/"38;5;0m/"38;5;208m/' macOS\ Creator.command && sed -i '' '74s/"38;5;58m/"38;5;208m/' macOS\ Creator.command && sed -i '' '74s/"38;5;1m/"38;5;208m/' macOS\ Creator.command && sed -i '' '74s/"38;5;38m/"38;5;208m/' macOS\ Creator.command
	sed -i '' '75s/"38;5;67m/"38;5;166m/' macOS\ Creator.command && sed -i '' '75s/"38;5;0m/"38;5;166m/' macOS\ Creator.command && sed -i '' '75s/"38;5;64m/"38;5;166m/' macOS\ Creator.command && sed -i '' '75s/"38;5;52m/"38;5;166m/' macOS\ Creator.command && sed -i '' '75s/"38;5;34m/"38;5;166m/' macOS\ Creator.command
	sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;0m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;0m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command
	sed -i '' '78s/"38;5;31m/"38;5;1m/' macOS\ Creator.command && sed -i '' '78s/"38;5;0m/"38;5;1m/' macOS\ Creator.command && sed -i '' '78s/"38;5;88m/"38;5;1m/' macOS\ Creator.command && sed -i '' '78s/"38;5;130m/"38;5;1m/' macOS\ Creator.command && sed -i '' '78s/"38;5;55m/"38;5;1m/' macOS\ Creator.command
	sed -i '' '84s/"38;5;158m/"38;5;180m/' macOS\ Creator.command && sed -i '' '84s/"38;5;255m/"38;5;180m/' macOS\ Creator.command && sed -i '' '84s/"38;5;108m/"38;5;180m/' macOS\ Creator.command && sed -i '' '84s/"38;5;88m/"38;5;180m/' macOS\ Creator.command && sed -i '' '84s/"38;5;185m/"38;5;180m/' macOS\ Creator.command
	sed -i '' '85s/"38;5;153m/"38;5;215m/' macOS\ Creator.command && sed -i '' '85s/"38;5;255m/"38;5;215m/' macOS\ Creator.command && sed -i '' '85s/"38;5;193m/"38;5;215m/' macOS\ Creator.command && sed -i '' '85s/"38;5;137m/"38;5;215m/' macOS\ Creator.command && sed -i '' '85s/"38;5;209m/"38;5;215m/' macOS\ Creator.command
	sed -i '' '86s/"38;5;158m/"38;5;180m/' macOS\ Creator.command && sed -i '' '86s/"38;5;255m/"38;5;180m/' macOS\ Creator.command && sed -i '' '86s/"38;5;108m/"38;5;180m/' macOS\ Creator.command && sed -i '' '86s/"38;5;88m/"38;5;180m/' macOS\ Creator.command && sed -i '' '86s/"38;5;201m/"38;5;180m/' macOS\ Creator.command
	sed -i '' '87s/"38;5;152m/"38;5;208m/' macOS\ Creator.command && sed -i '' '87s/"38;5;255m/"38;5;208m/' macOS\ Creator.command && sed -i '' '87s/"38;5;150m/"38;5;208m/' macOS\ Creator.command && sed -i '' '87s/"38;5;124m/"38;5;208m/' macOS\ Creator.command && sed -i '' '87s/"38;5;123m/"38;5;208m/' macOS\ Creator.command
	sed -i '' '88s/"38;5;111m/"38;5;166m/' macOS\ Creator.command && sed -i '' '88s/"38;5;255m/"38;5;166m/' macOS\ Creator.command && sed -i '' '88s/"38;5;194m/"38;5;166m/' macOS\ Creator.command && sed -i '' '88s/"38;5;138m/"38;5;166m/' macOS\ Creator.command && sed -i '' '88s/"38;5;156m/"38;5;166m/' macOS\ Creator.command
	sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;255m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;106m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;255m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command
	sed -i '' '91s/"38;5;38m/"38;5;197m/' macOS\ Creator.command && sed -i '' '91s/"38;5;255m/"38;5;197m/' macOS\ Creator.command && sed -i '' '91s/"38;5;187m/"38;5;197m/' macOS\ Creator.command && sed -i '' '91s/"38;5;210m/"38;5;197m/' macOS\ Creator.command && sed -i '' '91s/"38;5;135m/"38;5;197m/' macOS\ Creator.command
	if [[ $verbose == "1" ]]; then
		"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
	else
		"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
	fi
}
COLORFOREST()
{
	cd "$SCRIPTPATHMAIN"
	if [[ "$HOMEUSER" == "YES" ]]; then
		Output rm -R .desertsandssetting
		Output rm -R .defaultbluesetting
		Output rm -R .cinnamonapplecolor
		Output rm -R .classicsetting
		Output rm -R .colorm1setting
		touch .forestgreensetting
	fi
	sed -i '' '8279s/MAINMENU/CHANGECOLORS/' macOS\ Creator.command
	sed -i '' '71s/"38;5;130m/"38;5;22m/' macOS\ Creator.command && sed -i '' '71s/"38;5;0m/"38;5;22m/' macOS\ Creator.command && sed -i '' '71s/"38;5;23m/"38;5;22m/' macOS\ Creator.command && sed -i '' '71s/"38;5;88m/"38;5;22m/' macOS\ Creator.command && sed -i '' '71s/"38;5;214m/"38;5;22m/' macOS\ Creator.command
	sed -i '' '72s/"38;5;172m/"38;5;65m/' macOS\ Creator.command && sed -i '' '72s/"38;5;0m/"38;5;65m/' macOS\ Creator.command && sed -i '' '72s/"38;5;24m/"38;5;65m/' macOS\ Creator.command && sed -i '' '72s/"38;5;124m/"38;5;65m/' macOS\ Creator.command && sed -i '' '72s/"38;5;209m/"38;5;65m/' macOS\ Creator.command
	sed -i '' '73s/"38;5;130m/"38;5;22m/' macOS\ Creator.command && sed -i '' '73s/"38;5;0m/"38;5;22m/' macOS\ Creator.command && sed -i '' '73s/"38;5;23m/"38;5;22m/' macOS\ Creator.command && sed -i '' '73s/"38;5;88m/"38;5;22m/' macOS\ Creator.command && sed -i '' '73s/"38;5;163m/"38;5;22m/' macOS\ Creator.command
	sed -i '' '74s/"38;5;208m/"38;5;58m/' macOS\ Creator.command && sed -i '' '74s/"38;5;0m/"38;5;58m/' macOS\ Creator.command && sed -i '' '74s/"38;5;66m/"38;5;58m/' macOS\ Creator.command && sed -i '' '74s/"38;5;1m/"38;5;58m/' macOS\ Creator.command && sed -i '' '74s/"38;5;38m/"38;5;58m/' macOS\ Creator.command
	sed -i '' '75s/"38;5;166m/"38;5;64m/' macOS\ Creator.command && sed -i '' '75s/"38;5;0m/"38;5;64m/' macOS\ Creator.command && sed -i '' '75s/"38;5;67m/"38;5;64m/' macOS\ Creator.command && sed -i '' '75s/"38;5;52m/"38;5;64m/' macOS\ Creator.command && sed -i '' '75s/"38;5;34m/"38;5;64m/' macOS\ Creator.command
	sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;0m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;0m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command
	sed -i '' '78s/"38;5;1m/"38;5;88m/' macOS\ Creator.command && sed -i '' '78s/"38;5;0m/"38;5;88m/' macOS\ Creator.command && sed -i '' '78s/"38;5;31m/"38;5;88m/' macOS\ Creator.command && sed -i '' '78s/"38;5;130m/"38;5;88m/' macOS\ Creator.command && sed -i '' '78s/"38;5;55m/"38;5;88m/' macOS\ Creator.command
	sed -i '' '84s/"38;5;180m/"38;5;108m/' macOS\ Creator.command && sed -i '' '84s/"38;5;255m/"38;5;108m/' macOS\ Creator.command && sed -i '' '84s/"38;5;158m/"38;5;108m/' macOS\ Creator.command && sed -i '' '84s/"38;5;88m/"38;5;108m/' macOS\ Creator.command && sed -i '' '84s/"38;5;185m/"38;5;108m/' macOS\ Creator.command
	sed -i '' '85s/"38;5;215m/"38;5;193m/' macOS\ Creator.command && sed -i '' '85s/"38;5;255m/"38;5;193m/' macOS\ Creator.command && sed -i '' '85s/"38;5;153m/"38;5;193m/' macOS\ Creator.command && sed -i '' '85s/"38;5;137m/"38;5;193m/' macOS\ Creator.command && sed -i '' '85s/"38;5;209m/"38;5;193m/' macOS\ Creator.command
	sed -i '' '86s/"38;5;180m/"38;5;108m/' macOS\ Creator.command && sed -i '' '86s/"38;5;255m/"38;5;108m/' macOS\ Creator.command && sed -i '' '86s/"38;5;158m/"38;5;108m/' macOS\ Creator.command && sed -i '' '86s/"38;5;88m/"38;5;108m/' macOS\ Creator.command && sed -i '' '86s/"38;5;201m/"38;5;108m/' macOS\ Creator.command
	sed -i '' '87s/"38;5;208m/"38;5;150m/' macOS\ Creator.command && sed -i '' '87s/"38;5;255m/"38;5;150m/' macOS\ Creator.command && sed -i '' '87s/"38;5;152m/"38;5;150m/' macOS\ Creator.command && sed -i '' '87s/"38;5;124m/"38;5;150m/' macOS\ Creator.command && sed -i '' '87s/"38;5;123m/"38;5;150m/' macOS\ Creator.command
	sed -i '' '88s/"38;5;166m/"38;5;194m/' macOS\ Creator.command && sed -i '' '88s/"38;5;255m/"38;5;194m/' macOS\ Creator.command && sed -i '' '88s/"38;5;111m/"38;5;194m/' macOS\ Creator.command && sed -i '' '88s/"38;5;138m/"38;5;194m/' macOS\ Creator.command && sed -i '' '88s/"38;5;156m/"38;5;194m/' macOS\ Creator.command
	sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;255m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;106m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;255m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command
	sed -i '' '91s/"38;5;197m/"38;5;187m/' macOS\ Creator.command && sed -i '' '91s/"38;5;255m/"38;5;187m/' macOS\ Creator.command && sed -i '' '91s/"38;5;38m/"38;5;187m/' macOS\ Creator.command && sed -i '' '91s/"38;5;210m/"38;5;187m/' macOS\ Creator.command && sed -i '' '91s/"38;5;135m/"38;5;187m/' macOS\ Creator.command
	if [[ $verbose == "1" ]]; then
		"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
	else
		"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
	fi
}
CINNAMONCOLOR()
{
	cd "$SCRIPTPATHMAIN"
	if [[ "$HOMEUSER" == "YES" ]]; then
		Output rm -R .desertsandssetting
		Output rm -R .defaultbluesetting
		Output rm -R .forestgreensetting
		Output rm -R .classicsetting
		Output rm -R .colorm1setting
		touch .cinnamonapplecolor
	fi
	sed -i '' '8279s/MAINMENU/CHANGECOLORS/' macOS\ Creator.command
	sed -i '' '71s/"38;5;130m/"38;5;88m/' macOS\ Creator.command && sed -i '' '71s/"38;5;0m/"38;5;88m/' macOS\ Creator.command && sed -i '' '71s/"38;5;23m/"38;5;88m/' macOS\ Creator.command && sed -i '' '71s/"38;5;22m/"38;5;88m/' macOS\ Creator.command && sed -i '' '71s/"38;5;214m/"38;5;88m/' macOS\ Creator.command
	sed -i '' '72s/"38;5;172m/"38;5;124m/' macOS\ Creator.command && sed -i '' '72s/"38;5;0m/"38;5;124m/' macOS\ Creator.command && sed -i '' '72s/"38;5;24m/"38;5;124m/' macOS\ Creator.command && sed -i '' '72s/"38;5;65m/"38;5;124m/' macOS\ Creator.command && sed -i '' '72s/"38;5;209m/"38;5;124m/' macOS\ Creator.command
	sed -i '' '73s/"38;5;130m/"38;5;88m/' macOS\ Creator.command && sed -i '' '73s/"38;5;0m/"38;5;88m/' macOS\ Creator.command && sed -i '' '73s/"38;5;23m/"38;5;88m/' macOS\ Creator.command && sed -i '' '73s/"38;5;22m/"38;5;88m/' macOS\ Creator.command && sed -i '' '73s/"38;5;163m/"38;5;88m/' macOS\ Creator.command
	sed -i '' '74s/"38;5;208m/"38;5;1m/' macOS\ Creator.command && sed -i '' '74s/"38;5;0m/"38;5;1m/' macOS\ Creator.command && sed -i '' '74s/"38;5;66m/"38;5;1m/' macOS\ Creator.command && sed -i '' '74s/"38;5;58m/"38;5;1m/' macOS\ Creator.command && sed -i '' '74s/"38;5;38m/"38;5;1m/' macOS\ Creator.command
	sed -i '' '75s/"38;5;166m/"38;5;52m/' macOS\ Creator.command && sed -i '' '75s/"38;5;0m/"38;5;52m/' macOS\ Creator.command && sed -i '' '75s/"38;5;67m/"38;5;52m/' macOS\ Creator.command && sed -i '' '75s/"38;5;64m/"38;5;52m/' macOS\ Creator.command && sed -i '' '75s/"38;5;34m/"38;5;52m/' macOS\ Creator.command
	sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;0m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;0m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command
	sed -i '' '78s/"38;5;1m/"38;5;130m/' macOS\ Creator.command && sed -i '' '78s/"38;5;0m/"38;5;130m/' macOS\ Creator.command && sed -i '' '78s/"38;5;31m/"38;5;130m/' macOS\ Creator.command && sed -i '' '78s/"38;5;88m/"38;5;130m/' macOS\ Creator.command && sed -i '' '78s/"38;5;55m/"38;5;130m/' macOS\ Creator.command
	sed -i '' '84s/"38;5;180m/"38;5;88m/' macOS\ Creator.command && sed -i '' '84s/"38;5;255m/"38;5;88m/' macOS\ Creator.command && sed -i '' '84s/"38;5;158m/"38;5;88m/' macOS\ Creator.command && sed -i '' '84s/"38;5;108m/"38;5;88m/' macOS\ Creator.command && sed -i '' '84s/"38;5;185m/"38;5;88m/' macOS\ Creator.command
	sed -i '' '85s/"38;5;215m/"38;5;137m/' macOS\ Creator.command && sed -i '' '85s/"38;5;255m/"38;5;137m/' macOS\ Creator.command  && sed -i '' '85s/"38;5;153m/"38;5;137m/' macOS\ Creator.command  && sed -i '' '85s/"38;5;193m/"38;5;137m/' macOS\ Creator.command && sed -i '' '85s/"38;5;209m/"38;5;137m/' macOS\ Creator.command
	sed -i '' '86s/"38;5;180m/"38;5;88m/' macOS\ Creator.command && sed -i '' '86s/"38;5;255m/"38;5;88m/' macOS\ Creator.command && sed -i '' '86s/"38;5;158m/"38;5;88m/' macOS\ Creator.command && sed -i '' '86s/"38;5;108m/"38;5;88m/' macOS\ Creator.command && sed -i '' '86s/"38;5;201m/"38;5;88m/' macOS\ Creator.command
	sed -i '' '87s/"38;5;208m/"38;5;124m/' macOS\ Creator.command && sed -i '' '87s/"38;5;255m/"38;5;124m/' macOS\ Creator.command && sed -i '' '87s/"38;5;152m/"38;5;124m/' macOS\ Creator.command && sed -i '' '87s/"38;5;150m/"38;5;124m/' macOS\ Creator.command && sed -i '' '87s/"38;5;123m/"38;5;124m/' macOS\ Creator.command
	sed -i '' '88s/"38;5;166m/"38;5;138m/' macOS\ Creator.command && sed -i '' '88s/"38;5;255m/"38;5;138m/' macOS\ Creator.command && sed -i '' '88s/"38;5;111m/"38;5;138m/' macOS\ Creator.command && sed -i '' '88s/"38;5;194m/"38;5;138m/' macOS\ Creator.command && sed -i '' '88s/"38;5;156m/"38;5;138m/' macOS\ Creator.command
	sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;255m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;106m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;255m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command
	sed -i '' '91s/"38;5;197m/"38;5;210m/' macOS\ Creator.command && sed -i '' '91s/"38;5;255m/"38;5;210m/' macOS\ Creator.command && sed -i '' '91s/"38;5;38m/"38;5;210m/' macOS\ Creator.command && sed -i '' '91s/"38;5;187m/"38;5;210m/' macOS\ Creator.command && sed -i '' '91s/"38;5;135m/"38;5;210m/' macOS\ Creator.command
	if [[ $verbose == "1" ]]; then
		"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
	else
		"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
	fi
}
COLORCLASSIC()
{
	cd "$SCRIPTPATHMAIN"
	if [[ "$HOMEUSER" == "YES" ]]; then
		Output rm -R .desertsandssetting
		Output rm -R .forestgreensetting
		Output rm -R .cinnamonapplecolor
		Output rm -R .defaultbluesetting
		Output rm -R .colorm1setting
		touch .classicsetting
	fi
	sed -i '' '8279s/MAINMENU/CHANGECOLORS/' macOS\ Creator.command
	sed -i '' '71s/"38;5;23m/"38;5;0m/' macOS\ Creator.command && sed -i '' '71s/"38;5;130m/"38;5;0m/' macOS\ Creator.command && sed -i '' '71s/"38;5;22m/"38;5;0m/' macOS\ Creator.command && sed -i '' '71s/"38;5;88m/"38;5;0m/' macOS\ Creator.command && sed -i '' '71s/"38;5;214m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '72s/"38;5;24m/"38;5;0m/' macOS\ Creator.command && sed -i '' '72s/"38;5;172m/"38;5;0m/' macOS\ Creator.command && sed -i '' '72s/"38;5;65m/"38;5;0m/' macOS\ Creator.command && sed -i '' '72s/"38;5;124m/"38;5;0m/' macOS\ Creator.command && sed -i '' '72s/"38;5;209m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '73s/"38;5;23m/"38;5;0m/' macOS\ Creator.command && sed -i '' '73s/"38;5;130m/"38;5;0m/' macOS\ Creator.command && sed -i '' '73s/"38;5;22m/"38;5;0m/' macOS\ Creator.command && sed -i '' '73s/"38;5;88m/"38;5;0m/' macOS\ Creator.command && sed -i '' '73s/"38;5;163m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '74s/"38;5;66m/"38;5;0m/' macOS\ Creator.command && sed -i '' '74s/"38;5;208m/"38;5;0m/' macOS\ Creator.command && sed -i '' '74s/"38;5;58m/"38;5;0m/' macOS\ Creator.command && sed -i '' '74s/"38;5;1m/"38;5;0m/' macOS\ Creator.command && sed -i '' '74s/"38;5;38m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '75s/"38;5;67m/"38;5;0m/' macOS\ Creator.command && sed -i '' '75s/"38;5;166m/"38;5;0m/' macOS\ Creator.command && sed -i '' '75s/"38;5;64m/"38;5;0m/' macOS\ Creator.command && sed -i '' '75s/"38;5;52m/"38;5;0m/' macOS\ Creator.command && sed -i '' '75s/"38;5;34m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '76s/"38;5;160m/"38;5;0m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;0m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;0m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;0m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '77s/"38;5;9m/"38;5;0m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;0m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;0m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;0m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '78s/"38;5;31m/"38;5;0m/' macOS\ Creator.command && sed -i '' '78s/"38;5;1m/"38;5;0m/' macOS\ Creator.command && sed -i '' '78s/"38;5;88m/"38;5;0m/' macOS\ Creator.command && sed -i '' '78s/"38;5;130m/"38;5;0m/' macOS\ Creator.command && sed -i '' '78s/"38;5;55m/"38;5;0m/' macOS\ Creator.command
	sed -i '' '84s/"38;5;158m/"38;5;255m/' macOS\ Creator.command && sed -i '' '84s/"38;5;180m/"38;5;255m/' macOS\ Creator.command && sed -i '' '84s/"38;5;108m/"38;5;255m/' macOS\ Creator.command && sed -i '' '84s/"38;5;88m/"38;5;255m/' macOS\ Creator.command && sed -i '' '84s/"38;5;185m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '85s/"38;5;153m/"38;5;255m/' macOS\ Creator.command && sed -i '' '85s/"38;5;215m/"38;5;255m/' macOS\ Creator.command && sed -i '' '85s/"38;5;193m/"38;5;255m/' macOS\ Creator.command && sed -i '' '85s/"38;5;137m/"38;5;255m/' macOS\ Creator.command && sed -i '' '85s/"38;5;209m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '86s/"38;5;158m/"38;5;255m/' macOS\ Creator.command && sed -i '' '86s/"38;5;180m/"38;5;255m/' macOS\ Creator.command && sed -i '' '86s/"38;5;108m/"38;5;255m/' macOS\ Creator.command && sed -i '' '86s/"38;5;88m/"38;5;255m/' macOS\ Creator.command && sed -i '' '86s/"38;5;201m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '87s/"38;5;152m/"38;5;255m/' macOS\ Creator.command && sed -i '' '87s/"38;5;208m/"38;5;255m/' macOS\ Creator.command && sed -i '' '87s/"38;5;150m/"38;5;255m/' macOS\ Creator.command && sed -i '' '87s/"38;5;124m/"38;5;255m/' macOS\ Creator.command && sed -i '' '87s/"38;5;123m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '88s/"38;5;111m/"38;5;255m/' macOS\ Creator.command && sed -i '' '88s/"38;5;166m/"38;5;255m/' macOS\ Creator.command && sed -i '' '88s/"38;5;194m/"38;5;255m/' macOS\ Creator.command && sed -i '' '88s/"38;5;138m/"38;5;255m/' macOS\ Creator.command && sed -i '' '88s/"38;5;156m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '89s/"38;5;160m/"38;5;255m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;255m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;255m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;255m/' macOS\ Creator.command && sed -i '' '89s/"38;5;106m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '90s/"38;5;196m/"38;5;255m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;255m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;255m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;255m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;255m/' macOS\ Creator.command
	sed -i '' '91s/"38;5;38m/"38;5;255m/' macOS\ Creator.command && sed -i '' '91s/"38;5;197m/"38;5;255m/' macOS\ Creator.command && sed -i '' '91s/"38;5;187m/"38;5;255m/' macOS\ Creator.command && sed -i '' '91s/"38;5;210m/"38;5;255m/' macOS\ Creator.command && sed -i '' '91s/"38;5;135m/"38;5;255m/' macOS\ Creator.command
	if [[ $verbose == "1" ]]; then
		"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
	else
		"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
	fi
}
COLORM1()
{
	cd "$SCRIPTPATHMAIN"
	if [[ "$HOMEUSER" == "YES" ]]; then
		Output rm -R .desertsandssetting
		Output rm -R .forestgreensetting
		Output rm -R .classicsetting
		Output rm -R .cinnamonapplecolor
		Output rm -R .defaultbluesetting
		touch .colorm1setting
	fi
	sed -i '' '8279s/MAINMENU/CHANGECOLORS/' macOS\ Creator.command
	sed -i '' '71s/"38;5;23m/"38;5;214m/' macOS\ Creator.command && sed -i '' '71s/"38;5;130m/"38;5;214m/' macOS\ Creator.command && sed -i '' '71s/"38;5;22m/"38;5;214m/' macOS\ Creator.command && sed -i '' '71s/"38;5;0m/"38;5;214m/' macOS\ Creator.command && sed -i '' '71s/"38;5;88m/"38;5;214m/' macOS\ Creator.command && sed -i '' '71s/"38;5;30m/"38;5;214m/' macOS\ Creator.command
	sed -i '' '72s/"38;5;24m/"38;5;209m/' macOS\ Creator.command && sed -i '' '72s/"38;5;172m/"38;5;209m/' macOS\ Creator.command && sed -i '' '72s/"38;5;65m/"38;5;209m/' macOS\ Creator.command && sed -i '' '72s/"38;5;0m/"38;5;209m/' macOS\ Creator.command && sed -i '' '72s/"38;5;124m/"38;5;209m/' macOS\ Creator.command && sed -i '' '72s/"38;5;23m/"38;5;209m/' macOS\ Creator.command
	sed -i '' '73s/"38;5;23m/"38;5;163m/' macOS\ Creator.command && sed -i '' '73s/"38;5;130m/"38;5;163m/' macOS\ Creator.command && sed -i '' '73s/"38;5;22m/"38;5;163m/' macOS\ Creator.command && sed -i '' '73s/"38;5;0m/"38;5;163m/' macOS\ Creator.command && sed -i '' '73s/"38;5;88m/"38;5;163m/' macOS\ Creator.command && sed -i '' '73s/"38;5;30m/"38;5;163m/' macOS\ Creator.command
	sed -i '' '74s/"38;5;66m/"38;5;38m/' macOS\ Creator.command && sed -i '' '74s/"38;5;208m/"38;5;38m/' macOS\ Creator.command && sed -i '' '74s/"38;5;58m/"38;5;38m/' macOS\ Creator.command && sed -i '' '74s/"38;5;0m/"38;5;38m/' macOS\ Creator.command && sed -i '' '74s/"38;5;1m/"38;5;38m/' macOS\ Creator.command && sed -i '' '74s/"38;5;109m/"38;5;38m/' macOS\ Creator.command
	sed -i '' '75s/"38;5;67m/"38;5;34m/' macOS\ Creator.command && sed -i '' '75s/"38;5;166m/"38;5;34m/' macOS\ Creator.command && sed -i '' '75s/"38;5;64m/"38;5;34m/' macOS\ Creator.command && sed -i '' '75s/"38;5;0m/"38;5;34m/' macOS\ Creator.command && sed -i '' '75s/"38;5;52m/"38;5;34m/' macOS\ Creator.command && sed -i '' '75s/"38;5;30m/"38;5;34m/' macOS\ Creator.command
	sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;0m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '76s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;0m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command && sed -i '' '77s/"38;5;9m/"38;5;9m/' macOS\ Creator.command
	sed -i '' '78s/"38;5;31m/"38;5;55m/' macOS\ Creator.command && sed -i '' '78s/"38;5;1m/"38;5;55m/' macOS\ Creator.command && sed -i '' '78s/"38;5;88m/"38;5;55m/' macOS\ Creator.command && sed -i '' '78s/"38;5;0m/"38;5;55m/' macOS\ Creator.command && sed -i '' '78s/"38;5;130m/"38;5;55m/' macOS\ Creator.command && sed -i '' '78s/"38;5;66m/"38;5;55m/' macOS\ Creator.command
	sed -i '' '84s/"38;5;158m/"38;5;185m/' macOS\ Creator.command && sed -i '' '84s/"38;5;180m/"38;5;185m/' macOS\ Creator.command && sed -i '' '84s/"38;5;108m/"38;5;185m/' macOS\ Creator.command && sed -i '' '84s/"38;5;255m/"38;5;185m/' macOS\ Creator.command && sed -i '' '84s/"38;5;88m/"38;5;185m/' macOS\ Creator.command && sed -i '' '84s/"38;5;73m/"38;5;185m/' macOS\ Creator.command
	sed -i '' '85s/"38;5;153m/"38;5;209m/' macOS\ Creator.command && sed -i '' '85s/"38;5;215m/"38;5;209m/' macOS\ Creator.command && sed -i '' '85s/"38;5;193m/"38;5;209m/' macOS\ Creator.command && sed -i '' '85s/"38;5;255m/"38;5;209m/' macOS\ Creator.command && sed -i '' '85s/"38;5;137m/"38;5;209m/' macOS\ Creator.command && sed -i '' '85s/"38;5;152m/"38;5;209m/' macOS\ Creator.command
	sed -i '' '86s/"38;5;158m/"38;5;201m/' macOS\ Creator.command && sed -i '' '86s/"38;5;180m/"38;5;201m/' macOS\ Creator.command && sed -i '' '86s/"38;5;108m/"38;5;201m/' macOS\ Creator.command && sed -i '' '86s/"38;5;255m/"38;5;201m/' macOS\ Creator.command && sed -i '' '86s/"38;5;88m/"38;5;201m/' macOS\ Creator.command && sed -i '' '86s/"38;5;73m/"38;5;201m/' macOS\ Creator.command
	sed -i '' '87s/"38;5;152m/"38;5;123m/' macOS\ Creator.command && sed -i '' '87s/"38;5;208m/"38;5;123m/' macOS\ Creator.command && sed -i '' '87s/"38;5;150m/"38;5;123m/' macOS\ Creator.command && sed -i '' '87s/"38;5;255m/"38;5;123m/' macOS\ Creator.command && sed -i '' '87s/"38;5;124m/"38;5;123m/' macOS\ Creator.command && sed -i '' '87s/"38;5;109m/"38;5;123m/' macOS\ Creator.command
	sed -i '' '88s/"38;5;111m/"38;5;156m/' macOS\ Creator.command && sed -i '' '88s/"38;5;166m/"38;5;156m/' macOS\ Creator.command && sed -i '' '88s/"38;5;194m/"38;5;156m/' macOS\ Creator.command && sed -i '' '88s/"38;5;255m/"38;5;156m/' macOS\ Creator.command && sed -i '' '88s/"38;5;138m/"38;5;156m/' macOS\ Creator.command && sed -i '' '88s/"38;5;158m/"38;5;156m/' macOS\ Creator.command
	sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;255m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command && sed -i '' '89s/"38;5;160m/"38;5;160m/' macOS\ Creator.command
	sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;255m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command && sed -i '' '90s/"38;5;196m/"38;5;196m/' macOS\ Creator.command
	sed -i '' '91s/"38;5;38m/"38;5;135m/' macOS\ Creator.command && sed -i '' '91s/"38;5;197m/"38;5;135m/' macOS\ Creator.command && sed -i '' '91s/"38;5;187m/"38;5;135m/' macOS\ Creator.command && sed -i '' '91s/"38;5;255m/"38;5;135m/' macOS\ Creator.command && sed -i '' '91s/"38;5;210m/"38;5;135m/' macOS\ Creator.command && sed -i '' '91s/"38;5;194m/"38;5;135m/' macOS\ Creator.command
	if [[ $verbose == "1" ]]; then
		if [[ $CLEANED == 'TRUE' ]]; then
			"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
		else
			"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
		fi
	else
		"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
	fi
}
ADVANCEDMODE()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                                  Advanced Mode"
		echo -e "${RESET}${BODY}                    Start Normally.......................(1)"
		echo -e "${RESET}${BODY}                    Start in Verbose Mode................(2)"
		echo -e "${RESET}${BODY}                    Start in Safe Mode...................(3)"
		echo -e "${RESET}${BODY}                    Start in Verbose & Safe Mode.........(4)"
		echo -e "${RESET}${BODY}                    Safe Install.........................(5)"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                           Enter your option here: "
		read -n 1 input
		if [[ $input == '1' ]]; then
			echo -e "${RESET}"
			"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
		elif [[ $input == '2' ]]; then
			echo -e "${RESET}"
			"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
		elif [[ $input == '3' ]]; then
			echo -e "${RESET}"
			"$SCRIPTPATHMAIN"/macOS\ Creator.command -S && exit
		elif [[ $input == '4' ]]; then
			echo -e "${RESET}"
			"$SCRIPTPATHMAIN"/macOS\ Creator.command -s -v && exit
		elif [[ $input == '5' ]]; then
			SAFEINSTALL
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == '?' || $input == '/' ]]; then
			HELPADVANCED
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
	done
}
APPCONFIG()
{
	if [[ ! -d /Applications/macOS\ Creator.app ]]; then
		WINDOWBAR
		echo -e "${RESET}${ERROR}${BOLD}                  The app cannot be found, please reinstall it"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                          Press any key to go back... "
		read -n 1
		break
	fi
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                                App configuration"
		echo -e "${RESET}${BODY}                    Adjust how script launches...........(1)"
		echo -e "${RESET}${BODY}                    Adjust script advanced mode..........(2)"
		if [[ $APPLY == 'NO' ]]; then
			echo -e ""
			echo -e "${RESET}${TITLE}                            Press the S key to apply"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                           Enter your option here: "
		read -n 1 input
		if [[ $input == '1' ]]; then
			while true; do
				WINDOWBAR
				echo -e "${RESET}${TITLE}${BOLD}                                App configuration"
				echo -e "${RESET}${BODY}       Launch script as terminal command (Default)....................(1)"
				echo -e "${RESET}${BODY}       Launch script as one time only (Advanced Mode is disabled).....(2)"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                           Enter your option here: "
				read -n 1 input
				if [[ $input == '2' ]]; then
					APPLY="NO"
					SCRIPTLAUNCH="ONCE"
					break
				elif [[ $input == '1' ]]; then
					APPLY="NO"
					SCRIPTLAUNCH="ALL"
					break
				elif [[ $input == 'w' || $input == 'W' ]]; then
					break
				elif [[ $input == 'q' || $input == 'Q' ]]; then
					SCRIPTLAYOUT
				elif [[ $input == '?' || $input == '/' ]]; then
					HELPAPP
				elif [[ $input == '' ]]; then
					WINDOWBAREND
				else
					WINDOWERROR
				fi
			done
		elif [[ $input == '2' ]]; then
			while true; do
				WINDOWBAR
				echo -e "${RESET}${TITLE}${BOLD}                                App configuration"
				echo -e "${RESET}${BODY}                    Launch normally (Default)............(1)"
				echo -e "${RESET}${BODY}                    Launch in Verbose Mode...............(2)"
				echo -e "${RESET}${BODY}                    Launch in Safe Mode..................(3)"
				echo -e "${RESET}${BODY}                    Launch in Verbose & Safe Mode........(4)"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "                           Enter your option here: "
				read -n 1 input
				if [[ $input == '2' ]]; then
					APPLY="NO"
					SCRIPTMODE="V"
					break
				elif [[ $input == '3' ]]; then
					APPLY="NO"
					SCRIPTMODE="S"
					break
				elif [[ $input == '4' ]]; then
					APPLY="NO"
					SCRIPTMODE="VS"
					break
				elif [[ $input == '1' ]]; then
					APPLY="NO"
					SCRIPTMODE="N"
					break
				elif [[ $input == 'w' || $input == 'W' ]]; then
					break
				elif [[ $input == 'q' || $input == 'Q' ]]; then
					SCRIPTLAYOUT
				elif [[ $input == '?' || $input == '/' ]]; then
					HELPADVANCED
				elif [[ $input == '' ]]; then
					WINDOWBAREND
				else
					WINDOWERROR
				fi
			done
		elif [[ $input == 'w' || $input == 'W' ]]; then
			if [[ $APPLY == 'NO' ]]; then
				echo -e ""
				echo -e "${RESET}${WARNING}"
				echo -e -n "     You have not applied these settings. Do you want to apply them now? "
				read -n 1 input
				if [[ $input == 'y' || $input == 'Y' ]]; then
					APPLYMODES
				else
					break
				fi
			else
				break
			fi
		elif [[ $input == 's' || $input == 'S' ]]; then
			APPLYMODES		
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			if [[ $APPLY == 'NO' ]]; then
				echo -e ""
				echo -e "${RESET}${WARNING}"
				echo -e -n "     You have not applied these settings. Do you want to apply them now? "
				read -n 1 input
				if [[ $input == 'y' || $input == 'Y' ]]; then
					APPLYMODES
				else
					SCRIPTLAYOUT
				fi
			else
				SCRIPTLAYOUT
			fi
		elif [[ $input == '?' || $input == '/' ]]; then
			HELPAPPMAIN
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
	done
}
ADJUSTVERBOSE()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}                              Adjusting the App... "
	echo -e "${RESET}${TITLE}"
	sudo rm -R /Applications/macOS\ Creator.app/Contents/document.wflow
	sudo cp -R verbose.wflow /Applications/macOS\ Creator.app/Contents/document.wflow
	echo -e "${RESET}${TITLE}"
	echo -n "              Please quit the script for changes to take effect... "
	read -n 1
	SCRIPTLAYOUT
}
ADJUSTSAFE()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}                              Adjusting the App... "
	echo -e "${RESET}${TITLE}"
	sudo rm -R /Applications/macOS\ Creator.app/Contents/document.wflow
	sudo cp -R safe.wflow /Applications/macOS\ Creator.app/Contents/document.wflow
	echo -e "${RESET}${TITLE}"
	echo -n "              Please quit the script for changes to take effect... "
	read -n 1
	SCRIPTLAYOUT
}
ADJUSTVERBOSESAFE()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}                              Adjusting the App... "
	echo -e "${RESET}${TITLE}"
	sudo rm -R /Applications/macOS\ Creator.app/Contents/document.wflow
	sudo cp -R verbosesafe.wflow /Applications/macOS\ Creator.app/Contents/document.wflow
	echo -e "${RESET}${TITLE}"
	echo -n "              Please quit the script for changes to take effect... "
	read -n 1
	SCRIPTLAYOUT
}
ADJUSTNORMAL()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}                              Adjusting the App... "
	echo -e "${RESET}${TITLE}"
	sudo rm -R /Applications/macOS\ Creator.app/Contents/document.wflow
	sudo cp -R normal.wflow /Applications/macOS\ Creator.app/Contents/document.wflow
	echo -e "${RESET}${TITLE}"
	echo -n "              Please quit the script for changes to take effect... "
	read -n 1
	SCRIPTLAYOUT
}
APPLYMODES()
{
	if [[ $APPLY == 'NO' ]]; then
		if [[ $SCRIPTLAUNCH == 'ALL' ]]; then
			Output rm -R "$SCRIPTPATHMAIN/.launchonce"
			touch "$SCRIPTPATHMAIN/.launchall"
			cd "$SCRIPTPATHMAIN/normallaunch/"
			if [[ $SCRIPTMODE == 'V' ]]; then
				DELETEMODES
				touch "$SCRIPTPATHMAIN/.verbose"
				ADJUSTVERBOSE
			elif [[ $SCRIPTMODE == 'S' ]]; then
				DELETEMODES
				touch "$SCRIPTPATHMAIN/.safe"
				ADJUSTSAFE
			elif [[ $SCRIPTMODE == 'VS' ]]; then
				DELETEMODES
				touch "$SCRIPTPATHMAIN/.verbosesafe"
				ADJUSTVERBOSESAFE
			elif [[ $SCRIPTMODE == 'N' ]]; then
				DELETEMODES
				touch "$SCRIPTPATHMAIN/.normal"
				ADJUSTNORMAL
			else
				if [[ -e "$SCRIPTPATHMAIN/.verbose" ]]; then
					ADJUSTVERBOSE
				elif [[ -e "$SCRIPTPATHMAIN/.safe" ]]; then
					ADJUSTSAFE
				elif [[ -e "$SCRIPTPATHMAIN/.verbosesafe" ]]; then
					ADJUSTVERBOSESAFE
				elif [[ -e "$SCRIPTPATHMAIN/.normal" ]]; then
					ADJUSTNORMAL
				else
					ADJUSTNORMAL
				fi
			fi
		elif [[ $SCRIPTLAUNCH == 'ONCE' ]]; then
			Output rm -R "$SCRIPTPATHMAIN/.launchall"
			touch "$SCRIPTPATHMAIN/.launchonce"
			cd "$SCRIPTPATHMAIN/onelaunch/"
			if [[ $SCRIPTMODE == 'N' ]]; then
				touch "$SCRIPTPATHMAIN/.normal"
				ADJUSTNORMAL
			else
				if [[ -e "$SCRIPTPATHMAIN/.verbose" ]]; then
					Output rm -R "$SCRIPTPATHMAIN/.verbose"
					touch "$SCRIPTPATHMAIN/.normal"
					ADJUSTNORMAL
				elif [[ -e "$SCRIPTPATHMAIN/.safe" ]]; then
					Output rm -R "$SCRIPTPATHMAIN/.safe"
					touch "$SCRIPTPATHMAIN/.normal"
					ADJUSTNORMAL
				elif [[ -e "$SCRIPTPATHMAIN/.verbosesafe" ]]; then
					Output rm -R "$SCRIPTPATHMAIN/.verbosesafe"
					touch "$SCRIPTPATHMAIN/.normal"
					ADJUSTNORMAL
				elif [[ -e "$SCRIPTPATHMAIN/.normal" ]]; then
					ADJUSTNORMAL
				else
					ADJUSTNORMAL
				fi
			fi
		else
			if [[ -e "$SCRIPTPATHMAIN/.launchonce" ]]; then
				if [[ $SCRIPTMODE == 'V' ]]; then
					cd "$SCRIPTPATHMAIN/normallaunch/"
					DELETEMODES
					touch "$SCRIPTPATHMAIN/.verbose"
					ADJUSTVERBOSE
				elif [[ $SCRIPTMODE == 'S' ]]; then
					cd "$SCRIPTPATHMAIN/normallaunch/"
					DELETEMODES
					touch "$SCRIPTPATHMAIN/.safe"
					ADJUSTSAFE
				elif [[ $SCRIPTMODE == 'VS' ]]; then
					cd "$SCRIPTPATHMAIN/normallaunch/"
					DELETEMODES
					touch "$SCRIPTPATHMAIN/.verbosesafe"
					ADJUSTVERBOSESAFE
				elif [[ $SCRIPTMODE == 'N' ]]; then
					cd "$SCRIPTPATHMAIN/onelaunch/"
					DELETEMODES
					touch "$SCRIPTPATHMAIN/.normal"
					ADJUSTNORMAL
				else
					if [[ -e "$SCRIPTPATHMAIN/.verbose" ]]; then
						Output rm -R "$SCRIPTPATHMAIN/.verbose"
						touch "$SCRIPTPATHMAIN/.normal"
						ADJUSTNORMAL
					elif [[ -e "$SCRIPTPATHMAIN/.safe" ]]; then
						Output rm -R "$SCRIPTPATHMAIN/.safe"
						touch "$SCRIPTPATHMAIN/.normal"
						ADJUSTNORMAL
					elif [[ -e "$SCRIPTPATHMAIN/.verbosesafe" ]]; then
						Output rm -R "$SCRIPTPATHMAIN/.verbosesafe"
						touch "$SCRIPTPATHMAIN/.normal"
						ADJUSTNORMAL
					elif [[ -e "$SCRIPTPATHMAIN/.normal" ]]; then
						ADJUSTNORMAL
					else
						ADJUSTNORMAL
					fi
				fi
			elif [[ -e "$SCRIPTPATHMAIN/.launchall" ]]; then
				cd "$SCRIPTPATHMAIN/normallaunch/"
				if [[ $SCRIPTMODE == 'V' ]]; then
					DELETEMODES
					touch "$SCRIPTPATHMAIN/.verbose"
					ADJUSTVERBOSE
				elif [[ $SCRIPTMODE == 'S' ]]; then
					DELETEMODES
					touch "$SCRIPTPATHMAIN/.safe"
					ADJUSTSAFE
				elif [[ $SCRIPTMODE == 'VS' ]]; then
					DELETEMODES
					touch "$SCRIPTPATHMAIN/.verbosesafe"
					ADJUSTVERBOSESAFE
				elif [[ $SCRIPTMODE == 'N' ]]; then
					DELETEMODES
					touch "$SCRIPTPATHMAIN/.normal"
					ADJUSTNORMAL
				else
					if [[ -e "$SCRIPTPATHMAIN/.verbose" ]]; then
						ADJUSTVERBOSE
					elif [[ -e "$SCRIPTPATHMAIN/.safe" ]]; then
						ADJUSTSAFE
					elif [[ -e "$SCRIPTPATHMAIN/.verbosesafe" ]]; then
						ADJUSTVERBOSESAFE
					elif [[ -e "$SCRIPTPATHMAIN/.normal" ]]; then
						ADJUSTNORMAL
					else
						ADJUSTNORMAL
					fi
				fi
			else
				touch "$SCRIPTPATHMAIN/.launchall"
				cd "$SCRIPTPATHMAIN/normallaunch/"
				if [[ $SCRIPTMODE == 'V' ]]; then
					touch "$SCRIPTPATHMAIN/.verbose"
					ADJUSTVERBOSE
				elif [[ $SCRIPTMODE == 'S' ]]; then
					touch "$SCRIPTPATHMAIN/.safe"
					ADJUSTSAFE
				elif [[ $SCRIPTMODE == 'VS' ]]; then
					touch "$SCRIPTPATHMAIN/.verbosesafe"
					ADJUSTVERBOSESAFE
				elif [[ $SCRIPTMODE == 'N' ]]; then
					touch "$SCRIPTPATHMAIN/.normal"
					ADJUSTNORMAL
				else
					if [[ -e "$SCRIPTPATHMAIN/.verbose" ]]; then
						ADJUSTVERBOSE
					elif [[ -e "$SCRIPTPATHMAIN/.safe" ]]; then
						ADJUSTSAFE
					elif [[ -e "$SCRIPTPATHMAIN/.verbosesafe" ]]; then
						ADJUSTVERBOSESAFE
					elif [[ -e "$SCRIPTPATHMAIN/.normal" ]]; then
						ADJUSTNORMAL
					else
						ADJUSTNORMAL
					fi
				fi
			fi
		fi
	else
		WINDOWERROR
	fi
}
DELETEMODES()
{
	Output rm -R "$SCRIPTPATHMAIN/.verbose"
	Output rm -R "$SCRIPTPATHMAIN/.safe"
	Output rm -R "$SCRIPTPATHMAIN/.verbosesafe"
	Output rm -R "$SCRIPTPATHMAIN/.normal"
}
SAFEINSTALL()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                                  Safe Install"
		echo -e ""
		if [[ $SAFEINSTALLATION == 'FALSE' ]]; then
			echo -e "${RESET}${PROMPTSTYLE}                           Safe Install is turned off"
		else
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}                            Safe Install is turned on"
		fi
		echo -e ""
		echo -e "${RESET}${BODY}             Safe Install skips certain checks when installing macOS"
		echo -e "${RESET}${BODY}       Enable this mode if your Mac is dealing with issues such as memory"
		echo -e ""
		if [[ $SAFEINSTALLATION == 'FALSE' ]]; then
			echo -e -n "${RESET}${PROMPTSTYLE}${BOLD}                      Press Y to activate Safe Install... "
		else
			echo -e -n "${RESET}${PROMPTSTYLE}${BOLD}                      Press Y to turn off Safe Install... "
		fi
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			if [[ $SAFEINSTALLATION == 'FALSE' ]]; then
				sed -i '' '8280s/FALSE/TRUE/' macOS\ Creator.command
				echo -e ""
				echo -e ""
				echo -e -n "${RESET}${PROMPTSTYLE}${BOLD}           Safe Install has been activated, press any key to restart... "
				read -n 1
				if [[ $verbose == '1' && $safe == '1' || $verbose == '1' && $safe == '2' ]]; then
					"$SCRIPTPATHMAIN"/macOS\ Creator.command -v -s && exit
				elif [[ $verbose == "1" ]]; then
					"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
				elif [[ $safe == "1" || $safe == "2" ]]; then
					"$SCRIPTPATHMAIN"/macOS\ Creator.command -S && exit
				else
					"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
				fi
			else
				sed -i '' '8280s/TRUE/FALSE/' macOS\ Creator.command
				echo -e ""
				echo -e ""
				echo -e -n "${RESET}${PROMPTSTYLE}${BOLD}           Safe Install has been turned off, press any key to restart... "
				read -n 1
				if [[ $verbose == '1' && $safe == '1' || $verbose == '1' && $safe == '2' ]]; then
					"$SCRIPTPATHMAIN"/macOS\ Creator.command -v -s && exit
				elif [[ $verbose == "1" ]]; then
					"$SCRIPTPATHMAIN"/macOS\ Creator.command -v && exit
				elif [[ $safe == "1" || $safe == "2" ]]; then
					"$SCRIPTPATHMAIN"/macOS\ Creator.command -S && exit
				else
					"$SCRIPTPATHMAIN"/macOS\ Creator.command && exit
				fi
			fi
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == '?' || $input == '/' ]]; then
			HELPSAFEINSTALL
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
	done
}
SETTINGSMENU()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                                    Settings"
		echo -e "${RESET}${BODY}                    Change Colors........................(1)"
		echo -e "${RESET}${BODY}                    Advanced Mode........................(2)"
		echo -e "${RESET}${BODY}                    Clean up.............................(3)"
		if [[ $HOMEUSER = 'YES' ]]; then
			echo -e "${RESET}${BODY}                    App configuration....................(4)"
			echo -e "${RESET}${BODY}                    Reset................................(5)"
		fi
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                           Enter your option here: "
		read -n 1 input
		if [[ $input == '1' ]]; then
			CHANGECOLORS
		elif [[ $input == '2' ]]; then
			ADVANCEDMODE
		elif [[ $input == '3' ]]; then
			CLEANUP
		elif [[ $input == '4' ]]; then
			if [[ $HOMEUSER = 'YES' ]]; then
				APPLY="YES"
				APPCONFIG
			else
				WINDOWERROR
			fi
		elif [[ $input == '5' ]]; then
			if [[ $HOMEUSER = 'YES' ]]; then
				RESETSCRIPT
			else
				WINDOWERROR
			fi
		elif [[ $input == 'w' || $input == 'W' ]]; then
			break
		elif [[ $input == 'q' || $input == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ $input == '?' || $input == '/' ]]; then
			HELPSETTINGS
		elif [[ $input == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
	done
}

#BETA Builds
IDMAC()
{
	while true; do
		WINDOWBAR
		echo -e "${RESET}${TITLE}${BOLD}                               Identify Mac Model"
		echo -e "    ${RESET}${BODY}${BOLD}Use this tool to determine the latest compatible macOS Version for a Mac"
		echo -e "                  ${RESET}${BODY}You can identify this Mac or a different one"
		echo -e ""
		echo -e "${RESET}${WARNING}${BOLD}                       WARNING:${RESET}${WARNING} This tool is still in BETA"
		echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
		echo -n "                          Do you wish to continue?... "
		read -n 1 input
		if [[ "$input" == 'y' || "$input" == 'Y' ]]; then
			while true; do
			WINDOWBAR
			echo -e "${RESET}${TITLE}What would you like to do?"
			echo -e "${BODY}Identify this Mac........................................................(1)"
			echo -e "${BODY}Identify another Mac.....................................................(2)"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "Enter your option here: "
			read -n 1 input
			if [[ "$input" == '1' ]]; then
				if [[ $MACVERSION == 'MacBook5,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (13-inch, Aluminum, Late 2008)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADELCAPITAN
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBook5,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (13-inch, Early 2009) + (13-inch, Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADELCAPITAN
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBook6,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (13-inch, Late 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBook7,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (13-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBook8,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (Retina, 12-inch, Early 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADBIGSUR
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBook9,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (Retina, 12-inch, Early 2016)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBook10,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (Retina, 12-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADVENTURA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir1,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Original)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}Mac OS X Lion ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "                  Press any key to return to the Home Menu... "
					read -n 1 
					SCRIPTLAYOUT
				elif [[ $MACVERSION == 'MacBookAir2,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADELCAPITAN
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir3,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Late 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir3,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Late 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir4,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir4,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir5,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADCATALINA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir5,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADCATALINA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir6,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Mid 2013) + (11-inch, Early 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADBIGSUR
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir6,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Mid 2013) + (13-inch, Early 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADBIGSUR
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir7,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Early 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir7,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Early 2015) + MacBook Air (13-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir8,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Retina, 13-inch, 2018)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sonoma ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSONOMA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir8,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Retina, 13-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sonoma ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSONOMA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir9,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Retina, 13-inch, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookAir10,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (M1, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac14,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (M2, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac14,15' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (15-inch, M2, 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac15,12' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, M3, 2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac15,13' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (15-inch, M3, 2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac16,12' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, M4, 2025)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac16,13' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (15-inch, M4, 2025)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro4,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch/17-inch, Early 2008)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADELCAPITAN
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro5,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Late 2008)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADELCAPITAN
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro5,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (17-inch, Early/Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADELCAPITAN
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro5,5' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADELCAPITAN
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro5,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADELCAPITAN
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro7,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro6,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro6,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (17-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro8,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, Early/Late 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro8,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Early/Late 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro8,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (17-inch, Early/Late 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro9,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADCATALINA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro9,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADCATALINA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro10,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 15-inch, Mid 2012/Early 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADCATALINA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro10,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 13-inch, Late 2012/Early 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADCATALINA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro11,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 13-inch, Late 2013/Mid 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADBIGSUR
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro11,2' || $MACVERSION == 'MacBookPro11,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 15-inch, Late 2013/Mid 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADBIGSUR
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro12,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 13-inch, Early 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro11,4' || $MACVERSION == 'MacBookPro11,5' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 15-inch, Mid 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro13,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2016, Two Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro13,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2016, Four Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro13,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, 2016)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro14,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2017, Two Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADVENTURA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro14,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2017, Four Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADVENTURA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro14,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADVENTURA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro15,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2018/2019, Four Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro15,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, 2018)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro15,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro15,4' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2019, Two Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro16,1' || $MACVERSION == 'MacBookPro16,4' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro16,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro16,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2020, Two Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro17,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, M1, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro18,1' || $MACVERSION == 'MacBookPro18,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, 2021)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacBookPro18,3' || $MACVERSION == 'MacBookPro18,4' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (14-inch, 2021)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac14,7' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, M2, 2022)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac14,6' || $MACVERSION == 'Mac14,10' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac14,5' || $MACVERSION == 'Mac14,9' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (14-inch, 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac15,7' || $MACVERSION == 'Mac15,9' || $MACVERSION == 'Mac15,11' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, Nov 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac15,6' || $MACVERSION == 'Mac15,8' || $MACVERSION == 'Mac15,10' || $MACVERSION == 'Mac15,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (14-inch, Nov 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac16,7' || $MACVERSION == 'Mac16,5' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, 2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac16,6' || $MACVERSION == 'Mac16,8' || $MACVERSION == 'Mac16,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (14-inch, 2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac9,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Early 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADELCAPITAN
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac10,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Late 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac11,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac11,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (27-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac12,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac12,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (27-inch, Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac13,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Late 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADCATALINA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac13,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (27-inch, Late 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADCATALINA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac14,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Late 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADCATALINA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac14,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (27-inch, Late 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADCATALINA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac14,4' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Mid 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADBIGSUR
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac15,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, Late 2014/Mid 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADBIGSUR
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac16,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Late 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac16,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 4K, 21.5-inch, Late 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac17,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, Late 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac18,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADVENTURA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac18,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 4K, 21.5-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADVENTURA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac18,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADVENTURA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMacPro1,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac Pro (2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac19,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 4K, 21.5-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac19,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac20,1' || $MACVERSION == 'iMac20,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'iMac21,2' || $MACVERSION == 'iMac21,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, M1, 2021)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac15,4' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, 2023, Two ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac15,5' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, 2023, Four ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac16,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, 2024, Two ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac16,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, 2024, Four ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Macmini3,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Early/Late 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADELCAPITAN
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Macmini4,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Macmini5,1' || $MACVERSION == 'Macmini5,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADHIGHSIERRA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Macmini6,1' || $MACVERSION == 'Macmini6,2' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Late 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADCATALINA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Macmini7,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Late 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Macmini8,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (2018)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Macmini9,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (M1, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac14,12' || $MACVERSION == 'Mac14,3' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac16,15' || $MACVERSION == 'Mac16,10' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				
				elif [[ $MACVERSION == 'MacPro4,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (Early 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADELCAPITAN
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacPro5,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (Server) (Mid 2010/Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${TITLE}If you have a Metal Graphics card: ${BOLD}macOS Mojave ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "                  Press any key to return to the Home Menu... "
					read -n 1 
					SCRIPTLAYOUT
				elif [[ $MACVERSION == 'MacPro6,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (Late 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADMONTEREY
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'MacPro7,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac14,8' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac13,2' || $MACVERSION == 'Mac13,1' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Studio (2022)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac14,13' || $MACVERSION == 'Mac14,14' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Studio (2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				elif [[ $MACVERSION == 'Mac15,14' || $MACVERSION == 'Mac16,9' ]]; then
					WINDOWBAR
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Studio (2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Would you like to download it? (Press any other key to cancel)... "
					read -n 1 input
					if [[ $input == 'y' || $input == 'Y' ]]; then
						DOWNLOADSEQUOIA
					else
						SCRIPTLAYOUT
					fi
				else 
					WINDOWBAR
					echo -e "${RESET}${ERROR}Cannot detect Mac model."
					if [[ $safe == '1' || $safe == '2' ]]; then
						echo -e "You are running in Safe Mode"
					else
						echo -e "You may have a model that is not compatible with this script... "
					fi
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "                  Press any key to return to the Home Menu... "
					read -n 1 
					SCRIPTLAYOUT
				fi
			elif [[ "$input" == '2' ]]; then
				while true; do
				WINDOWBAR
				echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
				echo -e "${BODY}Laptop...................................................................(1)"
				echo -e "Desktop..................................................................(2)"
				echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
				echo -n "Enter your option here: "
				read -n 1 input
				if [[ "$input" == '1' ]]; then
					while true; do
					WINDOWBAR
					echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
					echo -e "${BODY}MacBook..................................................................(1)"
					echo -e "MacBook Pro..............................................................(2)"
					echo -e "MacBook Air..............................................................(3)"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Enter your option here: "
					read -n 1 input
					if [[ "$input" == '1' ]]; then
						while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}MacBook (Polycarbonate)..................................................(1)"
						echo -e "MacBook (Unibody)........................................................(2)"
						echo -e "MacBook (Retina).........................................................(3)"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "Enter your option here: "
						read -n 1 input
						if [[ "$input" == '1' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}Early 2009 / Mid 2009....................................................(1)"
							echo -e "Late 2009 / Mid 2010.....................................................(2)"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Enter your option here: "
							read -n 1 input
							if [[ "$input" == '1' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Early 2009/Mid 2009)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '2' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Late 2009/Mid 2010)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '' ]]; then
								WINDOWBAREND
								if [[ "$input" == '' ]]; then
									WINDOWBAREND
								else
									SCRIPTLAYOUT
								fi
							elif [[ $input == '?' || $input == '/' ]]; then
								HELPIDMAC
							elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
								SCRIPTLAYOUT
							elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
								break
							else
								WINDOWERROR
							fi
							done
						elif [[ "$input" == '2' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Aluminum, Late 2008)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT
						elif [[ "$input" == '3' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}2015.....................................................................(1)"
							echo -e "2016.....................................................................(2)"
							echo -e "2017.....................................................................(3)"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Enter your option here: "
							read -n 1 input
							if [[ "$input" == '1' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Retina, 2015)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '2' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Retina, 2016)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '3' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Retina, 2017)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '' ]]; then
								WINDOWBAREND
							elif [[ $input == '?' || $input == '/' ]]; then
								HELPIDMAC
							elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
								SCRIPTLAYOUT
							elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
								break
							else
								WINDOWERROR
							fi
							done
						elif [[ $input == '?' || $input == '/' ]]; then
							HELPIDMAC
						elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
							SCRIPTLAYOUT
						elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
							break
						elif [[ "$input" == '' ]]; then
							WINDOWBAREND
						else
							WINDOWERROR
						fi
						done
					elif [[ "$input" == '2' ]]; then
						while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}13-inch Display..........................................................(1)"
						echo -e "14-inch Display..........................................................(2)"
						echo -e "15-inch Display..........................................................(3)"
						echo -e "16-inch Display..........................................................(4)"
						echo -e "17-inch Display..........................................................(5)"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "Enter your option here: "
						read -n 1 input
						if [[ "$input" == '1' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}LCD Display..............................................................(1)"
							echo -e "Retina Display...........................................................(2)"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Enter your option here: "
							read -n 1 input
							if [[ "$input" == '1' ]]; then
								while true; do
								WINDOWBAR
								echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
								echo -e "${BODY}2009.....................................................................(1)"
								echo -e "2010-2011................................................................(2)"
								echo -e "2012.....................................................................(3)"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Enter your option here: "
								read -n 1 input
								if [[ "$input" == '1' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2009)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '2' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2010-2011)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '3' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2012)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '' ]]; then
									WINDOWBAREND
								elif [[ $input == '?' || $input == '/' ]]; then
									HELPIDMAC
								elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
									SCRIPTLAYOUT
								elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
									break
								else
									WINDOWERROR
								fi
								done
							elif [[ "$input" == '2' ]]; then
								while true; do
								WINDOWBAR
								echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
								echo -e "${BODY}2012-Early 2013..........................................................(1)"
								echo -e "Late 2013-2014...........................................................(2)"
								echo -e "2015-2016................................................................(3)"
								echo -e "2017.....................................................................(4)"
								echo -e "2018 or later............................................................(5)"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Enter your option here: "
								read -n 1 input
								if [[ "$input" == '1' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2012-2013)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '2' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2013-2014)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '3' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2015-2016)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '4' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2017)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '5' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2018 or later)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '' ]]; then
									WINDOWBAREND
								elif [[ $input == '?' || $input == '/' ]]; then
									HELPIDMAC
								elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
									SCRIPTLAYOUT
								elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
									break
								else
									WINDOWERROR
								fi
								done
							elif [[ "$input" == '' ]]; then
								WINDOWBAREND
							elif [[ $input == '?' || $input == '/' ]]; then
								HELPIDMAC
							elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
								SCRIPTLAYOUT
							elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
								break
							else
								WINDOWERROR
							fi
							done
						elif [[ "$input" == '2' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro 14-inch"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT								
						elif [[ "$input" == '3' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}LCD Display..............................................................(1)"
							echo -e "Retina Display...........................................................(2)"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Enter your option here: "
							read -n 1 input
							if [[ "$input" == '1' ]]; then
								while true; do
								WINDOWBAR
								echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
								echo -e "${BODY}2008-2009................................................................(1)"
								echo -e "2010-2011................................................................(2)"
								echo -e "2012.....................................................................(3)"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Enter your option here: "
								read -n 1 input
								if [[ "$input" == '1' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2008-2009)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '2' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2010-2011)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '3' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2012)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '' ]]; then
									WINDOWBAREND
								elif [[ $input == '?' || $input == '/' ]]; then
									HELPIDMAC
								elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
									SCRIPTLAYOUT
								elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
									break
								else
									WINDOWERROR
								fi
								done
							elif [[ "$input" == '2' ]]; then
								while true; do
								WINDOWBAR
								echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
								echo -e "${BODY}2012-Early 2013..........................................................(1)"
								echo -e "Late 2013-2014...........................................................(2)"
								echo -e "2015-2016................................................................(3)"
								echo -e "2017.....................................................................(4)"
								echo -e "2018 or later............................................................(5)"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Enter your option here: "
								read -n 1 input
									if [[ "$input" == '1' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2012-2013)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '2' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2013-2014)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '3' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2015-2016)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '4' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2017)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '5' ]]; then
									WINDOWBAR
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2018 or later)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
									echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
									echo -n "Press any key to return to the Home Menu... "
									read -n 1
									SCRIPTLAYOUT								
								elif [[ "$input" == '' ]]; then
									WINDOWBAREND
								elif [[ $input == '?' || $input == '/' ]]; then
									HELPIDMAC
								elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
									SCRIPTLAYOUT
								elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
									break
								else
									WINDOWERROR
								fi
								done
							elif [[ "$input" == '' ]]; then
								WINDOWBAREND
							elif [[ $input == '?' || $input == '/' ]]; then
								HELPIDMAC
							elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
								SCRIPTLAYOUT
							elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
								break
							else
								WINDOWERROR
							fi
							done
						elif [[ "$input" == '4' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro 16-inch"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT								
						elif [[ "$input" == '5' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}2008-2009................................................................(1)"
							echo -e "2010-2011................................................................(2)"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Enter your option here: "
							read -n 1 input
							if [[ "$input" == '1' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2008-2009)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '2' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2010-2011)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '' ]]; then
								WINDOWBAREND
							elif [[ $input == '?' || $input == '/' ]]; then
								HELPIDMAC
							elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
								SCRIPTLAYOUT
							elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
								break
							else
								WINDOWERROR
							fi
							done
						elif [[ $input == '?' || $input == '/' ]]; then
							HELPIDMAC
						elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
							SCRIPTLAYOUT
						elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
							break
						elif [[ "$input" == '' ]]; then
							WINDOWBAREND
						else
							WINDOWERROR
						fi
						done
					elif [[ "$input" == '3' ]]; then
						while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}11-inch Display..........................................................(1)"
						echo -e "13-inch Display..........................................................(2)"
						echo -e "15-inch Display..........................................................(3)"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "Enter your option here: "
						read -n 1 input
						if [[ "$input" == '1' ]]; then
							while true; do
							WINDOWBAR
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}2010-2011................................................................(1)"
							echo -e "2012.....................................................................(2)"
							echo -e "2013-2014................................................................(3)"
							echo -e "2015.....................................................................(4)"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Enter your option here: "
							read -n 1 input
							if [[ "$input" == '1' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2010-2011)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '2' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2012)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '3' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2013-2014)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '4' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2015)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ $input == '?' || $input == '/' ]]; then
								HELPIDMAC
							elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
								SCRIPTLAYOUT
							elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
								break
							elif [[ "$input" == '' ]]; then
								WINDOWBAREND
							else
								WINDOWERROR
							fi
							done
						elif [[ "$input" == '2' ]]; then
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
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Enter your option here: "
							read -n 1 input
							if [[ "$input" == '1' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2009)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '2' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2010-2011)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '3' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2012)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '4' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2013-2014)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '5' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2015 or 2017)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '6' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2018-2019)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sonoma ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '7' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2020 or later)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '' ]]; then
								WINDOWBAREND
							elif [[ $input == '?' || $input == '/' ]]; then
								HELPIDMAC
							elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
								SCRIPTLAYOUT
							elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
								break
							else
								WINDOWERROR
							fi
							done
						elif [[ "$input" == '3' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air 15-inch"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT
						elif [[ "$input" == '' ]]; then
							WINDOWBAREND
						elif [[ $input == '?' || $input == '/' ]]; then
							HELPIDMAC
						elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
							SCRIPTLAYOUT
						elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
							break
						else
							WINDOWERROR
						fi
						done
					elif [[ $input == '?' || $input == '/' ]]; then
						HELPIDMAC
					elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
						SCRIPTLAYOUT
					elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
						break
					elif [[ "$input" == '' ]]; then
						WINDOWBAREND
					else
						WINDOWERROR
					fi
					done
				elif [[ "$input" == '2' ]]; then
					while true; do
					WINDOWBAR
					echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
					echo -e "${BODY}iMac.....................................................................(1)"
					echo -e "Mac Mini.................................................................(2)"
					echo -e "Mac Pro..................................................................(3)"
					echo -e "Mac Studio...............................................................(4)"
					echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
					echo -n "Enter your option here: "
					read -n 1 input
					if [[ "$input" == '1' ]]; then
						while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}iMac.....................................................................(1)"
						echo -e "iMac Pro.................................................................(2)"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "Enter your option here: "
						read -n 1 input
						if [[ "$input" == '1' ]]; then
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
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Enter your option here: "
							read -n 1 input
							if [[ "$input" == '1' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2009)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '2' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2009-2011)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '3' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2012-2013)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '4' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2014-2015)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '5' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2015)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '6' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2017)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '7' ]]; then
								WINDOWBAR
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2019 or later)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
								echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
								echo -n "Press any key to return to the Home Menu... "
								read -n 1
								SCRIPTLAYOUT
							elif [[ "$input" == '' ]]; then
								WINDOWBAREND
							elif [[ $input == '?' || $input == '/' ]]; then
								HELPIDMAC
							elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
								SCRIPTLAYOUT
							elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
								break
							else
								WINDOWERROR
							fi
							done
						elif [[ "$input" == '2' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac Pro"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT						
						elif [[ "$input" == '' ]]; then
							WINDOWBAREND
						elif [[ $input == '?' || $input == '/' ]]; then
							HELPIDMAC
						elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
							SCRIPTLAYOUT
						elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
							break
						else
							WINDOWERROR
						fi
						done
					elif [[ "$input" == '2' ]]; then
						while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}2009.....................................................................(1)"
						echo -e "2010.....................................................................(2)"
						echo -e "2011.....................................................................(3)"
						echo -e "2012.....................................................................(4)"
						echo -e "2014.....................................................................(5)"
						echo -e "2018 or later............................................................(6)"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "Enter your option here: "
						read -n 1 input
						if [[ "$input" == '1' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2009)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT						
						elif [[ "$input" == '2' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2010)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT						
						elif [[ "$input" == '3' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2011)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT						
						elif [[ "$input" == '4' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2012)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT						
						elif [[ "$input" == '5' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2014)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT						
						elif [[ "$input" == '6' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2018 or later)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT						
						elif [[ "$input" == '' ]]; then
							WINDOWBAREND
						elif [[ $input == '?' || $input == '/' ]]; then
							HELPIDMAC
						elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
							SCRIPTLAYOUT
						elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
							break
						else
							WINDOWERROR
						fi
						done
					elif [[ "$input" == '3' ]]; then
						while true; do
						WINDOWBAR
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}2009.....................................................................(1)"
						echo -e "2010-2012................................................................(2)"
						echo -e "2013.....................................................................(3)"
						echo -e "2019 or later............................................................(4)"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "Enter your option here: "
						read -n 1 input
						if [[ "$input" == '1' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Pro (2009)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT						
						elif [[ "$input" == '2' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is a Mac Pro (2010 or 2012)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
							echo -e "${RESET}${TITLE}If you have a Metal Graphics card: ${BOLD}macOS Mojave ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT						
						elif [[ "$input" == '3' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Pro (2013)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT						
						elif [[ "$input" == '4' ]]; then
							WINDOWBAR
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2019 or later)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
							echo -n "Press any key to return to the Home Menu... "
							read -n 1
							SCRIPTLAYOUT						
						elif [[ "$input" == '' ]]; then
							WINDOWBAREND
						elif [[ $input == '?' || $input == '/' ]]; then
							HELPIDMAC
						elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
							SCRIPTLAYOUT
						elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
							break
						else
							WINDOWERROR
						fi
						done
					elif [[ "$input" == '4' ]]; then
						WINDOWBAR
						echo -e "${RESET}${OSFOUND}${BOLD}This is a Mac Studio"
						echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
						echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
						echo -n "Press any key to return to the Home Menu... "
						read -n 1
						SCRIPTLAYOUT
					elif [[ "$input" == '' ]]; then
						WINDOWBAREND
					elif [[ $input == '?' || $input == '/' ]]; then
						HELPIDMAC
					elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
						SCRIPTLAYOUT
					elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
						break
					else
						WINDOWERROR
					fi
					done
				elif [[ $input == '?' || $input == '/' ]]; then
					HELPIDMAC
				elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
					SCRIPTLAYOUT
				elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
					break
				elif [[ "$input" == '' ]]; then
					WINDOWBAREND
				else
					WINDOWERROR
				fi
				done
			elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
				SCRIPTLAYOUT
			elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
				break
			elif [[ $input == '?' || $input == '/' ]]; then
				HELPID
			elif [[ "$input" == '' ]]; then
				WINDOWBAREND
			else
				WINDOWERROR
			fi
			done
		elif [[ $input == '?' || $input == '/' ]]; then
			BETAHELP
		elif [[ "$input" == 'q' || "$input" == 'Q' ]]; then
			SCRIPTLAYOUT
		elif [[ "$input" == 'w' || "$input" == 'W' ]]; then
			break
		elif [[ "$input" == '' ]]; then
			WINDOWBAREND
		else
			WINDOWERROR
		fi
		done
}

#Extended Support Mode
ESMWINDOWBAR()
{
		clear
		echo "                            macOS Creator V6.2 (ESM)"
		echo "********************************************************************************"
}
ESMWINDOWBAREND()
{
	echo ""
	echo -n "                               Press Q to quit... "
	read -n 1 input
	if [[ $input == 'q' || $input == 'Q' ]]; then
		echo ""
		echo -e "\033[1A\033[0K                                Script Canceled"
		echo ""
		exit
	fi
}
ESMWINDOWBARERROR()
{
	echo ""
	echo ""
	echo -n "          This is not a valid command, press any key to try again... "
	read -n 1
}
ESMOSSEQUOIA()
{
	ESMWINDOWBAR
	echo "macOS Sequoia was found"
	echo "This macOS Verison is not compatible in ESM"
	echo ""
	echo -n "                          Press any key to go back... "
	read -n 1
}
ESMOSSONOMA()
{
	ESMWINDOWBAR
	echo "macOS Sonoma was found"
	echo "This macOS Verison is not compatible in ESM"
	echo ""
	echo -n "                          Press any key to go back... "
	read -n 1
}
ESMOSVENTURA()
{
	ESMWINDOWBAR
	echo "macOS Ventura was found"
	echo "This macOS Verison is not compatible in ESM"
	echo ""
	echo -n "                          Press any key to go back... "
	read -n 1
}
ESMOSMONTEREY()
{
	ESMWINDOWBAR
	echo "macOS Monterey was found"
	echo "This macOS Verison is not compatible in ESM"
	echo ""
	echo -n "                          Press any key to go back... "
	read -n 1
}
ESMOSBIGSUR()
{
	ESMWINDOWBAR
	echo "macOS Big Sur was found"
	echo "This macOS Verison is not compatible in ESM"
	echo ""
	echo -n "                          Press any key to go back... "
	read -n 1
}
ESMOSCATALINA()
{
	ESMWINDOWBAR
	echo "macOS Catalina was found"
	echo "This macOS Verison is not compatible in ESM"
	echo ""
	echo -n "                          Press any key to go back... "
	read -n 1
}
ESMOSMOJAVE()
{
	ESMWINDOWBAR
	echo "macOS Mojave was found"
	echo "This macOS Verison is not compatible in ESM"
	echo ""
	echo -n "                          Press any key to go back... "
	read -n 1
}
ESMOSHIGHSIERRA()
{
	ESMWINDOWBAR
	echo "macOS High Sierra was found"
	echo "This macOS Verison is not compatible in ESM"
	echo ""
	echo -n "Press any key to go back... "
	read -n 1
}
ESMOSSIERRA()
{
	ESMWINDOWBAR
	echo "macOS Sierra was found"
	echo "This macOS Verison is not compatible in ESM"
	echo ""
	echo -n "                          Press any key to go back... "
	read -n 1
}
ESMOSELCAPITAN()
{
	ESMWINDOWBAR
	echo "OS X El Capitan was found"
	echo "This macOS Verison is not compatible in ESM"
	echo ""
	echo -n "                          Press any key to go back... "
	read -n 1
}
ESMOSYOSEMITE()
{
	ESMWINDOWBAR
	echo "OS X Yosemite was found"
	echo "This macOS Verison is not compatible in ESM"
	echo ""
	echo -n "                          Press any key to go back... "
	read -n 1
}
ESMOSMAVERICKS()
{
	ESMWINDOWBAR
	echo "OS X Mavericks was found"
	echo "This macOS Verison is not compatible in ESM"
	echo ""
	echo -n "                          Press any key to go back... "
	read -n 1
}
ESMOSNONE()
{
	ESMWINDOWBAR
	echo "No Mac OS X Version was found"
	echo ""
	echo -n "                          Press any key to go back... "
	read -n 1
}
ESMOSL()
{
	ESMWINDOWBAR
	echo "Mac OS X Lion was found"
	echo "Press Y to use this OS Version."
	echo ""
	echo -n "                        Press any other key to go back... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		apppath="/Applications/Install Mac OS X Lion.app"
		ESMDRIVE
	fi
}
ESMOSML()
{
	ESMWINDOWBAR
	echo "OS X Mountain Lion was found"
	echo "Press Y to use this OS Version."
	echo ""
	echo -n "                        Press any other key to go back... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		apppath="/Applications/Install OS X Mountain Lion.app"
		ESMDRIVE
	fi
}
ESMDRIVE()
{
	while true; do
		ESMWINDOWBAR
		echo "Provide a drive to create the installer"
		echo "Drag the drive from the Finder into this window"
		echo "Press the return key when finished"
		echo ""
		read -p "Drive path: " drivepath
		if [[ "$drivepath" == '' ]]; then
			ESMWINDOWBAREND
		elif [[ "$drivepath" == 'q' || "$drivepath" == 'Q' ]]; then
			ESM
		elif [[ "$drivepath" == 'w' || "$drivepath" == 'W' ]]; then
			break
		else
			if [[ ! "$drivepath" == */Volumes/* ]]; then
				echo ""
				echo -n "          This is not a valid drive. Press any key to try again... "
				read -n 1
			else
				if [[ "$apppath" == *Mountain* ]]; then
					ESMMLCREATE
				else
					ESMLCREATE
				fi
			fi
		fi
	done
}
ESMMLCREATE()
{
	ESMWINDOWBAR
	echo -n "Creating the drive for OS X Mountain Lion. Please Enter Your "
	sudo echo ""
	echo ""
	echo -n "Please wait... "
	Output sudo asr restore -source "$apppath/Contents/SharedSupport/InstallESD.dmg" -target "$drivepath" -noprompt -noverify -erase
	if [[ -d /Volumes/Mac\ OS\ X\ Install\ ESD/Install\ OS\ X\ Mountain\ Lion.app ]]; then
		echo ""
		echo ""
		echo -n "The drive has been created successfully. Press any key to go back... "
		read -n 1
		ESM
	else
		echo ""
		echo ""
		echo "                                  Operation Failed"
		echo ""
		echo -n "                          Press any key to go back... "
		read -n 1
		ESM
	fi
}
ESMLCREATE()
{
	ESMWINDOWBAR
	echo -n "Creating the drive for Mac OS X Lion. Please Enter Your "
	sudo echo ""
	echo ""
	echo -n "Please wait... "
	Output sudo asr restore -source "$apppath/Contents/SharedSupport/InstallESD.dmg" -target "$drivepath" -noprompt -noverify -erase
	if [[ -d /Volumes/Mac\ OS\ X\ Install\ ESD/Install\ Mac\ OS\ X\ Lion.app ]]; then
		echo ""
		echo ""
		echo -n "The drive has been created successfully. Press any key to go back... "
		read -n 1
		ESM
	else
		echo ""
		echo ""
		echo "                                  Operation Failed"
		echo ""
		echo -n "                          Press any key to go back... "
		read -n 1
		ESM
	fi
}
ESMPROVIDE()
{
	while true; do
		ESMWINDOWBAR
		echo "Please provide the Mac OS X Installer path"
		echo "Drag the Mac OS X Installer from the Finder into this window"
		echo "Press the return key when finished"
		echo ""
		read -p "Mac OS X Installer path: " apppath
		if [[ "$apppath" == '' ]]; then
			ESMWINDOWBAREND
		elif [[ "$apppath" == 'q' || "$apppath" == 'Q' ]]; then
			ESM
		elif [[ "$apppath" == 'w' || "$apppath" == 'W' ]]; then
			break
		elif [[ ! "$apppath" == *Lion* ]]; then
			echo ""
			echo -n "This is not a valid Mac OS X Installer. Press any key to try again... "
			read -n 1
		else
			if [[ "$apppath" == *Mountain* ]]; then
				echo ""
				echo "                                OS X Mountain Lion"
				echo -n "                       Press any key to use this OS... "
				read -n 1
				ESMDRIVE
			else
				echo ""
				echo "                                  Mac OS X Lion"
				echo -n "                       Press any key to use this OS... "
				read -n 1
				ESMDRIVE
			fi
		fi
	done
}
ESM()
{
	while true; do
		ESMWINDOWBAR
		echo "                       Welcome to the macOS Creator (ESM)"
		echo "                   Please choose one of the folowing options"
		echo ""
		echo "       Search for Mac OS X Installer in Applications folder..........(1)"
		echo "       Manually provide path for Mac OS X Installer..................(2)"
		echo "       (ESM) Help....................................................(3)"
		echo ""
		echo -n "                           Enter your option here: "
		read -n 1 input
		if [[ $input == '1' ]]; then
			echo ""
			echo "Checking for valid Mac OS X Installer..."
			if [[ -d /Applications/Install\ OS\ X\ Mountain\ Lion.app ]]; then
				ESMOSML
			elif [[ -d /Applications/Install\ Mac\ OS\ X\ Lion.app ]]; then
				ESMOSL
			elif [[ -d /Applications/Install\ macOS\ Sequoia.app ]]; then
				ESMOSSEQUOIA
			elif [[ -d /Applications/Install\ macOS\ Sonoma.app ]]; then
				ESMOSSONOMA
			elif [[ -d /Applications/Install\ macOS\ Ventura.app ]]; then
				ESMOSVENTURA
			elif [[ -d /Applications/Install\ macOS\ Monterey.app ]]; then
				ESMOSMONTEREY
			elif [[ -d /Applications/Install\ macOS\ Big\ Sur.app ]]; then
				ESMOSBIGSUR
			elif [[ -d /Applications/Install\ macOS\ Catalina.app ]]; then
				ESMOSCATALINA
			elif [[ -d /Applications/Install\ macOS\ Mojave.app ]]; then
				ESMOSMOJAVE
			elif [[ -d /Applications/Install\ macOS\ High\ Sierra.app ]]; then
				ESMOSHIGHSIERRA
			elif [[ -d /Applications/Install\ macOS\ Sierra.app ]]; then
				ESMOSSIERRA
			elif [[ -d /Applications/Install\ OS\ X\ El\ Capitan.app ]]; then
				ESMOSELCAPITAN
			elif [[ -d /Applications/Install\ OS\ X\ Yosemite.app ]]; then
				ESMOSYOSEMITE
			elif [[ -d /Applications/Install\ OS\ X\ Mavericks.app ]]; then
				ESMOSMAVERICKS
			else
				ESMOSNONE
			fi
		elif [[ $input == '2' ]]; then
			ESMPROVIDE
		elif [[ $input == '3' ]]; then
			ESMWINDOWBAR
			echo "ESM (Extended Support Mode) is built for Macs running Mac OS X Snow Leopard."
			echo ""
			echo "Several features have been removed in order for script to funcion on this OS."
			echo "Such features include:"
			echo "- Download macOS"
			echo "- Identify Mac Model"
			echo "- Color Customization"
			echo "- GUI Application"
			echo "- Help Menu"
			echo ""
			echo "Mac OS X Lion and OS X Mountain Lion are the only OS versions compatible in ESM."
			echo "In order to have full access, upgrade to Mac OS X Lion or use macOS Creator V2.3"
			echo ""
			echo -n "                          Press any key to go back... "
			read -n 1
		elif [[ $input == '' ]]; then
			ESMWINDOWBAREND
		else
			ESMWINDOWBARERROR
		fi
	done
}

#Script Layout
SCRIPTLAYOUT()
{
	if [[ "$MACOSVERSION" == 10.6 ]]; then
		clear
		echo "                               macOS Creator V6.2"
		echo ""
		echo "                    This Mac is running Mac OS X Snow Leopard"
		echo "              You can run this script in ESM (Extended Support Mode)"
		echo ""
		echo -n "     Press (Y) if you wish to continue (Press any other key to cancel)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			ESM
		else
			echo ""
			exit
		fi
	elif [[ "$MACOSVERSION" == 10.5 ]]; then
		clear
		echo "                               macOS Creator V6.2"
		echo ""
		echo "                      This Mac is running Mac OS X Leopard"
		echo "              You can run this script in ESM (Extended Support Mode)"
		echo ""
		echo -n "     Press (Y) if you wish to continue (Press any other key to cancel)... "
		read -n 1 input
		if [[ $input == 'y' || $input == 'Y' ]]; then
			ESM
		else
			echo ""
			exit
		fi
	else
		while true; do
			FIRSTTIMEHERE="FALSE"
			MAINMENU
			SAFEINSTALLATION="FALSE"
			read -n 1 maininput
			if [[ $maininput == '1' ]]; then
				while true; do
					APPLICATIONSCREATE
				done
			elif [[ $maininput == '2' ]]; then
				MANUALCREATE
			elif [[ $maininput == '3' ]]; then
				DOWNLOADMACOS
			elif [[ $maininput == '4' ]]; then
				IDMAC
			elif [[ $maininput == '5' ]]; then
				TROUBLESHOOTGUIDEMAIN
			elif [[ $maininput == '6' ]]; then
				SETTINGSMENU
			elif [[ $maininput == 'w' || $maininput == 'W' ]]; then
				CONTROLS
			elif [[ $maininput == 'c' || $maininput == 'C' ]]; then
				CREDITS
			elif [[ $maininput == 'a' || $maininput == 'A' ]]; then
				LICENSEAGREEMENT
			elif [[ $maininput == 'r' || $maininput == 'R' ]]; then
				RELEASENOTES
			elif [[ $maininput == 'i' || $maininput == 'I' ]]; then
				MACINFO
			elif [[ $maininput == '?' || $maininput == '/' ]]; then
				GUIDE
			elif [[ $maininput == 'q' || $maininput == 'Q' ]]; then
				echo -e ""
			elif [[ $maininput == '' ]]; then
				WINDOWBAREND
			else
				WINDOWERROR
			fi
		done
	fi
}

#Script Order
SCRIPTORDER()
{
if [[ $safe == "1" ]]; then
	GRAPHICSSAFE="YES"
	SCRIPTLAYOUT
elif [[ $safe == "2" ]]; then
	clear
	echo -e "                          macOS Creator V6.2 Safe Mode"
	echo -e "    Press Y if you want to skip the following, press any other key to allow:"
	echo -e ""
	echo -n "    Skip Mac Verifications... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		MACVERIFY="NO"
		STARTUPDISK=000000000000000000000000000000000000000000000000000000000000000000
		echo -e ""
	else
		echo -e ""
	fi
	echo -n "    Skip OS Verifications... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		PRERUNOS="NO"
		echo -e ""
	else
		echo -e ""
	fi
	echo -n "    Skip script color set... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		PRERUNCOLOR="NO"
		echo -e ""
	else
		echo -e ""
	fi
	echo -n "    Run with safe graphics... "
	read -n 1 input
	if [[ $input == 'y' || $input == 'Y' ]]; then
		PRERUNDIS="YES"
		echo -e ""
	else
		echo -e ""
	fi
	if [[ $MACVERIFY == 'NO' ]]; then
		echo -e ""
	else
		PreRunMac
	fi
	if [[ $PRERUNOS == 'NO' ]]; then
		echo -e ""
	else
		PreRunOS
	fi
	if [[ $PRERUNCOLOR == 'NO' ]]; then
		echo -e ""
	else
		PreRun
	fi
	if [[ $PRERUNDIS == 'YES' ]]; then
		GRAPHICSSAFE="YES"
	else
		echo -e ""
	fi
	SCRIPTLAYOUT
else
	PreRunOS
	PreRun
	PreRunMac
	SCRIPTLAYOUT
fi
}

SCRIPTORDER

#End of Script
