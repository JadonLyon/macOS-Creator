#Welcome to the macOS Creator Script
#This is where the script code is located
#Caution: Modifying the script may cause it to break!

#Version 2.3
#Release notes:
#              V3.0 This update introduces the biggest changes ever made to the macOS Creator.
#                   The script has been completely rewritten to fix numerous bugs, ensure stability, and take up less space on your Mac.
#                   All-new, colorful UI. The UI has been brought to life with colors. Now drive creation is both super easy and enjoyable.
#                   Providing the macOS Installer path has been completely rewritten and fully tested, now completely stable.
#                   macOS Creator skips (provide drive path) step if drive name is Untitled.
#                   Introduces a new, powerful tool that helps you identify your Mac to determine latest compatible macOS Version (BETA).
#                   Script extension has changed from .sh to .command to launch the macOS Creator without first opening Terminal.
#                   
#              V2.3 Adds more support for macOS Versions.
#                   Fixed an issue where script would report macOS Sonoma detected with macOS Sequoia.
#                   Fixes a few bugs.
#
#              V2.2 Providing the macOS Installer is now much easier and more reliable (BETA).
#                   OS X Mavericks can now be downloaded from the Internet Archive.
#                   Fixes multiple issues overall.
#                   Drive creation is now much more stable.
#
#              V2.1 Fixes many issues with text.
#                   Fixes some issues when providing a path for the macOS Installer (BETA).
#                   Fixes an issue where drive creation would report succeeded even if failed.
#                   Adds a new feature that tests macOS Version to determine drive creation (i.e. macOS Sonoma can only be created on macOS High Sierra or newer).
#
#              V2.0 This new update adds exciting new features to the macOS Creator
#                   All-new UI. The UI has been completely redesigned to make drive creation easier than ever.
#                   Tools right from the start. You can now download macOS or review steps as soon as you launch the script.
#                   Provide installer path. You can now provide the installer path if it is not inside your Applications folder (BETA).
#                   Fixes an issue where your drive name could only be one word long.
#                   Fixes an issue where when downloading macOS, the script would report succeeded even if failed.
#                   Fixes an issue where capital (Y) would not respond.
#
#              V1.1 This version adds troubleshooting steps if drive creation fails





#Script:
#####################################################

#Check Mac model
MACVERSION=$(sysctl hw.model | awk '{ print $2 }')

#Check macOS Version
os_version=$(sw_vers -productVersion | cut -d '.' -f 1,2)

#Colors in UI
APP='\033[38;5;30m'
TITLE='\033[38;5;24m'
BODY='\033[38;5;23m'
PROMPT='\033[38;5;22m'
OSFOUND='\033[38;5;67m'
WARNING='\033[38;5;88m'
ERROR='\033[38;5;9m'
CANCEL='\033[38;5;132m'
BOLD='\033[1m'
RESET='\033[0m'

#Text in UI
LINES='********************************************************************************'
CANCELED='Operation Canceled.'
NOFAIL='is not a valid command. Please run this script again...'

#Script
if [[ "$os_version" == 10.6 ]]; then
	echo ""
	echo "You are running Mac OS X Snow Leopard"
	echo "This script requires Mac OS X Lion or newer"
	echo "Please download macOS Creator V2.3 from GitHub to use this script"
	echo ""
	read -p "Press the return key to continue... " prompt
		if [[ "$prompt" == '' ]]; then
			clear
			exit
		else
			clear
			exit
		fi
elif [[ "$os_version" == 10.5 ]]; then
	echo ""
	echo "You are running Mac OS X Leopard"
	echo "This script requires Mac OS X Lion or newer"
	echo ""
	read -p "Press the return key to continue... " prompt
		if [[ "$prompt" == '' ]]; then
			clear
			exit
		else
			clear
			exit
		fi
