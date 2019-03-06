#!/usr/bin/env bash
set -e
echo "Installing Pi-hole..."

# Install Pi-hole
cd Management/Resources && sudo chmod +x get_ip_addr.sh && sudo ./get_ip_addr.sh ens4 && sudo mkdir -p /etc/pihole/ && sudo cp /home/fende/Management/Resources/setupVars.conf /etc/pihole
sudo curl -sSl https://install.pi-hole.net | sudo bash /dev/stdin --unattended
