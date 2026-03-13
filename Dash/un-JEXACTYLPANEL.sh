#!/bin/bash

# Colors for UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# ASCII Art for Jexactyl
show_header() {
    clear
    echo -e "${PURPLE}╔══════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}${CYAN}       ██╗███████╗██╗  ██╗ █████╗  ██████╗ ████████╗██╗   ██╗${NC}${PURPLE}║${NC}"
    echo -e "${PURPLE}║${NC}${CYAN}       ██║██╔════╝╚██╗██╔╝██╔══██╗██╔════╝ ╚══██╔══╝╚██╗ ██╔╝${NC}${PURPLE}║${NC}"
    echo -e "${PURPLE}║${NC}${CYAN}       ██║█████╗   ╚███╔╝ ███████║██║  ███╗   ██║    ╚████╔╝ ${NC}${PURPLE}║${NC}"
    echo -e "${PURPLE}║${NC}${CYAN}  ██   ██║██╔══╝   ██╔██╗ ██╔══██║██║   ██║   ██║     ╚██╔╝  ${NC}${PURPLE}║${NC}"
    echo -e "${PURPLE}║${NC}${CYAN}  ╚█████╔╝███████╗██╔╝ ██╗██║  ██║╚██████╔╝   ██║      ██║   ${NC}${PURPLE}║${NC}"
    echo -e "${PURPLE}║${NC}${CYAN}   ╚════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝    ╚═╝      ╚═╝   ${NC}${PURPLE}║${NC}"
    echo -e "${PURPLE}╠══════════════════════════════════════════════╣${NC}"
    echo -e "${PURPLE}║${NC}${BOLD}            J E X A C T Y L   P A N E L          ${NC}${PURPLE}║${NC}"
    echo -e "${PURPLE}╚══════════════════════════════════════════════╝${NC}"
    echo ""
}

