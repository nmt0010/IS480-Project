#!/bin/bash

##############################################################################################
#                                                                          		     #
# Nicolas Thompson                                                                           #
# 11-03-2023 (CAT II)                                                      		     #
# The script will check for the presence of the vlock package.				     #
# uses dpkg -l to list all installed packages, and grep -q to search for the "vlock" package.# 
# If the package is found, it prints a message saying it's installed;			     #
# otherwise, it indicates that it is not installed.					     #
#											     #
##############################################################################################


package_name="vlock"

# Check if the package is installed
if dpkg -l | grep -q $package_name; then
    echo "$package_name is installed."

    # Check if the vlock command is executable
    if command -v vlock &> /dev/null; then
        echo "$package_name is enabled and ready for use."
    else
        echo "$package_name is installed but may not be enabled or executable."
    fi

else
    echo "$package_name is not installed."
fi

