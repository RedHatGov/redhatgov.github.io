#!/bin/bash
#
# Fourth script to break server for Troubleshooting Lab.
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
sed -i 's|internaldb=redhat|internaldb=redhat123|' /etc/pki/ca1/password.conf &>/dev/null
systemctl start pki-tomcatd@ca1.service &>/dev/null

echo "Break Script #4"

echo "---------------------------------"
echo "***********SYSTEM DOWN***********"
echo "*                               *"
echo "* Investigate the cause of the  *"
echo "* fourth outage using your elite*"
echo "* troubleshooting skills!       *"
echo "*                               *"
echo "*********************************"
echo "---------------------------------"
