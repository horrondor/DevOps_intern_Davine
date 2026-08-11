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

echo 
echo "-------- CPU --------"
echo "CPU Cores: $(nproc)"
echo "CPU Model: $(lscpu | grep 'Model name' | cut -d: -f2 | xargs)"

echo 
echo "------- Memory ------"
 free -h 

echo 
echo "------- DISK -----"
df -Th 

echo 
echo "------- SYSTEM LOAD --------"
uptime

