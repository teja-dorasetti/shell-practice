#! bin/bash

set -e # exit on error
trap 'echo "There is error in line $LINENO, COMMAND: $BASH_COMMAND"' ERR

#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

if [ $USERID -ne 0 ]; then
    echo -e "$R please run this script with root user access $N" | tee -a $LOGS_FILE
    exit 1

fi    

mkdir -p $LOGS_FOLDER
    
for package in $@ # $@ means all agruments passed [ sudo sh 13-loops.sh nginx nodejs mysql]
do
    dnf list installed $package &>>$LOGS_FILE
    if [ $? -ne 0 ]; then
        echo -e "$Y $package is not installed,installing now $N"
        dnf install $package -y &>>$LOGS_FILE
    else 
        echo -e "$G $package already installed,skipping... $N"   
    fi     
done

