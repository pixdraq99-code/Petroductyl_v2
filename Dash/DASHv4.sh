#!/bin/bash

clear
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔰 MythicalDash Script"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1️⃣  Install (nothing happens)"
echo "2️⃣  Uninstall (full cleanup)"
echo ""
read -p "👉 Choose option [1-2]: " ACTION

############################################
# INSTALL — DO NOTHING
############################################
if [ "$ACTION" == "1" ]; then
    echo ""
    echo "😌 Install mode selected."
    bash <(curl -s https://raw.githubusercontent.com/nobita54/-150/refs/heads/main/panel/Dashboard-v4.sh)
    echo "Nothing to install. Silence is golden ✨"
    echo "Exiting peacefully..."
    exit 0
fi

############################################
# UNINSTALL — FULL CLEANUP
############################################
if [ "$ACTION" == "2" ]; then

echo ""
echo "🧹 Uninstalling MythicalDash..."
sleep 1

# REMOVE PANEL FILES
rm -rf /var/www/mythicaldash-v3

# REMOVE NGINX CONFIG
rm -f /etc/nginx/sites-enabled/MythicalDashRemastered.conf
rm -f /etc/nginx/sites-available/MythicalDashRemastered.conf

# REMOVE SSL CERTS
rm -rf /etc/certs/MythicalDash-4

# REMOVE CRON JOBS (ONLY MYTHICALDASH)
crontab -l 2>/dev/null \
| grep -v "/var/www/mythicaldash-v3/backend/storage/cron/runner.bash" \
| grep -v "/var/www/mythicaldash-v3/backend/storage/cron/runner.php" \
| crontab -

# DROP DATABASE & USER
mariadb -e "DROP DATABASE IF EXISTS mythicaldash_remastered;"
mariadb -e "DROP USER IF EXISTS 'mythicaldash_remastered'@'127.0.0.1';"
mariadb -e "FLUSH PRIVILEGES;"

# OPTIONAL: REMOVE PACKAGES

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ MythicalDash fully removed"
echo "Install = empty. Uninstall = complete."
echo "Perfectly balanced, as all scripts should be ⚖️"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
exit 0
fi

echo "❌ Invalid option selected"
exit 1
