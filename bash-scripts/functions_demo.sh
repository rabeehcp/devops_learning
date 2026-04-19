#!/bin/bash
# -----------------------------------------------
# Script: functions_demo.sh
# Purpose: Learn functions in bash
# -----------------------------------------------

# ✅ HOW A FUNCTION WORKS:
# 1. You DEFINE it first (the block of code)
# 2. You CALL it by name whenever you need it

# ------------------------------
# FUNCTION 1: Simple greeting
# ------------------------------
greet_user() {
    echo "👋 Hello, $1!"       # $1 = first argument passed
    echo "🕐 Time: $(date +%T)"
}

# ------------------------------
# FUNCTION 2: Create a project folder structure
# ------------------------------
create_project() {
    PROJECT_NAME=$1            # $1 is the name you pass in

    echo ""
    echo "📁 Creating project: $PROJECT_NAME"

    mkdir -p "$PROJECT_NAME"/{src,tests,logs,configs,scripts}
    touch "$PROJECT_NAME/README.md"
    touch "$PROJECT_NAME/configs/config.yml"
    touch "$PROJECT_NAME/scripts/deploy.sh"

    echo "✅ Project '$PROJECT_NAME' created successfully!"
    echo ""
    echo "📂 Structure:"
    find "$PROJECT_NAME" -type f
}

# ------------------------------
# FUNCTION 3: Check if a command exists on the system
# (Used heavily in real DevOps scripts)
# ------------------------------
check_command() {
    COMMAND=$1

    if command -v "$COMMAND" &> /dev/null; then
        echo "✅ $COMMAND is installed → $(which $COMMAND)"
    else
        echo "❌ $COMMAND is NOT installed"
    fi
}

# ------------------------------
# FUNCTION 4: Return a value from function
# ------------------------------
get_disk_usage() {
    USAGE=$(df / | awk 'NR==2 {print $5}')
    echo "$USAGE"              # this is how bash "returns" a value
}

# ==============================
#  MAIN SCRIPT — calls functions
# ==============================
echo "================================"
echo "   🔧 DevOps Functions Demo"
echo "================================"

# Call FUNCTION 1 — pass your name as argument
greet_user "DevOps Learner"

# Call FUNCTION 2 — create a real project
create_project "my-app"

# Call FUNCTION 3 — check common DevOps tools
echo "🔍 Checking installed tools:"
check_command "git"
check_command "docker"
check_command "curl"
check_command "python3"

# Call FUNCTION 4 — capture returned value
echo ""
DISK=$(get_disk_usage)
echo "💽 Current disk usage: $DISK"

echo ""
echo "🎉 All functions executed successfully!"
