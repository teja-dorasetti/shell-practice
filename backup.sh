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

FILES=$(find $SOURCE_DIR -type f -mtime +$DAYS)
if [ -z "$FILES" ]; then
    echo -e "$Y No old backup files to remove $N" | tee -a $LOGS_FILE
else
    find $SOURCE_DIR -type f -mtime +$DAYS -exec rm -f {} \; &>>$LOGS_FILE
    if [ $? -ne 0 ]; then
        echo -e "$R Failed to remove old backup files $N" | tee -a $LOGS_FILE
        exit 1
    else
        echo -e "$G Old backup files removed successfully $N" | tee -a $LOGS_FILE
fi

TIMESTAMP=$(date +%F-%H-%M-%S)
BACKUP_FILE="$DEST_DIRECTORY/backup-$TIMESTAMP.tar.gz"
tar -czf $BACKUP_FILE $SOURCE_DIR &>>$LOGS_FILE
if [ $? -ne 0 ]; then
    echo -e "$R Failed to create backup file $N" | tee -a $LOGS_FILE
    exit 1
else
    echo -e "$G Backup file created successfully: $BACKUP_FILE $N" | tee -a $LOGS_FILE
fi  