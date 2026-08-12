#!/bin/bash

echo "========================================"
echo "------- Automated backup Script -------"
echo "========================================"

set -euo pipefail

# ------- Configuration -------
SOURCE_DIR="${1:-$HOME/DevOps-Week02}"
BACKUP_DIR="${2:-$HOME/Backups}"
RETENTION_DAYS="${3:-7}"

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
HOSTNAME=$(hostname)
BACKUP_NAME="${HOSTNAME}_backup_${TIMESTAMP}.tar.gz"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"


LOG_DIR="$BACKUP_DIR/logs"
LOG_FILE="$LOG_DIR/backup.log"

# ------- functions ---------

log()
{
  echo "[$(date '+%y-%m-%d %H-%M-%S')] $1" | tee -a "$LOG_FILE"	
}

error_exit() {
  log "ERROR: $1"
  exit 1
}

# ------- Validation ------
#
if [[ ! -d "$SOURCE_DIR" ]]
then
  echo "Source directory doesnot exist: $SOURCE_DIR"
  exit 1
else
  echo "source directory exist"	
fi	



mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"



# ------ Start Backup ---------


log "================================"
log "Starting backup"
log "Source : $SOURCE_DIR"
log "Destination: $BACKUP_PATH"
log "================================"

START_TIME=$(date +%s)

# ----- Create Backup ------

log "Creating compressed archieve......"

tar -czf "$BACKUP_PATH" \
	--exclude="$BACKUP_DIR" \
	"$SOURCE_DIR" \
	2>>"$LOG_FILE" || error_exit "Backup creation failed."

# ------ Verify Backup -----

if [[ ! -s "$BACKUP_PATH" ]] 
then
  error_exit "Backup file was created but is empty."	
fi	

log "backup created successfully."

# ------- Backup Size -------

BACKUP_SIZE=$(du -h "$BACKUP_PATH" | awk '{print $1}' )

log "Backup size : $BACKUP_SIZE"


# ------ verify Archieve -----
log "Verifying archive..."

if tar -tzf "$BACKUP_PATH" >/dev/null 2>>"$LOG_FILE"
then
  log "Archieve verification successful."
else
  error_exit "Archieve verficiation failed"	
fi	

# ------- Remove Old Backups ------

log "Removing backups older than $RETENTION_DAYS days"

find "$BACKUP_DIR" \
     -type f \
     -name "*.tar.gz" \
     -mtime +"$RETENTION_DAYS" \
     -print -delete >>"$LOG_FILE"

# --------- Calculate Duration --------

END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

log "Backup completed in ${DURATION} seconds."
log "Backup location: $BACKUP_PATH"
log "======================================================"







