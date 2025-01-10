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
