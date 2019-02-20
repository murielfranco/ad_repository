#!/usr/bin/env bash
set -e
echo "Installing Pi-hole..."

# Install Pi-hole
cd ../Resources && touch setupVars.conf && sudo chmod +x get_ip_addr.sh  &&  sudo ./get_ip_addr.sh ens4
sudo mkdir -p /etc/pihole/
cd ../Resources/ && sudo cp setupVars.conf /etc/pihole
curl -L https://install.pi-hole.net | sudo bash /dev/stdin --unattended



