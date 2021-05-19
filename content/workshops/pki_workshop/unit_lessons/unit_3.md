# Unit 3: Installing other subsytems

In this unit you will install the other subsystems associated with Certificate System. Key Recovery Authority (KRA), Online Certificate Status Protocol (OCSP), Token Key Service (TKS), and Token Processing System (TPS).

## KRA

A Key Recovery Authority (KRA). Certificates are created based on a specific and unique key pair. If a private key is ever lost, then the data which that key was used to access (such as encrypted emails) is also lost because it is inaccessible. The KRA stores key pairs, so that a new, identical certificate can be generated based on recovered keys, and all of the encrypted data can be accessed even after a private key is lost or damaged. 

1. Change to the pki-workshop/unit_labs/rhcs directory. This was cloned during the prerequisites.

    `cd pki-workshop/unit_labs/rhcs`

2. Run **pkispawn** to install the KRA using the user-defined configuration file.

    `pkispawn -s KRA -f master_install.cfg`

        Log file: /var/log/pki/pki-kra-spawn.20180617092826.log
        Loading deployment configuration from master_install.cfg.
        Installing KRA into /var/lib/pki/ca1.
        Storing deployment configuration into /etc/sysconfig/pki/tomcat/ca1/kra/deployment.cfg.

            ==========================================================================
                                        INSTALLATION SUMMARY
            ==========================================================================

              Administrator's username:             kraadmin

              To check the status of the subsystem:
                    systemctl status pki-tomcatd@ca1.service

              To restart the subsystem:
                    systemctl restart pki-tomcatd@ca1.service

              The URL for the subsystem is:
                    https://ca1.redhat.example.com:8443/kra

              PKI instances will be enabled upon system boot

            ==========================================================================


3. Check status of KRA.

    `systemctl status -l pki-tomcatd@ca1.service`

## OCSP

An Online Certificate Status Protocol (OCSP) responder. The OCSP verifies whether a certificate is valid and not expired. This function can also be done by the CA, which has an internal OCSP service, but using an external OCSP responder lowers the load of the issuing CA. 

1. Change to the pki-workshop/unit_labs/rhcs directory. This was cloned during the prerequisites.

    `cd pki-workshop/unit_labs/rhcs`

2. Run **pkispawn** to install the OCSP using the user-defined configuration file.

    `pkispawn -s OCSP -f master_install.cfg`

        Log file: /var/log/pki/pki-ocsp-spawn.20180617093123.log
        Loading deployment configuration from master_install.cfg.
        Installing OCSP into /var/lib/pki/ca1.
        Storing deployment configuration into /etc/sysconfig/pki/tomcat/ca1/ocsp/deployment.cfg.

            ==========================================================================
                                        INSTALLATION SUMMARY
            ==========================================================================

              Administrator's username:             ocspadmin

              To check the status of the subsystem:
                    systemctl status pki-tomcatd@ca1.service

              To restart the subsystem:
                    systemctl restart pki-tomcatd@ca1.service

              The URL for the subsystem is:
                    https://ca1.redhat.example.com:8443/ocsp

              PKI instances will be enabled upon system boot

            ==========================================================================


3. Check status of OCSP.

    `systemctl status -l pki-tomcatd@ca1.service`

## TKS
A Token Key Service (TKS). The TKS derives keys based on the token CCID, private information, and a defined algorithm. These derived keys are used by the TPS to format tokens and enroll certificates on the token. 

1. Change to the pki-workshop/unit_labs/rhcs directory. This was cloned during the prerequisites.

    `cd pki-workshop/unit_labs/rhcs`

2. Run **pkispawn** to install the TKS using the user-defined configuration file.

    `pkispawn -s TKS -f master_install.cfg`

        Log file: /var/log/pki/pki-tks-spawn.20180617093408.log
        Loading deployment configuration from master_install.cfg.
        Installing TKS into /var/lib/pki/ca1.
        Storing deployment configuration into /etc/sysconfig/pki/tomcat/ca1/tks/deployment.cfg.

            ==========================================================================
                                        INSTALLATION SUMMARY
            ==========================================================================

              Administrator's username:             tksadmin

              To check the status of the subsystem:
                    systemctl status pki-tomcatd@ca1.service

              To restart the subsystem:
                    systemctl restart pki-tomcatd@ca1.service

              The URL for the subsystem is:
                    https://ca1.redhat.example.com:8443/tks

              PKI instances will be enabled upon system boot

            ==========================================================================


3. Check status of TKS.

    `systemctl status -l pki-tomcatd@ca1.service`

## TPS
A Token Processing System (TPS). The TPS interacts directly with external tokens, like smart cards, and manages the keys and certificates on those tokens through a local client, the Enterprise Security Client (ESC). The ESC contacts the TPS when there is a token operation, and the TPS interacts with the CA, KRA, or TKS, as required, then send the information back to the token by way of the Enterprise Security Client. 

1. Change to the pki-workshop/unit_labs/rhcs directory. This was cloned during the prerequisites.

    `cd pki-workshop/unit_labs/rhcs`

2. Run **pkispawn** to install the TPS using the user-defined configuration file.

    `pkispawn -s TPS -f master_install.cfg`

        Log file: /var/log/pki/pki-tps-spawn.20180617093818.log
        Loading deployment configuration from master_install.cfg.
        Installing TPS into /var/lib/pki/ca1.
        Storing deployment configuration into /etc/sysconfig/pki/tomcat/ca1/tps/deployment.cfg.

            ==========================================================================
                                        INSTALLATION SUMMARY
            ==========================================================================

              Administrator's username:             tpsadmin

              To check the status of the subsystem:
                    systemctl status pki-tomcatd@ca1.service

              To restart the subsystem:
                    systemctl restart pki-tomcatd@ca1.service

              The URL for the subsystem is:
                    https://ca1.redhat.example.com:8443/tps

              PKI instances will be enabled upon system boot

            ==========================================================================


3. Check status of TPS.

    `systemctl status -l pki-tomcatd@ca1.service`

The next lesson is [Unit 4: Accessing the Web Interface](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_4.md).
