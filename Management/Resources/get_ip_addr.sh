#!/bin/bash

iface=$1

get_iface_addr() {
    iface_addr=$(ip addr show $iface | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
}

while true ; do
    echo "Trying to get $iface IP address..."
    get_iface_addr

    if [ -z $iface_addr ]; then
        sleep 1;
    else
        echo "IP address: $iface_addr"
        break;
    fi
done

echo "Creating Pi-hole conf file"
cat > setupVars.conf <<EOL
PIHOLE_INTERFACE=$iface
IPV4_ADDRESS=$iface_addr/24
IPV6_ADDRESS=
PIHOLE_DNS_1=8.8.8.8
PIHOLE_DNS_2=8.8.4.4
QUERY_LOGGING=true
INSTALL_WEB_SERVER=true
INSTALL_WEB_INTERFACE=true
LIGHTTPD_ENABLED=true
WEBPASSWORD=15902C25D3DD400EF3E857E5F1CC998ADF2FD1D932848B939383E5300A87A14C
EOL
