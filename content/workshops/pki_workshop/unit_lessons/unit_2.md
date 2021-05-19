# Unit 2: Installing a Certificate Authority

In this unit you will install a Certificate Authority (CA), or Certificate Manager. The CA is the core of the PKI; it issues and revokes all certificates. The Certificate Manager is also the core of the Certificate System. By establishing a security domain of trusted subsystems, it establishes and manages relationships between the other subsystems. 

The **pkispawn** setup script can be used interactively but we are going to use an automated install with pre-configured settings.

Note: The default password is **redhat**.

1. Install Certificate System. The **redhat-pki** package will install all the Certificate System packages.

    `yum install redhat-pki`

2. Change to the pki-workshop/unit_labs/rhcs directory. This was cloned during the prerequisites.

    `cd pki-workshop/unit_labs/rhcs` 

3. Run **pkispawn** to install the CA using the user-defined configuration file.

    `pkispawn -s CA -f master_install.cfg`

        Log file: /var/log/pki/pki-ca-spawn.20180617091924.log
        Loading deployment configuration from master_install.cfg.
        Installing CA into /var/lib/pki/ca1.
        Storing deployment configuration into /etc/sysconfig/pki/tomcat/ca1/ca/deployment.cfg.
        Notice: Trust flag u is set automatically if the private key is present.

            ==========================================================================
                                        INSTALLATION SUMMARY
            ==========================================================================

              Administrator's username:             caadmin
              Administrator's PKCS #12 file:
                    /root/.dogtag/ca1/ca_admin_cert.p12

              To check the status of the subsystem:
                    systemctl status pki-tomcatd@ca1.service

              To restart the subsystem:
                    systemctl restart pki-tomcatd@ca1.service

              The URL for the subsystem is:
                    https://ca1.redhat.example.com:8443/ca

              PKI instances will be enabled upon system boot

            ==========================================================================


4. Check status of CA.

    `systemctl status -l pki-tomcatd@ca1.service`

5. View certificates in the nssdb.

    `certutil -L -d /var/lib/pki/ca1/alias`

6. (Optional) View install log. This will give an overview of what was done during the install.

    Where <timestamp> is the latest date.

    `vim /var/log/pki/pki-ca-spawn.<timestamp>.log`

## Directory Structure

Below is the install directory layout.

| Use           | Directory     |
| ------------- | ------------- |
| Main Directory | /var/lib/pki/ca1 |
| Configuration Directory | /etc/pki/ca1 | 
| Security Databases | /var/lib/pki/ca1/alias |
| Log Files | /var/log/pki/ca1 |

The next lesson is [Unit 3: Install other subsystems](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_3.md).
