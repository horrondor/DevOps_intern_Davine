#!/bin/bash

set -euo pipefail

# ==========================================
# Dynamic DevOps User and Directory
# Provisioning Script
# ==========================================

usage() {
    echo "Usage:"
    echo "  sudo $0 --group GROUP --users USER1,USER2,... --base-dir PATH"
    echo
    echo "Example:"
    echo "  sudo $0 --group devops --users developer1,developer2 --base-dir /opt/devops"
    exit 1
}

# ----------------------------------------------------------
# Root check
# ----------------------------------------------------------

if [[ $EUID -ne 0 ]]; then
    echo "Error: Run this script with sudo/root privileges."
    exit 1
fi

# ----------------------------------------------------------
# Default values
# ----------------------------------------------------------

GROUP_NAME=""
USERS=""
BASE_DIR=""

# ----------------------------------------------------------
# Parse arguments
# ----------------------------------------------------------

while [[ $# -gt 0 ]]; do

    case "$1" in

        --group)
            if [[ $# -lt 2 ]]; then
                echo "Error: --group requires a value."
                usage
            fi

            GROUP_NAME="$2"
            shift 2
            ;;

        --users)
            if [[ $# -lt 2 ]]; then
                echo "Error: --users requires a value."
                usage
            fi

            USERS="$2"
            shift 2
            ;;

        --base-dir)
            if [[ $# -lt 2 ]]; then
                echo "Error: --base-dir requires a value."
                usage
            fi

            BASE_DIR="$2"
            shift 2
            ;;

        -h|--help)
            usage
            ;;

        *)
            echo "Error: Unknown option: $1"
            usage
            ;;

    esac

done

# ----------------------------------------------------------
# Validate arguments
# ----------------------------------------------------------

if [[ -z "$GROUP_NAME" || -z "$USERS" || -z "$BASE_DIR" ]]; then
    echo "Error: Missing required arguments."
    usage
fi

# ----------------------------------------------------------
# Validate group name
# ----------------------------------------------------------

if [[ ! "$GROUP_NAME" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
    echo "Error: Invalid group name: $GROUP_NAME"
    exit 1
fi

# ----------------------------------------------------------
# Convert comma-separated users into array
# ----------------------------------------------------------

IFS=',' read -r -a USER_LIST <<< "$USERS"

if [[ ${#USER_LIST[@]} -eq 0 ]]; then
    echo "Error: No users specified."
    exit 1
fi

# ----------------------------------------------------------
# Create base directory
# ----------------------------------------------------------

mkdir -p "$BASE_DIR"

# ----------------------------------------------------------
# Logging
# ----------------------------------------------------------

LOG_FILE="$BASE_DIR/provisioning.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# ----------------------------------------------------------
# Create group
# ----------------------------------------------------------

if getent group "$GROUP_NAME" > /dev/null; then

    log "Group already exists: $GROUP_NAME"

else

    groupadd "$GROUP_NAME"
    log "Created group: $GROUP_NAME"

fi

# ----------------------------------------------------------
# Create users
# ----------------------------------------------------------

for USERNAME in "${USER_LIST[@]}"; do

    # Remove accidental whitespace
    USERNAME="${USERNAME//[[:space:]]/}"

    if [[ -z "$USERNAME" ]]; then
        log "Skipping empty username."
        continue
    fi

    if [[ ! "$USERNAME" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
        log "Error: Invalid username: $USERNAME"
        exit 1
    fi

    if id "$USERNAME" &> /dev/null; then

        log "User already exists: $USERNAME"

    else

        useradd \
            --create-home \
            --shell /bin/bash \
            "$USERNAME"

        log "Created user: $USERNAME"

    fi

    # Add user to group
    usermod -aG "$GROUP_NAME" "$USERNAME"

    log "Added $USERNAME to $GROUP_NAME"

done

# ----------------------------------------------------------
# Directory structure
# ----------------------------------------------------------

DIRECTORIES=(
    "$BASE_DIR"
    "$BASE_DIR/projects"
    "$BASE_DIR/scripts"
    "$BASE_DIR/config"
    "$BASE_DIR/backup"
    "$BASE_DIR/shared"
)

# ----------------------------------------------------------
# Configure directories
# ----------------------------------------------------------

for DIR in "${DIRECTORIES[@]}"; do

    mkdir -p "$DIR"

    chown root:"$GROUP_NAME" "$DIR"
    chmod 2770 "$DIR"

    log "Configured directory: $DIR"

done

# ----------------------------------------------------------
# Configure log file
# ----------------------------------------------------------

chown root:"$GROUP_NAME" "$LOG_FILE"
chmod 660 "$LOG_FILE"

# ----------------------------------------------------------
# Summary
# ----------------------------------------------------------

echo
echo "================================="
echo "Provisioning completed"
echo "================================="

echo "Group : $GROUP_NAME"
echo "Users : ${USER_LIST[*]}"
echo "Base  : $BASE_DIR"

echo
echo "Directories:"
find "$BASE_DIR" -type d -print | sort

echo
echo "Group membership:"
getent group "$GROUP_NAME"

echo
echo "Log file:"
echo "$LOG_FILE"

echo
echo "================================="
echo "Done"
echo "================================="
