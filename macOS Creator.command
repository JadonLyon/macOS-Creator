#!/bin/bash


# macOS Creator Base Code
# WARNING: Modifying this code may break the script!

# macOS Creator Version 7.0 - Release Notes
#   - Completely rewrites the base code for ultimate stability and bug fix
#   - Updates all internet links to redirect to GitHub
#   - Updates the UI for easiest control
#   - Introduces minor support for macOS Tahoe Beta
#   - Makes several improvements to Safe Install
#
# To see older release notes, go to GitHub.com




# - Script Base Code -

# - Prelaunch commands (Saves information such as Mac Model, etc.) -
ARGUMENTS="${1}${2}${3}${4}${5}${6}${7}${8}${9}"
if [[ $ARGUMENTS == *"-v"* || $ARGUMENTS == *"-verbose"* ]]; then
	verbose="1"
elif [[ $ARGUMENTS == *"-V"* || $ARGUMENTS == *"-Verbose"* ]]; then
	verbose="1"
	set -x
fi
if [[ $ARGUMENTS == *"-S"* || $ARGUMENTS == *"-Safe"* ]]; then
	safe="1"
elif [[ $ARGUMENTS == *"-s"* || $ARGUMENTS == *"-safe"* ]]; then
	safe="2"
fi
if [[ $ARGUMENTS == *"-hmsrlnch0"* ]]; then
	HOMEUSER="YES"
