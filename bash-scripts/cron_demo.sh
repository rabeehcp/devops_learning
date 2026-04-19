#!/bin/bash
# -----------------------------------------------
# Script: cron_demo.sh
# Purpose: A script designed to be run by cron
# -----------------------------------------------

LOG_FILE="$HOME/devops-learning/bash-scripts/cron_activity.log"
APP_LOG="$HOME/devops-learning/bash-scripts/app.log"
ERROR_KEYWORDS=("ERROR" "FATAL" "CRITICAL" "FAILED")

write_log() {
    MESSAGE=$1
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$TIMESTAMP] $MESSAGE" >> "$LOG_FILE"
}

scan_logs() {
    TOTAL_ERRORS=0
    for KEYWORD in "${ERROR_KEYWORDS[@]}"; do
        COUNT=$(grep -c "$KEYWORD" "$APP_LOG" 2>/dev/null || echo 0)
        TOTAL_ERRORS=$((TOTAL_ERRORS + COUNT))
    done
    echo "$TOTAL_ERRORS"
}

check_disk() {
    USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
    echo "$USAGE"
}

write_log "====== Cron job started ======"

ERROR_COUNT=$(scan_logs)
if [ "$ERROR_COUNT" -gt 0 ]; then
    write_log "🚨 ALERT: Found $ERROR_COUNT errors in app.log"
else
    write_log "✅ No errors found in app.log"
fi

DISK=$(check_disk)
if [ "$DISK" -gt 80 ]; then
    write_log "⚠️  WARNING: Disk usage is ${DISK}%"
else
    write_log "✅ Disk usage OK: ${DISK}%"
fi

FREE_MEM=$(free -m | awk 'NR==2 {print $4}')
write_log "💾 Free memory: ${FREE_MEM}MB"

write_log "====== Cron job finished ======"
write_log ""
