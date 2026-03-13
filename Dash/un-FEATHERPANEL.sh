#!/bin/bash
set -e

# ==============================
# COLORS + UI
# ==============================
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
NC="\e[0m"

banner() {
clear
echo -e "${CYAN}"
echo "══════════════════════════════════════════════"
echo "        FEATHERPANEL CONTROL MENU"
echo "        GuideCloud | Auto Script"
echo "══════════════════════════════════════════════"
echo -e "${NC}"
}

pause() {
  read -rp "Press Enter to continue..."
}

install_panel() {
  echo -e "${BLUE}▶▶ Starting FeatherPanel INSTALL${NC}"
  sleep 1
  bash <(curl -s https://raw.githubusercontent.com/debraj0997/vm/refs/heads/main/panel/tool/FeatherPanel.sh)
}

uninstall_panel() {
  echo -e "${RED}▶▶ Starting FeatherPanel UNINSTALL${NC}"
  sleep 1

  # SAFE AUTO UNINSTALL (panel only)
  systemctl reload nginx 2>/dev/null || true
  crontab -l 2>/dev/null \
| grep -v "/var/www/featherpanel/backend/storage/cron/runner.bash" \
| grep -v "/var/www/featherpanel/backend/storage/cron/runner.php" \
| crontab -
  rm -rf /var/www/featherpanel
  rm -f /etc/nginx/sites-enabled/FeatherPanel.conf
  rm -f /etc/nginx/sites-available/FeatherPanel.conf
  rm -rf /etc/certs/featherpanel
  mariadb -e "DROP DATABASE IF EXISTS featherpanel;" || true
  mariadb -e "DROP USER IF EXISTS 'featherpanel'@'127.0.0.1';" || true
  mariadb -e "FLUSH PRIVILEGES;" || true
  nginx -t && systemctl reload nginx || true

  echo -e "${GREEN}✔ FeatherPanel uninstalled (dependencies untouched)${NC}"
}

# ==============================
# MENU LOOP
# ==============================
while true; do
  banner
  echo -e "${YELLOW}1) Install FeatherPanel"
  echo "2) Uninstall FeatherPanel"
  echo "3) Exit${NC}"
  echo "──────────────────────────────────────"
  read -rp "Select option → " opt

  case "$opt" in
    1)
      install_panel
      pause
      ;;
    2)
      uninstall_panel
      pause
      ;;
    3)
      echo -e "${GREEN}Bye boss 👋${NC}"
      exit 0
      ;;
    *)
      echo -e "${RED}Invalid option${NC}"
      sleep 1
      ;;
  esac
done
