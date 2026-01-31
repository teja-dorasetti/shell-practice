#! bin/bash

#### special variables ###

echo "all args passed to scrpit: $@"
echo "number of varibales passed: $#"
echo "script name: $0"
echo "present directory: $pwd"
echo "who is running: $user"
echo "Home Directory of current user: $HOME"
echo "PID of the scrpit: $$"
sleep 100 &
echo "PID recently executedackground process: $1"
echo "all args passed to scrpit: $*"
