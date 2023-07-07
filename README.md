# Website Monitoring Script

This script monitors the status of multiple websites by periodically checking their HTTP response codes. It requires a few dependencies to run properly. Follow the instructions below to set up and run the script.

## Dependencies

1. **Bash**: This script is written in Bash, so ensure your system supports Bash shell.

2. **curl**: The script uses `curl` command-line tool to make HTTP requests and check the response codes. Ensure that `curl` is installed on your system.

3. **awk**: The script uses `awk` for arithmetic operations and floating-point calculations. Ensure that `awk` is installed on your system.

## Setup

1. Clone the repository and navigate to the script's directory:

   ```bash
   git clone https://github.com/Morten03Nordbye/selfhosted-uptime.git
   cd selfhosted-uptime
   ```

2. Edit the script and add the URLs of the websites you want to monitor. Open the `monitor.sh` file in a text editor and modify the `websites` array:

   ```bash
   websites=("https://example.com" "https://google.com")
   ```

   Add or remove URLs as needed, enclosing each URL in double quotes and separating them with spaces.

3. Make the script executable:

   ```bash
   chmod +x monitor.sh
   ```

4. Run the script:

   ```bash
   ./monitor.sh
   ```

   The script will start monitoring the specified websites and log their status.

## Configuration

The script provides a few configuration options that you can adjust according to your needs:

- **Status Files Directory**: By default, the script creates a directory called `status_files` in the same directory as the script to store status files. If you want to change this directory, modify the `status_directory` variable in the script.

- **Check Frequency**: The script currently checks the status of websites every 2 seconds. If you want to change the frequency, modify the `sleep` command inside the loop in the script.

- **Log File**: The script logs the status of websites to a file called `log.txt` in the script's directory. If you want to change the log file's name or location, modify the `log_file` variable in the script.

- **Interrupt Handling**: By default, the script captures the SIGINT signal (Ctrl+C) and SIGTERM signals, and terminates all child processes. If you want to change this behavior, modify the `handle_interrupt` and `handle_termination` functions in the script.

## Notes

- The script runs an infinite loop for each website being monitored, which may consume significant system resources. Adjust the check frequency and introduce timeouts if necessary.

- Ensure you have proper permissions to write files in the script's directory and the specified log/status files directory.

- The script assumes that a 200 HTTP response code represents a website being "up". If you have specific requirements or conditions for determining a website's status, modify the `check_website` function in the script accordingly.

- The script saves the status of each website to separate status files using the website's URL, with all forward slashes replaced with underscores. The status files are created in the `status_files` directory. If a website's URL contains characters that are not valid in file names, they will be replaced with underscores.

- Remember to monitor the script's resource usage and adjust the configuration as needed to ensure optimal performance.

Feel free to modify the instructions and information in the README file according to your specific requirements and preferences.
