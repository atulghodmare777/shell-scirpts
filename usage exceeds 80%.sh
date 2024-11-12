#Create a script to monitor the disk usage of a server. If usage exceeds 80%, log the details to a file .
#!/bin/bash
#
THRESHHOLD=80

LOG_FILE="/var/log/disk_usage_alert.log"


SUBJECT="disk usage alert on $(hostname)"

# Get current date and time

DATE=$(date "+%Y-%m-%d_%H:%M:%S")

#check disk usage

df -h | awk '{if ($5+0 > THRESHHOLD) print $0}' THRESHHOLD=$THRESHHOLD | while read line; do
USAGE=$(echo $line | awk '{print $5}')
MOUNT=$(echo $line) | awk '{print $6}')

echo "$DATE -high disk usage detected: $USAGE on $MOUNT" >> $LOG_FILE
