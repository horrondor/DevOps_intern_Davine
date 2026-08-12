#!/bin/bash

# ==========================================================
# Log Cleanup Script
# Removes old log files based on retention period
# ==========================================================

set -euo pipefail

usage() {
    echo "Usage: sudo $0 <log_directory> <retention_days>"
    echo
    echo "Example:"
    echo "  sudo $0 /var/log/myapp 7"
    exit 1
}

# ----------------------------------------------------------
# Validate arguments
# ----------------------------------------------------------

if [[ $# -ne 2 ]]; then
    usage
fi

LOG_DIR="$1"
RETENTION_DAYS="$2"

# ----------------------------------------------------------
# Validate retention value
# ----------------------------------------------------------

if ! [[ "$RETENTION_DAYS" =~ ^[0-9]+$ ]]; then
    echo "Error: Retention days must be a number."
    exit 1
fi

# ----------------------------------------------------------
# Validate directory
# ----------------------------------------------------------

if [[ ! -d "$LOG_DIR" ]]; then
    echo "Error: Directory does not exist: $LOG_DIR"
    exit 1
fi

# ----------------------------------------------------------
# Root check
# ----------------------------------------------------------

if [[ ! -r "$LOG_DIR" || ! -x "$LOG_DIR" ]]; then
    echo "Error: Permission denied accessing $LOG_DIR"
    echo "Try running with sudo."
    exit 1
fi

# ----------------------------------------------------------
# Logging
# ----------------------------------------------------------

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
CLEANUP_LOG="$LOG_DIR/cleanup_$TIMESTAMP.log"

echo "==========================================" | tee -a "$CLEANUP_LOG"
echo "         LOG CLEANUP STARTED"              | tee -a "$CLEANUP_LOG"
echo "==========================================" | tee -a "$CLEANUP_LOG"

echo "Log directory : $LOG_DIR" | tee -a "$CLEANUP_LOG"
echo "Retention     : $RETENTION_DAYS days" | tee -a "$CLEANUP_LOG"

# ----------------------------------------------------------
# Find old logs
# ----------------------------------------------------------

echo | tee -a "$CLEANUP_LOG"
echo "Old log files:" | tee -a "$CLEANUP_LOG"

OLD_LOGS=$(find "$LOG_DIR" \
    -type f \
    \( -name "*.log" -o -name "*.log.*" \) \
    -mtime +"$RETENTION_DAYS" \
    -print)

# ----------------------------------------------------------
# Check if anything needs cleaning
# ----------------------------------------------------------

if [[ -z "$OLD_LOGS" ]]; then
    echo "No old log files found." | tee -a "$CLEANUP_LOG"
else

    echo "$OLD_LOGS" | tee -a "$CLEANUP_LOG"

    echo | tee -a "$CLEANUP_LOG"
    echo "Deleting old logs..." | tee -a "$CLEANUP_LOG"

    while IFS= read -r FILE; do
        rm -- "$FILE"
        echo "Deleted: $FILE" | tee -a "$CLEANUP_LOG"
    done <<< "$OLD_LOGS"

fi

# ----------------------------------------------------------
# Disk usage after cleanup
# ----------------------------------------------------------

echo | tee -a "$CLEANUP_LOG"
echo "Current log directory size:" | tee -a "$CLEANUP_LOG"

du -sh "$LOG_DIR" | tee -a "$CLEANUP_LOG"

echo | tee -a "$CLEANUP_LOG"
echo "Cleanup completed successfully." | tee -a "$CLEANUP_LOG"

echo "==========================================" | tee -a "$CLEANUP_LOG"
