#!/bin/bash

#Welcome to the macOS Creator Script
#This is where the script code is located
#Caution: Modifying the script may cause it to break!

#Version 1.1
#Release notes:
#V1.1 This version adds troubleshooting steps if drive creation fails





#Script:
#####################################################

clear

echo "Encore Platforms"
echo "Version 1.1"
echo ""

echo "Welcome to the macOS Creator"
echo "This script will make a bootable USB drive for macOS"
echo ""

echo "To begin, we must check your Mac for eligibility..."
echo "To continue, press (Y)..."
read -p "(If you wish to cancel, press the return key)... " prompt
if [[ $prompt == 'y' ]]; then
	echo ""
	echo "Checking for valid macOS Installers..."
	if [  -d /Applications/Install\ OS\ X\ Mavericks.app ]; then
		clear
		echo "OS X Mavericks was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' ]]; then
			clear
			echo ""
			echo "You must provide a drive to create the installer (WARNING: All data on the drive will be erased"
			echo "Drag the drive from the Finder into the Terminal window (Drive name must de one word long)"
			read -p "Drive path (" prompt
			if [[ $prompt == '' ]]; then
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "Creating the drive..."
				sudo /Applications/Install\ OS\ X\ Mavericks.app/Contents/Resources/createinstallmedia --volume $prompt --applicationpath /Applications/Install\ OS\ X\ Mavericks.app --nointeraction
				echo ""
				if [ -d /Volumes/Install\ OS\ X\ Mavericks ]; then
					clear
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' ]]; then
						clear
						echo "1) Make sure the drive name is only one word long"
						echo "2) Make sure Terminal has access to your external drive (Security and Privacy Settings)"
						echo "3) Format the drive using Disk Utility (Use macOS Extended with a GUID Partition map)"
						echo "4) Try using a different drive"
						echo "5) Try redownloading the macOS Installer"
						echo "6) Restart your Mac"
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
		echo "OS X Yosemite was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' ]]; then
			clear
			echo ""
			echo "You must provide a drive to create the installer (WARNING: All data on the drive will be erased"
			echo "Drag the drive from the Finder into the Terminal window (Drive name must de one word long)"
			read -p "Drive path (" prompt
			if [[ $prompt == '' ]]; then
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "Creating the drive..."
				sudo /Applications/Install\ OS\ X\ Yosemite.app/Contents/Resources/createinstallmedia --volume $prompt --applicationpath /Applications/Install\ OS\ X\ Yosemite.app --nointeraction
				echo ""
				if [ -d /Volumes/Install\ OS\ X\ Yosemite ]; then
					clear
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' ]]; then
						clear
						echo "1) Make sure the drive name is only one word long"
						echo "2) Make sure Terminal has access to your external drive (Security and Privacy Settings)"
						echo "3) Format the drive using Disk Utility (Use macOS Extended with a GUID Partition map)"
						echo "4) Try using a different drive"
						echo "5) Try redownloading the macOS Installer"
						echo "6) Restart your Mac"
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
		echo "OS X El Capitan was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' ]]; then
			clear
			echo ""
			echo "You must provide a drive to create the installer (WARNING: All data on the drive will be erased"
			echo "Drag the drive from the Finder into the Terminal window (Drive name must de one word long)"
			read -p "Drive path (" prompt
			if [[ $prompt == '' ]]; then
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "Creating the drive..."
				sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume $prompt --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app --nointeraction
				echo ""
				if [ -d /Volumes/Install\ OS\ X\ El\ Capitan ]; then
					clear
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' ]]; then
						clear
						echo "1) Make sure the drive name is only one word long"
						echo "2) Make sure Terminal has access to your external drive (Security and Privacy Settings)"
						echo "3) Format the drive using Disk Utility (Use macOS Extended with a GUID Partition map)"
						echo "4) Try using a different drive"
						echo "5) Try redownloading the macOS Installer"
						echo "6) Restart your Mac"
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
		echo "macOS Sierra was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' ]]; then
			clear
			echo ""
			echo "You must provide a drive to create the installer (WARNING: All data on the drive will be erased"
			echo "Drag the drive from the Finder into the Terminal window (Drive name must de one word long)"
			read -p "Drive path (" prompt
			if [[ $prompt == '' ]]; then
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia --volume $prompt --applicationpath /Applications/Install\ OS\ X\ Sierra.app --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Sierra ]; then
					clear
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' ]]; then
						clear
						echo "1) Make sure the drive name is only one word long"
						echo "2) Make sure Terminal has access to your external drive (Security and Privacy Settings)"
						echo "3) Format the drive using Disk Utility (Use macOS Extended with a GUID Partition map)"
						echo "4) Try using a different drive"
						echo "5) Try redownloading the macOS Installer"
						echo "6) Restart your Mac"
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
		echo "macOS High Sierra was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' ]]; then
			clear
			echo ""
			echo "You must provide a drive to create the installer (WARNING: All data on the drive will be erased"
			echo "Drag the drive from the Finder into the Terminal window (Drive name must de one word long)"
			read -p "Drive path (" prompt
			if [[ $prompt == '' ]]; then
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume $prompt --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ High\ Sierra ]; then
					clear
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' ]]; then
						clear
						echo "1) Make sure the drive name is only one word long"
						echo "2) Make sure Terminal has access to your external drive (Security and Privacy Settings)"
						echo "3) Format the drive using Disk Utility (Use macOS Extended with a GUID Partition map)"
						echo "4) Try using a different drive"
						echo "5) Try redownloading the macOS Installer"
						echo "6) Restart your Mac"
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
		echo "macOS Mojave was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' ]]; then
			clear
			echo ""
			echo "You must provide a drive to create the installer (WARNING: All data on the drive will be erased"
			echo "Drag the drive from the Finder into the Terminal window (Drive name must de one word long)"
			read -p "Drive path (" prompt
			if [[ $prompt == '' ]]; then
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume $prompt --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Mojave ]; then
					clear
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' ]]; then
						clear
						echo "1) Make sure the drive name is only one word long"
						echo "2) Make sure Terminal has access to your external drive (Security and Privacy Settings)"
						echo "3) Format the drive using Disk Utility (Use macOS Extended with a GUID Partition map)"
						echo "4) Try using a different drive"
						echo "5) Try redownloading the macOS Installer"
						echo "6) Restart your Mac"
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
		echo "macOS Catalina was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' ]]; then
			clear
			echo ""
			echo "You must provide a drive to create the installer (WARNING: All data on the drive will be erased"
			echo "Drag the drive from the Finder into the Terminal window (Drive name must de one word long)"
			read -p "Drive path (" prompt
			if [[ $prompt == '' ]]; then
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume $prompt --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Catalina ]; then
					clear
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' ]]; then
						clear
						echo "1) Make sure the drive name is only one word long"
						echo "2) Make sure Terminal has access to your external drive (Security and Privacy Settings)"
						echo "3) Format the drive using Disk Utility (Use macOS Extended with a GUID Partition map)"
						echo "4) Try using a different drive"
						echo "5) Try redownloading the macOS Installer"
						echo "6) Restart your Mac"
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
		echo "macOS Big Sur was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' ]]; then
			clear
			echo ""
			echo "You must provide a drive to create the installer (WARNING: All data on the drive will be erased"
			echo "Drag the drive from the Finder into the Terminal window (Drive name must de one word long)"
			read -p "Drive path (" prompt
			if [[ $prompt == '' ]]; then
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume $prompt --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Big\ Sur ]; then
					clear
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' ]]; then
						clear
						echo "1) Make sure the drive name is only one word long"
						echo "2) Make sure Terminal has access to your external drive (Security and Privacy Settings)"
						echo "3) Format the drive using Disk Utility (Use macOS Extended with a GUID Partition map)"
						echo "4) Try using a different drive"
						echo "5) Try redownloading the macOS Installer"
						echo "6) Restart your Mac"
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
		echo "macOS Monterey was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' ]]; then
			clear
			echo ""
			echo "You must provide a drive to create the installer (WARNING: All data on the drive will be erased"
			echo "Drag the drive from the Finder into the Terminal window (Drive name must de one word long)"
			read -p "Drive path (" prompt
			if [[ $prompt == '' ]]; then
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Monterey.app/Contents/Resources/createinstallmedia --volume $prompt --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Monterey ]; then
					clear
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' ]]; then
						clear
						echo "1) Make sure the drive name is only one word long"
						echo "2) Make sure Terminal has access to your external drive (Security and Privacy Settings)"
						echo "3) Format the drive using Disk Utility (Use macOS Extended with a GUID Partition map)"
						echo "4) Try using a different drive"
						echo "5) Try redownloading the macOS Installer"
						echo "6) Restart your Mac"
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
		echo "macOS Ventura was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' ]]; then
			clear
			echo ""
			echo "You must provide a drive to create the installer (WARNING: All data on the drive will be erased"
			echo "Drag the drive from the Finder into the Terminal window (Drive name must de one word long)"
			read -p "Drive path (" prompt
			if [[ $prompt == '' ]]; then
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Ventura.app/Contents/Resources/createinstallmedia --volume $prompt --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Ventura ]; then
					clear
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' ]]; then
						clear
						echo "1) Make sure the drive name is only one word long"
						echo "2) Make sure Terminal has access to your external drive (Security and Privacy Settings)"
						echo "3) Format the drive using Disk Utility (Use macOS Extended with a GUID Partition map)"
						echo "4) Try using a different drive"
						echo "5) Try redownloading the macOS Installer"
						echo "6) Restart your Mac"
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
		echo "macOS Sonoma was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' ]]; then
			clear
			echo ""
			echo "You must provide a drive to create the installer (WARNING: All data on the drive will be erased"
			echo "Drag the drive from the Finder into the Terminal window (Drive name must de one word long)"
			read -p "Drive path (" prompt
			if [[ $prompt == '' ]]; then
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Sonoma.app/Contents/Resources/createinstallmedia --volume $prompt --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Sonoma ]; then
					clear
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' ]]; then
						clear
						echo "1) Make sure the drive name is only one word long"
						echo "2) Make sure Terminal has access to your external drive (Security and Privacy Settings)"
						echo "3) Format the drive using Disk Utility (Use macOS Extended with a GUID Partition map)"
						echo "4) Try using a different drive"
						echo "5) Try redownloading the macOS Installer"
						echo "6) Restart your Mac"
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
		echo "macOS Sequoia was detected"
		read -p "Do you wish to use this macOS Installer? (Y=Yes, return=No)... " prompt
		if [[ $prompt == 'y' ]]; then
			clear
			echo ""
			echo "You must provide a drive to create the installer (WARNING: All data on the drive will be erased"
			echo "Drag the drive from the Finder into the Terminal window (Drive name must de one word long)"
			read -p "Drive path (" prompt
			if [[ $prompt == '' ]]; then
				echo "Error. No drive path provided, please run this script again..."
				echo ""
				exit

			else
				clear
				echo "Creating the drive..."
				sudo /Applications/Install\ macOS\ Sequoia.app/Contents/Resources/createinstallmedia --volume $prompt --nointeraction
				echo ""
				if [ -d /Volumes/Install\ macOS\ Sequoia ]; then
					clear
					echo "The drive has been created successfully. Thank you for using the macOS Creator."
					echo ""
					exit
				
				else
					echo "Operation failed"
					echo ""
					read -p "Would you like to review troubleshooting steps?... " prompt
					if [[ $prompt == 'y' ]]; then
						clear
						echo "1) Make sure the drive name is only one word long"
						echo "2) Make sure Terminal has access to your external drive (Security and Privacy Settings)"
						echo "3) Format the drive using Disk Utility (Use macOS Extended with a GUID Partition map)"
						echo "4) Try using a different drive"
						echo "5) Try redownloading the macOS Installer"
						echo "6) Restart your Mac"
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
		echo "OS X Mountain Lion detected"
		echo "OS X Mountain Lion is not compatible with this script."
		echo ""
		exit

	elif [ -d /Applications/Install\ Mac\ OS\ X\ Lion.app ]; then
		clear
		echo "Mac OS X Lion detected"
		echo "Mac OS X Lion is not compatible with this script."
		echo ""
		exit

	else
		clear
		echo "No versions of macOS detected..."
		echo ""
		echo ""
		echo "What would you like to do?"
		echo ""
		echo "Review troubleshooting solutions....(1)"
		echo "Download macOS Installer............(2)"
		echo "Cancel..............................(return)"
		read -p "Enter number here: " prompt
		if [[ $prompt == '1' ]]; then
			clear
			echo ""
			echo "Here are some troubleshoting steps:"
			echo ""
			echo "1) Make sure your macOS Installer is inside of your Applications folder."
			echo "2) Make sure your macOS Installer has not been modified. (i.e. name changed)"
			echo "3) Make sure Terminal has access to your Applications folder. (Security and Privacy Settings)"
			echo "4) Redownload the macOS Installer"
			echo ""
			echo "Once you have found a solution, run this script again..."
			echo ""
			exit

		elif [[ $prompt == '2' ]]; then
			clear
			echo ""
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
			read -p "Type the number or letter here: " prompt
			if [[ $prompt == '1' ]]; then
				clear
				echo "Downloading OS X Yosemite..."
				sudo curl http://updates-http.cdn-apple.com/2019/cert/061-41343-20191023-02465f92-3ab5-4c92-bfe2-b725447a070d/InstallMacOSX.dmg -o /private/tmp/InstallmacOS.dmg
				sudo open /private/tmp/InstallmacOS.dmg
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit

			elif [[ $prompt == '2' ]]; then
				clear
				echo "Downloading OS X El Capitan..."
				sudo curl http://updates-http.cdn-apple.com/2019/cert/061-41424-20191024-218af9ec-cf50-4516-9011-228c78eda3d2/InstallMacOSX.dmg -o /private/tmp/InstallmacOS.dmg
				sudo open /private/tmp/InstallmacOS.dmg
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit

			elif [[ $prompt == '3' ]]; then
				clear
				echo "Downloading macOS Sierra..."
				sudo curl http://updates-http.cdn-apple.com/2019/cert/061-39476-20191023-48f365f4-0015-4c41-9f44-39d3d2aca067/InstallOS.dmg -o /private/tmp/InstallmacOS.dmg
				sudo open /private/tmp/InstallmacOS.dmg
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit

			elif [[ $prompt == '4' ]]; then
				clear
				echo "Downloading macOS High Sierra..."
				sudo curl https://archive.org/download/mac-os-high-sierra-10.13.5/macOS%20High%20Sierra%2010.13.5.iso -o /private/tmp/InstallmacOS.iso
				sudo open /private/tmp/InstallmacOS.iso
				echo "Copy the installer to your Applications folder..."
				echo "Once completed, please run this script again..."
				echo ""
				exit

			elif [[ $prompt == '5' ]]; then
				clear
				echo "Downloading macOS Mojave..."
				sudo curl https://archive.org/download/mac-os-mojave-10.14/macOS%20Mojave%2010.14.iso -o /private/tmp/InstallmacOS.iso
				sudo open /private/tmp/InstallmacOS.iso
				echo "Copy the installer to your Applications folder..."
				echo "Once completed, please run this script again..."
				echo ""
				exit

			elif [[ $prompt == '6' ]]; then
				clear
				echo "Downloading macOS Catalina..."
				sudo curl https://archive.org/download/macOS-Catalina-IOS/macOSCatalina.iso -o /private/tmp/InstallmacOS.iso
				sudo open /private/tmp/InstallmacOS.iso
				echo "Copy the installer to your Applications folder..."
				echo "Once completed, please run this script again..."
				echo ""
				exit

			elif [[ $prompt == '7' ]]; then
				clear
				echo "Downloading macOS Big Sur..."
				sudo curl https://swcdn.apple.com/content/downloads/14/38/042-45246-A_NLFOFLCJFZ/jk992zbv98sdzz3rgc7mrccjl3l22ruk1c/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
				sudo open /private/tmp/InstallAssistant.pkg
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit

			elif [[ $prompt == '8' ]]; then
				clear
				echo "Downloading macOS Monterey..."
				sudo curl https://swcdn.apple.com/content/downloads/46/57/052-60131-A_KM2RH04C2D/9yzvba1uvpem2wuo95r459qno57qaizwf2/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
				sudo open /private/tmp/InstallAssistant.pkg
				echo "Follow the on-screen instructions to install..."
				echo "Once completed, please run this script again..."
				echo ""
				exit
									
			elif [[ $prompt == '9' ]]; then
				clear
				echo ""
				echo "Choose the macOS Version you wish to download:"
				echo "(To cancel, press the return key)"
				echo ""
				echo "macOS Ventura......(1)"
				echo "macOS Sonoma.......(2)"
				echo "macOS Sequoia......(3)"
				echo "Cancel.............(return)"
				echo ""
				read -p "Type the number or letter here: " prompt
				if [[ $prompt == '1' ]]; then
					clear
					echo "Downloading macOS Ventura..."
					sudo curl https://swcdn.apple.com/content/downloads/29/47/072-09024-A_8G5EY3SPX2/l6ecgngkrhhbc6q4mae5cwe42pxp49co7w/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
					sudo open /private/tmp/InstallAssistant.pkg
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit

				elif [[ $prompt == '2' ]]; then
					clear
					echo "Downloading macOS Sonoma..."
					sudo curl https://swcdn.apple.com/content/downloads/16/03/072-24524-A_BOQKY5YAFR/x086vnjdghnpudh3dv11jbce398n0alxtl/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
					sudo open /private/tmp/InstallAssistant.pkg
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit

				elif [[ $prompt == '2' ]]; then
					clear
					echo "Downloading macOS Sequoia..."
					sudo curl https://swcdn.apple.com/content/downloads/08/08/072-12353-A_IUBHH68MQT/sv48ma68gmhl96fa9anqfj3i2fnb1ur2wh/InstallAssistant.pkg -o /private/tmp/InstallAssistant.pkg
					sudo open /private/tmp/InstallAssistant.pkg
					echo "Follow the on-screen instructions to install..."
					echo "Once completed, please run this script again..."
					echo ""
					exit

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

elif [[ $prompt == '' ]]; then
	clear
	echo ""
	echo "Operation canceled"
	echo ""
	exit

else
	clear
	echo ""
	echo "Error. If you wish to conintue, type (Y) instead of ($prompt)" 
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