while true; do
    show_header
    
    # Menu Options
    echo -e "${CYAN}┌────────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│${NC} ${GREEN}📦${NC} ${BOLD}1.${NC} Install       ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC} ${RED}🗑️${NC} ${BOLD}2.${NC} Uninstall      ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC} ${YELLOW}🔄${NC} ${BOLD}3.${NC} Update          ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC} ${BLUE}🚪${NC} ${BOLD}4.${NC} Exit Menu                       ${CYAN}│${NC}"
    echo -e "${CYAN}├────────────────────────────────────────────┤${NC}"
    echo -e "${CYAN}│${NC} ${PURPLE}💡${NC} Need help? Check docs: jexactyl.com      ${CYAN}│${NC}"
    echo -e "${CYAN}└────────────────────────────────────────────┘${NC}"
    echo ""
    
    read -p "$(echo -e "${YELLOW}🎯 Select option [1-4]:${NC} ")" choice

    case "$choice" in
        1)
            echo -e "\n${GREEN}══════════════════════════════════════════════${NC}"
            echo -e "${GREEN}           📥 INSTALLATION STARTING            ${NC}"
            echo -e "${GREEN}══════════════════════════════════════════════${NC}"
            echo -e "${CYAN}Installing Jexactyl Panel...${NC}"
            echo -e "${YELLOW}This may take a few minutes. Please wait...${NC}\n"
            
            bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/panel/Jexactyl.sh)
            
            echo -e "\n${GREEN}✅ Installation process completed!${NC}"
            ;;
            
        2)
            echo -e "\n${RED}══════════════════════════════════════════════${NC}"
            echo -e "${RED}           ⚠️  UNINSTALL WARNING!                ${NC}"
            echo -e "${RED}══════════════════════════════════════════════${NC}"
            echo -e "${YELLOW}This will completely remove Jexactyl from your system.${NC}"
            echo -e "${RED}All data including database will be deleted!${NC}\n"
            
            read -p "$(echo -e "${RED}Are you sure? (y/N):${NC} ")" confirm
            
            if [[ $confirm == "y" || $confirm == "Y" ]]; then
                echo -e "\n${RED}🗑️  Starting uninstall process...${NC}"
                
                # Stop and disable service
                echo -e "${YELLOW}Stopping services...${NC}"
                systemctl stop jxctl.service 2>/dev/null
                systemctl disable jxctl.service 2>/dev/null
                rm -f /etc/systemd/system/jxctl.service 2>/dev/null
                systemctl daemon-reload 2>/dev/null
                
                # Remove nginx config
                echo -e "${YELLOW}Removing nginx configuration...${NC}"
                rm -f /etc/nginx/sites-available/jexactyl.conf 2>/dev/null
                rm -f /etc/nginx/sites-enabled/jexactyl.conf 2>/dev/null
                nginx -s reload 2>/dev/null
                
                # Remove database
                echo -e "${YELLOW}Removing database...${NC}"
                mysql -u root -p -e "
                DROP DATABASE IF EXISTS jexactyldb;
                DROP USER IF EXISTS 'jexactyluser'@'127.0.0.1';
                FLUSH PRIVILEGES;
                " 2>/dev/null
                
                # Remove cron jobs
                echo -e "${YELLOW}Cleaning up cron jobs...${NC}"
                sudo crontab -l | grep -v 'php /var/www/jexactyl/artisan schedule:run' | sudo crontab - || true
                
                # Remove files
                echo -e "${YELLOW}Removing panel files...${NC}"
                rm -rf /var/www/jexactyl 2>/dev/null
                
                echo -e "\n${GREEN}══════════════════════════════════════════════${NC}"
                echo -e "${GREEN}           ✅ UNINSTALL COMPLETE!              ${NC}"
                echo -e "${GREEN}══════════════════════════════════════════════${NC}"
                echo -e "${CYAN}Jexactyl has been completely removed from your system.${NC}"
                echo -e "${GREEN}Server is now clean and ready for new installations.${NC}"
            else
                echo -e "${YELLOW}❌ Uninstall cancelled.${NC}"
            fi
            ;;
            
        3)
            echo -e "\n${YELLOW}══════════════════════════════════════════════${NC}"
            echo -e "${YELLOW}           🔄 UPDATE STARTING                  ${NC}"
            echo -e "${YELLOW}══════════════════════════════════════════════${NC}"
            
            # Check if Jexactyl is installed
            if [ ! -d "/var/www/jexactyl" ]; then
                echo -e "${RED}❌ Jexactyl directory not found!${NC}"
                echo -e "${YELLOW}Please install Jexactyl first using option 1.${NC}"
                read -p "Press Enter to continue..."
                continue
            fi
            
            cd /var/www/jexactyl
            
            echo -e "${CYAN}Putting panel in maintenance mode...${NC}"
            php artisan down
            
            echo -e "${CYAN}Downloading latest release...${NC}"
            curl -Lo panel.tar.gz https://github.com/jexactyl/jexactyl/releases/download/v4.0.0-rc2/panel.tar.gz
            
            echo -e "${CYAN}Extracting files...${NC}"
            tar -xzvf panel.tar.gz
            
            echo -e "${CYAN}Setting permissions...${NC}"
            chmod -R 755 storage/* bootstrap/cache/
            
            echo -e "${CYAN}Installing dependencies...${NC}"
            COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader
            
            echo -e "${CYAN}Optimizing and migrating...${NC}"
            php artisan optimize:clear
            php artisan migrate --seed --force
            
            echo -e "${CYAN}Setting ownership...${NC}"
            chown -R www-data:www-data /var/www/jexactyl/
            
            echo -e "${CYAN}Bringing panel back online...${NC}"
            php artisan up
            
            echo -e "\n${GREEN}══════════════════════════════════════════════${NC}"
            echo -e "${GREEN}           ✅ UPDATE COMPLETE!                  ${NC}"
            echo -e "${GREEN}══════════════════════════════════════════════${NC}"
            echo -e "${CYAN}Jexactyl has been successfully updated!${NC}"
            echo -e "${GREEN}Panel is now running the latest version.${NC}"
            ;;
            
        4)
            echo -e "\n${BLUE}══════════════════════════════════════════════${NC}"
            echo -e "${BLUE}           👋 GOODBYE!                         ${NC}"
            echo -e "${BLUE}══════════════════════════════════════════════${NC}"
            echo -e "${CYAN}Thank you for using Jexactyl Panel Manager${NC}"
            echo -e "${BLUE}Server console signing off... 🌙${NC}\n"
            exit 0
            ;;
            
        *)
            echo -e "\n${RED}══════════════════════════════════════════════${NC}"
            echo -e "${RED}           ❌ INVALID OPTION!                   ${NC}"
            echo -e "${RED}══════════════════════════════════════════════${NC}"
            echo -e "${YELLOW}Please select a valid option between 1 and 4.${NC}"
            ;;
    esac

    echo ""
    read -p "$(echo -e "${CYAN}Press ${BOLD}Enter${NC}${CYAN} to return to menu...${NC}")" dummy
done
