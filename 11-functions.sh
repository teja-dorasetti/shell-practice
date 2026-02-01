#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "this is not a root user to install Nginx"

fi    

# by defalut shell will not execute, only executed when called

VALIDATE(){
    if [ $1 -ne 0 ]; then

        echo "$2 ....failure"    
        exit 1

    else 
        echo "$2....Success"
    fi

}
    dnf install nginx -y 
    VALIDATE $? "Install Nginx"

    dnf install mysql -y 
    VALIDATE $? "Install Mysql"

    dnf install nodejs -y 
    VALIDATE $? "Install nodejs"