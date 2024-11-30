#!/bin/bash

#Welcome to the macOS Creator Script
#This is where the script code is located
#Caution: Modifying the script may cause it to break!

#Version 2.1
#Release notes:
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

os_version=$(sw_vers -productVersion)

clear
echo "                               macOS Creator V2.1"
echo "********************************************************************************"
echo "Welcome to the macOS Creator by Encore Platforms"
echo "This script will make a bootable USB drive for macOS"
echo "To cancel at any point, press the return key"
echo ""
echo ""
echo "Please choose your option..."
echo "Create a bootable installer from your Applications folder................(1)"
echo "Provide a path to create the bootable installer (BETA)...................(2)"
echo "Download macOS...........................................................(3)"
echo "Review troubleshooting options...........................................(4)"
echo ""
read -p "Enter your option here... " prompt
if [[ $prompt == '1' ]]; then
	echo ""
	echo "Checking for valid macOS Installers..."
	if [  -d /Applications/Install\ OS\ X\ Mavericks.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "OS X Mavericks was detected"
		echo "Do you wish to use this macOS Installer? (Y=Yes, return=No)"
		echo ""
		read -p "Enter your option here... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "You must provide a drive to create the installer"
			echo "Drag the drive from the Finder into this window"
			echo "WARNING: All data on the drive will be erased!"
			echo ""
			read -p "Enter the drive path here (" prompt
			if [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ OS\ X\ Mavericks.app/Contents/Resources/createinstallmedia --volume "$prompt" --applicationpath /Applications/Install\ OS\ X\ Mavericks.app --nointeraction
				echo ""
				if [ -d /Volumes/Install\ OS\ X\ Mavericks/Install\ OS\ X\ Mavericks.app ]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
						clear
						echo "                               macOS Creator V2.1"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. ($prompt) is not a valid command, please run this script again..."
						echo ""
						exit

					fi
				fi
			fi
				
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation canceled"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ OS\ X\ Yosemite.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "OS X Yosemite was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "You must provide a drive to create the installer"
			echo "Drag the drive from the Finder into this window"
			echo "WARNING: All data on the drive will be erased!"
			echo ""
			read -p "Enter the drive path here (" prompt
			if [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ OS\ X\ Yosemite.app/Contents/Resources/createinstallmedia --volume "$prompt" --applicationpath /Applications/Install\ OS\ X\ Yosemite.app --nointeraction
				echo ""
				if [ -d /Volumes/Install\ OS\ X\ Yosemite/Install\ OS\ X\ Yosemite.app ]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
						clear
						echo "                               macOS Creator V2.1"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. ($prompt) is not a valid command, please run this script again..."
						echo ""
						exit

					fi
				fi
			fi
				
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation canceled"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ OS\ X\ El\ Capitan.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "OS X El Capitan was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "You must provide a drive to create the installer"
			echo "Drag the drive from the Finder into this window"
			echo "WARNING: All data on the drive will be erased!"
			echo ""
			read -p "Enter the drive path here (" prompt
			if [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume "$prompt" --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app --nointeraction
				echo ""
				if [ -d /Volumes/Install\ OS\ X\ El\ Capitan/Install\ OS\ X\ El\ Capitan.app ]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
						clear
						echo "                               macOS Creator V2.1"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. ($prompt) is not a valid command, please run this script again..."
						echo ""
						exit

					fi
				fi
			fi
				
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation canceled"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Sierra.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "macOS Sierra was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "You must provide a drive to create the installer"
			echo "Drag the drive from the Finder into this window"
			echo "WARNING: All data on the drive will be erased!"
			echo ""
			read -p "Enter the drive path here (" prompt
			if [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia --volume "$prompt" --applicationpath /Applications/Install\ OS\ X\ Sierra.app --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Sierra/Install\ macOS\ Sierra.app ]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
						clear
						echo "                               macOS Creator V2.1"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. ($prompt) is not a valid command, please run this script again..."
						echo ""
						exit

					fi
				fi
			fi
				
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation canceled"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ High\ Sierra.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "macOS High Sierra was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "You must provide a drive to create the installer"
			echo "Drag the drive from the Finder into this window"
			echo "WARNING: All data on the drive will be erased!"
			echo ""
			read -p "Enter the drive path here (" prompt
			if [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ High\ Sierra/Install\ macOS\ High\ Sierra.app ]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
						clear
						echo "                               macOS Creator V2.1"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. ($prompt) is not a valid command, please run this script again..."
						echo ""
						exit

					fi
				fi
			fi
				
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation canceled"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Mojave.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "macOS Mojave was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "You must provide a drive to create the installer"
			echo "Drag the drive from the Finder into this window"
			echo "WARNING: All data on the drive will be erased!"
			echo ""
			read -p "Enter the drive path here (" prompt
			if [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Mojave/Install\ macOS\ Mojave.app ]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
						clear
						echo "                               macOS Creator V2.1"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. ($prompt) is not a valid command, please run this script again..."
						echo ""
						exit

					fi
				fi
			fi
				
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation canceled"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Catalina.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "macOS Catalina was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "You must provide a drive to create the installer"
			echo "Drag the drive from the Finder into this window"
			echo "WARNING: All data on the drive will be erased!"
			echo ""
			read -p "Enter the drive path here (" prompt
			if [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Catalina/Install\ macOS\ Catalina.app ]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
						clear
						echo "                               macOS Creator V2.1"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. ($prompt) is not a valid command, please run this script again..."
						echo ""
						exit

					fi
				fi
			fi
				
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation canceled"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Big\ Sur.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "macOS Big Sur was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "You must provide a drive to create the installer"
			echo "Drag the drive from the Finder into this window"
			echo "WARNING: All data on the drive will be erased!"
			echo ""
			read -p "Enter the drive path here (" prompt
			if [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Big\ Sur/Install\ macOS\ Big\ Sur.app ]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
						clear
						echo "                               macOS Creator V2.1"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. ($prompt) is not a valid command, please run this script again..."
						echo ""
						exit

					fi
				fi
			fi
				
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation canceled"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Monterey.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "macOS Monterey was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "You must provide a drive to create the installer"
			echo "Drag the drive from the Finder into this window"
			echo "WARNING: All data on the drive will be erased!"
			echo ""
			read -p "Enter the drive path here (" prompt
			if [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Monterey.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Monterey/Install\ macOS\ Monterey.app ]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
						clear
						echo "                               macOS Creator V2.1"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. ($prompt) is not a valid command, please run this script again..."
						echo ""
						exit

					fi
				fi
			fi
				
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation canceled"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Ventura.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "macOS Ventura was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "You must provide a drive to create the installer"
			echo "Drag the drive from the Finder into this window"
			echo "WARNING: All data on the drive will be erased!"
			echo ""
			read -p "Enter the drive path here (" prompt
			if [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Ventura.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Ventura/Install\ macOS\ Ventura.app ]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
						clear
						echo "                               macOS Creator V2.1"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. ($prompt) is not a valid command, please run this script again..."
						echo ""
						exit

					fi
				fi
			fi
				
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation canceled"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Sonoma.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "macOS Sonoma was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
		if [[ "$(printf "$os_version")" == '10.12.6' || "$(printf "$os_version")" == '10.12.5' || "$(printf "$os_version")" == '10.12.4' || "$(printf "$os_version")" == '10.12.3' || "$(printf "$os_version")" == '10.12.2' || "$(printf "$os_version")" == '10.12.1' || "$(printf "$os_version")" == '10.12'  ]]; then
		clear
		echo ""
		echo "You are running on macOS Sierra."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.11.6' || "$(printf "$os_version")" == '10.11.5' || "$(printf "$os_version")" == '10.11.4' || "$(printf "$os_version")" == '10.11.3' || "$(printf "$os_version")" == '10.11.2' || "$(printf "$os_version")" == '10.11.1' || "$(printf "$os_version")" == '10.11'  ]]; then
		clear
		echo ""
		echo "You are running on OS X El Capitan."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.10.7' || "$(printf "$os_version")" == '10.10.6' || "$(printf "$os_version")" == '10.10.5' || "$(printf "$os_version")" == '10.10.4' || "$(printf "$os_version")" == '10.10.3' || "$(printf "$os_version")" == '10.10.2' || "$(printf "$os_version")" == '10.10.1' || "$(printf "$os_version")" == '10.10'  ]]; then
		clear
		echo ""
		echo "You are running on OS X Yosemite."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.9.7' || "$(printf "$os_version")" == '10.9.6' || "$(printf "$os_version")" == '10.9.5' || "$(printf "$os_version")" == '10.9.4' || "$(printf "$os_version")" == '10.9.3' || "$(printf "$os_version")" == '10.9.2' || "$(printf "$os_version")" == '10.9.1' || "$(printf "$os_version")" == '10.9'  ]]; then
		clear
		echo ""
		echo "You are running on OS X Mavericks."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.8.7' || "$(printf "$os_version")" == '10.8.6' || "$(printf "$os_version")" == '10.8.5' || "$(printf "$os_version")" == '10.8.4' || "$(printf "$os_version")" == '10.8.3' || "$(printf "$os_version")" == '10.8.2' || "$(printf "$os_version")" == '10.8.1' || "$(printf "$os_version")" == '10.8'  ]]; then
		clear
		echo ""
		echo "You are running on OS X Mountain Lion."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.7.7' || "$(printf "$os_version")" == '10.7.6' || "$(printf "$os_version")" == '10.7.5' || "$(printf "$os_version")" == '10.7.4' || "$(printf "$os_version")" == '10.7.3' || "$(printf "$os_version")" == '10.7.2' || "$(printf "$os_version")" == '10.7.1' || "$(printf "$os_version")" == '10.7'  ]]; then
		clear
		echo ""
		echo "You are running on OS X Lion."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.6.7' || "$(printf "$os_version")" == '10.6.6' || "$(printf "$os_version")" == '10.6.5' || "$(printf "$os_version")" == '10.6.4' || "$(printf "$os_version")" == '10.6.3' || "$(printf "$os_version")" == '10.6.2' || "$(printf "$os_version")" == '10.6.1' || "$(printf "$os_version")" == '10.6'  ]]; then
		clear
		echo ""
		echo "You are running on OS X Snow Leopard."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.5.7' || "$(printf "$os_version")" == '10.5.6' || "$(printf "$os_version")" == '10.5.5' || "$(printf "$os_version")" == '10.5.4' || "$(printf "$os_version")" == '10.5.3' || "$(printf "$os_version")" == '10.5.2' || "$(printf "$os_version")" == '10.5.1' || "$(printf "$os_version")" == '10.5'  ]]; then
		clear
		echo ""
		echo "You are running on OS X Leopard."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		else
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "You must provide a drive to create the installer"
			echo "Drag the drive from the Finder into this window"
			echo "WARNING: All data on the drive will be erased!"
			echo ""
			read -p "Enter the drive path here (" prompt
			if [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Sonoma.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Sonoma/Install\ macOS\ Sonoma.app ]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
						clear
						echo "                               macOS Creator V2.1"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. ($prompt) is not a valid command, please run this script again..."
						echo ""
						exit

					fi
				fi
			fi
		fi
				
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation canceled"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Sequoia.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "macOS Sequoia was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
		if [[ "$(printf "$os_version")" == '10.12.6' || "$(printf "$os_version")" == '10.12.5' || "$(printf "$os_version")" == '10.12.4' || "$(printf "$os_version")" == '10.12.3' || "$(printf "$os_version")" == '10.12.2' || "$(printf "$os_version")" == '10.12.1' || "$(printf "$os_version")" == '10.12'  ]]; then
		clear
		echo ""
		echo "You are running on macOS Sierra."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.11.6' || "$(printf "$os_version")" == '10.11.5' || "$(printf "$os_version")" == '10.11.4' || "$(printf "$os_version")" == '10.11.3' || "$(printf "$os_version")" == '10.11.2' || "$(printf "$os_version")" == '10.11.1' || "$(printf "$os_version")" == '10.11'  ]]; then
		clear
		echo ""
		echo "You are running on OS X El Capitan."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.10.7' || "$(printf "$os_version")" == '10.10.6' || "$(printf "$os_version")" == '10.10.5' || "$(printf "$os_version")" == '10.10.4' || "$(printf "$os_version")" == '10.10.3' || "$(printf "$os_version")" == '10.10.2' || "$(printf "$os_version")" == '10.10.1' || "$(printf "$os_version")" == '10.10'  ]]; then
		clear
		echo ""
		echo "You are running on OS X Yosemite."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.9.7' || "$(printf "$os_version")" == '10.9.6' || "$(printf "$os_version")" == '10.9.5' || "$(printf "$os_version")" == '10.9.4' || "$(printf "$os_version")" == '10.9.3' || "$(printf "$os_version")" == '10.9.2' || "$(printf "$os_version")" == '10.9.1' || "$(printf "$os_version")" == '10.9'  ]]; then
		clear
		echo ""
		echo "You are running on OS X Mavericks."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.8.7' || "$(printf "$os_version")" == '10.8.6' || "$(printf "$os_version")" == '10.8.5' || "$(printf "$os_version")" == '10.8.4' || "$(printf "$os_version")" == '10.8.3' || "$(printf "$os_version")" == '10.8.2' || "$(printf "$os_version")" == '10.8.1' || "$(printf "$os_version")" == '10.8'  ]]; then
		clear
		echo ""
		echo "You are running on OS X Mountain Lion."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.7.7' || "$(printf "$os_version")" == '10.7.6' || "$(printf "$os_version")" == '10.7.5' || "$(printf "$os_version")" == '10.7.4' || "$(printf "$os_version")" == '10.7.3' || "$(printf "$os_version")" == '10.7.2' || "$(printf "$os_version")" == '10.7.1' || "$(printf "$os_version")" == '10.7'  ]]; then
		clear
		echo ""
		echo "You are running on OS X Lion."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.6.7' || "$(printf "$os_version")" == '10.6.6' || "$(printf "$os_version")" == '10.6.5' || "$(printf "$os_version")" == '10.6.4' || "$(printf "$os_version")" == '10.6.3' || "$(printf "$os_version")" == '10.6.2' || "$(printf "$os_version")" == '10.6.1' || "$(printf "$os_version")" == '10.6'  ]]; then
		clear
		echo ""
		echo "You are running on OS X Snow Leopard."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		elif [[ "$(printf "$os_version")" == '10.5.7' || "$(printf "$os_version")" == '10.5.6' || "$(printf "$os_version")" == '10.5.5' || "$(printf "$os_version")" == '10.5.4' || "$(printf "$os_version")" == '10.5.3' || "$(printf "$os_version")" == '10.5.2' || "$(printf "$os_version")" == '10.5.1' || "$(printf "$os_version")" == '10.5'  ]]; then
		clear
		echo ""
		echo "You are running on OS X Leopard."
		echo "macOS Sonoma can only be installed using macOS High Sierra or newer."
		echo ""
		exit

		else
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "You must provide a drive to create the installer"
			echo "Drag the drive from the Finder into this window"
			echo "WARNING: All data on the drive will be erased!"
			echo ""
			read -p "Enter the drive path here (" prompt
			if [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Sequoia.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Sequoia/Install\ macOS\ Sequoia.app ]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
						clear
						echo "                               macOS Creator V2.1"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map)"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. ($prompt) is not a valid command, please run this script again..."
						echo ""
						exit

					fi
				fi
			fi
		fi
				
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation canceled"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ OS\ X\ Mountain\ Lion.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "OS X Mountain Lion detected"
		echo "OS X Mountain Lion is not compatible with this script."
		echo ""
		exit

	elif [ -d /Applications/Install\ Mac\ OS\ X\ Lion.app ]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "Mac OS X Lion detected"
		echo "Mac OS X Lion is not compatible with this script."
		echo ""
		exit

	else
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "No versions of macOS detected..."
		echo ""
		echo ""
		echo "What would you like to do?"
		echo ""
		echo "Review troubleshooting solutions....(1)"
		echo "Download macOS Installer............(2)"
		echo "Provide the installer path (BETA)...(3)"
		echo "Cancel..............................(return)"
		echo ""
		read -p "Enter your option here... " prompt
		if [[ $prompt == '1' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "Here are some troubleshoting steps:"
			echo ""
			echo "1) Make sure your macOS Installer is inside of your Applications folder."
			echo "2) Make sure your macOS Installer has not been modified. (i.e. name changed)"
			echo "3) Make sure Terminal can access your Applications folder (Security and Privacy)"
			echo "4) Redownload the macOS Installer"
			echo ""
			echo "Once you have found a solution, run this script again..."
			echo ""
			exit

		elif [[ $prompt == '2' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "Choose the macOS Version you wish to download:"
			echo "(To cancel, press the return key)"
			echo ""
			echo "OS X Yosemite......(1)"
			echo "OS X El Capitan....(2)"
			echo "macOS Sierra.......(3)"
			echo "macOS High Sierra..(4)"
			echo "macOS Mojave.......(5)"
			echo "macOS Catalina.....(6)"
			echo "macOS Big Sur......(7)"
			echo "macOS Monterey.....(8)"
			echo "Next page..........(9)"
			echo ""
			read -p "Enter your option here... " prompt
			if [[ $prompt == '1' ]]; then
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Downloading OS X Yosemite..."
				sudo curl http://updates-http.cdn-apple.com/2019/cert/061-41343-20191023-02465f92-3ab5-4c92-bfe2-b725447a070d/InstallMacOSX.dmg -o /private/tmp/InstallmacOS.dmg
				if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
					sudo open /private/tmp/InstallmacOS.dmg
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit
				else
					echo ""
					echo "Download failed"
					echo ""
					exit
				fi

			elif [[ $prompt == '2' ]]; then
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Downloading OS X El Capitan..."
				sudo curl http://updates-http.cdn-apple.com/2019/cert/061-41424-20191024-218af9ec-cf50-4516-9011-228c78eda3d2/InstallMacOSX.dmg -o /private/tmp/InstallmacOS.dmg
				if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
					sudo open /private/tmp/InstallmacOS.dmg
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit
				else
					echo ""
					echo "Download failed"
					echo ""
					exit
				fi

			elif [[ $prompt == '3' ]]; then
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Downloading macOS Sierra..."
				sudo curl http://updates-http.cdn-apple.com/2019/cert/061-39476-20191023-48f365f4-0015-4c41-9f44-39d3d2aca067/InstallOS.dmg -o /private/tmp/InstallmacOS.dmg
				if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
					sudo open /private/tmp/InstallmacOS.dmg
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit
				else
					echo ""
					echo "Download failed"
					echo ""
					exit
				fi

			elif [[ $prompt == '4' ]]; then
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Downloading macOS High Sierra..."
				sudo curl https://archive.org/download/mac-os-high-sierra-10.13.5/macOS%20High%20Sierra%2010.13.5.iso -o /private/tmp/InstallmacOS.iso
				if [[ -e /private/tmp/InstallmacOS.iso ]]; then
					sudo open /private/tmp/InstallmacOS.iso
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit
				else
					echo ""
					echo "Download failed"
					echo ""
					exit
				fi

			elif [[ $prompt == '5' ]]; then
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Downloading macOS Mojave..."
				sudo curl https://archive.org/download/mac-os-mojave-10.14/macOS%20Mojave%2010.14.iso -o /private/tmp/InstallmacOS.iso
				if [[ -e /private/tmp/InstallmacOS.iso ]]; then
					sudo open /private/tmp/InstallmacOS.iso
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit
				else
					echo ""
					echo "Download failed"
					echo ""
					exit
				fi

			elif [[ $prompt == '6' ]]; then
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Downloading macOS Catalina..."
				sudo curl https://archive.org/download/macOS-Catalina-IOS/macOSCatalina.iso -o /private/tmp/InstallmacOS.iso
				if [[ -e /private/tmp/InstallmacOS.iso ]]; then
					sudo open /private/tmp/InstallmacOS.iso
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit
				else
					echo ""
					echo "Download failed"
					echo ""
					exit
				fi

			elif [[ $prompt == '7' ]]; then
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Downloading macOS Big Sur..."
				sudo curl https://swcdn.apple.com/content/downloads/14/38/042-45246-A_NLFOFLCJFZ/jk992zbv98sdzz3rgc7mrccjl3l22ruk1c/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
				if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
					sudo open /private/tmp/InstallAssistant.pkg
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit
				else
					echo ""
					echo "Download failed"
					echo ""
					exit
				fi

			elif [[ $prompt == '8' ]]; then
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Downloading macOS Monterey..."
				sudo curl https://swcdn.apple.com/content/downloads/46/57/052-60131-A_KM2RH04C2D/9yzvba1uvpem2wuo95r459qno57qaizwf2/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
				if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
					sudo open /private/tmp/InstallAssistant.pkg
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit
				else
					echo ""
					echo "Download failed"
					echo ""
					exit
				fi
									
			elif [[ $prompt == '9' ]]; then
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Choose the macOS Version you wish to download:"
				echo "(To cancel, press the return key)"
				echo ""
				echo "macOS Ventura......(1)"
				echo "macOS Sonoma.......(2)"
				echo "macOS Sequoia......(3)"
				echo "Cancel.............(return)"
				echo ""
				read -p "Enter your option here... " prompt
				if [[ $prompt == '1' ]]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "Downloading macOS Ventura..."
					sudo curl https://swcdn.apple.com/content/downloads/29/47/072-09024-A_8G5EY3SPX2/l6ecgngkrhhbc6q4mae5cwe42pxp49co7w/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
					if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
						sudo open /private/tmp/InstallAssistant.pkg
						echo "Follow the on-screen instructions to install..."
						echo "Once completed, please run this script again..."
						echo ""
						exit
					else
						echo ""
						echo "Download failed"
						echo ""
						exit
					fi

				elif [[ $prompt == '2' ]]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "Downloading macOS Sonoma..."
					sudo curl https://swcdn.apple.com/content/downloads/16/03/072-24524-A_BOQKY5YAFR/x086vnjdghnpudh3dv11jbce398n0alxtl/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
					if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
						sudo open /private/tmp/InstallAssistant.pkg
						echo "Follow the on-screen instructions to install..."
						echo "Once completed, please run this script again..."
						echo ""
						exit
					else
						echo ""
						echo "Download failed"
						echo ""
						exit
					fi

				elif [[ $prompt == '3' ]]; then
					clear
					echo "                               macOS Creator V2.1"
					echo "********************************************************************************"
					echo "Downloading macOS Sequoia..."
					sudo curl https://swcdn.apple.com/content/downloads/08/08/072-12353-A_IUBHH68MQT/sv48ma68gmhl96fa9anqfj3i2fnb1ur2wh/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
					if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
						sudo open /private/tmp/InstallAssistant.pkg
						echo "Follow the on-screen instructions to install..."
						echo "Once completed, please run this script again..."
						echo ""
						exit
					else
						echo ""
						echo "Download failed"
						echo ""
						exit
					fi

				elif [[ $prompt == '' ]]; then
					clear
					echo ""
					echo "When ready, please run this script again."
					echo ""
					exit

				else
					clear
					echo ""
					echo "Error. ($prompt) is not a valid command, please run this script again..."
					echo ""
					exit

				fi

			elif [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "When ready, please run this script again"
				echo ""
				exit

			else
				clear
				echo ""
				echo "Error. ($prompt) is not a valid command, please run this script again..."
				echo ""
				exit
			fi
				
		elif [[ $prompt == '3' ]]; then
	clear
	echo "                               macOS Creator V2.1"
	echo "********************************************************************************"
	echo "WARNING: THIS IS A BETA BUILD!"
	echo "BETA builds may not work as expected!"
	echo "This tool is still being tested for issues."
	echo "You may still use this tool, but it may not create the drive as expected to."
	echo "Press the return key now in order to cancel."
	echo "Type (Y) only if you are willing to continue..."
	echo ""
	read -p "Enter your option here... " prompt
	if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
		clear
		echo "                             macOS Creator V2.1 BETA"
		echo "********************************************************************************"
		echo "Please insert your USB Drive into the Mac now, format it with the name Untitled"
		read -p "Type (Y) once formatted... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			if [[ -d /Volumes/Untitled ]]; then
				clear
				echo "                             macOS Creator V2.1 BETA"
					echo "********************************************************************************"
				echo "Which version will you be using?"
				echo "macOS Sierra or older..................(1)"
				echo "macOS High Sierra or newer.............(2)"
				echo "Unsure.................................(3)"
				echo ""
				read -p "Enter your option here... " prompt
				if [[ $prompt == '1' ]]; then
					clear
					echo "                             macOS Creator V2.1 BETA"
					echo "********************************************************************************"
					echo "Please provide the drive path..."
					echo "In order to do this, drag the Installer from the Finder into this window"
					echo ""
					read -p "Installer path(" prompt
					if [[ $prompt == '' ]]; then
						echo ""
						echo "Error, no path provided..."
						echo ""
						exit
					else
						clear
						echo "                             macOS Creator V2.1 BETA"
						echo "********************************************************************************"
						echo "Creating the drive..."
						sudo "$prompt"/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath "$prompt" --nointeraction
						exit
					fi
				elif [[ $prompt == '2' ]]; then
					clear
					echo "                             macOS Creator V2.1 BETA"
					echo "********************************************************************************"
					echo "Please provide the drive path..."
					echo "In order to do this, drag the Installer from the Finder into this window"
					echo ""
					read -p "Installer path(" prompt
					if [[ $prompt == '' ]]; then
						echo ""
						echo "Error, no path provided..."
						echo ""
						exit
					else
						clear
						echo "                             macOS Creator V2.1 BETA"
						echo "********************************************************************************"
						echo "Creating the drive..."
						sudo "$prompt"/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						exit
					fi
				elif [[ $prompt == '3' ]]; then
					clear
					echo "                             macOS Creator V2.1 BETA"
					echo "********************************************************************************"
					echo "Order of macOS Versions..."
					echo ""
					echo "OS X Mavericks..........(10.9)"
					echo "OS X Yosemite...........(10.10)"
					echo "OS X El Capitan.........(10.11)"
					echo "macOS Sierra............(10.12)"
					echo ""
					echo "macOS High Sierra.......(10.13)"
					echo "macOS Mojave............(10.14)"
					echo "macOS Catalina..........(10.15)"
					echo "macOS Big Sur...........(11.0)"
					echo "macOS Monterey..........(12.0)"
					echo "macOS Ventura...........(13.0)"
					echo "macOS Sonoma............(14.0)"
					echo "macOS Sequoia...........(15.0)"
					echo ""
					echo "Locate the version of macOS you are trying to install."
					echo "Once located, run this script again."
					echo ""
					exit

				elif [[ $prompt == '' ]]; then
					clear
					echo ""
					echo "Operation Canceled."
					echo ""
					exit
				else
					clear
					echo ""
					echo "Error. ($prompt) is not a valid command, please run this script again..."
					echo ""
					exit
				fi
			else
				clear
				echo ""
				echo "The drive was not detected."
				echo "Make sure it is connected and formatted with the name Untitled"
				echo ""
				exit
			fi
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation Canceled."
			echo ""
			exit
		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi
	elif [[ $prompt == '' ]]; then
		clear
		echo ""
		echo "Operation Canceled."
		echo ""
		exit
	else
		clear
		echo ""
		echo "Error. ($prompt) is not a valid command, please run this script again..."
		echo ""
		exit
	fi
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "When ready, please run this script again."
			echo ""
			exit
						
		else 
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..." 
			echo ""
			exit
		fi
	fi

elif [[ $prompt == '2' ]]; then
	clear
	echo "                               macOS Creator V2.1"
	echo "********************************************************************************"
	echo "WARNING: THIS IS A BETA BUILD!"
	echo "BETA builds may not work as expected!"
	echo "This tool is still being tested for issues."
	echo "You may still use this tool, but it may not create the drive as expected to."
	echo "Press the return key now in order to cancel."
	echo "Type (Y) only if you are willing to continue..."
	echo ""
	read -p "Enter your option here... " prompt
	if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
		clear
		echo "                             macOS Creator V2.1 BETA"
		echo "********************************************************************************"
		echo "Please insert your USB Drive into the Mac now, format it with the name Untitled"
		read -p "Type (Y) once formatted... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			if [[ -d /Volumes/Untitled ]]; then
				clear
				echo "                             macOS Creator V2.1 BETA"
					echo "********************************************************************************"
				echo "Which version will you be using?"
				echo "macOS Sierra or older..................(1)"
				echo "macOS High Sierra or newer.............(2)"
				echo "Unsure.................................(3)"
				echo ""
				read -p "Enter your option here... " prompt
				if [[ $prompt == '1' ]]; then
					clear
					echo "                             macOS Creator V2.1 BETA"
					echo "********************************************************************************"
					echo "Please provide the drive path..."
					echo "In order to do this, drag the Installer from the Finder into this window"
					echo ""
					read -p "Installer path(" prompt
					if [[ $prompt == '' ]]; then
						echo ""
						echo "Error, no path provided..."
						echo ""
						exit
					else
						clear
						echo "                             macOS Creator V2.1 BETA"
						echo "********************************************************************************"
						echo "Creating the drive..."
						sudo "$prompt"/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath "$prompt" --nointeraction
						exit
					fi
				elif [[ $prompt == '2' ]]; then
					clear
					echo "                             macOS Creator V2.1 BETA"
					echo "********************************************************************************"
					echo "Please provide the drive path..."
					echo "In order to do this, drag the Installer from the Finder into this window"
					echo ""
					read -p "Installer path(" prompt
					if [[ $prompt == '' ]]; then
						echo ""
						echo "Error, no path provided..."
						echo ""
						exit
					else
						clear
						echo "                             macOS Creator V2.1 BETA"
						echo "********************************************************************************"
						echo "Creating the drive..."
						sudo "$prompt"/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						exit
					fi
				elif [[ $prompt == '3' ]]; then
					clear
					echo "                             macOS Creator V2.1 BETA"
					echo "********************************************************************************"
					echo "Order of macOS Versions..."
					echo ""
					echo "OS X Mavericks..........(10.9)"
					echo "OS X Yosemite...........(10.10)"
					echo "OS X El Capitan.........(10.11)"
					echo "macOS Sierra............(10.12)"
					echo ""
					echo "macOS High Sierra.......(10.13)"
					echo "macOS Mojave............(10.14)"
					echo "macOS Catalina..........(10.15)"
					echo "macOS Big Sur...........(11.0)"
					echo "macOS Monterey..........(12.0)"
					echo "macOS Ventura...........(13.0)"
					echo "macOS Sonoma............(14.0)"
					echo "macOS Sequoia...........(15.0)"
					echo ""
					echo "Locate the version of macOS you are trying to install."
					echo "Once located, run this script again."
					echo ""
					exit

				elif [[ $prompt == '' ]]; then
					clear
					echo ""
					echo "Operation Canceled."
					echo ""
					exit
				else
					clear
					echo ""
					echo "Error. ($prompt) is not a valid command, please run this script again..."
					echo ""
					exit
				fi
			else
				clear
				echo ""
				echo "The drive was not detected."
				echo "Make sure it is connected and formatted with the name Untitled"
				echo ""
				exit
			fi
		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "Operation Canceled."
			echo ""
			exit
		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi
	elif [[ $prompt == '' ]]; then
		clear
		echo ""
		echo "Operation Canceled."
		echo ""
		exit
	else
		clear
		echo ""
		echo "Error. ($prompt) is not a valid command, please run this script again..."
		echo ""
		exit
	fi

elif [[ $prompt == '3' ]]; then
		clear
		echo "                               macOS Creator V2.1"
		echo "********************************************************************************"
		echo "Choose the macOS Version you wish to download:"
		echo "(To cancel, press the return key)"
		echo ""
		echo "OS X Yosemite......(1)"
		echo "OS X El Capitan....(2)"
		echo "macOS Sierra.......(3)"
		echo "macOS High Sierra..(4)"
		echo "macOS Mojave.......(5)"
		echo "macOS Catalina.....(6)"
		echo "macOS Big Sur......(7)"
		echo "macOS Monterey.....(8)"
		echo "Next page..........(9)"
		echo ""
		read -p "Enter your option here... " prompt
		if [[ $prompt == '1' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "Downloading OS X Yosemite..."
			sudo curl http://updates-http.cdn-apple.com/2019/cert/061-41343-20191023-02465f92-3ab5-4c92-bfe2-b725447a070d/InstallMacOSX.dmg -o /private/tmp/InstallmacOS.dmg
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				sudo open /private/tmp/InstallmacOS.dmg
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit
			else
				echo ""
				echo "Download failed"
				echo ""
				exit
			fi

		elif [[ $prompt == '2' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "Downloading OS X El Capitan..."
			sudo curl http://updates-http.cdn-apple.com/2019/cert/061-41424-20191024-218af9ec-cf50-4516-9011-228c78eda3d2/InstallMacOSX.dmg -o /private/tmp/InstallmacOS.dmg
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				sudo open /private/tmp/InstallmacOS.dmg
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit
			else
				echo ""
				echo "Download failed"
				echo ""
				exit
			fi

		elif [[ $prompt == '3' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "Downloading macOS Sierra..."
			sudo curl http://updates-http.cdn-apple.com/2019/cert/061-39476-20191023-48f365f4-0015-4c41-9f44-39d3d2aca067/InstallOS.dmg -o /private/tmp/InstallmacOS.dmg
			if [[ -e /private/tmp/InstallmacOS.dmg ]]; then
				sudo open /private/tmp/InstallmacOS.dmg
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit
			else
				echo ""
				echo "Download failed"
				echo ""
				exit
			fi

		elif [[ $prompt == '4' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "Downloading macOS High Sierra..."
			sudo curl https://archive.org/download/mac-os-high-sierra-10.13.5/macOS%20High%20Sierra%2010.13.5.iso -o /private/tmp/InstallmacOS.iso
			if [[ -e /private/tmp/InstallmacOS.iso ]]; then
				sudo open /private/tmp/InstallmacOS.iso
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit
			else
				echo ""
				echo "Download failed"
				echo ""
				exit
			fi

		elif [[ $prompt == '5' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "Downloading macOS Mojave..."
			sudo curl https://archive.org/download/mac-os-mojave-10.14/macOS%20Mojave%2010.14.iso -o /private/tmp/InstallmacOS.iso
			if [[ -e /private/tmp/InstallmacOS.iso ]]; then
				sudo open /private/tmp/InstallmacOS.iso
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit
			else
				echo ""
				echo "Download failed"
				echo ""
				exit
			fi

		elif [[ $prompt == '6' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "Downloading macOS Catalina..."
			sudo curl https://archive.org/download/macOS-Catalina-IOS/macOSCatalina.iso -o /private/tmp/InstallmacOS.iso
			if [[ -e /private/tmp/InstallmacOS.iso ]]; then
				sudo open /private/tmp/InstallmacOS.iso
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit
			else
				echo ""
				echo "Download failed"
				echo ""
				exit
			fi

		elif [[ $prompt == '7' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "Downloading macOS Big Sur..."
			sudo curl https://swcdn.apple.com/content/downloads/14/38/042-45246-A_NLFOFLCJFZ/jk992zbv98sdzz3rgc7mrccjl3l22ruk1c/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				sudo open /private/tmp/InstallAssistant.pkg
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit
			else
				echo ""
				echo "Download failed"
				echo ""
				exit
			fi

		elif [[ $prompt == '8' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "Downloading macOS Monterey..."
			sudo curl https://swcdn.apple.com/content/downloads/46/57/052-60131-A_KM2RH04C2D/9yzvba1uvpem2wuo95r459qno57qaizwf2/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
			if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
				sudo open /private/tmp/InstallAssistant.pkg
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit
			else
				echo ""
				echo "Download failed"
				echo ""
				exit
			fi
									
		elif [[ $prompt == '9' ]]; then
			clear
			echo "                               macOS Creator V2.1"
			echo "********************************************************************************"
			echo "Choose the macOS Version you wish to download:"
			echo "(To cancel, press the return key)"
			echo ""
			echo "macOS Ventura......(1)"
			echo "macOS Sonoma.......(2)"
			echo "macOS Sequoia......(3)"
			echo "Cancel.............(return)"
			echo ""
			read -p "Enter your option here... " prompt
			if [[ $prompt == '1' ]]; then
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Downloading macOS Ventura..."
				sudo curl https://swcdn.apple.com/content/downloads/29/47/072-09024-A_8G5EY3SPX2/l6ecgngkrhhbc6q4mae5cwe42pxp49co7w/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
				if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
					sudo open /private/tmp/InstallAssistant.pkg
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit
				else
					echo ""
					echo "Download failed"
					echo ""
					exit
				fi

			elif [[ $prompt == '2' ]]; then
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Downloading macOS Sonoma..."
				sudo curl https://swcdn.apple.com/content/downloads/16/03/072-24524-A_BOQKY5YAFR/x086vnjdghnpudh3dv11jbce398n0alxtl/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
				if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
					sudo open /private/tmp/InstallAssistant.pkg
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit
				else
					echo ""
					echo "Download failed"
					echo ""
					exit
				fi

			elif [[ $prompt == '3' ]]; then
				clear
				echo "                               macOS Creator V2.1"
				echo "********************************************************************************"
				echo "Downloading macOS Sequoia..."
				sudo curl https://swcdn.apple.com/content/downloads/08/08/072-12353-A_IUBHH68MQT/sv48ma68gmhl96fa9anqfj3i2fnb1ur2wh/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
				if [[ -e /private/tmp/InstallAssistant.pkg ]]; then
					sudo open /private/tmp/InstallAssistant.pkg
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit
				else
					echo ""
					echo "Download failed"
					echo ""
					exit
				fi

			elif [[ $prompt == '' ]]; then
				clear
				echo ""
				echo "When ready, please run this script again."
				echo ""
				exit

			else
				clear
				echo ""
				echo "Error. ($prompt) is not a valid command, please run this script again..."
				echo ""
				exit

			fi

		elif [[ $prompt == '' ]]; then
			clear
			echo ""
			echo "When ready, please run this script again"
			echo ""
			exit

		else
			clear
			echo ""
			echo "Error. ($prompt) is not a valid command, please run this script again..."
			echo ""
			exit
		fi

elif [[ $prompt == '4' ]]; then
	clear
	echo "                               macOS Creator V2.1"
	echo "********************************************************************************"
	echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
	echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map)"
	echo "3) Try using a different drive"
	echo "4) Try redownloading the macOS Installer"
	echo "5) Make sure your macOS Installer is inside of your Applications folder."
	echo "6) Make sure your macOS Installer has not been modified. (i.e. name changed)"
	echo "7) Restart your Mac."
	echo ""
	echo "Once you have found a solution, run this script again..."
	echo ""
	exit

elif [[ $prompt == '' ]]; then
	clear
	echo ""
	echo "Operation canceled"
	echo ""
	exit

else
	clear
	echo ""
	echo "Error. If you wish to conintue, type out the number instead of ($prompt)" 
	echo ""
	exit
fi








##############

#End of Script