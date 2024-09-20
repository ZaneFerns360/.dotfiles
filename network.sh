#!/usr/bin/zsh

# Flush existing rules
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F

# Delete custom chains
sudo iptables -X
sudo iptables -t nat -X
sudo iptables -t mangle -X

# Set default policies
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT

# Enable IP forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# Assuming your virtual network interface is virbr0 and your wireless interface is wlan0
# Replace these if your interfaces are named differently

# Allow forwarding
sudo iptables -A FORWARD -i virbr0 -o wlan0 -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o virbr0 -m state --state ESTABLISHED,RELATED -j ACCEPT

# Set up NAT
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE

# Optional: If you want to allow incoming connections to your VM, you'll need to add port forwarding rules
# For example, to forward incoming connections on port 8080 to your VM's port 80:
# sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 192.168.122.2:80

echo "iptables rules have been flushed and new routing rules have been set up."
