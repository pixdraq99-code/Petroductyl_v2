#!/bin/bash

# ===== COLORS =====
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
NC="\033[0m"

while true; do
    clear
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════╗"
    echo "║        🐲 JEXACTYL MANAGER            ║"
    echo "╠══════════════════════════════════════╣"
    echo -e "║ ${GREEN}1)${NC} Install / Update Panel         ║"
    echo -e "║ ${RED}2)${NC} Uninstall / Restore Backup     ║"
    echo -e "║ ${YELLOW}3)${NC} Exit                           ║"
    echo "╠══════════════════════════════════════╣"
    echo -e "║  Panel Control • Clean • Stable     ║"
    echo "╚══════════════════════════════════════╝"
    echo -ne "${BLUE}Select an option → ${NC}"
    read choice

    case $option in

        1)
            echo "🔰 Starting Install / Update Process..."

            # === Backup Phase ===
            cp -R /var/www/pterodactyl /var/www/pterodactyl-backup
            mysqldump -u root -p panel > /var/www/pterodactyl-backup/panel.sql

            # === Update Phase ===
            cd /var/www/pterodactyl
            php artisan down

            curl -L -o panel.tar.gz https://github.com/jexactyl/jexactyl/releases/latest/download/panel.tar.gz
            tar -xzvf panel.tar.gz && rm -f panel.tar.gz

            chmod -R 755 storage/* bootstrap/cache
            COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader

            php artisan optimize:clear
            php artisan migrate --seed --force

            chown -R www-data:www-data /var/www/pterodactyl/*

            php artisan queue:restart
            php artisan up

            echo "-----------------------------"
            echo "🎉 Panel Updated Successfully!"
            echo "Backup Safe & New Build Running."
            echo "-----------------------------"
            ;;

        2)
            echo "⚠ Restoring Backup & Repairing Panel..."
            php artisan down
            rm -rf /var/www/pterodactyl
            mv /var/www/pterodactyl-backup /var/www/pterodactyl
            cd /var/www/pterodactyl

            chmod -R 755 storage/* bootstrap/cache
            COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader

            echo "🧹 Clearing cache..."
            php artisan view:clear
            php artisan config:clear

            echo "📂 Running migrations..."
            php artisan migrate --seed --force

            echo "👤 Setting ownership..."
            chown -R www-data:www-data /var/www/pterodactyl/*

            echo "♻ Restarting queue..."
            php artisan queue:restart

            echo "🚀 Panel Restored & Back Online."
            php artisan up
            ;;

        3)
            echo "Exit — script closed."
            exit 0
            ;;

        *)
            echo "Invalid option — choose 1–3 only."
            ;;
    esac

    echo
    read -p "Press Enter to return..."
done
