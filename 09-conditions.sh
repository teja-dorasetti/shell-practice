#! bin/bash

NUMBER=25

### -gt -> greater than
### -lt -> less than
### -nt -> not equal
### -eq -> equal 

if [ $NUMBER -gt 20]; then
     echo "Given Number: $NUMBER is greater than 20"
elif [ $NUMBER -eq 20]; then     
     echo "Given Number: $NUMBER is equal to 20"
else 
     echo "Given Number: $NUMBER is less than 20"
fi