else
	clear
	echo -e "${APP}${BOLD}                               macOS Creator V3.0"
	echo -e "$LINES"
	echo -e "${RESET}${TITLE}${BOLD}Welcome to the macOS Creator by Encore Platforms${RESET}"
	echo -e "${TITLE}This script will make a bootable installer for macOS${RESET}"
	echo -e "${CANCEL}To cancel at any point, press the ${BOLD}return ${RESET}${CANCEL}key${RESET}"
	echo -e ""
	echo -e "${TITLE}Please choose an option...${RESET}"
	echo -e "${BODY}Create a bootable installer from your Applications folder................(1)"
	echo -e "Provide a path to create the bootable installer..........................(2)"
	echo -e "Download macOS...........................................................(3)"
	echo -e "Identify your Mac model..................................................(4)"
	echo -e "Review troubleshooting options...........................................(5)${RESET}"
	echo -e "${PROMPT}"
	read -p "Enter your option here... " prompt
	if [[ "$prompt" == '1' ]]; then
		echo -e "${RESET}${TITLE}Checking for valid macOS Installers...${RESET}"
		if [[ -d /Applications/Install\ OS\ X\ Mavericks.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}OS X Mavericks was found...${RESET}${PROMPT}"
			read -p "Would you like to use this installer? (Y=Yes;return=No)... " prompt
			if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
				if [[ -d /Volumes/Untitled ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}Creating the installer for OS X Mavericks...${BODY}"
					sudo /Applications/Install\ OS\ X\ Mavericks.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath /Applications/Install\ OS\ X\ Mavericks.app --nointeraction
					if [ -d /Volumes/Install\ OS\ X\ Mavericks/Install\ OS\ X\ Mavericks.app ]; then
						echo -e "${TITLE}The drive has been created successfully for OS X Mavericks."
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
						echo -e "${PROMPT}"
						read -p "Would you like to review troubleshooting steps?... " prompt
						if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
							echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
							echo -e "3) Try using a different drive"
							echo -e "4) Try redownloading the macOS Installer"
							echo -e "5) Restart your Mac${RESET}"
							echo -e ""
							echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}${ERROR}"
							echo -e "Error. ($prompt) $NOFAIL"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						fi
					fi
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}You must provide a drive to create the installer"
					echo -e "Drag the drive from the Finder into this window${RESET}"
					echo -e "${WARNING}WARNING: All data on the drive will be erased!${RESET}"
					echo -e "${PROMPT}"
					read -p "Enter the drive path here (" prompt
					if [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for OS X Mavericks...${BODY}"
						sudo /Applications/Install\ OS\ X\ Mavericks.app/Contents/Resources/createinstallmedia --volume "$prompt" --applicationpath /Applications/Install\ OS\ X\ Mavericks.app --nointeraction
						if [ -d /Volumes/Install\ OS\ X\ Mavericks/Install\ OS\ X\ Mavericks.app ]; then
							echo -e "${TITLE}The drive has been created successfully for OS X Mavericks."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					fi
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ OS\ X\ Yosemite.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}OS X Yosemite was found...${RESET}${PROMPT}"
			read -p "Would you like to use this installer? (Y=Yes;return=No)... " prompt
			if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
				if [[ -d /Volumes/Untitled ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}Creating the installer for OS X Yosemite...${BODY}"
					sudo /Applications/Install\ OS\ X\ Yosemite.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath /Applications/Install\ OS\ X\ Yosemite.app --nointeraction
					if [ -d /Volumes/Install\ OS\ X\ Yosemite/Install\ OS\ X\ Yosemite.app ]; then
						echo -e "${TITLE}The drive has been created successfully for OS X Yosemite."
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
						echo -e "${PROMPT}"
						read -p "Would you like to review troubleshooting steps?... " prompt
						if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
							echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
							echo -e "3) Try using a different drive"
							echo -e "4) Try redownloading the macOS Installer"
							echo -e "5) Restart your Mac${RESET}"
							echo -e ""
							echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}${ERROR}"
							echo -e "Error. ($prompt) $NOFAIL"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						fi
					fi
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}You must provide a drive to create the installer"
					echo -e "Drag the drive from the Finder into this window${RESET}"
					echo -e "${WARNING}WARNING: All data on the drive will be erased!${RESET}"
					echo -e "${PROMPT}"
					read -p "Enter the drive path here (" prompt
					if [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for OS X Yosemite...${BODY}"
						sudo /Applications/Install\ OS\ X\ Yosemite.app/Contents/Resources/createinstallmedia --volume "$prompt" --applicationpath /Applications/Install\ OS\ X\ Yosemite.app --nointeraction
						if [ -d /Volumes/Install\ OS\ X\ Yosemite/Install\ OS\ X\ Yosemite.app ]; then
							echo -e "${TITLE}The drive has been created successfully for OS X Yosemite."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					fi
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ OS\ X\ El\ Capitan.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}OS X El Capitan was found...${RESET}${PROMPT}"
			read -p "Would you like to use this installer? (Y=Yes;return=No)... " prompt
			if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
				if [[ -d /Volumes/Untitled ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}Creating the installer for OS X El Capitan...${BODY}"
					sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app --nointeraction
					if [ -d /Volumes/Install\ OS\ X\ El\ Capitan/Install\ OS\ X\ El\ Capitan.app ]; then
						echo -e "${TITLE}The drive has been created successfully for OS X El Capitan."
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
						echo -e "${PROMPT}"
						read -p "Would you like to review troubleshooting steps?... " prompt
						if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
							echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
							echo -e "3) Try using a different drive"
							echo -e "4) Try redownloading the macOS Installer"
							echo -e "5) Restart your Mac${RESET}"
							echo -e ""
							echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}${ERROR}"
							echo -e "Error. ($prompt) $NOFAIL"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						fi
					fi
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}You must provide a drive to create the installer"
					echo -e "Drag the drive from the Finder into this window${RESET}"
					echo -e "${WARNING}WARNING: All data on the drive will be erased!${RESET}"
					echo -e "${PROMPT}"
					read -p "Enter the drive path here (" prompt
					if [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for OS X El Capitan...${BODY}"
						sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume "$prompt" --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app --nointeraction
						if [ -d /Volumes/Install\ OS\ X\ El\ Capitan/Install\ OS\ X\ El\ Capitan.app ]; then
							echo -e "${TITLE}The drive has been created successfully for OS X El Capitan."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					fi
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ macOS\ Sierra.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}macOS Sierra was found...${RESET}${PROMPT}"
			read -p "Would you like to use this installer? (Y=Yes;return=No)... " prompt
			if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
				if [[ $os_version == '10.7' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running Mac OS X Lion${RESET}"
					echo -e "${ERROR}You need OS X Mountain Lion or newer to install macOS Sierra."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					if [[ -d /Volumes/Untitled ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Sierra...${BODY}"
						sudo /Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath /Applications/Install\ macOS\ Sierra.app --nointeraction
						if [ -d /Volumes/Install\ macOS\ Sierra/Install\ macOS\ Sierra.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Sierra."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					else
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}You must provide a drive to create the installer"
						echo -e "Drag the drive from the Finder into this window${RESET}"
						echo -e "${WARNING}WARNING: All data on the drive will be erased!${RESET}"
						echo -e "${PROMPT}"
						read -p "Enter the drive path here (" prompt
						if [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Creating the installer for macOS Sierra...${BODY}"
							sudo /Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia --volume "$prompt" --applicationpath /Applications/Install\ macOS\ Sierra.app --nointeraction
							if [ -d /Volumes/Install\ macOS\ Sierra/Install\ macOS\ Sierra.app ]; then
								echo -e "${TITLE}The drive has been created successfully for macOS Sierra."
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
								echo -e "${PROMPT}"
								read -p "Would you like to review troubleshooting steps?... " prompt
								if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
									echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
									echo -e "3) Try using a different drive"
									echo -e "4) Try redownloading the macOS Installer"
									echo -e "5) Restart your Mac${RESET}"
									echo -e ""
									echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							fi
						fi
					fi
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ macOS\ High\ Sierra.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}macOS High Sierra was found...${RESET}${PROMPT}"
			read -p "Would you like to use this installer? (Y=Yes;return=No)... " prompt
			if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
				if [[ $os_version == '10.7' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running Mac OS X Lion${RESET}"
					echo -e "${ERROR}You need OS X Mountain Lion or newer to install macOS High Sierra."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					if [[ -d /Volumes/Untitled ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS High Sierra...${BODY}"
						sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						if [ -d /Volumes/Install\ macOS\ High\ Sierra/Install\ macOS\ High\ Sierra.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS High Sierra."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					else
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}You must provide a drive to create the installer"
						echo -e "Drag the drive from the Finder into this window${RESET}"
						echo -e "${WARNING}WARNING: All data on the drive will be erased!${RESET}"
						echo -e "${PROMPT}"
						read -p "Enter the drive path here (" prompt
						if [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Creating the installer for macOS High Sierra...${BODY}"
							sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
							if [ -d /Volumes/Install\ macOS\ High\ Sierra/Install\ macOS\ High\ Sierra.app ]; then
								echo -e "${TITLE}The drive has been created successfully for macOS High Sierra."
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
								echo -e "${PROMPT}"
								read -p "Would you like to review troubleshooting steps?... " prompt
								if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
									echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
									echo -e "3) Try using a different drive"
									echo -e "4) Try redownloading the macOS Installer"
									echo -e "5) Restart your Mac${RESET}"
									echo -e ""
									echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							fi
						fi
					fi
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ macOS\ Mojave.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}macOS Mojave was found...${RESET}${PROMPT}"
			read -p "Would you like to use this installer? (Y=Yes;return=No)... " prompt
			if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
				if [[ $os_version == '10.7' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running Mac OS X Lion${RESET}"
					echo -e "${ERROR}You need OS X Mountain Lion or newer to install macOS Mojave."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					if [[ -d /Volumes/Untitled ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Mojave...${BODY}"
						sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						if [ -d /Volumes/Install\ macOS\ Mojave/Install\ macOS\ Mojave.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Mojave."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					else
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}You must provide a drive to create the installer"
						echo -e "Drag the drive from the Finder into this window${RESET}"
						echo -e "${WARNING}WARNING: All data on the drive will be erased!${RESET}"
						echo -e "${PROMPT}"
						read -p "Enter the drive path here (" prompt
						if [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Creating the installer for macOS Mojave...${BODY}"
							sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
							if [ -d /Volumes/Install\ macOS\ Mojave/Install\ macOS\ Mojave.app ]; then
								echo -e "${TITLE}The drive has been created successfully for macOS Mojave."
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
								echo -e "${PROMPT}"
								read -p "Would you like to review troubleshooting steps?... " prompt
								if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
									echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
									echo -e "3) Try using a different drive"
									echo -e "4) Try redownloading the macOS Installer"
									echo -e "5) Restart your Mac${RESET}"
									echo -e ""
									echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							fi
						fi
					fi
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ macOS\ Catalina.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}macOS Catalina was found...${RESET}${PROMPT}"
			read -p "Would you like to use this installer? (Y=Yes;return=No)... " prompt
			if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
				if [[ $os_version == '10.7' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running Mac OS X Lion${RESET}"
					echo -e "${ERROR}You need OS X Mavericks or newer to install macOS Catalina."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.8' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X Mountain Lion${RESET}"
					echo -e "${ERROR}You need OS X Mavericks or newer to install macOS Catalina."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					if [[ -d /Volumes/Untitled ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Catalina...${BODY}"
						sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						if [ -d /Volumes/Install\ macOS\ Catalina/Install\ macOS\ Catalina.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Catalina."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					else
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}You must provide a drive to create the installer"
						echo -e "Drag the drive from the Finder into this window${RESET}"
						echo -e "${WARNING}WARNING: All data on the drive will be erased!${RESET}"
						echo -e "${PROMPT}"
						read -p "Enter the drive path here (" prompt
						if [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Creating the installer for macOS Catalina...${BODY}"
							sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
							if [ -d /Volumes/Install\ macOS\ Catalina/Install\ macOS\ Catalina.app ]; then
								echo -e "${TITLE}The drive has been created successfully for macOS Catalina."
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
								echo -e "${PROMPT}"
								read -p "Would you like to review troubleshooting steps?... " prompt
								if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
									echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
									echo -e "3) Try using a different drive"
									echo -e "4) Try redownloading the macOS Installer"
									echo -e "5) Restart your Mac${RESET}"
									echo -e ""
									echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							fi
						fi
					fi
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ macOS\ Big\ Sur.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}macOS Big Sur was found...${RESET}${PROMPT}"
			read -p "Would you like to use this installer? (Y=Yes;return=No)... " prompt
			if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
				if [[ $os_version == '10.7' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running Mac OS X Lion${RESET}"
					echo -e "${ERROR}You need OS X Mavericks or newer to install macOS Big Sur."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.8' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X Mountain Lion${RESET}"
					echo -e "${ERROR}You need OS X Mavericks or newer to install macOS Big Sur."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					if [[ -d /Volumes/Untitled ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Big Sur...${BODY}"
						sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						if [ -d /Volumes/Install\ macOS\ Big\ Sur/Install\ macOS\ Big\ Sur.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Big Sur."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					else
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}You must provide a drive to create the installer"
						echo -e "Drag the drive from the Finder into this window${RESET}"
						echo -e "${WARNING}WARNING: All data on the drive will be erased!${RESET}"
						echo -e "${PROMPT}"
						read -p "Enter the drive path here (" prompt
						if [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Creating the installer for macOS Big Sur...${BODY}"
							sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
							if [ -d /Volumes/Install\ macOS\ Big\ Sur/Install\ macOS\ Big\ Sur.app ]; then
								echo -e "${TITLE}The drive has been created successfully for macOS Big Sur."
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
								echo -e "${PROMPT}"
								read -p "Would you like to review troubleshooting steps?... " prompt
								if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
									echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
									echo -e "3) Try using a different drive"
									echo -e "4) Try redownloading the macOS Installer"
									echo -e "5) Restart your Mac${RESET}"
									echo -e ""
									echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							fi
						fi
					fi
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ macOS\ Monterey.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}macOS Monterey was found...${RESET}${PROMPT}"
			read -p "Would you like to use this installer? (Y=Yes;return=No)... " prompt
			if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
				if [[ $os_version == '10.7' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running Mac OS X Lion${RESET}"
					echo -e "${ERROR}You need OS X Mavericks or newer to install macOS Monterey."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.8' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X Mountain Lion${RESET}"
					echo -e "${ERROR}You need OS X Mavericks or newer to install macOS Monterey."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					if [[ -d /Volumes/Untitled ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Monterey...${BODY}"
						sudo /Applications/Install\ macOS\ Monterey.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						if [ -d /Volumes/Install\ macOS\ Monterey/Install\ macOS\ Monterey.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Monterey."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					else
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}You must provide a drive to create the installer"
						echo -e "Drag the drive from the Finder into this window${RESET}"
						echo -e "${WARNING}WARNING: All data on the drive will be erased!${RESET}"
						echo -e "${PROMPT}"
						read -p "Enter the drive path here (" prompt
						if [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Creating the installer for macOS Monterey...${BODY}"
							sudo /Applications/Install\ macOS\ Monterey.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
							if [ -d /Volumes/Install\ macOS\ Monterey/Install\ macOS\ Monterey.app ]; then
								echo -e "${TITLE}The drive has been created successfully for macOS Monterey."
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
								echo -e "${PROMPT}"
								read -p "Would you like to review troubleshooting steps?... " prompt
								if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
									echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
									echo -e "3) Try using a different drive"
									echo -e "4) Try redownloading the macOS Installer"
									echo -e "5) Restart your Mac${RESET}"
									echo -e ""
									echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							fi
						fi
					fi
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ macOS\ Ventura.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}macOS Ventura was found...${RESET}${PROMPT}"
			read -p "Would you like to use this installer? (Y=Yes;return=No)... " prompt
			if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
				if [[ $os_version == '10.7' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running Mac OS X Lion${RESET}"
					echo -e "${ERROR}You need macOS Sierra or newer to install macOS Ventura."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.8' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X Mountain Lion${RESET}"
					echo -e "${ERROR}You need macOS Sierra or newer to install macOS Ventura."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.9' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X Mavericks${RESET}"
					echo -e "${ERROR}You need macOS Sierra or newer to install macOS Ventura."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.10' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X Yosemite${RESET}"
					echo -e "${ERROR}You need macOS Sierra or newer to install macOS Ventura."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.11' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X El Capitan${RESET}"
					echo -e "${ERROR}You need macOS Sierra or newer to install macOS Ventura."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					if [[ -d /Volumes/Untitled ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Ventura...${BODY}"
						sudo /Applications/Install\ macOS\ Ventura.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						if [ -d /Volumes/Install\ macOS\ Ventura/Install\ macOS\ Ventura.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Ventura."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					else
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}You must provide a drive to create the installer"
						echo -e "Drag the drive from the Finder into this window${RESET}"
						echo -e "${WARNING}WARNING: All data on the drive will be erased!${RESET}"
						echo -e "${PROMPT}"
						read -p "Enter the drive path here (" prompt
						if [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Creating the installer for macOS Ventura...${BODY}"
							sudo /Applications/Install\ macOS\ Ventura.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
							if [ -d /Volumes/Install\ macOS\ Ventura/Install\ macOS\ Ventura.app ]; then
								echo -e "${TITLE}The drive has been created successfully for macOS Ventura."
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
								echo -e "${PROMPT}"
								read -p "Would you like to review troubleshooting steps?... " prompt
								if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
									echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
									echo -e "3) Try using a different drive"
									echo -e "4) Try redownloading the macOS Installer"
									echo -e "5) Restart your Mac${RESET}"
									echo -e ""
									echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							fi
						fi
					fi
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ macOS\ Sonoma.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}macOS Sonoma was found...${RESET}${PROMPT}"
			read -p "Would you like to use this installer? (Y=Yes;return=No)... " prompt
			if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
				if [[ $os_version == '10.7' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running Mac OS X Lion${RESET}"
					echo -e "${ERROR}You need macOS High Sierra or newer to install macOS Sonoma."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.8' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X Mountain Lion${RESET}"
					echo -e "${ERROR}You need macOS High Sierra or newer to install macOS Sonoma."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.9' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X Mavericks${RESET}"
					echo -e "${ERROR}You need macOS High Sierra or newer to install macOS Sonoma."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.10' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X Yosemite${RESET}"
					echo -e "${ERROR}You need macOS High Sierra or newer to install macOS Sonoma."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.11' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X El Capitan${RESET}"
					echo -e "${ERROR}You need macOS High Sierra or newer to install macOS Sonoma."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.12' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running macOS Sierra${RESET}"
					echo -e "${ERROR}You need macOS High Sierra or newer to install macOS Sonoma."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					if [[ -d /Volumes/Untitled ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Sonoma...${BODY}"
						sudo /Applications/Install\ macOS\ Sonoma.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						if [ -d /Volumes/Install\ macOS\ Sonoma/Install\ macOS\ Sonoma.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Sonoma."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					else
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}You must provide a drive to create the installer"
						echo -e "Drag the drive from the Finder into this window${RESET}"
						echo -e "${WARNING}WARNING: All data on the drive will be erased!${RESET}"
						echo -e "${PROMPT}"
						read -p "Enter the drive path here (" prompt
						if [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Creating the installer for macOS Sonoma...${BODY}"
							sudo /Applications/Install\ macOS\ Sonoma.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
							if [ -d /Volumes/Install\ macOS\ Sonoma/Install\ macOS\ Sonoma.app ]; then
								echo -e "${TITLE}The drive has been created successfully for macOS Sonoma."
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
								echo -e "${PROMPT}"
								read -p "Would you like to review troubleshooting steps?... " prompt
								if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
									echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
									echo -e "3) Try using a different drive"
									echo -e "4) Try redownloading the macOS Installer"
									echo -e "5) Restart your Mac${RESET}"
									echo -e ""
									echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							fi
						fi
					fi
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ macOS\ Sequoia.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}macOS Sequoia was found...${RESET}${PROMPT}"
			read -p "Would you like to use this installer? (Y=Yes;return=No)... " prompt
			if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
				if [[ $os_version == '10.7' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running Mac OS X Lion${RESET}"
					echo -e "${ERROR}You need macOS High Sierra or newer to install macOS Sequoia."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.8' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X Mountain Lion${RESET}"
					echo -e "${ERROR}You need macOS High Sierra or newer to install macOS Sequoia."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.9' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X Mavericks${RESET}"
					echo -e "${ERROR}You need macOS High Sierra or newer to install macOS Sequoia."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.10' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X Yosemite${RESET}"
					echo -e "${ERROR}You need macOS High Sierra or newer to install macOS Sequoia."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.11' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running OS X El Capitan${RESET}"
					echo -e "${ERROR}You need macOS High Sierra or newer to install macOS Sequoia."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $os_version == '10.12' ]]; then
					echo -e "${RESET}${ERROR}${BOLD}"
					echo -e "You are running macOS Sierra${RESET}"
					echo -e "${ERROR}You need macOS High Sierra or newer to install macOS Sequoia."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					if [[ -d /Volumes/Untitled ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Sequoia...${BODY}"
						sudo /Applications/Install\ macOS\ Sequoia.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						if [ -d /Volumes/Install\ macOS\ Sequoia/Install\ macOS\ Sequoia.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Sequoia."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					else
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}You must provide a drive to create the installer"
						echo -e "Drag the drive from the Finder into this window${RESET}"
						echo -e "${WARNING}WARNING: All data on the drive will be erased!${RESET}"
						echo -e "${PROMPT}"
						read -p "Enter the drive path here (" prompt
						if [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Creating the installer for macOS Sequoia...${BODY}"
							sudo /Applications/Install\ macOS\ Sequoia.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
							if [ -d /Volumes/Install\ macOS\ Sequoia/Install\ macOS\ Sequoia.app ]; then
								echo -e "${TITLE}The drive has been created successfully for macOS Sequoia."
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
								echo -e "${PROMPT}"
								read -p "Would you like to review troubleshooting steps?... " prompt
								if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
									echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
									echo -e "3) Try using a different drive"
									echo -e "4) Try redownloading the macOS Installer"
									echo -e "5) Restart your Mac${RESET}"
									echo -e ""
									echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							fi
						fi
					fi
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ OS\ X\ Mountain\ Lion.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}OS X Mountain Lion was found...${RESET}"
			echo -e "${ERROR}OS X Mountain Lion is not compatible with this script.${RESET}${PROMPT}"
			echo -e ""
			read -p "Press the return key to cancel... " prompt
			if [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ -d /Applications/Install\ Mac\ OS\ X\ Lion.app ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${OSFOUND}Mac OS X Lion was found...${RESET}"
			echo -e "${ERROR}Mac OS X Lion is not compatible with this script.${RESET}${PROMPT}"
			echo -e ""
			read -p "Press the return key to cancel... " prompt
			if [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		else
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${RESET}${OSFOUND}${BOLD}No versions of macOS were found..."
			echo -e "${RESET}"
			echo -e "${TITLE}Please run this script again and choose one of the tools listed.${RESET}"
			echo -e "${RESET}${PROMPT}"
			read -p "Press the return key to cancel... " prompt
			if [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		fi
	elif [[ "$prompt" == '2' ]]; then
		clear
		echo -e "${APP}${BOLD}                               macOS Creator V3.0"
		echo -e "$LINES"
		echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
		echo -e ""
		echo -e "${RESET}${BODY}Please drag the macOS Installer into this window:"
		echo -e "${RESET}${PROMPT}"
		read -p "Installer path: " AppPath
		if [[ "$AppPath" == '' ]]; then
			echo -e "${RESET}${CANCEL}${BOLD}"
			echo -e "$CANCELED"
			echo -e "${RESET}${APP}${BOLD}"
			echo -e "$LINES"
			echo -e "${RESET}"
			exit
		else
			if [[ "$AppPath" == *'Mavericks.app'* ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
				echo -e ""
				echo -e "${RESET}${BODY}Now please drag the drive into this window:"
				echo -e "${RESET}${PROMPT}"
				read -p "Drive Path: " DrivePath
				if [[ "$DrivePath" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}${BOLD}Please confirm:"
					echo -e ""
					echo -e "${RESET}${BODY}macOS Installer: $AppPath"
					echo -e "Drive Path: $DrivePath"
					echo -e "${RESET}${PROMPT}"
					read -p "Is this okay?... " prompt
					if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for OS X Mavericks...${BODY}"
						sudo "$AppPath"/Contents/Resources/createinstallmedia --volume "$DrivePath" --applicationpath "$AppPath" --nointeraction
						if [ -d /Volumes/Install\ OS\ X\ Mavericks/Install\ OS\ X\ Mavericks.app ]; then
							echo -e "${TITLE}The drive has been created successfully for OS X Mavericks."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}"
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				fi
			elif [[ "$AppPath" == *'Yosemite.app'* ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
				echo -e ""
				echo -e "${RESET}${BODY}Now please drag the drive into this window:"
				echo -e "${RESET}${PROMPT}"
				read -p "Drive Path: " DrivePath
				if [[ "$DrivePath" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}${BOLD}Please confirm:"
					echo -e ""
					echo -e "${RESET}${BODY}macOS Installer: $AppPath"
					echo -e "Drive Path: $DrivePath"
					echo -e "${RESET}${PROMPT}"
					read -p "Is this okay?... " prompt
					if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for OS X Yosemite...${BODY}"
						sudo "$AppPath"/Contents/Resources/createinstallmedia --volume "$DrivePath" --applicationpath "$AppPath" --nointeraction
						if [ -d /Volumes/Install\ OS\ X\ Yosemite/Install\ OS\ X\ Yosemite.app ]; then
							echo -e "${TITLE}The drive has been created successfully for OS X Yosemite."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}"
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				fi
			elif [[ "$AppPath" == *'Capitan.app'* ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
				echo -e ""
				echo -e "${RESET}${BODY}Now please drag the drive into this window:"
				echo -e "${RESET}${PROMPT}"
				read -p "Drive Path: " DrivePath
				if [[ "$DrivePath" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}${BOLD}Please confirm:"
					echo -e ""
					echo -e "${RESET}${BODY}macOS Installer: $AppPath"
					echo -e "Drive Path: $DrivePath"
					echo -e "${RESET}${PROMPT}"
					read -p "Is this okay?... " prompt
					if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for OS X El Capitan...${BODY}"
						sudo "$AppPath"/Contents/Resources/createinstallmedia --volume "$DrivePath" --applicationpath "$AppPath" --nointeraction
						if [ -d /Volumes/Install\ OS\ X\ El\ Capitan/Install\ OS\ X\ El\ Capitan.app ]; then
							echo -e "${TITLE}The drive has been created successfully for OS X El Capitan."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}"
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				fi
			elif [[ "$AppPath" == *'macOS Sierra.app'* ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
				echo -e ""
				echo -e "${RESET}${BODY}Now please drag the drive into this window:"
				echo -e "${RESET}${PROMPT}"
				read -p "Drive Path: " DrivePath
				if [[ "$DrivePath" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}${BOLD}Please confirm:"
					echo -e ""
					echo -e "${RESET}${BODY}macOS Installer: $AppPath"
					echo -e "Drive Path: $DrivePath"
					echo -e "${RESET}${PROMPT}"
					read -p "Is this okay?... " prompt
					if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Sierra...${BODY}"
						sudo "$AppPath"/Contents/Resources/createinstallmedia --volume "$DrivePath" --applicationpath "$AppPath" --nointeraction
						if [ -d /Volumes/Install\ macOS\ Sierra/Install\ macOS\ Sierra.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Sierra."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}"
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				fi
			elif [[ "$AppPath" == *'High Sierra.app'* ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
				echo -e ""
				echo -e "${RESET}${BODY}Now please drag the drive into this window:"
				echo -e "${RESET}${PROMPT}"
				read -p "Drive Path: " DrivePath
				if [[ "$DrivePath" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}${BOLD}Please confirm:"
					echo -e ""
					echo -e "${RESET}${BODY}macOS Installer: $AppPath"
					echo -e "Drive Path: $DrivePath"
					echo -e "${RESET}${PROMPT}"
					read -p "Is this okay?... " prompt
					if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS High Sierra...${BODY}"
						sudo "$AppPath"/Contents/Resources/createinstallmedia --volume "$DrivePath" --nointeraction
						if [ -d /Volumes/Install\ macOS\ High\ Sierra/Install\ macOS\ High\ Sierra.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS High Sierra."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}"
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				fi
			elif [[ "$AppPath" == *'Mojave.app'* ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
				echo -e ""
				echo -e "${RESET}${BODY}Now please drag the drive into this window:"
				echo -e "${RESET}${PROMPT}"
				read -p "Drive Path: " DrivePath
				if [[ "$DrivePath" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}${BOLD}Please confirm:"
					echo -e ""
					echo -e "${RESET}${BODY}macOS Installer: $AppPath"
					echo -e "Drive Path: $DrivePath"
					echo -e "${RESET}${PROMPT}"
					read -p "Is this okay?... " prompt
					if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Mojave...${BODY}"
						sudo "$AppPath"/Contents/Resources/createinstallmedia --volume "$DrivePath" --nointeraction
						if [ -d /Volumes/Install\ macOS\ Mojave/Install\ macOS\ Mojave.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Mojave."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}"
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				fi
			elif [[ "$AppPath" == *'Catalina.app'* ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
				echo -e ""
				echo -e "${RESET}${BODY}Now please drag the drive into this window:"
				echo -e "${RESET}${PROMPT}"
				read -p "Drive Path: " DrivePath
				if [[ "$DrivePath" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}${BOLD}Please confirm:"
					echo -e ""
					echo -e "${RESET}${BODY}macOS Installer: $AppPath"
					echo -e "Drive Path: $DrivePath"
					echo -e "${RESET}${PROMPT}"
					read -p "Is this okay?... " prompt
					if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Catalina...${BODY}"
						sudo "$AppPath"/Contents/Resources/createinstallmedia --volume "$DrivePath" --nointeraction
						if [ -d /Volumes/Install\ macOS\ Catalina/Install\ macOS\ Catalina.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Catalina."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}"
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				fi
			elif [[ "$AppPath" == *'Sur.app'* ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
				echo -e ""
				echo -e "${RESET}${BODY}Now please drag the drive into this window:"
				echo -e "${RESET}${PROMPT}"
				read -p "Drive Path: " DrivePath
				if [[ "$DrivePath" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}${BOLD}Please confirm:"
					echo -e ""
					echo -e "${RESET}${BODY}macOS Installer: $AppPath"
					echo -e "Drive Path: $DrivePath"
					echo -e "${RESET}${PROMPT}"
					read -p "Is this okay?... " prompt
					if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Big Sur...${BODY}"
						sudo "$AppPath"/Contents/Resources/createinstallmedia --volume "$DrivePath" --nointeraction
						if [ -d /Volumes/Install\ macOS\ Big\ Sur/Install\ macOS\ Big\ Sur.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Big Sur."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}"
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				fi
			elif [[ "$AppPath" == *'Monterey.app'* ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
				echo -e ""
				echo -e "${RESET}${BODY}Now please drag the drive into this window:"
				echo -e "${RESET}${PROMPT}"
				read -p "Drive Path: " DrivePath
				if [[ "$DrivePath" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}${BOLD}Please confirm:"
					echo -e ""
					echo -e "${RESET}${BODY}macOS Installer: $AppPath"
					echo -e "Drive Path: $DrivePath"
					echo -e "${RESET}${PROMPT}"
					read -p "Is this okay?... " prompt
					if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Monterey...${BODY}"
						sudo "$AppPath"/Contents/Resources/createinstallmedia --volume "$DrivePath" --nointeraction
						if [ -d /Volumes/Install\ macOS\ Monterey/Install\ macOS\ Monterey.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Monterey."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}"
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				fi
			elif [[ "$AppPath" == *'Ventura.app'* ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
				echo -e ""
				echo -e "${RESET}${BODY}Now please drag the drive into this window:"
				echo -e "${RESET}${PROMPT}"
				read -p "Drive Path: " DrivePath
				if [[ "$DrivePath" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}${BOLD}Please confirm:"
					echo -e ""
					echo -e "${RESET}${BODY}macOS Installer: $AppPath"
					echo -e "Drive Path: $DrivePath"
					echo -e "${RESET}${PROMPT}"
					read -p "Is this okay?... " prompt
					if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Ventura...${BODY}"
						sudo "$AppPath"/Contents/Resources/createinstallmedia --volume "$DrivePath" --nointeraction
						if [ -d /Volumes/Install\ macOS\ Ventura/Install\ macOS\ Ventura.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Ventura."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}"
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				fi
			elif [[ "$AppPath" == *'Sonoma.app'* ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
				echo -e ""
				echo -e "${RESET}${BODY}Now please drag the drive into this window:"
				echo -e "${RESET}${PROMPT}"
				read -p "Drive Path: " DrivePath
				if [[ "$DrivePath" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}${BOLD}Please confirm:"
					echo -e ""
					echo -e "${RESET}${BODY}macOS Installer: $AppPath"
					echo -e "Drive Path: $DrivePath"
					echo -e "${RESET}${PROMPT}"
					read -p "Is this okay?... " prompt
					if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Sonoma...${BODY}"
						sudo "$AppPath"/Contents/Resources/createinstallmedia --volume "$DrivePath" --nointeraction
						if [ -d /Volumes/Install\ macOS\ Sonoma/Install\ macOS\ Sonoma.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Sonoma."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}"
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				fi
			elif [[ "$AppPath" == *'Sequoia.app'* ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}${BOLD}Manually provide the macOS Installer and drive path:"
				echo -e ""
				echo -e "${RESET}${BODY}Now please drag the drive into this window:"
				echo -e "${RESET}${PROMPT}"
				read -p "Drive Path: " DrivePath
				if [[ "$DrivePath" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}${BOLD}Please confirm:"
					echo -e ""
					echo -e "${RESET}${BODY}macOS Installer: $AppPath"
					echo -e "Drive Path: $DrivePath"
					echo -e "${RESET}${PROMPT}"
					read -p "Is this okay?... " prompt
					if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Creating the installer for macOS Sequoia...${BODY}"
						sudo "$AppPath"/Contents/Resources/createinstallmedia --volume "$DrivePath" --nointeraction
						if [ -d /Volumes/Install\ macOS\ Sequoia/Install\ macOS\ Sequoia.app ]; then
							echo -e "${TITLE}The drive has been created successfully for macOS Sequoia."
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}"
							echo -e "${ERROR}${BOLD}Operation Failed.${RESET}"
							echo -e "${PROMPT}"
							read -p "Would you like to review troubleshooting steps?... " prompt
							if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
								echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
								echo -e "3) Try using a different drive"
								echo -e "4) Try redownloading the macOS Installer"
								echo -e "5) Restart your Mac${RESET}"
								echo -e ""
								echo -e "${TITLE}Once you have found a solution, run this script again...${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				fi
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($AppPath) is not a valid macOS Installer."
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		fi
	elif [[ "$prompt" == '3' ]]; then
		clear
		echo -e "${APP}${BOLD}                               macOS Creator V3.0"
		echo -e "$LINES"
		echo -e "${RESET}${TITLE}Choose the version of macOS you wish to download..."
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
		echo -e "${RESET}${PROMPT}"
		read -p "Enter your option here... " prompt
		if [[ "$prompt" == '1' ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${RESET}${TITLE}Downloading OS X Mavericks...${RESET}${BODY}"
			sudo curl https://ia801805.us.archive.org/35/items/os-x-mavericks/Install%20OS%20X%20Mavericks.zip -o /private/tmp/InstallmacOS.zip
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				sudo open /private/tmp/InstallmacOS.zip
				echo -e "${RESET}${TITLE}"
				echo -e "Now copy the macOS Installer into your Applications folder..."
				echo -e "Once completed, please run this script again..."
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e ""
				echo -e "${RESET}${ERROR}Download failed"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ "$prompt" == '2' ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${RESET}${TITLE}Downloading OS X Yosemite...${RESET}${BODY}"
			sudo curl http://updates-http.cdn-apple.com/2019/cert/061-41343-20191023-02465f92-3ab5-4c92-bfe2-b725447a070d/InstallMacOSX.dmg -o /private/tmp/InstallmacOS.dmg
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				sudo open /private/tmp/InstallmacOS.dmg
				echo -e "${RESET}${TITLE}"
				echo -e "Follow the on-screen instructions to install..."
				echo -e "Once completed, please run this script again..."
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e ""
				echo -e "${RESET}${ERROR}Download failed"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ "$prompt" == '3' ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${RESET}${TITLE}Downloading OS X El Capitan...${RESET}${BODY}"
			sudo curl http://updates-http.cdn-apple.com/2019/cert/061-41424-20191024-218af9ec-cf50-4516-9011-228c78eda3d2/InstallMacOSX.dmg -o /private/tmp/InstallmacOS.dmg
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				sudo open /private/tmp/InstallmacOS.dmg
				echo -e "${RESET}${TITLE}"
				echo -e "Follow the on-screen instructions to install..."
				echo -e "Once completed, please run this script again..."
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e ""
				echo -e "${RESET}${ERROR}Download failed"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ "$prompt" == '4' ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${RESET}${TITLE}Downloading macOS Sierra...${RESET}${BODY}"
			sudo curl http://updates-http.cdn-apple.com/2019/cert/061-39476-20191023-48f365f4-0015-4c41-9f44-39d3d2aca067/InstallOS.dmg -o /private/tmp/InstallmacOS.dmg
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				sudo open /private/tmp/InstallmacOS.dmg
				echo -e "${RESET}${TITLE}"
				echo -e "Follow the on-screen instructions to install..."
				echo -e "Once completed, please run this script again..."
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e ""
				echo -e "${RESET}${ERROR}Download failed"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ "$prompt" == '5' ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${RESET}${TITLE}Downloading macOS High Sierra...${RESET}${BODY}"
			sudo curl https://archive.org/download/mac-os-high-sierra-10.13.5/macOS%20High%20Sierra%2010.13.5.iso -o /private/tmp/InstallmacOS.iso
			if [[ -e /private/tmp/InstallmacOS.iso ]]; then
				sudo open /private/tmp/InstallmacOS.iso
				echo -e "${RESET}${TITLE}"
				echo -e "Now copy the macOS Installer into your Applications folder..."
				echo -e "Once completed, please run this script again..."
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e ""
				echo -e "${RESET}${ERROR}Download failed"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ "$prompt" == '6' ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${RESET}${TITLE}Downloading macOS Mojave...${RESET}${BODY}"
			sudo curl https://archive.org/download/mac-os-mojave-10.14/macOS%20Mojave%2010.14.iso -o /private/tmp/InstallmacOS.iso
			if [[ -e /private/tmp/InstallmacOS.iso ]]; then
				sudo open /private/tmp/InstallmacOS.iso
				echo -e "${RESET}${TITLE}"
				echo -e "Now copy the macOS Installer into your Applications folder..."
				echo -e "Once completed, please run this script again..."
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e ""
				echo -e "${RESET}${ERROR}Download failed"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ "$prompt" == '7' ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${RESET}${TITLE}Downloading macOS Catalina...${RESET}${BODY}"
			sudo curl https://archive.org/download/macOS-Catalina-IOS/macOSCatalina.iso -o /private/tmp/InstallmacOS.iso
			if [[ -e /private/tmp/InstallmacOS.iso ]]; then
				sudo open /private/tmp/InstallmacOS.iso
				echo -e "${RESET}${TITLE}"
				echo -e "Now copy the macOS Installer into your Applications folder..."
				echo -e "Once completed, please run this script again..."
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e ""
				echo -e "${RESET}${ERROR}Download failed"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ "$prompt" == '8' ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${RESET}${TITLE}Downloading macOS Big Sur...${RESET}${BODY}"
			sudo curl https://swcdn.apple.com/content/downloads/14/38/042-45246-A_NLFOFLCJFZ/jk992zbv98sdzz3rgc7mrccjl3l22ruk1c/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				sudo open /private/tmp/InstallAssistant.pkg
				echo -e "${RESET}${TITLE}"
				echo -e "Follow the on-screen instructions to install..."
				echo -e "Once completed, please run this script again..."
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e ""
				echo -e "${RESET}${ERROR}Download failed"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			fi
		elif [[ "$prompt" == '9' ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${RESET}${TITLE}Choose the version of macOS you wish to download..."
			echo -e "${RESET}${BODY}"
			echo -e "macOS Monterey.....(1)"
			echo -e "macOS Ventura......(2)"
			echo -e "macOS Sonoma.......(3)"
			echo -e "macOS Sequoia......(4)"
			echo -e "${RESET}${PROMPT}"
			read -p "Enter your option here... " prompt
			if [[ "$prompt" == '1' ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}Downloading macOS Monterey...${RESET}${BODY}"
				sudo curl https://swcdn.apple.com/content/downloads/46/57/052-60131-A_KM2RH04C2D/9yzvba1uvpem2wuo95r459qno57qaizwf2/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
				if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
					sudo open /private/tmp/InstallAssistant.pkg
					echo -e "${RESET}${TITLE}"
					echo -e "Follow the on-screen instructions to install..."
					echo -e "Once completed, please run this script again..."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					echo -e ""
					echo -e "${RESET}${ERROR}Download failed"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				fi
			elif [[ "$prompt" == '2' ]]; then
					clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}Downloading macOS Ventura...${RESET}${BODY}"
				sudo curl https://swcdn.apple.com/content/downloads/29/47/072-09024-A_8G5EY3SPX2/l6ecgngkrhhbc6q4mae5cwe42pxp49co7w/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
				if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
					sudo open /private/tmp/InstallAssistant.pkg
					echo -e "${RESET}${TITLE}"
					echo -e "Follow the on-screen instructions to install..."
					echo -e "Once completed, please run this script again..."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					echo -e ""
					echo -e "${RESET}${ERROR}Download failed"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				fi
			elif [[ "$prompt" == '3' ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}Downloading macOS Sonoma...${RESET}${BODY}"
				sudo curl https://swcdn.apple.com/content/downloads/16/03/072-24524-A_BOQKY5YAFR/x086vnjdghnpudh3dv11jbce398n0alxtl/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
				if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
					sudo open /private/tmp/InstallAssistant.pkg
					echo -e "${RESET}${TITLE}"
					echo -e "Follow the on-screen instructions to install..."
					echo -e "Once completed, please run this script again..."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					echo -e ""
					echo -e "${RESET}${ERROR}Download failed"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				fi
			elif [[ "$prompt" == '4' ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}Downloading macOS Sequoia...${RESET}${BODY}"
				sudo curl https://swcdn.apple.com/content/downloads/08/08/072-12353-A_IUBHH68MQT/sv48ma68gmhl96fa9anqfj3i2fnb1ur2wh/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
				if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
					sudo open /private/tmp/InstallAssistant.pkg
					echo -e "${RESET}${TITLE}"
					echo -e "Follow the on-screen instructions to install..."
					echo -e "Once completed, please run this script again..."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					echo -e ""
					echo -e "${RESET}${ERROR}Download failed"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit				
			fi
		elif [[ "$prompt" == '' ]]; then
			echo -e "${RESET}${CANCEL}${BOLD}"
			echo -e "$CANCELED"
			echo -e "${RESET}${APP}${BOLD}"
			echo -e "$LINES"
			echo -e "${RESET}"
			exit
		else
			echo -e "${RESET}${ERROR}"
			echo -e "Error. ($prompt) $NOFAIL"
			echo -e "${RESET}${APP}${BOLD}"
			echo -e "$LINES"
			echo -e "${RESET}"
			exit
		fi
	elif [[ "$prompt" == '4' ]]; then
		clear
		echo -e "${APP}${BOLD}                               macOS Creator V3.0"
		echo -e "$LINES"
		echo -e "${RESET}${WARNING}${BOLD}WARNING: This is a BETA build!"
		echo -e "${RESET}${WARNING}BETA builds may not work as expected."
		echo -e "${RESET}${TITLE}You can use this tool to identify this Mac or another one"
		echo -e "Use this tool to determine lastest macOS Version compatible for the Mac."
		echo -e "${RESET}${PROMPT}"
		read -p "Do you wish to continue?... " prompt
		if [[ "$prompt" == 'y' || "$prompt" == 'Y' ]]; then
			clear
			echo -e "${APP}${BOLD}                               macOS Creator V3.0"
			echo -e "$LINES"
			echo -e "${RESET}${TITLE}What would you like to do?"
			echo -e "${BODY}Identify this Mac........................................................(1)"
			echo -e "${BODY}Identify another Mac.....................................................(2)"
			echo -e "${RESET}${PROMPT}"
			read -p "Enter your option here... " prompt
			if [[ "$prompt" == '1' ]]; then
				if [[ $MACVERSION == 'MacBook5,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (13-inch, Aluminum, Late 2008)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBook5,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (13-inch, Early 2009) + (13-inch, Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBook6,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (13-inch, Late 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBook7,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (13-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBook8,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (Retina, 12-inch, Early 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBook9,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (Retina, 12-inch, Early 2016)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBook10,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook (Retina, 12-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir1,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Original)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}Mac OS X Lion ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir2,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir3,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Late 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir3,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Late 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir4,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir4,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir5,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir5,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir6,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Mid 2013) + (11-inch, Early 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir6,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Mid 2013) + (13-inch, Early 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir7,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (11-inch, Early 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir7,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, Early 2015) + MacBook Air (13-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir8,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Retina, 13-inch, 2018)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sonoma ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir8,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Retina, 13-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sonoma ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir9,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (Retina, 13-inch, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookAir10,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (M1, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac14,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (M2, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac14,15' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (15-inch, M2, 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac15,12' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (13-inch, M3, 2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac15,13' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Air (15-inch, M3, 2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro4,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch/17-inch, Early 2008)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro5,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Late 2008)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro5,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (17-inch, Early/Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro5,5' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro5,3' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Mid 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro7,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro6,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro6,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (17-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro8,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, Early/Late 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro8,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Early/Late 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro8,3' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (17-inch, Early/Late 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro9,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro9,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro10,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 15-inch, Mid 2012/Early 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro10,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 13-inch, Late 2012/Early 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro11,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 13-inch, Late 2013/Mid 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro11,2' || $MACVERSION == 'MacBookPro11,3' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 15-inch, Late 2013/Mid 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro12,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 13-inch, Early 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro11,4' || $MACVERSION == 'MacBookPro11,5' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (Retina, 15-inch, Mid 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro13,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2016, Two Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro13,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2016, Four Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro13,3' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, 2016)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro14,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2017, Two Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro14,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2017, Four Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro14,3' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro15,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2018/2019, Four Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro15,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, 2018)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro15,3' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (15-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro15,4' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2019, Two Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro16,1' || $MACVERSION == 'MacBookPro16,4' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro16,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro16,3' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, 2020, Two Thunderbolt 3 ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro17,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, M1, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro18,1' || $MACVERSION == 'MacBookPro18,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, 2021)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacBookPro18,3' || $MACVERSION == 'MacBookPro18,4' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (14-inch, 2021)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac14,7' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (13-inch, M2, 2022)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac14,6' || $MACVERSION == 'Mac14,10' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac14,5' || $MACVERSION == 'Mac14,9' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (14-inch, 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac15,7' || $MACVERSION == 'Mac15,9' || $MACVERSION == 'Mac15,11' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, Nov 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac15,6' || $MACVERSION == 'Mac15,8' || $MACVERSION == 'Mac15,10' || $MACVERSION == 'Mac15,3' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (14-inch, Nov 2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac16,7' || $MACVERSION == 'Mac16,5' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (16-inch, 2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac16,6' || $MACVERSION == 'Mac16,8' || $MACVERSION == 'Mac16,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a MacBook Pro (14-inch, 2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac9,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Early 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac10,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Late 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac11,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac11,3' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (27-inch, Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac12,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac12,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (27-inch, Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac13,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Late 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac13,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (27-inch, Late 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac14,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Late 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac14,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (27-inch, Late 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac14,4' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Mid 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac15,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, Late 2014/Mid 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac16,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, Late 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac16,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 4K, 21.5-inch, Late 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac17,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, Late 2015)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac18,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (21.5-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac18,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 4K, 21.5-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac18,3' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, 2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMacPro1,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac Pro (2017)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac19,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 4K, 21.5-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac19,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, 2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac20,1' || $MACVERSION == 'iMac20,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (Retina 5K, 27-inch, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'iMac21,2' || $MACVERSION == 'iMac21,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, M1, 2021)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac15,4' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, 2023, Two ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac15,5' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, 2023, Four ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac16,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, 2024, Two ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac16,3' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a iMac (24-inch, 2024, Four ports)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Macmini3,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Early/Late 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Macmini4,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Mid 2010)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Macmini5,1' || $MACVERSION == 'Macmini5,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Mid 2011)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Macmini6,1' || $MACVERSION == 'Macmini6,2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Late 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Macmini7,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (Late 2014)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Macmini8,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (2018)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Macmini9,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (M1, 2020)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac14,12' || $MACVERSION == 'Mac14,3' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac16,15' || $MACVERSION == 'Mac16,10' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac mini (2024)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				
				elif [[ $MACVERSION == 'MacPro4,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (Early 2009)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacPro5,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (Server) (Mid 2010/Mid 2012)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
					echo -e "${RESET}${TITLE}If you have a Metal Graphics card: ${BOLD}macOS Mojave ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacPro6,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (Late 2013)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'MacPro7,1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (2019)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				elif [[ $MACVERSION == 'Mac14,8' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${OSFOUND}${BOLD}You have a Mac Pro (2023)"
					echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else 
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${ERROR}Cannot detect Mac model."
					echo -e "You may have a model that is not compatible with this script..."
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				fi
			elif [[ "$prompt" == '2' ]]; then
				clear
				echo -e "${APP}${BOLD}                               macOS Creator V3.0"
				echo -e "$LINES"
				echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
				echo -e "${BODY}Laptop...................................................................(1)"
				echo -e "Desktop..................................................................(2)"
				echo -e "${RESET}${PROMPT}"
				read -p "Enter your option here... " prompt
				if [[ "$prompt" == '1' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
					echo -e "${BODY}MacBook..................................................................(1)"
					echo -e "MacBook Pro..............................................................(2)"
					echo -e "MacBook Air..............................................................(3)"
					echo -e "${RESET}${PROMPT}"
					read -p "Enter your option here... " prompt
					if [[ "$prompt" == '1' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}MacBook (Polycarbonate)..................................................(1)"
						echo -e "MacBook (Unibody)........................................................(2)"
						echo -e "MacBook (Retina).........................................................(3)"
						echo -e "${RESET}${PROMPT}"
						read -p "Enter your option here... " prompt
						if [[ "$prompt" == '1' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}Early 2009 / Mid 2009....................................................(1)"
							echo -e "Late 2009 / Mid 2010.....................................................(2)"
							echo -e "${RESET}${PROMPT}"
							read -p "Enter your option here... " prompt
							if [[ "$prompt" == '1' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Early 2009/Mid 2009)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '2' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Late 2009/Mid 2010)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						elif [[ "$prompt" == '2' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Aluminum, Late 2008)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '3' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}2015.....................................................................(1)"
							echo -e "2016.....................................................................(2)"
							echo -e "2017.....................................................................(3)"
							echo -e "${RESET}${PROMPT}"
							read -p "Enter your option here... " prompt
							if [[ "$prompt" == '1' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Retina, 2015)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '2' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Retina, 2016)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '3' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook (Retina, 2017)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						elif [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}${ERROR}"
							echo -e "Error. ($prompt) $NOFAIL"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						fi
					elif [[ "$prompt" == '2' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}13-inch Display..........................................................(1)"
						echo -e "14-inch Display..........................................................(2)"
						echo -e "15-inch Display..........................................................(3)"
						echo -e "16-inch Display..........................................................(4)"
						echo -e "17-inch Display..........................................................(5)"
						echo -e "${RESET}${PROMPT}"
						read -p "Enter your option here... " prompt
						if [[ "$prompt" == '1' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}LCD Display..............................................................(1)"
							echo -e "Retina Display...........................................................(2)"
							echo -e "${RESET}${PROMPT}"
							read -p "Enter your option here... " prompt
							if [[ "$prompt" == '1' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
								echo -e "${BODY}2009.....................................................................(1)"
								echo -e "2010-2011................................................................(2)"
								echo -e "2012.....................................................................(3)"
								echo -e "${RESET}${PROMPT}"
								read -p "Enter your option here... " prompt
								if [[ "$prompt" == '1' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2009)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '2' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2010-2011)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '3' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2012)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							elif [[ "$prompt" == '2' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
								echo -e "${BODY}2012-Early 2013..........................................................(1)"
								echo -e "Late 2013-2014...........................................................(2)"
								echo -e "2015-2016................................................................(3)"
								echo -e "2017.....................................................................(4)"
								echo -e "2018 or newer............................................................(5)"
								echo -e "${RESET}${PROMPT}"
								read -p "Enter your option here... " prompt
									if [[ "$prompt" == '1' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2012-2013)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '2' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2013-2014)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '3' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2015-2016)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '4' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2017)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '5' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2018 or newer)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						elif [[ "$prompt" == '2' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro 14-inch"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '3' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}LCD Display..............................................................(1)"
							echo -e "Retina Display...........................................................(2)"
							echo -e "${RESET}${PROMPT}"
							read -p "Enter your option here... " prompt
							if [[ "$prompt" == '1' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
								echo -e "${BODY}2008-2009................................................................(1)"
								echo -e "2010-2011................................................................(2)"
								echo -e "2012.....................................................................(3)"
								echo -e "${RESET}${PROMPT}"
								read -p "Enter your option here... " prompt
								if [[ "$prompt" == '1' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2008-2009)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '2' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2010-2011)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '3' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2012)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							elif [[ "$prompt" == '2' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
								echo -e "${BODY}2012-Early 2013..........................................................(1)"
								echo -e "Late 2013-2014...........................................................(2)"
								echo -e "2015-2016................................................................(3)"
								echo -e "2017.....................................................................(4)"
								echo -e "2018 or newer............................................................(5)"
								echo -e "${RESET}${PROMPT}"
								read -p "Enter your option here... " prompt
									if [[ "$prompt" == '1' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2012-2013)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '2' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2013-2014)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '3' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2015-2016)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '4' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2017)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '5' ]]; then
									clear
									echo -e "${APP}${BOLD}                               macOS Creator V3.0"
									echo -e "$LINES"
									echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2018 or newer)"
									echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								elif [[ "$prompt" == '' ]]; then
									echo -e "${RESET}${CANCEL}${BOLD}"
									echo -e "$CANCELED"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								else
									echo -e "${RESET}${ERROR}"
									echo -e "Error. ($prompt) $NOFAIL"
									echo -e "${RESET}${APP}${BOLD}"
									echo -e "$LINES"
									echo -e "${RESET}"
									exit
								fi
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						elif [[ "$prompt" == '4' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro 16-inch"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '5' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}2008-2009................................................................(1)"
							echo -e "2010-2011................................................................(2)"
							echo -e "${RESET}${PROMPT}"
							read -p "Enter your option here... " prompt
							if [[ "$prompt" == '1' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2008-2009)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '2' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Pro (2010-2011)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						elif [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}${ERROR}"
							echo -e "Error. ($prompt) $NOFAIL"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						fi
					elif [[ "$prompt" == '3' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}11-inch Display..........................................................(1)"
						echo -e "13-inch Display..........................................................(2)"
						echo -e "15-inch Display..........................................................(3)"
						echo -e "${RESET}${PROMPT}"
						read -p "Enter your option here... " prompt
						if [[ "$prompt" == '1' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}2010-2011................................................................(1)"
							echo -e "2012.....................................................................(2)"
							echo -e "2013-2014................................................................(3)"
							echo -e "2015.....................................................................(4)"
							echo -e "${RESET}${PROMPT}"
							read -p "Enter your option here... " prompt
							if [[ "$prompt" == '1' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2010-2011)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '2' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2012)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '3' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2013-2014)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '4' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2015)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						elif [[ "$prompt" == '2' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}2009.....................................................................(1)"
							echo -e "2010-2011................................................................(2)"
							echo -e "2012.....................................................................(3)"
							echo -e "2013-2014................................................................(4)"
							echo -e "2015-2017................................................................(5)"
							echo -e "2018-2019................................................................(6)"
							echo -e "2020 or newer............................................................(7)"
							echo -e "${RESET}${PROMPT}"
							read -p "Enter your option here... " prompt
							if [[ "$prompt" == '1' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2009)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '2' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2010-2011)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '3' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2012)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '4' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2013-2014)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '5' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2015 or 2017)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '6' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2018-2019)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sonoma ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '7' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air (2020 or newer)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						elif [[ "$prompt" == '3' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is a MacBook Air 15-inch"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}${ERROR}"
							echo -e "Error. ($prompt) $NOFAIL"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				elif [[ "$prompt" == '2' ]]; then
					clear
					echo -e "${APP}${BOLD}                               macOS Creator V3.0"
					echo -e "$LINES"
					echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
					echo -e "${BODY}iMac.....................................................................(1)"
					echo -e "Mac Mini.................................................................(2)"
					echo -e "Mac Pro..................................................................(3)"
					echo -e "${RESET}${PROMPT}"
					read -p "Enter your option here... " prompt
					if [[ "$prompt" == '1' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}iMac.....................................................................(1)"
						echo -e "iMac Pro.................................................................(2)"
						echo -e "${RESET}${PROMPT}"
						read -p "Enter your option here... " prompt
						if [[ "$prompt" == '1' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
							echo -e "${BODY}Early 2009...............................................................(1)"
							echo -e "Late 2009-2011...........................................................(2)"
							echo -e "2012-2013................................................................(3)"
							echo -e "2014-Mid 2015............................................................(4)"
							echo -e "Late 2015................................................................(5)"
							echo -e "2017.....................................................................(6)"
							echo -e "2029 or newer............................................................(7)"
							echo -e "${RESET}${PROMPT}"
							read -p "Enter your option here... " prompt
							if [[ "$prompt" == '1' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2009)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '2' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2009-2011)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '3' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2012-2013)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '4' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2014-2015)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Big Sur ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '5' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2015)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '6' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2017)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Ventura ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '7' ]]; then
								clear
								echo -e "${APP}${BOLD}                               macOS Creator V3.0"
								echo -e "$LINES"
								echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac (2019 or newer)"
								echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							elif [[ "$prompt" == '' ]]; then
								echo -e "${RESET}${CANCEL}${BOLD}"
								echo -e "$CANCELED"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							else
								echo -e "${RESET}${ERROR}"
								echo -e "Error. ($prompt) $NOFAIL"
								echo -e "${RESET}${APP}${BOLD}"
								echo -e "$LINES"
								echo -e "${RESET}"
								exit
							fi
						elif [[ "$prompt" == '2' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is an iMac Pro"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}${ERROR}"
							echo -e "Error. ($prompt) $NOFAIL"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						fi
					elif [[ "$prompt" == '2' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}2009.....................................................................(1)"
						echo -e "2010.....................................................................(2)"
						echo -e "2011.....................................................................(3)"
						echo -e "2012.....................................................................(4)"
						echo -e "2014.....................................................................(5)"
						echo -e "2018 or newer............................................................(6)"
						echo -e "${RESET}${PROMPT}"
						read -p "Enter your option here... " prompt
						if [[ "$prompt" == '1' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2009)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '2' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2010)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '3' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2011)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '4' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2012)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Catalina ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '5' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2014)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '6' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2018 or newer)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}${ERROR}"
							echo -e "Error. ($prompt) $NOFAIL"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						fi
					elif [[ "$prompt" == '3' ]]; then
						clear
						echo -e "${APP}${BOLD}                               macOS Creator V3.0"
						echo -e "$LINES"
						echo -e "${RESET}${TITLE}Please choose one of the following:${RESET}"
						echo -e "${BODY}2009.....................................................................(1)"
						echo -e "2010-2012................................................................(2)"
						echo -e "2013.....................................................................(3)"
						echo -e "2019 or newer............................................................(4)"
						echo -e "${RESET}${PROMPT}"
						read -p "Enter your option here... " prompt
						if [[ "$prompt" == '1' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Pro (2009)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}OS X El Capitan ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '2' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is a Mac Pro (2010 or 2012)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS High Sierra ${RESET}"
							echo -e "${RESET}${TITLE}If you have a Metal Graphics card: ${BOLD}macOS Mojave ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '3' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Pro (2013)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Monterey ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '4' ]]; then
							clear
							echo -e "${APP}${BOLD}                               macOS Creator V3.0"
							echo -e "$LINES"
							echo -e "${RESET}${OSFOUND}${BOLD}This is an Mac Mini (2019 or newer)"
							echo -e "${RESET}${TITLE}The latest compatible macOS version is ${BOLD}macOS Sequoia ${RESET}"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						elif [[ "$prompt" == '' ]]; then
							echo -e "${RESET}${CANCEL}${BOLD}"
							echo -e "$CANCELED"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						else
							echo -e "${RESET}${ERROR}"
							echo -e "Error. ($prompt) $NOFAIL"
							echo -e "${RESET}${APP}${BOLD}"
							echo -e "$LINES"
							echo -e "${RESET}"
							exit
						fi
					elif [[ "$prompt" == '' ]]; then
						echo -e "${RESET}${CANCEL}${BOLD}"
						echo -e "$CANCELED"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					else
						echo -e "${RESET}${ERROR}"
						echo -e "Error. ($prompt) $NOFAIL"
						echo -e "${RESET}${APP}${BOLD}"
						echo -e "$LINES"
						echo -e "${RESET}"
						exit
					fi
				elif [[ "$prompt" == '' ]]; then
					echo -e "${RESET}${CANCEL}${BOLD}"
					echo -e "$CANCELED"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				else
					echo -e "${RESET}${ERROR}"
					echo -e "Error. ($prompt) $NOFAIL"
					echo -e "${RESET}${APP}${BOLD}"
					echo -e "$LINES"
					echo -e "${RESET}"
					exit
				fi
			elif [[ "$prompt" == '' ]]; then
				echo -e "${RESET}${CANCEL}${BOLD}"
				echo -e "$CANCELED"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit
			else
				echo -e "${RESET}${ERROR}"
				echo -e "Error. ($prompt) $NOFAIL"
				echo -e "${RESET}${APP}${BOLD}"
				echo -e "$LINES"
				echo -e "${RESET}"
				exit	
			fi
		elif [[ "$prompt" == '' ]]; then
			echo -e "${RESET}${CANCEL}${BOLD}"
			echo -e "$CANCELED"
			echo -e "${RESET}${APP}${BOLD}"
			echo -e "$LINES"
			echo -e "${RESET}"
			exit
		else
			echo -e "${RESET}${ERROR}"
			echo -e "Error. ($prompt) $NOFAIL"
			echo -e "${RESET}${APP}${BOLD}"
			echo -e "$LINES"
			echo -e "${RESET}"
			exit
		fi
	elif [[ "$prompt" == '5' ]]; then
		clear
		echo -e "${APP}${BOLD}                               macOS Creator V3.0"
		echo -e "$LINES"
		echo -e "${RESET}${BODY}1) Make sure Terminal has access to your external drive (Security and Privacy)"
		echo -e "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map)"
		echo -e "3) Try using a different drive"
		echo -e "4) Try redownloading the macOS Installer"
		echo -e "5) Make sure your macOS Installer is inside of your Applications folder."
		echo -e "6) Make sure your macOS Installer has not been modified. (i.e. name changed)"
		echo -e "7) Restart your Mac${RESET}"
		echo -e ""
		echo -e "${TITLE}${BOLD}Once you have found a solution, run this script again...${RESET}"
		echo -e "${RESET}${APP}${BOLD}"
		echo -e "$LINES"
		echo -e "${RESET}"
		exit
	elif [[ "$prompt" == '' ]]; then
		echo -e "${RESET}${CANCEL}${BOLD}"
		echo -e "$CANCELED"
		echo -e "${RESET}${APP}${BOLD}"
		echo -e "$LINES"
		echo -e "${RESET}"
		exit
	else
		echo -e "${RESET}${ERROR}"
		echo -e "Error. ($prompt) $NOFAIL"
		echo -e "${RESET}${APP}${BOLD}"
		echo -e "$LINES"
		echo -e "${RESET}"
		exit
	fi
fi
