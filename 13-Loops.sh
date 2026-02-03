#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

if [ $USERID -ne 0 ]; then
    echo "please run this script with root user access" | tee -a $LOGS_FILE
    exit 1

fi    

mkdir -p $LOGS_FOLDER

VALIDATE(){
    if [ $1 -ne 0 ]; then

        echo "$2 ....failure"   | tee -a $LOGS_FILE
        exit 1

    else 
        echo "$2....Success"    | tee -a $LOGS_FILE
    fi

}
    
for package in $@ # $@ means all agruments passed [ sudo sh 13-loops.sh nginx nodejs mysql]
do
    dnf list installed $package &>>$LOGS_FILE
    if [ $? -ne 0]; then
        echo "$package is not installed,installing now"
        dnf install $package -y &>>$LOGS_FILE
        VALIDATE $? "$package installation"
    else 
        echo "$package already installed,skipping..."   
    fi     
done