fi
SCRIPTPATH="${0}"
SCRIPTPATHMAIN="${0%/*}"
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
	MACOSVERSION=$(sw_vers -productVersion | cut -d '.' -f 1,2)
}
PreRunMac()
{
	MACVERSION=$(sysctl hw.model | awk '{ print $2 }')
	STARTUPDISK=$(diskutil info / | sed -n 's/^ *Volume Name: *//p')
	if [[ $(uname -m) == "arm64" ]]; then
		APPLESILICONE="YES"
		if [[ ! -d "$("xcode-select" -p)" ]]; then
			echo -e "${RESET}${ERROR}You are running on Apple Silicone without Xcode tools"
			echo -e "${RESET}${BODY}You need these tools to install older versions of macOS"
			echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
			echo -n "Would you like to install them now? (Press any key to skip install)... "
			read -n 1 input
			if [[ $input == 'y' || $input == 'Y' ]]; then
				xcode-select --install
				echo -e "${RESET}${TITLE}Once installed, please run this script again"
				exit
			else
				echo -e ""
			fi
		fi
	fi
}
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
UIColors()
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
		MODIFIEDCOLORS="YES"
		SETTINGCOLOR="Unknown"
	fi
	if [[ $UIAPPEARANCE == 'Dark' ]]; then
		APPLECHIPINFO="\033[38;5;117mApp\033[38;5;111mle \033[38;5;135mSili\033[38;5;207mcone"
	else
		APPLECHIPINFO="\033[38;5;33mApp\033[38;5;63mle \033[38;5;129mSili\033[38;5;163mcone"
	fi
}
VERSION_URL="https://raw.githubusercontent.com/JadonLyon/macOS-Creator-Resources/refs/heads/main/macOS%20Creator%20Version.txt"
CURRENT_VERSION="7.0"
PreUpdate()
{
	LATEST_VERSION=$(curl -s https://raw.githubusercontent.com/JadonLyon/macOS-Creator-Resources/refs/heads/main/macOS%20Creator%20Version.txt)
	if [[ "$CURRENT_VERSION" == "$LATEST_VERSION" ]]; then
		UPDATEAVAILABLE="YES"
	fi
}

# - Text and Animations -
ANIMATIONDRIVE()
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
			echo -e "${APP}${BOLD}                    macOS Creator ${RESET}${APP}V7.0${BOLD} ${WARNING}(Verbose & Safe Mode)${APP}${BOLD}"
		elif [[ $verbose == '1' ]]; then
			echo -e "${APP}${BOLD}                           macOS Creator ${RESET}${APP}V7.0${BOLD} ${WARNING}(Verbose)${APP}${BOLD}"
		elif [[ $safe == '1' || $safe == '2' ]]; then
			echo -e "${APP}${BOLD}                         macOS Creator ${RESET}${APP}V7.0${BOLD} ${WARNING}(Safe Mode)${APP}${BOLD}"
		else
			echo -e "${APP}${BOLD}                               macOS Creator ${RESET}${APP}V7.0${BOLD}"
		fi
		echo -e ""
	else
		clear
		if [[ $verbose == '1' && $safe == '1' || $verbose == '1' && $safe == '2' ]]; then
			echo -e "${APP}${BOLD}                    macOS Creator ${RESET}${APP}V7.0${BOLD} ${WARNING}(Verbose & Safe Mode)${APP}${BOLD}"
		elif [[ $verbose == '1' ]]; then
			echo -e "${APP}${BOLD}                          macOS Creator ${RESET}${APP}V7.0${BOLD} ${WARNING}(Verbose)${APP}${BOLD}"
		elif [[ $safe == '1' || $safe == '2' ]]; then
			echo -e "${APP}${BOLD}                         macOS Creator ${RESET}${APP}V7.0${BOLD} ${WARNING}(Safe Mode)${APP}${BOLD}"
		else
			echo -e "${APP}${BOLD}                               macOS Creator ${RESET}${APP}V7.0${BOLD}"
		fi
		echo -e "»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»"
	fi
}
WINDOWBAREND()
{
	echo -e ""
	echo -e "${RESET}${CANCEL}${BOLD}                                Script Canceled"
	if [[ ! $GRAPHICSSAFE == 'YES' ]]; then
		echo -e "${RESET}${APP}${BOLD}"
		echo -e "»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»"
		echo -e "${RESET}"
	fi
	exit
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
WINDOWERROR()
{
	echo -e ""
	echo -e "${RESET}${ERROR}${BOLD}"
	echo -e "       Command not recognized, please report the following code to GitHub: "
	echo -e "                                     384508"
	echo -e "${RESET}"
	if [[ ! $GRAPHICSSAFE == 'YES' ]]; then
		echo -e "${RESET}${APP}${BOLD}"
		echo -e "»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»"
		echo -e "${RESET}"
	fi
}
UIColors
MENU_SELECTOR()
{
    local options=("$@")
    local selected=0
    local key
    local num_options=${#options[@]}
    echo
    for i in "${!options[@]}"; do
        if [[ $i -eq $selected ]]; then
            printf "${RESET}${PROMPTSTYLE}${BOLD}                >-%s\033[0m\n" "${options[$i]}"
        else
            printf "                  ${RESET}${TITLE}%s\n" "${options[$i]}"
        fi
    done
    while true; do
        tput cuu $num_options
        for i in "${!options[@]}"; do
            if [[ $i -eq $selected ]]; then
                printf "${RESET}${PROMPTSTYLE}${BOLD}                >-%s\033[0m\n" "${options[$i]}-<"
            else
                printf "                  ${RESET}${TITLE}%s\n" "${options[$i]}  "
            fi
        done
        IFS= read -rsn1 key
        case "$key" in
            $'\x1b')
                IFS= read -rsn2 -t 1 rest || continue
                case "$rest" in
                    "[A")
                        ((selected--))
                        ((selected < 0)) && selected=$((num_options - 1))
                        ;;
                    "[B")
                        ((selected++))
                        ((selected >= num_options)) && selected=0
                        ;;
                esac
                ;;
            "")
                return $selected
                ;;
            [Qq])
                return 111
                ;;
            [Cc])
                return 110
                ;;
            *)
                ;;
        esac
    done
}
MAINMENU()
{
	if [[ $FIRSTTIMEHERE=='TRUE' ]]; then
		cd "$SCRIPTPATHMAIN"
		sed -i '' '8856s/TRUE/FALSE/' macOS\ Creator.command
	fi
	FIRSTTIMEHERE="FALSE"
	ENTERHERE="TRUE"
	WINDOWBAR
	echo -e "${RESET}${TITLE}${BOLD}                            macOS Creator Home menu${RESET}"
	echo -e "${RESET}${BODY}                        Press ${BOLD}W${RESET}${BODY} to see list of controls${RESET}"
	echo -e "${RESET}${BODY}                  Use ${BOLD}↑ ↓${RESET}${BODY} to navigate. Press ${BOLD}Return${RESET}${BODY} to select${RESET}"
	echo -e "${CANCEL}                     To show the help menu, press the ${BOLD}? ${RESET}${CANCEL}key${RESET}"
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-----------Create macOS Installer-----------" \
             	"-------------Identify Mac model-------------" \
             	"------------------Settings------------------" \
             	"-----------------User Guide-----------------" \
             	"--------------------Exit--------------------" )
	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
	if [[ $selection -eq 000 ]]; then
    	AUTOMACOSINSTALL
    elif [[ $selection -eq 004 ]]; then
    	WINDOWBAREND
    elif [[ $selection -eq 110 ]]; then
    	echo "Credits"
	else
    	WINDOWERROR
	fi
}
AUTOMACOSINSTALL()
{
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
OSMAVERICKS()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                            OS X Mavericks was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${BODY}${BOLD}                           Safe Install is turned on"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install OS X Mavericks.app"
		FINDDRIVE
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSYOSEMITE()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                            OS X Yosemite was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${BODY}${BOLD}                           Safe Install is turned on"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install OS X Yosemite.app"
		FINDDRIVE
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSELCAPITAN()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                           OS X El Capitan was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${BODY}${BOLD}                           Safe Install is turned on"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install OS X El Capitan.app"
		FINDDRIVE
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSSIERRA()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                             macOS Sierra was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${ERROR}               macOS Sierra cannot be installed with Safe Install"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install macOS Sierra.app"
		FINDDRIVE
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSHIGHSIERRA()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                          macOS High Sierra was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${BODY}${BOLD}                           Safe Install is turned on"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
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
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSMOJAVE()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                            macOS Mojave was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${ERROR}               macOS Mojave cannot be installed with Safe Install"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
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
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSCATALINA()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                            macOS Catalina was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${ERROR}              macOS Catalina cannot be installed with Safe Install"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
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
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSBIGSUR()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                            macOS Big Sur was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${ERROR}              macOS Big Sur cannot be installed with Safe Install"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
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
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSMONTEREY()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                            macOS Monterey was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${ERROR}              macOS Monterey cannot be installed with Safe Install"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
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
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSVENTURA()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                            macOS Ventura was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${ERROR}              macOS Ventura cannot be installed with Safe Install"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
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
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSSONOMA()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                             macOS Sonoma was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${ERROR}               macOS Sonoma cannot be installed with Safe Install"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
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
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSSEQUOIA()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                            macOS Sequoia was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${ERROR}              macOS Sequoia cannot be installed with Safe Install"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
	if [[ $selection -eq 000 ]]; then
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
    elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSML()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                          OS X Mountain Lion was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${ERROR}               OS X Mountain Lion cannot be installed with Safe Install"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install OS X Mountain Lion.app"
		FINDDRIVE
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSL()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                            Mac OS X Lion was found${RESET}${TITLE}"
	if [[ $SAFEINSTALLATION == 'TRUE' ]]; then
		echo -e ""
		echo -e "${RESET}${ERROR}                 Mac OS X Lion cannot be installed with Safe Install"
	fi
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("-------------Use this Installer-------------" \
				"----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
	if [[ $input == 'y' || $input == 'Y' ]]; then
		installpath="/Applications/Install Mac OS X Lion.app"
		FINDDRIVE
	elif [[ $selection -eq 004 ]]; then
    	HELPOSFOUNDSEQUOIA
    elif [[ $selection -eq 005 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
OSNONE()
{
	WINDOWBAR
	echo -e "${RESET}${OSFOUND}${BOLD}                         No macOS Installers were found${RESET}${TITLE}"
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("----------------Search again----------------" \
             	"-------------Provide Installer--------------" \
             	"-------------Download Installer-------------" \
             	"------------------Get Help------------------" \
             	"-------------------Return-------------------" )

	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
	if [[ $selection -eq 000 ]]; then
    	AUTOMACOSINSTALL
    elif [[ $selection -eq 003 ]]; then
    	HELPOSNONE
    elif [[ $selection -eq 004 ]]; then
    	MAINMENU
	else
    	WINDOWERROR
	fi
}
HELPOSFOUNDSEQUOIA()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}Choose Use this Installer to install macOS Sequoia on the USB Drive."
	echo -e "Choose Search again to check your Applications folder again."
	echo -e "If you have a macOS Installer somewhere else, choose Provide Installer."
	echo -e "If you wish to use a different macOS Installer, choose Download Installer."
	echo -e ""
	echo -e "Choose Return to go back to the Home Menu."
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	OSSEQUOIA
}
HELPOSNONE()
{
	WINDOWBAR
	echo -e "${RESET}${TITLE}The script did not find any macOS Installers in your Applications folder."
	echo -e "Choose Search again to check your Applications folder again."
	echo -e "If you have a macOS Installer somewhere else, choose Provide Installer."
	echo -e "If you do not have a macOS Installer, choose Download Installer."
	echo -e ""
	echo -e "Choose Return to go back to the Home Menu."
	echo -e "${RESET}${PROMPTSTYLE}${BOLD}"
	echo -n "                           Press any key to return... "
	read -n 1
	OSNONE
}
MAINMENU












































