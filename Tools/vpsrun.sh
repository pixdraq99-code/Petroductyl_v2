#!/bin/bash
# ===========================================================
# DEV ENVIRONMENT MANAGER - OBSIDIAN NEXT GEN (v11.4)
# Style: Full Segmented UI / Nobita Edition / Multi-Menu
# ===========================================================

# --- 0. PRE-INITIALIZATION ---
# Hostname badalna sabse pehle
hostnamectl set-hostname Nobita 2>/dev/null

# --- COLORS & STYLES ---
B_BLUE='\033[1;38;5;33m'
B_CYAN='\033[1;38;5;51m'
B_PURPLE='\033[1;38;5;141m'
B_GREEN='\033[1;38;5;82m'
B_RED='\033[1;38;5;196m'
GOLD='\033[38;5;220m'
W='\033[1;38;5;255m'
G='\033[0;38;5;244m'
BG_SHADE='\033[48;5;236m' 
NC='\033[0m'

# --- UTILS ---
pause() { echo; echo -ne "  ${G}➜${NC} ${W}Press Enter to return...${NC}"; read _; }

# --- DATA AGGREGATOR ---
get_metrics() {
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{printf "%.0f", $2+$4}')
    RAM=$(free | grep Mem | awk '{printf "%.0f", $3*100/$2}')
    UPT=$(uptime -p | sed 's/up //')
    DISK=$(df -h / | awk 'NR==2 {print $5}')
    CURRENT_HOST=$(hostname)
    
    # KVM Check status
    KVM_STATUS="${B_RED}OFF${NC}"
    if [ -e /dev/kvm ]; then KVM_STATUS="${B_GREEN}ON${NC}"; fi
}

# --- SUB-MENU: PANEL CONTROL (SAME UI STYLE) ---
panel_menu() {
    while true; do
        clear
        get_metrics
        # Header
        echo -e " ${B_BLUE}${NC}${BG_SHADE}${W}   HOST: $CURRENT_HOST ${NC}${B_BLUE}${NC}  ${B_PURPLE}${NC}${BG_SHADE}${W}   $UPT ${NC}${B_PURPLE}${NC}"
        echo -e ""
        # Sub-Menu Banner
        echo -e "  ${GOLD}██████╗  █████╗ ███╗   ██╗███████╗██╗     ${NC}"
        echo -e "  ${GOLD}██╔══██╗██╔══██╗████╗  ██║██╔════╝██║     ${NC}"
        echo -e "  ${GOLD}██████╔╝███████║██╔██╗ ██║█████╗  ██║     ${NC}"
        echo -e "  ${GOLD}██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║     ${NC}"
        echo -e "  ${GOLD}██║     ██║  ██║██║ ╚████║███████╗███████╗${NC}"
        echo -e "  ${G}──────────────────────────────────────────${NC}"
        
        echo -e "  ${W}Available Control Panels:${NC}\n"
        echo -e "  ${B_CYAN}  WEB INTERFACES${NC}"
        echo -e "  ${G}├─ ${W}[1]${NC} Install Cockpit ${G}(Web VM Manager)${NC}"
        echo -e "  ${G}├─ ${W}[2]${NC} Install CasaOS  ${G}(Home Cloud UI)${NC}"
        echo -e "  ${G}└─ ${W}[3]${NC} Install 1Panel  ${G}(Modern Hosting)${NC}"
        echo -e ""
        echo -e "  ${B_PURPLE}  NAVIGATION${NC}"
        echo -e "  ${G}└─ ${B_BLUE}${NC}${BG_SHADE}${W} [0] BACK TO MAIN MENU ${NC}${B_BLUE}${NC}"
        
        echo -e "\n  ${G}──────────────────────────────────────────${NC}"
        echo -ne "  ${B_CYAN}➜${NC} ${W}Panel ID${NC} ${G}(0-3):${NC} "; read p_opt
        
        case $p_opt in
            1) echo -e "\n  ${B_BLUE}➜ Installing Cockpit...${NC}"
               bash <(curl -s https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/vps/panel/cockpit.sh); pause ;;
            2) echo -e "\n  ${B_BLUE}➜ Installing CasaOS...${NC}"
               bash <(curl -s https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/vps/panel/casaos.sh); pause ;;
            3) echo -e "\n  ${B_BLUE}➜ Installing 1Panel...${NC}"
               bash <(curl -s https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/vps/panel/1panel.sh); pause ;;
            0) break ;;
            *) echo -e "  ${B_RED}Invalid option!${NC}"; sleep 0.7 ;;
        esac
    done
}

