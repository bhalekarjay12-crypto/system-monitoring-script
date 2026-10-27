
#!/usr/bin/env bash

# System Monitoring and Alerting Script
# Project: Capstone Project 1

set -u

# Configuration: change these thresholds as needed
DISK_THRESHOLD=1
MEMORY_THRESHOLD=1

# Store logs inside the project directory
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/system_monitor.log"

# Print a message and save it to the log
log_message() {
    local message="$1"
    printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$message" \
        | tee -a "$LOG_FILE"
}

# Check disk usage of the root filesystem
check_disk() {
    local disk_usage

    disk_usage=$(df -P / | awk 'NR == 2 {gsub(/%/, "", $5); print $5}')

    log_message "Root filesystem disk usage: ${disk_usage}%"

    if (( disk_usage >= DISK_THRESHOLD )); then
        log_message "ALERT: Disk usage is at or above ${DISK_THRESHOLD}%!"
    else
        log_message "OK: Disk usage is below the threshold."
    fi
}

# Check memory usage
check_memory() {
    local memory_usage

    memory_usage=$(free | awk '/^Mem:/ {
        if ($2 > 0) printf "%d", (($2 - $7) / $2) * 100
    }')

    if [[ ! "$memory_usage" =~ ^[0-9]+$ ]]; then
        log_message "ERROR: Could not determine memory usage."
        return 1
    fi

    log_message "Memory usage: ${memory_usage}%"

    if (( memory_usage >= MEMORY_THRESHOLD )); then
        log_message "ALERT: Memory usage is at or above ${MEMORY_THRESHOLD}%!"
    else
        log_message "OK: Memory usage is below the threshold."
    fi
}

# Display the top five CPU-consuming processes
show_top_processes() {
    log_message "Top five CPU-consuming processes:"
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6 \
        | tee -a "$LOG_FILE"
}

# Main function
main() {
    log_message "===== System Monitoring Started ====="
    check_disk
    check_memory
    show_top_processes
    log_message "===== System Monitoring Completed ====="
}

main "$@"
