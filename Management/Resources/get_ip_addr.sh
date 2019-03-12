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
QUERY_LOGGING=true
INSTALL_WEB=true
DNSMASQ_LISTENING=single
PIHOLE_DNS_1=8.8.8.8
PIHOLE_DNS_2=8.8.4.4
PIHOLE_DNS_3=2620:fe::fe  # Secure: Blocklist, DNSSEC, No EDNS Client-Subnet
PIHOLE_DNS_4=2620:fe::9   # Secure: Blocklist, DNSSEC, No EDNS Client-Subnet
DNS_FQDN_REQUIRED=true
DNS_BOGUS_PRIV=true
DNSSEC=true
TEMPERATUREUNIT=C
WEBUIBOXEDLAYOUT=traditional
API_QUERY_LOG_SHOW=all
API_PRIVACY_MODE=false
WEBPASSWORD=15902C25D3DD400EF3E857E5F1CC998ADF2FD1D932848B939383E5300A87A14C
EOL
