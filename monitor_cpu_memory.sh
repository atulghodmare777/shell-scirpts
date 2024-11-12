#Write a script to monitor CPU and memory usage every minute and log the details if CPU usage is above 90% or memory usage exceeds 75%.
#!/bin/bash

# Log file to store alerts
LOG_FILE="/var/log/resource_monitor.log"

# Thresholds
CPU_THRESHOLD=90
MEM_THRESHOLD=75

# Get the current date and time for logging
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Function to check CPU usage
check_cpu_usage() {
  # Get CPU usage as an integer (using top command and extracting the idle percentage)
  CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d. -f1)
  CPU_USAGE=$((100 - CPU_IDLE))

  if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "$DATE - High CPU usage detected: ${CPU_USAGE}%." | tee -a "$LOG_FILE"
  fi
}

# Function to check memory usage
check_memory_usage() {
  # Get memory usage as a percentage
  MEM_USAGE=$(free | awk '/Mem/ {printf "%.0f", $3/$2 * 100.0}')

  if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
    echo "$DATE - High memory usage detected: ${MEM_USAGE}%." | tee -a "$LOG_FILE"
  fi
}

# Main monitoring function
monitor_resources() {
  check_cpu_usage
  check_memory_usage
}

# Run monitoring function every minute
while true; do
  monitor_resources
  sleep 60
done
