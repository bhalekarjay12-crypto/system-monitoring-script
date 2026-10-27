
# System Monitoring and Alerting Script

## Project Overview

This project is part of Capstone Project 1:
Linux, Shell Scripting, and Git.

It automates basic Linux system monitoring using Bash.

## Features

- Checks root filesystem disk usage.
- Monitors memory usage.
- Displays alerts when thresholds are reached.
- Displays the top five CPU-consuming processes.
- Records timestamped messages in a log file.
- Uses Git for version control.

## Requirements

- Linux or Ubuntu
- Bash
- Git
- Standard Linux utilities: df, free, awk, ps, head, tee

## Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/system-monitoring-script.git
cd system-monitoring-script
```

Make the script executable:

```bash
chmod +x system_monitor.sh
```

## Usage

Run the monitoring script:

```bash
./system_monitor.sh
```

View the log:

```bash
cat system_monitor.log
```

View the latest log entries:

```bash
tail -n 20 system_monitor.log
```

## Configuration

Edit `system_monitor.sh` to change the thresholds:

```bash
DISK_THRESHOLD=80
MEMORY_THRESHOLD=80
```

The values represent percentage thresholds.

An alert is printed when measured usage is greater than or equal to the threshold.

## Output

The script displays disk usage, memory usage,
alerts, and the top five CPU-consuming processes.

Results are also appended to `system_monitor.log`.

## Limitations

- Monitors the root filesystem only.
- Performs a single check each time it runs.
- Does not send email, SMS, or external notifications.
- Requires manual execution unless scheduled separately.

## Learning Outcomes

- Linux command-line operations
- Bash scripting and functions
- Conditional statements and variables
- System resource monitoring
- File logging
- Git version control

## Author

jay bhalekar
