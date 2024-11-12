#Create a script that checks if a particular service (e.g., httpd or nginx) is running. If not, it should restart the service and log the action.
#!/bin/bash

# Service name to check
SERVICE="nginx"  # Replace with the service name, e.g., "httpd" or "nginx"

# Log file to record actions
LOG_FILE="/var/log/service_monitor.log"

# Get the current date and time for logging
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Check if the service is running
if systemctl is-active --quiet "$SERVICE"; then
  echo "$DATE - $SERVICE is running."
else
  # If the service is not running, restart it
  echo "$DATE - $SERVICE is not running. Restarting..." | tee -a "$LOG_FILE"
  
  # Attempt to restart the service
  if systemctl restart "$SERVICE"; then
    echo "$DATE - Successfully restarted $SERVICE." | tee -a "$LOG_FILE"
  else
    echo "$DATE - Failed to restart $SERVICE." | tee -a "$LOG_FILE"
  fi
fi
