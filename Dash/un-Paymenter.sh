#!/bin/bash

# Colors for UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# UI Elements
TOP="╔════════════════════════════════════════════════════════════╗"
BOTTOM="╚════════════════════════════════════════════════════════════╝"

show_header() {
    clear
    printf "${CYAN}${TOP}\n"
    printf "║${WHITE}                  🚀 PAYMENTER CONTROL PANEL                 ${CYAN}║\n"
    printf "╠════════════════════════════════════════════════════════════╣\n"
    printf "║${YELLOW}            Version 2.0 • Secure Panel Manager              ${CYAN}║\n"
    printf "${BOTTOM}${NC}\n\n"
}

show_menu() {
    printf "${MAGENTA}╔════════════════════════════════════════════════════════════╗\n"
    printf "║${WHITE}                     📋 MAIN MENU                          ${MAGENTA}║\n"
    printf "╠════════════════════════════════════════════════════════════╣\n"
    printf "║${GREEN}   1. ${WHITE}📥 Install Paymenter         ${MAGENTA}║\n"
    printf "║${RED}   2. ${WHITE}🗑️  Uninstall Paymenter                        ${MAGENTA}║\n"
    printf "║${YELLOW}   3. ${WHITE}🔄 Update Paymenter                          ${MAGENTA}║\n"
    printf "║${WHITE}   4. ${WHITE}❌ Exit                                      ${MAGENTA}║\n"
    printf "╚════════════════════════════════════════════════════════════╝${NC}\n\n"
}

install_paymenter() {
    printf "${GREEN}╔════════════════════════════════════════════════════════════╗\n"
    printf "║${WHITE}               📥 INSTALLING PAYMENTER                   ${GREEN}║\n"
    printf "╠════════════════════════════════════════════════════════════╣${NC}\n"
    
    echo "🚀 Starting Paymenter installation..."
    echo "⚙️  Setting up ad-blocker first..."
    echo "📦 Proceeding with Paymenter installation..."
    echo "⏳ This may take a few minutes..."
    
    # Run the Paymenter install script
    bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/panel/Payment.sh)
    
    printf "${GREEN}║                                                              ║\n"
    printf "║${WHITE}          ✅ INSTALLATION PROCESS COMPLETE!              ${GREEN}║\n"
    printf "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}\n"
}

uninstall_paymenter() {
    printf "${RED}╔════════════════════════════════════════════════════════════╗\n"
    printf "║${WHITE}               ⚠️ UNINSTALLING PAYMENTER                 ${RED}║\n"
    printf "╠════════════════════════════════════════════════════════════╣${NC}\n"
    
    echo "🗑️  Removing Paymenter files..."
    sudo rm -rf /var/www/paymenter
    
    echo "🗑️  Removing database..."
    sudo mysql -u root -e "DROP DATABASE IF EXISTS paymenter;" 2>/dev/null
    sudo mysql -u root -e "DROP USER IF EXISTS 'paymenteruser'@'127.0.0.1';" 2>/dev/null
    sudo mysql -u root -e "FLUSH PRIVILEGES;" 2>/dev/null
    
    echo "🗑️  Removing cron jobs..."
    sudo crontab -l | grep -v 'php /var/www/paymenter/artisan schedule:run' | sudo crontab - || true
    
    echo "🗑️  Removing service..."
    sudo rm -f /etc/systemd/system/paymenter.service
    
    echo "🗑️  Removing nginx configuration..."
    [ -f /etc/nginx/sites-enabled/paymenter.conf ] && sudo rm -f /etc/nginx/sites-enabled/paymenter.conf
    [ -f /etc/nginx/sites-available/paymenter.conf ] && sudo rm -f /etc/nginx/sites-available/paymenter.conf
    
    echo "🗑️  Removing ad-blocker files..."
    sudo rm -rf /etc/nginx/adblock
    sudo rm -f /etc/nginx/conf.d/adblock.conf
    
    echo "🔄 Reloading services..."
    sudo systemctl reload nginx || true
    
    printf "${GREEN}║                                                              ║\n"
    printf "║${WHITE}          ✅ PAYMENTER COMPLETELY REMOVED!               ${GREEN}║\n"
    printf "${RED}╚════════════════════════════════════════════════════════════╝${NC}\n"
}

update_paymenter() {
    printf "${YELLOW}╔════════════════════════════════════════════════════════════╗\n"
    printf "║${WHITE}               🔄 UPDATING PAYMENTER                     ${YELLOW}║\n"
    printf "╠════════════════════════════════════════════════════════════╣${NC}\n"
    
    if [ ! -d "/var/www/paymenter" ]; then
        echo "❌ Paymenter is not installed!"
        return
    fi
    
    echo "📁 Changing to Paymenter directory..."
    cd /var/www/paymenter
    
    echo "⚙️  Running upgrade command..."
    php artisan app:upgrade
    
    printf "${GREEN}║                                                              ║\n"
    printf "║${WHITE}          ✅ PAYMENTER UPDATED SUCCESSFULLY!             ${GREEN}║\n"
    printf "${YELLOW}╚════════════════════════════════════════════════════════════╝${NC}\n"
}

# Main loop
while true; do
    show_header
    show_menu
    
    printf "${CYAN}┌─[${WHITE}SELECT OPTION${CYAN}]${NC}\n"
    printf "${CYAN}└──╼${WHITE} $ ${NC}"
    read -p "" option
    
    case $option in
        1)
            install_paymenter
            ;;
        2)
            uninstall_paymenter
            ;;
        3)
            update_paymenter
            ;;
        4)
            printf "\n${CYAN}╔════════════════════════════════════════════════════════════╗\n"
            printf "║${WHITE}                    👋 GOODBYE!                          ${CYAN}║\n"
            printf "╚════════════════════════════════════════════════════════════╝${NC}\n\n"
            exit 0
            ;;
        *)
            printf "\n${RED}❌ Invalid option! Please select 1-4${NC}\n"
            ;;
    esac
    
    echo ""
    read -p "Press Enter to return to menu..."
done
