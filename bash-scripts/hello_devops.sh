#!/bin/bash
# -----------------------------------------------
# Script: hello_devops.sh
# Purpose: Learn basic bash scripting concepts
# -----------------------------------------------

# Variables
NAME="DevOps Engineer"
DATE=$(date +"%Y-%m-%d %H:%M:%S")

echo "=============================="
echo "  Welcome, $NAME!"
echo "  Current Date/Time: $DATE"
echo "=============================="

# Check OS info (useful in real servers)
echo ""
echo "📌 System Info:"
echo "  OS: $(uname -o)"
echo "  Hostname: $(hostname)"
echo "  Uptime: $(uptime -p)"
