#!/bin/bash
# -----------------------------------------------
# Script: bulk_creator.sh
# Purpose: Create multiple files/folders in bulk
# (Real use: creating log dirs, env folders)
# -----------------------------------------------

ENVIRONMENTS=("development" "staging" "production")

echo "📁 Creating environment folders..."

for ENV in "${ENVIRONMENTS[@]}"; do
    mkdir -p "project/$ENV/logs"
    mkdir -p "project/$ENV/configs"
    touch "project/$ENV/configs/app.conf"
    echo "  ✅ Created: project/$ENV/"
done

echo ""
echo "📂 Final structure:"
find project -type f
