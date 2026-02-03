#! bin/bash

set -e
trap 'echo "Script interrupted $LINENO!, COMMAND_$BASH_COMMAND; exit 1' ERR


echo "Script started"
echo "Press Ctrl+C to interrupt the script"
echoo "Press Ctrl+Z to pause the script"

