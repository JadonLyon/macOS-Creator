#!/bin/bash

#Welcome to the macOS Creator Script
#This is where the script code is located
#Caution: Modifying the script may cause it to break!

#Version 2.0
#Release notes:
#              V2.0 This new updates adds exciting new features to the macOS Creator
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

clear
echo "                               macOS Creator V2.0"
echo "********************************************************************************"
echo "Encore Platforms"
echo "Welcome to the macOS Creator"
echo "This script will make a bootable USB drive for macOS"
echo ""
echo ""
echo "Please choose your option...           (Press return at any point to cancel)"
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
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "OS X Mavericks was detected"
		echo "Do you wish to use this macOS Installer?"
		echo "(Y=Yes, return=No)"
		echo ""
		read -p "Enter your option here... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
				echo "********************************************************************************"
				echo "Creating the drive..."
				sudo /Applications/Install\ OS\ X\ Mavericks.app/Contents/Resources/createinstallmedia --volume "$prompt" --applicationpath /Applications/Install\ OS\ X\ Mavericks.app --nointeraction
				echo ""
				if [ -d /Volumes/Install\ OS\ X\ Mavericks ]; then
					clear
					echo "                               macOS Creator V2.0"
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
						echo "                               macOS Creator V2.0"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ OS\ X\ Yosemite.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "OS X Yosemite was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.0"
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
				echo "Creating the drive..."
				sudo /Applications/Install\ OS\ X\ Yosemite.app/Contents/Resources/createinstallmedia --volume "$prompt" --applicationpath /Applications/Install\ OS\ X\ Yosemite.app --nointeraction
				echo ""
				if [ -d /Volumes/Install\ OS\ X\ Yosemite ]; then
					clear
					echo "                               macOS Creator V2.0"
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
						echo "                               macOS Creator V2.0"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ OS\ X\ El\ Capitan.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "OS X El Capitan was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.0"
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
				echo "Creating the drive..."
				sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume "$prompt" --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app --nointeraction
				echo ""
				if [ -d /Volumes/Install\ OS\ X\ El\ Capitan ]; then
					clear
					echo "                               macOS Creator V2.0"
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
						echo "                               macOS Creator V2.0"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Sierra.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "macOS Sierra was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.0"
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
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia --volume "$prompt" --applicationpath /Applications/Install\ OS\ X\ Sierra.app --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Sierra ]; then
					clear
					echo "                               macOS Creator V2.0"
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
						echo "                               macOS Creator V2.0"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ High\ Sierra.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "macOS High Sierra was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.0"
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
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ High\ Sierra ]; then
					clear
					echo "                               macOS Creator V2.0"
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
						echo "                               macOS Creator V2.0"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Mojave.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "macOS Mojave was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.0"
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
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Mojave ]; then
					clear
					echo "                               macOS Creator V2.0"
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
						echo "                               macOS Creator V2.0"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Catalina.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "macOS Catalina was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.0"
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
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Catalina ]; then
					clear
					echo "                               macOS Creator V2.0"
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
						echo "                               macOS Creator V2.0"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Big\ Sur.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "macOS Big Sur was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.0"
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
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Big\ Sur ]; then
					clear
					echo "                               macOS Creator V2.0"
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
						echo "                               macOS Creator V2.0"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Monterey.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "macOS Monterey was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.0"
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
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Monterey.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Monterey ]; then
					clear
					echo "                               macOS Creator V2.0"
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
						echo "                               macOS Creator V2.0"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Ventura.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "macOS Ventura was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.0"
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
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Ventura.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Ventura ]; then
					clear
					echo "                               macOS Creator V2.0"
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
						echo "                               macOS Creator V2.0"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Sonoma.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "macOS Sonoma was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.0"
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
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Sonoma.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Sonoma ]; then
					clear
					echo "                               macOS Creator V2.0"
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
						echo "                               macOS Creator V2.0"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map))"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ macOS\ Sequoia.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "macOS Sequoia was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			clear
			echo "                               macOS Creator V2.0"
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
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Sequoia.app/Contents/Resources/createinstallmedia --volume "$prompt" --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Sequoia ]; then
					clear
					echo "                               macOS Creator V2.0"
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
						echo "                               macOS Creator V2.0"
						echo "********************************************************************************"
						echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
						echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map)"
						echo "3) Try using a different drive"
						echo "4) Try redownloading the macOS Installer"
						echo "5) Restart your Mac"
						echo ""
						echo echo "Once you have found a solution, run this script again..."
						echo ""
						exit

					elif [[ $prompt == '' ]]; then
						echo ""
						exit

					else
						clear
						echo ""
						echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

	elif [ -d /Applications/Install\ OS\ X\ Mountain\ Lion.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "OS X Mountain Lion detected"
		echo "OS X Mountain Lion is not compatible with this script."
		echo ""
		exit

	elif [ -d /Applications/Install\ Mac\ OS\ X\ Lion.app ]; then
		clear
		echo "                               macOS Creator V2.0"
		echo "********************************************************************************"
		echo "Mac OS X Lion detected"
		echo "Mac OS X Lion is not compatible with this script."
		echo ""
		exit

	else
		clear
		echo "                               macOS Creator V2.0"
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
			echo "                               macOS Creator V2.0"
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
			echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
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
					echo "                               macOS Creator V2.0"
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
					echo "                               macOS Creator V2.0"
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
					echo "                               macOS Creator V2.0"
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
					echo "Error. '$prompt' is not a valid command, please run this script again..."
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
				echo "Error. '$prompt' is not a valid command, please run this script again..."
				echo ""
				exit
			fi
				
		elif [[ $prompt == '3' ]]; then
	clear
	echo "                               macOS Creator V2.0"
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
		echo "                             macOS Creator V2.0 BETA"
		echo "********************************************************************************"
		echo "Please insert your USB Drive into the Mac now, format it with the name Untitled"
		read -p "Type (Y) once formatted... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			if [[ -d /Volumes/Untitled ]]; then
				clear
				echo "                             macOS Creator V2.0 BETA"
					echo "********************************************************************************"
				echo "Which version will you be using?"
				echo "macOS Sierra or older..................(1)"
				echo "macOS High Sierra or newer.............(2)"
				echo ""
				read -p "Enter your option here... " prompt
				if [[ $prompt == '1' ]]; then
					clear
					echo "                             macOS Creator V2.0 BETA"
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
						echo "                             macOS Creator V2.0 BETA"
						echo "********************************************************************************"
						echo "Creating the drive..."
						sudo "$prompt"/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath "$prompt" --nointeraction
						exit
					fi
				elif [[ $prompt == '2' ]]; then
					clear
					echo "                             macOS Creator V2.0 BETA"
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
						echo "                             macOS Creator V2.0 BETA"
						echo "********************************************************************************"
						echo "Creating the drive..."
						sudo "$prompt"/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						exit
					fi
				else
					clear
					echo ""
					echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
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
		echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..." 
			echo ""
			exit
		fi
	fi

elif [[ $prompt == '2' ]]; then
	clear
	echo "                               macOS Creator V2.0"
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
		echo "                             macOS Creator V2.0 BETA"
		echo "********************************************************************************"
		echo "Please insert your USB Drive into the Mac now, format it with the name Untitled"
		read -p "Type (Y) once formatted... " prompt
		if [[ $prompt == 'y' || $prompt == 'Y' ]]; then
			if [[ -d /Volumes/Untitled ]]; then
				clear
				echo "                             macOS Creator V2.0 BETA"
					echo "********************************************************************************"
				echo "Which version will you be using?"
				echo "macOS Sierra or older..................(1)"
				echo "macOS High Sierra or newer.............(2)"
				echo ""
				read -p "Enter your option here... " prompt
				if [[ $prompt == '1' ]]; then
					clear
					echo "                             macOS Creator V2.0 BETA"
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
						echo "                             macOS Creator V2.0 BETA"
						echo "********************************************************************************"
						echo "Creating the drive..."
						sudo "$prompt"/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath "$prompt" --nointeraction
						exit
					fi
				elif [[ $prompt == '2' ]]; then
					clear
					echo "                             macOS Creator V2.0 BETA"
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
						echo "                             macOS Creator V2.0 BETA"
						echo "********************************************************************************"
						echo "Creating the drive..."
						sudo "$prompt"/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						exit
					fi
				else
					clear
					echo ""
					echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
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
		echo "Error. '$prompt' is not a valid command, please run this script again..."
		echo ""
		exit
	fi

elif [[ $prompt == '3' ]]; then
		clear
		echo "                               macOS Creator V2.0"
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
			echo "                               macOS Creator V2.0"
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
			echo "                               macOS Creator V2.0"
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
			echo "                               macOS Creator V2.0"
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
			echo "                               macOS Creator V2.0"
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
			echo "                               macOS Creator V2.0"
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
			echo "                               macOS Creator V2.0"
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
			echo "                               macOS Creator V2.0"
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
			echo "                               macOS Creator V2.0"
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
			echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
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
				echo "                               macOS Creator V2.0"
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
				echo "Error. '$prompt' is not a valid command, please run this script again..."
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
			echo "Error. '$prompt' is not a valid command, please run this script again..."
			echo ""
			exit
		fi

elif [[ $prompt == '4' ]]; then
	clear
	echo "                               macOS Creator V2.0"
	echo "********************************************************************************"
	echo "1) Make sure Terminal has access to your external drive (Security and Privacy)"
	echo "2) Format the drive using Disk Utility (macOS Extended + GUID Partition map)"
	echo "3) Try using a different drive"
	echo "4) Try redownloading the macOS Installer"
	echo "5) Restart your Mac"
	echo "6) Make sure your macOS Installer is inside of your Applications folder."
	echo "7) Make sure your macOS Installer has not been modified. (i.e. name changed)"
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

#Beta Builds, currently unavailable

##############


			elif [[ $prompt == '3' ]]; then
				clear
				echo "To provide a macOS Installer path, the drive name MUST be (Untitled), or this will not work"
				echo ""
				echo "You also must determine which version of macOS you will provide:"
				echo "macOS Sierra or older.........(1)"
				echo "macOS High Sierra or newer....(2)"
				echo "Cancel........................(return)"
				echo ""
				read -p "Enter the number here... " prompt
				if [[ $prompt == '1' ]]; then
					clear
					echo "Make sure the drive you want to use is named (Untited)"
					echo "WARNING: This will erase all data on the drive"
					echo ""
					echo "To provide the installer path, drag the installer application into this window..."
					read -p "Installer path(" prompt
					if [[ $prompt == '' ]]; then
						clear
						echo "No installer path provided, please run this script again"
						echo ""
						exit
					else
						clear
						echo "Creating the drive..."
						sudo $prompt/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath $prompt --nointeraction
						exit
					fi

				elif [[ $prompt == '2' ]]; then
					clear
					echo "Make sure the drive you want to use is named (Untited)"
					echo "WARNING: This will erase all data on the drive"
					echo ""
					echo "To provide the installer path, drag the installer application into this window..."
					read -p "Installer path(" prompt
					if [[ $prompt == '' ]]; then
						clear
						echo "No installer path provided, please run this script again"
						echo ""
						exit
					else
						clear
						echo "Creating the drive..."
						sudo $prompt/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
						exit
					fi

				elif [[ $prompt == '2' ]]; then
					clear
					echo ""
					echo "Operation canceled"
					echo ""
					exit

				else
					clear
					echo ""
					echo "Error. '$prompt' is not a valid command, please run this script again..."
					echo ""
					exit

				fi
