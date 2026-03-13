#!/bin/bash

# Colors
Y="\e[33m"
G="\e[32m"
R="\e[31m"
C="\e[36m"
M="\e[35m"
B="\e[34m"
W="\e[97m"
N="\e[0m"

# Box Drawing Characters
TL="╔"  # Top Left
TR="╗"  # Top Right
BL="╚"  # Bottom Left
BR="╝"  # Bottom Right
HL="═"  # Horizontal Line
VL="║"  # Vertical Line
LT="╠"  # Left T
RT="╣"  # Right T

show_header() {
    clear
    echo -e "${M}${TL}════════════════════════════════════════════════════════════${TR}${N}"
    echo -e "${VL}${W}             🚀 MACK THAME AND BLUEPRINT                    ${M}${VL}${N}"
    echo -e "${LT}════════════════════════════════════════════════════════════${RT}${N}"
    echo -e "${VL}${Y}               ALL THAME AND BLUEPRINT                    ${M}${VL}${N}"
    echo -e "${BL}════════════════════════════════════════════════════════════${BR}${N}\n"
}

show_menu() {
    echo -e "${B}${TL}════════════════════════════════════════════════════════════${TR}${N}"
    echo -e "${VL}${W}                     📋 MAIN MENU                          ${B}${VL}${N}"
    echo -e "${LT}════════════════════════════════════════════════════════════${RT}${N}"
    echo -e "${VL}${G}   1. ${W}🌐 BLUEPRINT             ${B}${VL}${N}"
    echo -e "${VL}${C}   2. ${W}🏠 Change Theme                    ${B}${VL}${N}"
    echo -e "${VL}${R}   3. ${W}🗑️ Uninstall             ${B}${VL}${N}"
    echo -e "${VL}${Y}   0. ${W}🚪 Exit                                         ${B}${VL}${N}"
    echo -e "${BL}════════════════════════════════════════════════════════════${BR}${N}\n"
}


# Main loop
while true; do
    show_header
    show_menu
    
    echo -e "${C}┌─[${W}SELECT OPTION${C}]${N}"
    echo -ne "${C}└──╼${W} $ ${N}"
    read -p "" opt
    
    case $opt in
        1)
            bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/thame/ch.sh)
            ;;
        2)
            bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/thame/chang.sh)
            ;;
        3)
            bash <(curl -s https://raw.githubusercontent.com/yourlink/theme_uninstall.sh)
            ;;
        0)
            clear
            echo -e "${M}${TL}════════════════════════════════════════════════════════════${TR}${N}"
            echo -e "${VL}${W}                    👋 GOODBYE!                          ${M}${VL}${N}"
            echo -e "${VL}${Y}          Thank you for using Mack GuideCloud        ${M}${VL}${N}"
            echo -e "${BL}════════════════════════════════════════════════════════════${BR}${N}\n"
            exit 0
            ;;
        *)
            echo -e "\n${R}❌ Invalid option! Please select 0-3${N}"
            sleep 1
            ;;
    esac
done
