#!/bin/bash

# Enhanced Colors for UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
PURPLE='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# UI Elements
BOLD='\033[1m'
UNDERLINE='\033[4m'

# Function to print section headers
print_header() {
    echo -e "\n${PURPLE}${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}${BOLD}║${CYAN} $1 ${PURPLE}║${NC}"
    echo -e "${PURPLE}${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}\n"
}

# Function to print status messages
print_status() {
    echo -e "${YELLOW}${BOLD}[~]${NC} $1..."
}

print_success() {
    echo -e "${GREEN}${BOLD}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}${BOLD}[✗]${NC} $1"
}

print_warning() {
    echo -e "${MAGENTA}${BOLD}[!]${NC} $1"
}

print_info() {
    echo -e "${BLUE}${BOLD}[i]${NC} $1"
}

# Function to show progress bar
progress_bar() {
    local duration=$1
    local steps=10
    local step_delay=$(echo "scale=3; $duration/$steps" | bc -l 2>/dev/null || echo "0.1")
    
    echo -ne "${BLUE}["
    for ((i=0; i<steps; i++)); do
        echo -ne "█"
        sleep $step_delay
    done
    echo -e "]${NC}"
}

# Function to animate text
animate_text() {
    local text=$1
    echo -ne "${CYAN}"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.03
    done
    echo -e "${NC}"
}

# Function to check if command succeeded
check_success() {
    if [ $? -eq 0 ]; then
        print_success "$1"
        return 0
    else
        print_error "$2"
        return 1
    fi
}

# Clear screen and show enhanced welcome message
clear
echo -e "${PURPLE}"
echo -e "╔══════════════════════════════════════════════════════════════╗"
echo -e "║${CYAN}                                                          ${PURPLE}║"
echo -e "║${CYAN}           🔐 SSH CONFIGURATION TOOL                     ${PURPLE}║"
echo -e "║${CYAN}                 by Nobita-hosting                       ${PURPLE}║"
echo -e "║${WHITE}               With Enhanced UI                          ${PURPLE}║"
echo -e "║${CYAN}                                                          ${PURPLE}║"
echo -e "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if running as root
print_status "Checking root privileges"
if [ "$EUID" -ne 0 ]; then
    print_error "Please run this script as root or with sudo"
    exit 1
fi
print_success "Root privileges confirmed"

CONFIG_FILE="/etc/ssh/sshd_config"

print_header "SSH CONFIGURATION BACKUP"
print_status "Creating backup of SSH configuration"
cp "$CONFIG_FILE" "${CONFIG_FILE}.bak" 2>/dev/null
check_success "Backup created at ${CONFIG_FILE}.bak" "Failed to create backup"

print_header "ENABLING ROOT LOGIN"
print_status "Configuring PermitRootLogin"
sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' "$CONFIG_FILE" 2>/dev/null
sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' "$CONFIG_FILE" 2>/dev/null
grep -q "^PermitRootLogin" "$CONFIG_FILE" 2>/dev/null || echo "PermitRootLogin yes" >> "$CONFIG_FILE"
check_success "Root login enabled" "Failed to enable root login"

print_header "ENABLING PASSWORD AUTHENTICATION"
print_status "Configuring PasswordAuthentication"
# Remove any existing PasswordAuthentication settings
sed -i '/^#PasswordAuthentication/d' "$CONFIG_FILE" 2>/dev/null
sed -i '/^PasswordAuthentication/d' "$CONFIG_FILE" 2>/dev/null
# Add the new setting
echo "PasswordAuthentication yes" >> "$CONFIG_FILE" 2>/dev/null
check_success "Password authentication enabled" "Failed to enable password authentication"

print_header "RESTARTING SSH SERVICE"
print_status "Restarting SSH service"
systemctl restart ssh 2>/dev/null
progress_bar 3
check_success "SSH service restarted successfully" "Failed to restart SSH service"

