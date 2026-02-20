#! bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/Shell-Roboshop"
LOGS_FILE="$LOGS_FOLDER/backup.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIRECTORY=$2
DAYS=${3:-14} # default value for days is 14

if [ $USERID -ne 0 ]; then
    echo -e "$R please run this script with root user access $N" 

fi    

mkdir -p $LOGS_FOLDER

USAGE(){
    echo -e "$R USAGE:: sudo backup <SOURCE_DIRECTORY> <DEST_DIRECTORY>[default 14 days] $N"
    exit 1
}

log(){
    echo -e "$(date +%F-%H-%M-%S) $1" | tee -a $LOGS_FILE
}

if [ $# -ne 2 ]; then
    USAGE
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "$R Source directory: $SOURCE_DIR does not exist $N" 
    exit 1
fi

if [ ! -d "$DEST_DIRECTORY" ]; then
    echo -e "$R Destination directory: $DEST_DIRECTORY does not exist $N" 
    exit 1
fi

### Find the files
FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

log "Backup Started"
log "Source Directory: $SOURCE_DIR"
log "Destination Directory: $DEST_DIRECTORY"    
log "Days: $DAYS"

if [ -z $FILES ]; then
    log "No files found for backup"
    exit 0
else
    log "Files found for backup: $FILES"
    timestamp=$(date +%F-%H-%M-%S)
    ZIP_FILE_NAME="$DEST_DIRECTORY/backup-$timestamp.tar.gz"
    tar -czf $ZIP_FILE_NAME $FILES
    log "Backup completed: $ZIP_FILE_NAME"  
fi  