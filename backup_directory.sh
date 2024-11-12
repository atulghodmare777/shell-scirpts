#Write a script that performs a backup of a specified directory and compresses it with the current date in the filename. Schedule it to run daily using cron.
#!/bin/bash

# Directory to back up
SOURCE_DIR="/path/to/source_directory"

# Directory where the backup will be saved
BACKUP_DIR="/path/to/backup_directory"

# Get the current date in YYYY-MM-DD format
DATE=$(date +"%Y-%m-%d")

# Name of the backup file
BACKUP_FILE="backup-$DATE.tar.gz"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Perform the backup and compress it
tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$SOURCE_DIR" .

# Verify the backup
if [ $? -eq 0 ]; then
  echo "Backup successful: $BACKUP_DIR/$BACKUP_FILE"
else
  echo "Backup failed!"
fi
