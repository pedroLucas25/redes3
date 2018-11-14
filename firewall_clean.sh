#!//bin/bash

iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT