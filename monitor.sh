# Create a script that monitors a specified directory and automatically deletes any files larger than 100 MB.
#!/bin/bash

# Directory to monitor (change this to the directory you want to monitor)
MONITOR_DIR="/path/to/your/directory"

# Size threshold in bytes (100 MB = 100 * 1024 * 1024 bytes)
SIZE_THRESHOLD=$((100 * 1024 * 1024))

# Log file to keep track of deleted files
LOG_FILE="/path/to/log/deleted_files.log"

# Function to delete files larger than the threshold
delete_large_files() {
    # Find files larger than SIZE_THRESHOLD and delete them
    find "$MONITOR_DIR" -type f -size +100M -print | while read FILE; do
        echo "Deleting large file: $FILE"
        
        # Log the file deletion with timestamp
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Deleted: $FILE" >> "$LOG_FILE"
        
        # Delete the file
        rm -f "$FILE"
    done
}

# Call the function to delete large files
delete_large_files
