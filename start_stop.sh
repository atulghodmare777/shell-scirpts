#Develop a script that starts and stops EC2 instances based on a schedule (e.g., start at 8 AM and stop at 8 PM).
#!/bin/bash

# AWS Region
REGION="your-region"  # Replace with your AWS region (e.g., us-east-1)

# Instance IDs (replace with your EC2 instance IDs)
INSTANCE_IDS=("i-0123456789abcdef0" "i-0fedcba9876543210")  # Replace with your instance IDs

# Define start and stop times
START_HOUR=8   # 8 AM
STOP_HOUR=20   # 8 PM

# Get the current hour
CURRENT_HOUR=$(date +%H)

# Function to start EC2 instances
start_instances() {
    echo "Starting instances: ${INSTANCE_IDS[@]}"
    aws ec2 start-instances --instance-ids "${INSTANCE_IDS[@]}" --region "$REGION"
}

# Function to stop EC2 instances
stop_instances() {
    echo "Stopping instances: ${INSTANCE_IDS[@]}"
    aws ec2 stop-instances --instance-ids "${INSTANCE_IDS[@]}" --region "$REGION"
}

# Main logic to check the time and start/stop instances
if [ "$CURRENT_HOUR" -eq "$START_HOUR" ]; then
    start_instances
elif [ "$CURRENT_HOUR" -eq "$STOP_HOUR" ]; then
    stop_instances
else
    echo "No action required at this hour."
fi