# Show configuration summary
print_header "CONFIGURATION SUMMARY"
echo -e "${GREEN}${BOLD}Current SSH Configuration:${NC}"
echo -e "${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
grep -E "^(PermitRootLogin|PasswordAuthentication)" "$CONFIG_FILE" 2>/dev/null | while read line; do
    echo -e "  ${CYAN}•${NC} ${GREEN}$line${NC}"
done
echo -e "${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

print_header "NEXT STEPS REQUIRED"
echo -e "${YELLOW}${BOLD}📋 Manual action required:${NC}"
echo -e ""
echo -e "  ${CYAN}1.${NC} ${GREEN}Set a root password using this command:${NC}"
echo -e "     ${MAGENTA}sudo passwd root${NC}"
echo -e ""
echo -e "  ${CYAN}2.${NC} ${GREEN}Test SSH connection:${NC}"
echo -e "     ${MAGENTA}ssh root@your-server-ip${NC}"
echo -e ""
echo -e "  ${CYAN}3.${NC} ${YELLOW}For security, consider:${NC}"
echo -e "     ${CYAN}•${NC} Using SSH keys instead of passwords"
echo -e "     ${CYAN}•${NC} Changing the default SSH port"
echo -e "     ${CYAN}•${NC} Using fail2ban for brute force protection"
echo -e ""
echo -e "${MAGENTA}${BOLD}⚠️  Security Note:${NC}"
echo -e "  ${RED}Enabling root login with password can be a security risk.${NC}"
echo -e "  ${YELLOW}Make sure to use a strong password and consider additional security measures.${NC}"

print_header "QUICK COMMAND REFERENCE"
echo -e "${GREEN}${BOLD}Essential Commands:${NC}"
echo -e "  ${CYAN}•${NC} Set root password: ${MAGENTA}passwd root${NC}"
echo -e "  ${CYAN}•${NC} Check SSH status: ${MAGENTA}systemctl status ssh${NC}"
echo -e "  ${CYAN}•${NC} View SSH config: ${MAGENTA}grep -E '(PermitRootLogin|PasswordAuthentication)' /etc/ssh/sshd_config${NC}"
echo -e ""
echo -e "${GREEN}${BOLD}Security Commands:${NC}"
echo -e "  ${CYAN}•${NC} Install fail2ban: ${MAGENTA}apt install fail2ban${NC}"
echo -e "  ${CYAN}•${NC} Change SSH port: ${MAGENTA}sed -i 's/^#Port 22/Port 2222/' /etc/ssh/sshd_config${NC}"

# Final completion message with animation
echo -e ""
print_header "INSTALLATION COMPLETE"
echo -e "${GREEN}"
animate_text "🎉 SSH Configuration Completed Successfully!"
echo -e "${NC}"

echo -e ""
echo -e "${CYAN}${BOLD}Summary of Changes:${NC}"
echo -e "  ${GREEN}✓${NC} Root login enabled (PermitRootLogin yes)"
echo -e "  ${GREEN}✓${NC} Password authentication enabled"
echo -e "  ${GREEN}✓${NC} SSH service restarted"
echo -e "  ${GREEN}✓${NC} Configuration backup created"
echo -e ""

echo -e "${YELLOW}${BOLD}Important Reminders:${NC}"
echo -e "  ${CYAN}•${NC} ${WHITE}Set a strong root password immediately${NC}"
echo -e "  ${CYAN}•${NC} ${WHITE}Consider using SSH keys for better security${NC}"
echo -e "  ${CYAN}•${NC} ${WHITE}Monitor SSH access logs regularly${NC}"
echo -e ""

echo -e "${PURPLE}${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}${BOLD}║${WHITE}           Thank you for using GuideCloud!           ${PURPLE}║${NC}"
echo -e "${PURPLE}${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"

# Enhanced wait for user with better styling
echo -e ""
echo -e "${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -p "$(echo -e "${YELLOW}${BOLD}Press Enter to exit...${NC}")" -n 1
echo -e ""
