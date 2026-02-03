#! bin/bash

set -e
trap 'echo "There is error in line $LINENO, COMMAND: $BASH_COMMAND"' ERR


echo "Script started"
echo "Press Ctrl+C to interrupt the script"
echoo "Press Ctrl+Z to pause the script"

