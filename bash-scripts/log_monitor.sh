#!/bin/bash
# -----------------------------------------------
# Script: log_monitor.sh
# Purpose: Monitor log files for errors
# Real DevOps use: Run this on servers to catch
# problems before users notice them!
# -----------------------------------------------

# ==============================
# CONFIGURATION — change these
# ==============================
LOG_FILE="app.log"             # log file to monitor
ERROR_KEYWORDS=("ERROR" "FATAL" "CRITICAL" "FAILED")
MAX_LOG_SIZE=1024              # max size in KB before warning

# ==============================
# FUNCTION 1: Create fake logs
# (simulates a real running app)
# ==============================
generate_fake_logs() {
    echo "📝 Generating fake app logs..."

    cat > "$LOG_FILE" << EOF
2024-01-15 10:00:01 INFO  App started successfully
2024-01-15 10:01:05 INFO  User 'john' logged in
2024-01-15 10:02:10 INFO  Processing request /api/users
2024-01-15 10:03:15 ERROR Cannot connect to database
2024-01-15 10:04:20 INFO  Retrying connection...
2024-01-15 10:05:25 FATAL Database connection timeout
2024-01-15 10:06:30 INFO  User 'sara' logged in
2024-01-15 10:07:35 ERROR Disk space low on /dev/sda1
2024-01-15 10:08:40 INFO  Backup started
2024-01-15 10:09:45 CRITICAL Memory usage above 95%
2024-01-15 10:10:50 INFO  Request completed in 200ms
2024-01-15 10:11:55 FAILED Payment processing error
2024-01-15 10:12:00 INFO  App running normally
EOF

    echo "✅ Log file created: $LOG_FILE"
    echo ""
}

# ==============================
# FUNCTION 2: Check log file exists
# ==============================
check_log_exists() {
    if [ ! -f "$LOG_FILE" ]; then
        echo "❌ ERROR: Log file '$LOG_FILE' not found!"
        echo "   Run this script with --generate flag first"
        exit 1                 # stop the script with error code
    fi
    echo "✅ Log file found: $LOG_FILE"
}

# ==============================
# FUNCTION 3: Scan for errors
# (the core monitoring function)
# ==============================
scan_for_errors() {
    echo ""
    echo "==============================="
    echo "  🔍 Scanning for errors..."
    echo "==============================="

    TOTAL_ERRORS=0             # counter starts at 0

    for KEYWORD in "${ERROR_KEYWORDS[@]}"; do
        # grep searches the file for the keyword
        # -c counts how many lines match
        COUNT=$(grep -c "$KEYWORD" "$LOG_FILE" 2>/dev/null)

        if [ "$COUNT" -gt 0 ]; then
            echo ""
            echo "⚠️  Found $COUNT '$KEYWORD' line(s):"
            # grep -n shows line numbers where errors appear
            grep -n "$KEYWORD" "$LOG_FILE" | while read -r LINE; do
                echo "   → $LINE"
            done
            TOTAL_ERRORS=$((TOTAL_ERRORS + COUNT))
        fi
    done

    echo ""
    echo "==============================="
    if [ "$TOTAL_ERRORS" -gt 0 ]; then
        echo "🚨 TOTAL ISSUES FOUND: $TOTAL_ERRORS"
        echo "   Action needed! Check the logs above."
    else
        echo "✅ No errors found! System is healthy."
    fi
    echo "==============================="
}

# ==============================
# FUNCTION 4: Check log file size
# ==============================
check_log_size() {
    echo ""
    echo "📦 Checking log file size..."

    # du gets file size, awk extracts the number
    SIZE=$(du -k "$LOG_FILE" | awk '{print $1}')

    echo "   Log size: ${SIZE}KB (max allowed: ${MAX_LOG_SIZE}KB)"

    if [ "$SIZE" -gt "$MAX_LOG_SIZE" ]; then
        echo "⚠️  WARNING: Log file is too large! Consider rotating."
    else
        echo "✅ Log size is OK"
    fi
}

# ==============================
# FUNCTION 5: Show log summary
# ==============================
show_summary() {
    echo ""
    echo "==============================="
    echo "  📊 Log Summary"
    echo "==============================="

    TOTAL_LINES=$(wc -l < "$LOG_FILE")
    INFO_COUNT=$(grep -c "INFO" "$LOG_FILE")
    ERROR_COUNT=$(grep -cE "ERROR|FATAL|CRITICAL|FAILED" "$LOG_FILE")

    echo "  Total log lines : $TOTAL_LINES"
    echo "  INFO messages   : $INFO_COUNT"
    echo "  Error messages  : $ERROR_COUNT"
    echo ""

    # Calculate error percentage
    ERROR_PCT=$(( (ERROR_COUNT * 100) / TOTAL_LINES ))
    echo "  Error rate: ${ERROR_PCT}%"

    if [ "$ERROR_PCT" -gt 20 ]; then
        echo "  🚨 Error rate is HIGH — investigate!"
    else
        echo "  ✅ Error rate is acceptable"
    fi
    echo "==============================="
}

# ==============================
# MAIN SCRIPT
# ==============================
echo ""
echo "================================"
echo "  🖥️  DevOps Log Monitor v1.0"
echo "================================"
echo "  Started: $(date)"
echo "================================"
echo ""

# Check if user passed --generate flag
if [ "$1" == "--generate" ]; then
    generate_fake_logs
fi

check_log_exists
scan_for_errors
check_log_size
show_summary

echo ""
echo "✅ Monitoring complete! — $(date)"
