#!/bin/bash

USERID=$(id -u)

if [$USERID -ne 0]; then
    echo "$USERID :is not and root user to install Nginx"

fi    