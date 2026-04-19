#!/bin/bash
# -----------------------------------------------
# Script: git_auto.sh
# Purpose: Automate git workflow
# Real use: Save time, avoid mistakes, enforce
# good commit message standards in teams
# -----------------------------------------------

# ==============================
# CONFIGURATION
# ==============================
BRANCH="main"                  # default branch to push to
LOG_FILE="git_auto.log"        # log all git actions

# ==============================
# FUNCTION 1: Write to log
# ==============================
write_log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# ==============================
# FUNCTION 2: Check if inside a git repo
# ==============================
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "❌ ERROR: Not inside a git repository!"
        echo "   Run 'git init' first or cd into your project"
        exit 1
    fi
    echo "✅ Git repository found"
}

# ==============================
# FUNCTION 3: Check for changes
# ==============================
check_changes() {
    # git status --porcelain shows changes in simple format
    # if output is empty → no changes
    if [ -z "$(git status --porcelain)" ]; then
        echo "⚠️  No changes to commit!"
        echo "   Make some changes to your files first"
        exit 0
    fi
    echo "✅ Changes detected — ready to commit"
}

# ==============================
# FUNCTION 4: Show what changed
# ==============================
show_changes() {
    echo ""
    echo "📋 Files changed:"
    # git status --porcelain gives clean output
    git status --porcelain | while read -r LINE; do
        echo "   → $LINE"
    done
    echo ""
}

# ==============================
# FUNCTION 5: Get commit message
# ==============================
get_commit_message() {
    # Check if message was passed as argument
    if [ -n "$1" ]; then
        COMMIT_MSG="$1"
    else
        # Ask user to type a message
        echo "💬 Enter commit message:"
        read -r COMMIT_MSG

        # Make sure message is not empty
        if [ -z "$COMMIT_MSG" ]; then
            echo "❌ Commit message cannot be empty!"
            exit 1
        fi
    fi

    echo "✅ Commit message: '$COMMIT_MSG'"
}

# ==============================
# FUNCTION 6: Do the git push
# ==============================
git_push() {
    echo ""
    echo "🚀 Starting git push process..."
    echo ""

    # Stage all changes
    echo "📦 Staging all changes..."
    git add .
    write_log "git add . executed"

    # Commit with message
    echo "💾 Committing..."
    git commit -m "$COMMIT_MSG"
    write_log "git commit: $COMMIT_MSG"

    # Push to remote
    echo "⬆️  Pushing to GitHub..."
    git push origin "$BRANCH"
    write_log "git push to $BRANCH"

    # Check if push was successful
    if [ $? -eq 0 ]; then
        echo ""
        echo "================================"
        echo "  ✅ Successfully pushed to GitHub!"
        echo "  Branch : $BRANCH"
        echo "  Message: $COMMIT_MSG"
        echo "  Time   : $(date)"
        echo "================================"
        write_log "SUCCESS: pushed to $BRANCH"
    else
        echo "❌ Push failed! Check your internet or GitHub access"
        write_log "FAILED: push to $BRANCH failed"
        exit 1
    fi
}

# ==============================
# FUNCTION 7: Show git history
# ==============================
show_history() {
    echo ""
    echo "📜 Last 5 commits:"
    # --oneline shows compact history
    # -5 shows only last 5
    git log --oneline -5
}

# ==============================
# MAIN SCRIPT
# ==============================
echo "================================"
echo "  🔧 Git Auto Push Script"
echo "================================"
echo ""

# Run all checks first
check_git_repo
check_changes
show_changes

# Get commit message ($1 = first argument passed to script)
get_commit_message "$1"

# Do the push
git_push

# Show recent history
show_history

echo ""
echo "✅ All done!"
