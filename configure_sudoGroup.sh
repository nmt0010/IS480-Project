#!/bin/bash

########################################################################
# Nicolas Thompson						       #
# 12-03-2023 (CAT I)						       #
# This script checks for the existence of sudo groups and its members, #
# displays its current members if they are present, then asks 	       #
# for a username to remove from the sudo group with the option to skip.#
########################################################################

# Define the sudo group
sudo_group="sudo"

# Check if the sudo group contains users not needing access to security functions
if grep -E "^${sudo_group}:" /etc/group; then
    # Display the current members of the sudo group
    echo "Current members of the sudo group:"
    sudo grep "^${sudo_group}:" /etc/group

    # Prompt for user removal
    read -p "Enter the username to remove from the sudo group (leave blank to skip): " username

    if [ -n "$username" ]; then
        # Remove the user from the sudo group
        sudo gpasswd -d "$username" "$sudo_group"
        echo "User $username removed from the sudo group."
    else
        echo "No users were removed from the sudo group."
    fi
else
    echo "The sudo group does not exist or has no members. No action needed."
fi
