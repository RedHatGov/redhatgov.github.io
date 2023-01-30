#!/bin/bash
#
# First script to break server for Troubleshooting Lab.
#

# Clear screen.
clear

# Check if user is root.
if [ "$(id -u)" != "0" ]; then
  echo "You need to run this as root."
  exit 1
fi

# Copy log files.
if [ -h /etc/pki/ca1/logging.properties ]; then
  unlink /etc/pki/ca1/logging.properties
  cp logging.properties /etc/pki/ca1/logging.properties
  cp log4j.properties /etc/pki/ca1/log4j.properties
  chown pkiuser:pkiuser /etc/pki/ca1/logging.properties
  chown pkiuser:pkiuser /etc/pki/ca1/log4j.properties
  restorecon -F /etc/pki/ca1/logging.properties
  restorecon -F /etc/pki/ca1/log4j.properties
else
  cp logging.properties /etc/pki/ca1/logging.properties
  cp log4j.properties /etc/pki/ca1/log4j.properties
  chown pkiuser:pkiuser /etc/pki/ca1/logging.properties
  chown pkiuser:pkiuser /etc/pki/ca1/log4j.properties
  restorecon -F /etc/pki/ca1/logging.properties
  restorecon -F /etc/pki/ca1/log4j.properties
fi 

# Don't cheat.
> /var/log/pki/ca1/ca/debug &>/dev/null
systemctl stop dirsrv@ds1.service &>/dev/null
systemctl restart pki-tomcatd@ca1.service &>/dev/null

echo "Break Script #1"

echo "---------------------------------"
echo "***********SYSTEM DOWN***********"
echo "*                               *"
echo "* Investigate the cause of the  *"
echo "* first outage using your elite *"
echo "* troubleshooting skills!       *"
echo "*                               *"
echo "*********************************"
echo "---------------------------------"
