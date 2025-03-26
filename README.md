# macOS-Creator
This tool allows for easy creation of macOS Installers on USB Drives

USE: YOU MAY USE THIS TOOL FREE OF CHARGE. BUT, PLEASE DO NOT REDISTRIBUTE THIS SOFTWARE AND CLAIM IT AS YOUR OWN!

How to use the tool:
Open the "macOS Creator.dmg" file. There you can build the application.
NOTE: you can run the script directly from the .dmg file, but you will not be able to customize it.

Enter your password to install the app.

If you get a "Permission Denied" error, type chmod +x and then drag the script into the Terminal window.
(NOTE: In V5.1 and newer, you should not experience this issue.)

To choose a command, type the number corresponding to it.
Press "return" any time you wish to cancel.
Press "Q" any time you wish to go back to the Home Menu.
Press "W" any time you wish to go back one step.
Adjust the settings you like in the settings menu.
Follow the on-screen instructions to create the drive.

New changes in V4.0
Pre-Run Commands are invisible commands that the script will use throughout the entire drive creation process.
For example, if you try to create macOS High Sierra on OS X Lion, the script will give you an error.
This is because Pre-Run checked your Mac before you even see the home screen in order to determine which versions of macOS will work.
There are several other examples where Pre-Run checks your Mac in order to prevent any major issues while script is running.
New changes in V5.0
If you wish to skip these steps, drag the script into the terminal window, but before pressing the return key, type -s to enter Safe Mode.

UI Color Settings in V4.1
In order to change the UI colors, the script must rewrite itself while running. In order for this funcion to work, aviod all modifications to the script (i.e. Script name change, script line modification, etc.). You also must make sure that the script location is not in a read-only folder or drive. This will not allow change in the script.

Apple Silicone support in V5.0
Over the next releases, more support will be added for Apple Silicone. For now, the script simply produces an error if macOS version is not compatible with Apple Silicone.

UI Color for Apple Silicone
If you are running on a Mac with Apple Silicone, you have the ability to choose a rainbow colored UI. This UI is unavailable on Intel-Based Macs.

App Build in V5.0
If you use the macOS Creator on a regualar basis, you can now build an app that will appear in your Applications folder. THIS IS NOT A UI APP! This is simply an Automator app that launches the script for you. When building the app, the script itself is saved to your home folder, inside a folder named "macOS Creator." This folder is then hidden so that is does not appear every time you access the home folder.

Script layout in V5.0
The entire script has been rewritten in V5.0 in order to change the script structure. As a result, the macOS Creator now has many new features, but is only half the size of V4.1. This is great for devolopers if a bug is found in the future, and therefore the script is much more stable. For the average user, the script will feel just like V4.1 and older.

Verbose mode in V5.0
The average user probably does not want to see the boring commands running while creating the installer. In V5.0, these commands now run in the background and will not be seen by the user. If you continuously recieve an error, you can run the script again but type -v before pressing the return key. This will output the commands while creating the drive. If you feel as though the script has an issue and you wish to locate the problem, you can type -V for a deeper verbose mode.

Creating the drive in V5.0
Drive creation both automatically and manually now use the same command. This allows for much faster creation than before.

Listing the drives in V5.0
The drives listed are numbered. If you continuously type an invalid command, the list will progressively grow larger in number. It may get to the point where the drive you need is label 67 or higher. Because the macOS Creator only recives single digit numbers for input, you must restart the script or manually provide the drive.

Cleanup in V5.0
While donwloading the macOS Installer, the script saves the file to /private/tmp/ on your Mac's internal drive. When the drive has been successfully created, you can now use the cleanup tool to remove those files and free disk space on your Mac. This tool has many more features begining in V5.1 and more will be added in future releases.

First time in V5.2 and newer.
When you first launch the script, it will ask if you have ever used the script before, and it can take you to the user guide. When you continue to the main menu, the script rewrites itself so you never see that message again. If you are updating from a previous version, the Build App.command script will save a file to your Mac's tmp folder to show that the update has been successful.

Settings in V5.3 and newer.
All configurations have been moved to a menu called Settings. This includes color adjustments and the cleanup tool. If you build the app, you will be able to save your setting permanently. This way, you do not lose your Setitngs after an upgrade or reinstallation. Running in Verbose or Safe Mode simply relaunches the script with an argument added. Adjusting the app has two options: One Launch and Normal Launch. Normal launch simply opens a terminal window and runs the script. This way, you can run the script as many times as needed. One Launch opens the script directly, so it is faster, and more direct. This, however, forces the user to close the window and reopen it every time.

macOS Sierra Drive Modification in V5.5.
macOS Sierra has some bug with the standard createinstallmedia command which is why is fails continuously. In order to resolve this issue with the macOS Creator, drive creation has been completely changed. Now, the macOS Creator will mount the Install ESD disk image and restore the Base System disk image onto the drive. Then, it will copy the packages required for installation to the drive. It will then bless the drive to make it bootable.