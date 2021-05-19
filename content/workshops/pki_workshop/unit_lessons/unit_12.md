# Unit 12: Troubleshooting

In this unit you will troubleshoot common issues with maintaining a Certificate System. Each section has a shell script to run that will "break" the system. A hint will be offered to help you hone your troubleshooting skills.

## Instructions

To solve, the CA should be accessible in a browser without errors in status output or logs.

### Run script to break CA (1st lab)

1. Change to labs troubleshooting directory.

    `cd pki-workshop/unit_labs/rhcs`

2. Run first lab.

    `bash break1.sh`


        Break Script #1

        ---------------------------------
        ***********SYSTEM DOWN***********
        *                               *
        * Investigate the cause of the  *
        * first outage using your elite *
        * troubleshooting skills!       *
        *                               *
        *********************************
        ---------------------------------

3. Troubleshoot.

### Solution

<details>
<summary>Click to expand solution.</summary>

<ol>
  <li>The webpage is shows a java error but no real clues.</li>
  <li>The status command does not list anything relevant.<br>
    <code>systemctl status pki-tomcatd@ca1.service -l</code></li>
  <li>A clue is in journalctl.<br>
    <code>journalctl -u pki-tomcatd@ca1.service</code><br>
    <code>Password test execution failed. Is the database up?</code></li>
  <li>Another clue in the ca debug log.<br>
    <code>Could not connect to LDAP server host ds1.redhat.example.com port 389 Error</code></li>
  <li>Check the status of the DS:<br>
    <code>systemctl status dirsrv@ds1.service</code></li>
  <li>The DS is not running. Start the DS.<br>
    <code>systemctl start dirsrv@ds1.service</code></li>
  <li>Restart CS.<br>
    <code>systemctl restart pki-tomcatd@ca1.service</code></li>
  <li>Check webpage. Should be accessible.</li>
</ol>

</details>

***

### Run script to break CA (2nd lab)

1. Change to labs troubleshooting directory.

    `cd pki-workshop/unit_labs/rhcs`

2. Run second lab.

    `bash break2.sh`

        Break Script #2

        ---------------------------------
        ***********SYSTEM DOWN***********
        *                               *
        * Investigate the cause of the  *
        * second outage using your elite*
        * troubleshooting skills!       *
        *                               *
        *********************************
        ---------------------------------

3. Troubleshoot.

### Solution

<details>
<summary>Click to expand solution.</summary>

<ol>
  <li>The webpage is inaccessible.</li>
  <li>The status command has a clue.<br>
    <code>systemctl status pki-tomcatd@ca1.service -l</code><br>
    <code>Permission denied: '/var/lib/pki/ca1/ca/conf/CS.cfg'</code></li>
  <li>Same error in journalctl.<br>
    <code>journalctl -u pki-tomcatd@ca1.service</code></li>
  <li>Nothing in the debug log because the CA did not start so nothing was written to the log.</li>
  <li>Check ownership/perms on CS.cfg<br>
    <code>ls -l /var/lib/pki/ca1/ca/conf/CS.cfg</code></li>
  <li>The file is owned by root. Should be owned by pkiuser.<br>
    <code>chown pkiuser:pkiuser /var/lib/pki/ca1/ca/conf/CS.cfg</code></li>
  <li>Restart CS.<br>
    <code>`systemctl restart pki-tomcatd@ca1.service`</code></li>
  <li>Check webpage. Should be accessible.</li>
</ol>

</details>

***

### Run script to break CA (3rd lab)

1. Change to labs troubleshooting directory.

    `cd pki-workshop/unit_labs/rhcs`

2. Run third lab.

    `bash break3.sh`

        Break Script #3

        ---------------------------------
        ***********SYSTEM DOWN***********
        *                               *
        * Investigate the cause of the  *
        * third outage using your elite *
        * troubleshooting skills!       *
        *                               *
        *********************************
        ---------------------------------

3. Troubleshoot.

### Solution

<details>
<summary>Click to expand solution.</summary>

<ol>
  <li>The webpage is inaccessible.</li>
  <li>The status command shows a partial java error.<br>
    <code>systemctl status pki-tomcatd@ca1.service -l</code></li>
  <li>A clue is in journalctl.<br>
    <code>journalctl -u pki-tomcatd@ca1.service</code><br>
    <code>SEVERE: Exception initializing random number generator using provider [Mozilla-JSS]</code></li>
  <li>Nothing in the debug log because the CA did not start so nothing was written to the log.</li>
  <li>Same error in the catalina.<timestamp>.log.<br>
    <code>java.security.NoSuchProviderException: no such provider: Mozilla-JSS</code></li>
  <li>Another clue in the CA system log.<br>
    <code>JSS General Security Error Failed to create jss service: java.lang.SecurityException: Unable to initialize security library</code></li>
  <li>Check the nssdb perms. Should be owned by pkiuser.<br>
    <code>ls -al /etc/pki/ca1/alias/</code></li>
  <li>Check the SELinux context. One is different.<br>
    <code>ls -alZ /etc/pki/ca1/alias/</code></li>
  <li>Run restorecon on the file.<br>
    <code>restorecon -Fv /etc/pki/ca1/alias/cert8.db</code></li>
  <li>Restart CS.<br>
    <code>`systemctl restart pki-tomcatd@ca1.service`</code></li>
  <li>Check webpage. Should be accessible.</li>
</ol>

</details>

***

### Run script to break CA (4th lab)

1. Change to labs troubleshooting directory.

    `cd pki-workshop/unit_labs/rhcs`

2. Run fourth lab.

    `bash break4.sh`

        Break Script #4

        ---------------------------------
        ***********SYSTEM DOWN***********
        *                               *
        * Investigate the cause of the  *
        * fourth outage using your elite*
        * troubleshooting skills!       *
        *                               *
        *********************************
        ---------------------------------

3. Troubleshoot.

### Solution

<details>
<summary>Click to expand solution.</summary>

<ol>
  <li>The webpage is shows a java error but no real clues.</li>
  <li>The status command does not list anything relevant.<br>
    <code>systemctl status pki-tomcatd@ca1.service -l</code></li>
  <li>A clue is in journalctl.<br>
    <code>journalctl -u pki-tomcatd@ca1.service</code><br>
    <code>testLDAPConnection: Invalid Password</code></li>
  <li>Nothing in the debug since the CA did not fully start.<br>
  <li>No clues in the catalina, localhost, or system logs.<br>
  <li>We know the passwords are stored in password.conf so check those.<br>
    <code>cat /etc/pki/ca1/password.conf</code></li>
  <li>The internaldb (or DS) password is incorrect. Change it to <code>redhat</code>.</li>
  <li>Restart CS.<br>
    <code>systemctl restart pki-tomcatd@ca1.service</code></li>
  <li>Check webpage. Should be accessible.</li>
</ol>

</details>

***