# --- MAIN RENDERER ---
render_ui() {
    clear
    get_metrics
    # Top Status Bar
    echo -e " ${B_BLUE}${NC}${BG_SHADE}${W}   HOST: $CURRENT_HOST ${NC}${B_BLUE}${NC}  ${B_PURPLE}${NC}${BG_SHADE}${W}   $UPT ${NC}${B_PURPLE}${NC}  ${B_GREEN}${NC}${BG_SHADE}${W} ⚙ KVM: $KVM_STATUS ${NC}${B_GREEN}${NC}"
    echo -e ""

    # Big Custom Banner
    echo -e "${B_CYAN} ██████╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗      ██╗  ██╗██╗   ██╗██████╗ ${NC}"
    echo -e "${B_CYAN}██╔════╝██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝      ██║  ██║██║   ██║██╔══██╗${NC}"
    echo -e "${B_PURPLE}██║     ██║   ██║██║  ██║██║██╔██╗ ██║██║  ███╗     ███████║██║   ██║██████╔╝${NC}"
    echo -e "${B_PURPLE}██║     ██║   ██║██║  ██║██║██║╚██╗██║██║   ██║     ██╔══██║██║   ██║██╔══██╗${NC}"
    echo -e "${GOLD}╚██████╗╚██████╔╝██████╔╝██║██║ ╚████║╚██████╔╝     ██║  ██║╚██████╔╝██████╔╝${NC}"
    echo -e "${GOLD} ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝      ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ${NC}"
    
    echo -e "  ${G}───────────────────────────────────────────────────────────────────────────${NC}"
    
    # System Metrics
    echo -e "  ${W}System Vitality:${NC}"
    printf "  ${G}CPU:${NC} ${B_CYAN}%-4s${NC} ${G}RAM:${NC} ${B_PURPLE}%-4s${NC} ${G}Disk:${NC} ${B_GREEN}%-4s${NC}\n" "$CPU%" "$RAM%" "$DISK"
    echo -e ""

    # Menu Options
    echo -e "  ${B_CYAN}  VIRTUALIZATION & TOOLS${NC}"
    echo -e "  ${G}├─ ${W}[1]${NC} RDX/IDX Tool Setup         ${G}├─ ${W}[4]${NC} Panel Control Center"
    echo -e "  ${G}├─ ${W}[2]${NC} Launch VM-1 (KVM Mode)     ${G}├─ ${W}[5]${NC} LXC/LXD Container Manager"
    echo -e "  ${G}└─ ${W}[3]${NC} Launch VM-2 (No-KVM)       ${G}└─ ${W}[6]${NC} Docker Engine Setup"
    echo -e ""
    
    echo -e "  ${B_PURPLE}  SYSTEM EXIT${NC}"
    echo -e "  ${G}└─ ${B_RED}${NC}${BG_SHADE}${W} [0] EXIT SESSION ${NC}${B_RED}${NC}"
    
    echo -e "\n  ${G}───────────────────────────────────────────────────────────────────────────${NC}"
    echo -ne "  ${B_CYAN}➜${NC} ${W}Command${NC} ${G}(0-6):${NC} "
}

# --- MAIN LOOP ---
while true; do
    render_ui
    read -r opt
    case $opt in
        1) # Setup IDX
           echo -e "\n  ${B_CYAN}🔧 Initializing RDX/IDX...${NC}"
           mkdir -p "$HOME/vm/.idx"
           cd "$HOME/vm/.idx" || return
           cat <<EOF > dev.nix
{ pkgs, ... }: {
  channel = "stable-24.05";
  packages = with pkgs; [
    unzip
    openssh
    git
    qemu_kvm
    btop
    sudo
    cdrkit
    cloud-utils
    qemu
  ];
  env = {
    EDITOR = "nano";
  };
  idx = {
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];
    workspace = {
      onCreate = { };
      onStart = { };
    };
    previews = {
      enable = false;
    };
  };
}
EOF
           echo -e "  ${B_GREEN}✅ dev.nix configured.${NC}"; pause ;;
        2) bash <(curl -s https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/vps/vm-1.sh); pause ;;
        3) bash <(curl -s https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/vps/auto.sh)
           bash <(curl -s https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/vps/vm-2.sh); pause ;;
        4) panel_menu ;;
        5) bash <(curl -s https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/vps/lxc.sh); pause ;;
        6) bash <(curl -s https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/vps/Docker.sh); pause ;;
        0) echo -e "\n  ${B_RED}Terminating session...${NC} Goodbye, Nobita."; exit 0 ;;
        *) echo -e "  ${B_RED}Error: Input not valid.${NC}"; sleep 0.7 ;;
    esac
done
