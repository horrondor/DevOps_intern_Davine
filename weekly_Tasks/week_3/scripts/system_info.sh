#!/bin/bash

echo "================================"
echo "      System Information    "
echo "================================"

echo "Hostname: $(hostname)"
echo "Operating System: $(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')"
echo "Kernel Version: $(uname -r)"
echo "Architecture :$(uname -m)"
echo "Uptime : $(uptime -p)"
echo "Current User: $(whoami)"
echo "Ip Address: $(hostname -I | awk '{print $1}')"
echo "Current Date: $(date)"


# CPU

echo 
echo "-------- CPU --------"
echo "CPU Cores: $(nproc)"
echo "CPU Model: $(lscpu | grep 'Model name' | cut -d: -f2 | xargs)"
echo "CPU Architecture: $(lscpu | grep Architecture | awk '{print $2}')"
echo "CPU Load : $(uptime | awk -F'load average:' '{print $2}')"



# Memory

echo 
echo "---------- Memory ---------"
free -h 

# Disk

echo 
echo "---------- Disk Usage --------"
df -Th --exclude-type=tmpfs --exclude-type=devtmpfs

# Network
echo 
echo "--- Network ---"
echo "IP Addresses:"
ip -br addr

echo 
echo "Default gateway:"
ip route | grep default


# Block Devices

echo
echo "--- Block Devices ---"
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS


# Logged-in users
echo 
echo "--- Logged-in users ---"
who

# Processes
echo "--- Top Processes by CPU --- "
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 11

echo
echo "--- Top Processes by Memory ---"
ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -n 11

# Services
echo 
echo "--- Failed Systemd Services  ---"
systemctl --failed --no-legend 2>/dev/null

# Environment
echo 
echo "--- Environment ---"
echo "Shell : $SHELL"
echo "User : $USER"
echo "Home: $Home"
echo "PATH : $PATH"

# System Load
echo
echo "---------- SYSTEM LOAD -----------"
uptime

echo 
echo "===================================="
echo "          END OF SYSTEM INFORMATION"
echo "===================================="
