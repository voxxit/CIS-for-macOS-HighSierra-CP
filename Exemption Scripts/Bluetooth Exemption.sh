#!/bin/bash

dir="/Library/Application Support/SecurityScoring"

if [[ ! -e "$dir" ]]; then
    mkdir "$dir"
fi
plistlocation="$dir/org_exemptions.plist"


##################################################################
############### ADMINS DESIGNATE ORG VALUES BELOW ################
##################################################################
### Set "true" or "false" for Parameter 4 in a Jamf Policy

# 2.1.1 Bluetooth Exemption
Exemption2_1_1="$4"

##################################################################
############# DO NOT MODIFY ANYTHING BELOW THIS LINE #############
##################################################################
# Write org_security_exemption values to local plist

if [[ "$4" = "" ]]
    echo "TRUE or FALSE value not specified in policy, exiting"
fi

/usr/libexec/PlistBuddy -c "add :Exemption2_1_1 bool ${Exemption2_1_1}" $plistlocation
