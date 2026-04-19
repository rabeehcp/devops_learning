#!/bin/bash
# -----------------------------------------------
# Script: system_check.sh
# Purpose: Check if system resources are healthy
# -----------------------------------------------

echo "🔍 Running System Health Check..."
echo ""

# Disk usage check
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$DISK_USAGE" -gt 80 ]; then
    echo "⚠️  WARNING: Disk usage is HIGH → ${DISK_USAGE}%"
else
    echo "✅ Disk usage is OK → ${DISK_USAGE}%"
fi

# Memory check
FREE_MEM=$(free -m | awk 'NR==2 {print $4}')
echo "💾 Free Memory: ${FREE_MEM} MB"

# Check if a service is running (e.g., bash itself as demo)
SERVICE="bash"
if pgrep "$SERVICE" > /dev/null; then
    echo "✅ Service '$SERVICE' is running"
else
    echo "❌ Service '$SERVICE' is NOT running"
fi

echo ""
echo "✅ Health check complete!"
