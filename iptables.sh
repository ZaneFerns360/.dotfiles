#!/usr/bin/env bash
sudo nft flush ruleset
sudo nft add table inet filter

sudo nft add chain inet filter input ' { type filter hook input priority 0; policy accept; }'
sudo nft add chain inet filter forward ' { type filter hook forward priority 0; policy accept; }'
sudo nft add chain inet filter output ' { type filter hook output priority 0; policy accept; }'
sudo sysctl -w net.ipv4.ip_forward=1
