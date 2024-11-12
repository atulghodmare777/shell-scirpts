#!/bin/bash

DIRECTORY= "/mnt/logs"

if [-d "DIRECTORY"]; then
	echo "finding the files which are older than 30 days"
	find "$DIRECTORY" -type f -mtime +30 -exec rm -rf {} \;
        echo "files has been removed"
else
        echo "Directory  $DIRECTORY does not exist"
fi	
