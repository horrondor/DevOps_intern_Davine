#!/bin/bash

# ==========================================
# Simple DevOps Backup & Apache Deployment
# ==========================================

# Project directories
PROJECT_DIR="$HOME/my_project"
SOURCE_DIR="$PROJECT_DIR/files"
BACKUP_DIR="$PROJECT_DIR/backups"

# Apache web root
APACHE_DIR="/var/www/html"

# Timestamp for backup
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Backup name
BACKUP_NAME="backup_$TIMESTAMP"

echo "======================================"
echo " DevOps Backup & Deployment Script"
echo "======================================"

# 1. Create project directories
echo "[1] Creating project directories..."

mkdir -p "$SOURCE_DIR"
mkdir -p "$BACKUP_DIR"

echo "Directories created."

# 2. Create index.html
echo "[2] Creating index.html..."

cat > "$SOURCE_DIR/index.html" <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>My DevOps Project</title>
</head>
<body>

    <h1>Hello from Apache2!</h1>

    <p>This website was deployed using a Bash script.</p>

</body>
</html>
EOF

echo "index.html created."

# 3. Copy project files to backup directory
echo "[3] Copying project files..."

mkdir -p "$BACKUP_DIR/$BACKUP_NAME"

cp -r "$SOURCE_DIR/"* "$BACKUP_DIR/$BACKUP_NAME/"

echo "Project files copied to backup."

# 4. Compress the backup
echo "[4] Compressing backup..."

tar -czf "$BACKUP_DIR/$BACKUP_NAME.tar.gz" \
    -C "$BACKUP_DIR" "$BACKUP_NAME"

# Remove temporary backup directory
rm -rf "$BACKUP_DIR/$BACKUP_NAME"

echo "Backup compressed successfully."

# 5. Copy index.html to Apache2 web directory
echo "[5] Deploying website to Apache2..."

sudo cp "$SOURCE_DIR/index.html" "$APACHE_DIR/index.html"

echo "index.html copied to Apache2."

# 6. Set permissions
sudo chmod 644 "$APACHE_DIR/index.html"

# 7. Restart Apache
echo "[6] Restarting Apache2..."

sudo systemctl restart apache2

# 8. Check Apache status
if sudo systemctl is-active --quiet apache2; then
    echo "Apache2 is running successfully."
else
    echo "ERROR: Apache2 is not running."
    exit 1
fi

echo ""
echo "======================================"
echo " Deployment completed successfully!"
echo "======================================"
echo ""
echo "Website location:"
echo "$APACHE_DIR/index.html"
echo ""
echo "Backup location:"
echo "$BACKUP_DIR/$BACKUP_NAME.tar.gz"
