# Network

#Create a Script to show all of your networks processes

ip_address=$(ip addr |
gateway=$(ip route | grep gefault | awk '{print $3}'
subnet_mask=$(ip -o -4 addr show dev $(ip route| awk '$1=="default" {print $5}') | awk {print $4}'
