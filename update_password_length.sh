#!/bin/bash

#########################################################################################################
#													#
# Nicolas Thompson											#
# 11-03-2023 (CAT II)											#
# It defines the path to the configuration file and the desired minimum password length, then           #
# checks if the "minlen" parameter is already set in the configuration file. If the parameter is found, #
# it checks if the current value is less than the desired minimum length.                               #
# If the current value is less, it updates the parameter with the desired value.                        #
#########################################################################################################

config_file="/etc/security/pwquality.conf"
minlen_value=15

# Check if the minlen parameter is set in the pwquality.conf file
if grep -E '^minlen\s*=\s*[0-9]+' "$config_file"; then
    current_minlen=$(grep -E '^minlen\s*=\s*[0-9]+' "$config_file" | awk -F '=' '{print $2}' | tr -d '[:space:]')
    if [ "$current_minlen" -ge "$minlen_value" ]; then
        echo "Password length is already set to $minlen_value or higher. No action needed."
    else
        sudo sed -i "s/^minlen.*/minlen = $minlen_value/" "$config_file"
        echo "Password length updated to $minlen_value in $config_file."
    fi
else
    echo "minlen parameter not found in $config_file. Adding it with a value of $minlen_value."
    echo "minlen = $minlen_value" | sudo tee -a "$config_file" > /dev/null
fi

