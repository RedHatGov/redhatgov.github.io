#!/bin/bash
#
# Second script to break server for Troubleshooting Lab.
#

# Clear screen.
clear

# Check if user is root.
if [ "$(id -u)" != "0" ]; then
  echo "You need to run this as root."
  exit 1
fi

# Don't cheat.
> /var/log/pki/ca1/ca/debug &>/dev/null
systemctl stop pki-tomcatd@ca1.service &>/dev/null
chown root:root /etc/pki/ca1/ca/CS.cfg &>/dev/null
systemctl start pki-tomcatd@ca1.service &>/dev/null

echo "Break Script #2"

echo "---------------------------------"
echo "***********SYSTEM DOWN***********"
echo "*                               *"
echo "* Investigate the cause of the  *"
echo "* second outage using your elite*"
echo "* troubleshooting skills!       *"
echo "*                               *"
echo "*********************************"
echo "---------------------------------"
