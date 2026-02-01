#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/sell-script"
LOGS_FILE="/var/log/sell-script/$0.log"

if [ $USERID -ne 0 ]; then
    echo "this is not a root user to install Nginx"

fi    
    mkdir -p $LOGS_FLODER

# by defalut shell will not execute, only executed when called

VALIDATE(){
    if [ $1 -ne 0 ]; then

        echo "$2 ....failure"    
        exit 1

    else 
        echo "$2....Success"
    fi

}
    dnf install nginx -y $>> $LOGS_FILE
    VALIDATE $? "Install Nginx"

    dnf install mysql -y $>> $LOGS_FILE
    VALIDATE $? "Install Mysql"

    dnf install nodejs -y $>> $LOGS_FILE
    VALIDATE $? "Install nodejs"