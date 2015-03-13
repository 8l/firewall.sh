#!/bin/sh
# Set default chain policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Accept on localhost
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow established sessions to receive traffic
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Allow SSH remote
# iptables -I INPUT -p tcp --dport 22 -j ACCEPT

iptables-save > /etc/firewall.conf

sed -i '/exit\ 0/i iptables\-restore\ \<\ \/etc\/firewall\.conf' /etc/init.d/network

