#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "this is not a root user to install Nginx"

fi    
    echo "Installing nginx"

    dnf install nginx -y 

if [$? -ne 0]; then
    echo "Installing Nginx ....failure"    
    exit 1

else 
    echo "Installing Nginx....Success"
fi