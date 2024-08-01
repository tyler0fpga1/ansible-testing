#!/bin/bash
###################
# LXC CHECK Setup #	
# VERSION:   0.1a #
###################


# Check for Proxmox LXC
if command -v pct > /dev/null; then     
        echo "PM-LXC: true"
	#$FLAG_VAR=1
 else
        echo "PM-LXC: false"
	#$FLAG_VAR=0
fi
# Check for python3-lxc
if command -v pct > /dev/null; then     
        echo "python3-lxc: true"
	#$FLAG_VAR=1
 else
        echo "python3-lxc: false"
	echo "Installing..."
	$PKG_EXE python3-lxc
	#$FLAG_VAR=0
 fi


