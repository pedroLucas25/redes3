#!//bin/bash

modprobe ip_conntrack_ftp
modprobe ip_nat_ftp

iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -p icmp --icmp-type 8 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type 8 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# UDP DNS
iptables -A INPUT -i br0 -p udp --sport 53 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o br0 -p udp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
# TCP DNS
iptables -A INPUT -i br0 -p tcp --sport 53 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o br0 -p tcp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT

# Chegando HTTP
iptables -A INPUT -i br0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o br0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
# Saindo HTTP
iptables -A INPUT -i br0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o br0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

# Chegando HTTPS
iptables -A INPUT -i br0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o br0 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT
# Saindo HTTPS
iptables -A INPUT -i br0 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o br0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT



