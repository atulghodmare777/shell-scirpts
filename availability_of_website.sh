#Create a script to check the availability of a list of websites. For each site, if it's unreachable, log the URL and send an alert.
#!/bin/bash

# List of websites to check
WEBSITES=("https://example.com" "https://anotherexample.com" "https://somesite.com")

# Log file to record unreachable sites
LOG_FILE="/var/log/website_availability.log"

# Alert email address
ALERT_EMAIL="your_email@example.com"

# Get the current date and time for logging
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Function to check the availability of each website
check_website() {
  for SITE in "${WEBSITES[@]}"; do
    # Send a request to the website and check if it's reachable
    if ! curl -Is --connect-timeout 5 "$SITE" | grep "200 OK" > /dev/null; then
      echo "$DATE - $SITE is unreachable." | tee -a "$LOG_FILE"
      
      # Send an alert email
      echo "$SITE is currently unreachable." | mail -s "Website Unreachable Alert" "$ALERT_EMAIL"
    else
      echo "$DATE - $SITE is reachable."
    fi
  done
}

# Run the website check function
check_website
