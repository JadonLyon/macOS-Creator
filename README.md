# macOS-Creator
This tool allows for easy creation of macOS Installers on USB Drives

How to use the tool:
Drag the script into a Terminal window.
If you get a "Permission Denied" error, type chmod +x and then drag the script into the Terminal window.
Type "y" every time you want to advance to the next step.
Press "return" any time you wish to cancel.
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
While donwloading the macOS Installer, the script saves the file to /private/tmp/ on your Mac's internal drive. When the drive has been successfully created, you can now use the cleanup tool to remove those files and free disk space on your Mac. This tool is still in acitve devolopment and is currently limited.
