#!/bin/bash

# Websites to monitor (add or remove URLs as needed)
websites=("https://example.com" "https://googl1e.com")

# Get the directory of the script
script_directory=$(dirname "$0")

# Directory to store status files
status_directory="${script_directory}/status_files"

# Ensure the status files directory exists
mkdir -p "$status_directory"

# Function to check if a website is up
check_website() {
  local url=$1
  response_code=$(curl -sL -w "%{http_code}\\n" "$url" -o /dev/null)
  if [ "$response_code" -eq 200 ]; then
    echo "up"
  else
    echo "down"
  fi
}

# File to store logs
log_file="${script_directory}/log.txt"

# Function to write logs
write_log() {
  echo "$@" >> "$log_file"
  echo "$@"
}

# Function to handle interruptions
handle_interrupt() {
  echo -e "\nScript interrupted by user."
  kill -- -$$  # Terminate all child processes
  exit 0
}

# Register trap to capture SIGINT (Ctrl+C) and execute the handle_interrupt function
trap handle_interrupt SIGINT

# Start monitoring for each website
pids=()
for website in "${websites[@]}"; do
  (
    # Replace forward slashes ('/') in website URL with underscores ('_') for filename
    status_file="${status_directory}/$(echo "$website" | tr '/' '_').txt"

    start_time=$(date +%s)
    total_checks=0
    successful_checks=0

    while true; do
      let total_checks++

      if [ "$(check_website "$website")" = "up" ]; then
        let successful_checks++
        status="up"
      else
        status="down"
      fi

      # Calculate uptime percentage
      uptime_percentage=$(awk "BEGIN {print ($successful_checks / $total_checks) * 100}")

      # Prepare the log and status messages
      timestamp=$(date "+%a. %d. %b %H:%M:%S %Z %Y")
      log_message="$timestamp - Website $website is $status - Uptime: $uptime_percentage%"
      status_message="$timestamp - Website $website is $status - Uptime: $uptime_percentage%"

      # Write to log file
      write_log "$log_message"

      # Write to status file
      echo "$status_message" > "$status_file"

      sleep 2  # Delay between checks in seconds
    done
  ) &
  pids+=($!)
done

# Function to handle termination
handle_termination() {
  echo -e "\nScript terminated."
  kill "${pids[@]}"  # Terminate all background processes
  exit 0
}

# Register trap to capture SIGTERM and execute the handle_termination function
trap handle_termination SIGTERM

# Wait for the background processes to finish
wait "${pids[@]}"
