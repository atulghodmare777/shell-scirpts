#Write a script that renames all .txt files in a directory by appending the current date to the filename.
#!/bin/bash

# Specify the directory containing the .txt files
DIRECTORY="/path/to/directory"

# Get the current date in YYYY-MM-DD format
DATE=$(date +"%Y-%m-%d")

# Check if the directory exists
if [ -d "$DIRECTORY" ]; then
  echo "Renaming .txt files in $DIRECTORY by appending the current date..."

  # Loop through each .txt file in the directory
  for file in "$DIRECTORY"/*.txt; do
    # Check if any .txt files exist to avoid errors if no files are found
    [ -e "$file" ] || continue
    
    # Get the filename without the extension
    BASENAME=$(basename "$file" .txt)
    
    # Define the new filename by appending the date
    NEW_FILENAME="${DIRECTORY}/${BASENAME}_${DATE}.txt"
    
    # Rename the file
    mv "$file" "$NEW_FILENAME"
    
    echo "Renamed $file to $NEW_FILENAME"
  done

  echo "All .txt files have been renamed."
else
  echo "Directory $DIRECTORY does not exist."
fi
