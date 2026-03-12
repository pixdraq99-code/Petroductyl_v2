#!/bin/bash
# ===========================================================
# 🚀 GUIDECLOUD ULTIMATE TERMINAL v3.0
# 🛠️ POWERED BY: B1 @ GuideCloud
# 📅 EDITION: 2026
# ===========================================================

# --- DYNAMIC COLOR ENGINE ---
refresh_color() {
    # Exclusive Professional Colors
    COLORS=('\033[1;32m' '\033[1;33m' '\033[1;34m' '\033[1;35m' '\033[1;36m' '\033[38;5;214m')
    C1=${COLORS[$RANDOM % ${#COLORS[@]}]} # Primary Branding Color
    C2='\033[1;37m' # Clean White
    NC='\033[0m'
    BOLD='\033[1m'
}

# --- SYSTEM INFO ---
UPTIME=$(uptime -p | sed 's/up //')

# ===================== PERFECT LOGO BANNER =====================
banner(){
refresh_color
clear
echo -e "${C1}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${BOLD}${C2}⚡ UPTIME: ${C1}$UPTIME${NC}  ${BOLD}${C2}👑 OWNER: ${C1}B1 @ GUIDECLOUD${NC}  ${BOLD}${C2}📅 YEAR: ${C1}2026${NC}"
echo -e "${C1}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${C1}"
echo -e "   ██████╗ ██╗   ██╗██╗██████╗ ███████╗ ██████╗██╗      ██████╗ ██╗   ██╗██████╗ "
echo -e "  ██╔════╝ ██║   ██║██║██╔══██╗██╔════╝██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗"
echo -e "  ██║  ███╗██║   ██║██║██║  ██║█████╗  ██║     ██║     ██║   ██║██║   ██║██║  ██║"
echo -e "  ██║   ██║██║   ██║██║██║  ██║██╔══╝  ██║     ██║     ██║   ██║██║   ██║██║  ██║"
echo -e "  ╚██████╔╝╚██████╔╝██║██████╔╝███████╗╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝"
echo -e "   ╚═════╝  ╚═════╝ ╚═╝╚═════╝ ╚══════╝ ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝ "
echo -e "${NC}"
echo -e "                     ${BOLD}${C2}DEVELOPED & PROMOTED BY: ${C1}B1${NC}"
echo -e "${C1}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo
}

# ===================== MENUS =====================
panel_menu(){
while true; do banner
echo -e " ${BOLD}${C1}💠 [ SERVER PANEL MANAGEMENT ]${NC}"
echo -e " ${C1}─────────────────────────────────────────────────────────────────────────────${NC}"
echo -e "  ${C1}01)${C2} 🪶 FeatherPanel      ${C1}07)${C2} 💳 Payment Gateway"
echo -e "  ${C1}02)${C2} 🦖 Pterodactyl       ${C1}08)${C2} 🎮 CtrlPanel"
echo -e "  ${C1}03)${C2} 🧪 Jexactyl v3       ${C1}09)${C2} 🔄 Reviactyl"
echo -e "  ${C1}04)${C2} 🧬 Jexpanel v4       ${C1}10)${C2} 🔧 External Tools"
echo -e "  ${C1}05)${C2} 📊 Dashboard v3      ${C1}11)${C2} 🔙 Return to HQ"
echo -e "  ${C1}06)${C2} 📈 Dashboard v4"
echo -e " ${C1}─────────────────────────────────────────────────────────────────────────────${NC}"
read -p " 🎯 ENTER CHOICE → " p

case $p in
 1) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/Uninstall/unFEATHERPANEL.sh) ;;
 2) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/Uninstall/unPterodactyl.sh) ;;
 3) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/panel/Jexactyl.sh) ;;
 4) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/Uninstall/unJexactyl.sh) ;;
 5) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/Uninstall/undash-3.sh) ;;
 6) bash <(curl -s https://github.com/nobita329/The-Coding-Hub/raw/refs/heads/main/srv/Uninstall/dash-v4.sh) ;;
 7) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/Uninstall/unPaymenter.sh) ;;
 8) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/Uninstall/unCtrlPanel.sh) ;;
 9) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/Uninstall/unReviactyl.sh) ;;
 10) bash <(curl -s https://raw.githubusercontent.com/yourlink/t-panel.sh) ;;
 11) break;;
 *) echo -e "${RED} [!] Selection Error. Refreshing... ${NC}"; sleep 1;;
esac
done
}

tools_menu(){
while true; do banner
echo -e " ${BOLD}${C1}🛠️ [ ADVANCED EMPIRE TOOLS ]${NC}"
echo -e " ${C1}─────────────────────────────────────────────────────────────────────────────${NC}"
echo -e "  ${C1}1)${C2} 🔑 Root Access       ${C1}5)${C2} 🚀 Vps Run"
echo -e "  ${C1}2)${C2} 🌐 Tailscale         ${C1}1)${C2} 📟 TERMINAL"
echo -e "  ${C1}3)${C2} ☁️  Cloudflare DNS    ${C1}7)${C2} 💻 RDP Installer"
echo -e "  ${C1}4)${C2} 📋 System Info       ${C1}8)${C2} 🔙 Back"
echo -e " ${C1}─────────────────────────────────────────────────────────────────────────────${NC}"
read -p " ⚙️ TOOL ID → " t
case $t in
 1) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/tools/root.sh) ;;
 2) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/tools/Tailscale.sh) ;;
 3) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/tools/cloudflare.sh) ;;
 4) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/tools/SYSTEM.sh) ;;
 5) bash <(curl -s https://raw.githubusercontent.com/nobita54/-150/refs/heads/main/tools/vps.sh) ;;
 6) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/tools/terminal.sh) ;;
 7) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/tools/rdp.sh) ;;
 8) break;;
esac
done
}

main_menu(){
while true; do banner
echo -e " ${BOLD}${C2}💎 [ B1 x GUIDECLOUD MAINBOARD ]${NC}"
echo -e " ${C1}─────────────────────────────────────────────────────────────────────────────${NC}"
echo -e "  ${C1}[1]${C2} ⚡  VPS RUN           ${C1}[5]${C2} 🎨  THEME"
echo -e "  ${C1}[2]${C2} 🖥️   PANEL            ${C1}[6]${C2} ⚙️   SYSTEM"
echo -e "  ${C1}[3]${C2} 🕊️   WINGS            ${C1}[7]${C2} 👑  ALL BEST"
echo -e "  ${C1}[4]${C2} 🛠️   TOOLS            ${C1}[8]${C2} 🚪  EXIT"
echo -e " ${C1}─────────────────────────────────────────────────────────────────────────────${NC}"
echo -en " ${BOLD}${C1}❯❯${NC} ${BOLD}${C2}COMMANDER B1, SELECT UNIT: ${NC}"
read c

case $c in
 1) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/vm/vps.sh) ;;
 2) panel_menu ;;
 3) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/wings/www.sh) ;;
 4) tools_menu ;;
 5) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/thame/alla.sh) ;;
 6) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/menu/System1.sh) ;;
 7) bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/External/INFRA.sh) ;;
 8) echo -e "${GREEN}System Shutdown... Goodbye King B1!${NC}"; exit ;;
 *) echo -e "\033[1;31m [!] Error! Refreshing Dynamic UI... \033[0m"; sleep 1 ;;
esac
done
}

main_menu
