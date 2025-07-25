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
LATEST_VERSION=$(curl -s https://raw.githubusercontent.com/JadonLyon/macOS-Creator-Resources/refs/heads/main/macOS%20Creator%20Version.txt)
PreUpdate()
{
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
	echo -n -e "${RESET}${CANCEL}${BOLD}                              Press Q to quit... "
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
            printf "  > \033[1;32m%s\033[0m\n" "${options[$i]}"
        else
            printf "    %s\n" "${options[$i]}"
        fi
    done
    while true; do
        tput cuu $num_options
        for i in "${!options[@]}"; do
            if [[ $i -eq $selected ]]; then
                printf "  > \033[1;32m%s\033[0m\n" "${options[$i]}"
            else
                printf "    %s\n" "${options[$i]}"
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
                return 001
                ;;
            [Cc])
                return 002
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
	echo -e "${CANCEL}                     To show the help menu, press the ${BOLD}? ${RESET}${CANCEL}key${RESET}"
	echo -e ""
	echo -e "${TITLE}${BOLD}                            Please choose an option:${RESET}${BODY}"
	menuoptions=("Search for macOS installer in your Applications folder" \
             	"Manually provide macOS Installer" \
             	"Download macOS Installer" \
             	"Identify Mac model" \
             	"Settings")
	MENU_SELECTOR "${menuoptions[@]}"
	selection=$?
	if [[ $selection -eq 001 ]]; then
    	echo "User pressed ESC (going back)"
    elif [[ $selection -eq 002 ]]; then
    	echo "Credits"
	else
    	echo "User selected: ${menuoptions[$selection]}"
	fi
}
MAINMENU