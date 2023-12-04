#!/bin/bash

############################################################################
#									   #
# Nicolas Thompson							   #
# 11-01-2023 (CAT I)							   #
# This script will create a new configuration file if it doesn't exist     #
# and set the use_mappers parameter to pwent. 				   #
# Save the script, make it executable, and run it again.		   #
#									   #
############################################################################

config_file="/etc/pam_pkcs11/pam_pkcs11.conf"
desired_value="use_mappers = pwent"

# Check if the directory exists, create it if not
if [ ! -d "/etc/pam_pkcs11/" ]; then
    sudo mkdir -p /etc/pam_pkcs11/
fi

# Check if the configuration file exists
if [ -f "$config_file" ]; then
    # Check if the use_mappers parameter is set in the pam_pkcs11.conf file
    if grep -E '^use_mappers\s*=\s*pwent' "$config_file"; then
        echo "use_mappers is already set to pwent. No action needed."
    else
        # Add or update the use_mappers parameter in the configuration file
        if grep -E '^use_mappers' "$config_file"; then
            sudo sed -i "s/^use_mappers.*/$desired_value/" "$config_file"
            echo "use_mappers parameter updated in $config_file."
        else
            echo "use_mappers parameter not found. Adding it with a value of pwent."
            echo "$desired_value" | sudo tee -a "$config_file" > /dev/null
        fi
    fi
else
    # Create a basic configuration file
    echo "$desired_value" | sudo tee "$config_file" > /dev/null
    echo "Created a new configuration file at $config_file with use_mappers parameter set to pwent."
fi

