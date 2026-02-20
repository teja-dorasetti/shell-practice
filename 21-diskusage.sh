#! bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

log(){
    echo -e "$(date +%F-%H-%M-%S) $1" | tee -a $LOGS_FILE
}

DISK_USAGE=$(df -hT / | grep -v "FILESYSTEM")
USAGAE_THRESHOLD=80


While IFS= read -r line
do
    USAGE=$(echo $line | awk '{print $6}'| cut -d "%" -f1)
    PARTITION=$(echo $line | awk '{print $7}')
    if [ "$USAGE" -gt $USAGAE_THRESHOLD ]; then
        message="Disk usage for partition $PARTITION is at $USAGE% which is above the threshold of $USAGAE_THRESHOLD%"
        log "$message"
    else
        message="Disk usage for partition $PARTITION is at $USAGE% which is below the threshold of $USAGAE_THRESHOLD%"
        log "$message"
    fi
done <<< "$DISK_USAGE"

