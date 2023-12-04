#!/bin/bash

###########################################################################
# Nicolas Thompson							  #
# 12-04-2023								  #
# This script checks if the ctl-alt-del.target is masked or active. 	  #
# It will mask it if active and do the inverse. The last thing it does is #
# reload the systemd daemon to apply the changes.			  #
###########################################################################

# Check if ctrl-alt-del.target is masked
if sudo systemctl is-active --quiet ctrl-alt-del.target; then
    echo "ctrl-alt-del.target is active. Masking..."
    sudo systemctl mask ctrl-alt-del.target
fi

# Check if ctrl-alt-del.target is masked
if ! sudo systemctl is-active --quiet ctrl-alt-del.target; then
    echo "ctrl-alt-del.target is not masked. Masking..."
    sudo systemctl mask ctrl-alt-del.target
fi

# Reload the systemd daemon
sudo systemctl daemon-reload

echo "Ctrl-Alt-Delete sequence is disabled."


# run this script with: sudo ./disableSequence.sh (it needs sudo to work)
