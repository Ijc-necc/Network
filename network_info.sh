#!/bin/bash

current_date=$(date +"%m-%d-%Y") #show the durrent date at the top of the report

filename="/bin/net_script/Network_Info.txt"	#appends the info to the file when run

echo "Network Information (Date: ${current_date})" | tee "${filename}"
echo "--------------------------------------------------" | tee -a "${filename}" #these 2 lines make up the headder

#Call IP, Gateway, Subnet Mask and save them to variables
ip_address=$(ip addr show dev enp0s3 | grep -w inet | awk '{print $2}')	#display the current IP address
gateway=$(ip route | grep default | awk '{print $3}')
subnet_mask=$(ip -o -4 addr show dev $(ip route | awk '$1=="default" {print $5}') | awk '{print $4}')

#DNS server
dns_servers=$(cat /etc/resolv.conf | grep -w nameserver | awk '{print $2}')

#Open Ports
open_ports=$(netstat -tuln | grep 'LISTEN' | awk '{print $4}' | cut -d ':' -f 2)

#Routing Tables
routing_tables=$(ip route show)

#ARP Table
arp_table=$(arp -a)

#Firewall Rules
firewall_rules=$(iptables -L)

#display the network information to the user and saves to Network_Info.txt
echo "-----Network Information-----"
echo "Date: $current_date"

echo -e "\nIP Address: ${ip_address}" | tee -a "${filename}"
echo -e "\nGateway: ${gateway}" | tee -a "${filename}"
echo -e "\nSubnet Mask: ${subnet_mask}" |tee -a "${filename}"
echo -e "\nDNS Servers: " | tee -a "${filename}"
echo "${dns_servers}" | tee -a "${filename}"

echo -e "\nOpenPorts:" | tee -a "${filename}"
echo "${open_ports}" | tee -a "${filename}"

echo -e "\nRouting Table:" | tee -a "${filename}"
echo "${routing_tables}" | tee -a "${filename}"

echo -e "\nARP Table:" | tee -a "${filename}"
echo "${arp_table}" | tee -a "${filename}"

echo -e "\nFirewall Rules: " | tee -a "${filename}"
echo "${firewall_rules}" | tee -a "${filename}"

echo -e "\nNetwork information has been saved to Network_Info.txt located at /bin/net_script/"
