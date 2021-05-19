#!/bin/bash
#
# Third script to break server for Troubleshooting Lab.
#

# Clear screen.
clear

# Don't cheat.
> /var/log/pki/ca1/ca/debug &>/dev/null
systemctl stop pki-tomcatd@ca1.service &>/dev/null
chcon system_u:object_r:cert_t:s0 /var/lib/pki/ca1/alias/cert8.db &>/dev/null
systemctl start pki-tomcatd@ca1.service &>/dev/null

echo "Break Script #3"

echo "---------------------------------"
echo "***********SYSTEM DOWN***********"
echo "*                               *"
echo "* Investigate the cause of the  *"
echo "* third outage using your elite *"
echo "* troubleshooting skills!       *"
echo "*                               *"
echo "*********************************"
echo "---------------------------------"
