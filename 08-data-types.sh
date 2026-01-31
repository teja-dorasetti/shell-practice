#! bin/bash

NUM1=100
NUM2=200

SUM=$(($NUM1+$NUM2))

echo "print sum of two numbers: $SUM"

DEVOPS=("AWS" "Docker" "instance")

echo "In DevOps course we have: ${DEVOPS[@]}"
