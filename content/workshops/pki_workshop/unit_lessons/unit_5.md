# Unit 5: CLI tools

In this unit you will access the Certificate System using various command-line interface (CLI) tools. Red Hat Certificate System provides a client command-line interface to access various services on the server.

## Prerequisites

Your environment needs to be configured to use the ca_admin certificate to interact with the subsystems via the CLI. The root user does not have be to used but access to /root/.dogtag is required to use the ca_admin certificate.

1. Store the passwords in a text file. The default passwords are **redhat**.

    `echo redhat > ~/.dogtag/ca1/client_password.txt`

    `echo redhat > ~/.dogtag/ca1/pkcs12_password.txt`

2. Initialize nssdb if it does not exist.

    `pki -C ~/.dogtag/ca1/client_password.txt client-init`

3. Import ca_admin certificate.

    `pki -C ~/.dogtag/ca1/client_password.txt \
    client-cert-import \
    --pkcs12 ~/.dogtag/ca1/ca_admin_cert.p12 \
    --pkcs12-password-file ~/.dogtag/ca1/pkcs12_password.txt`

## certutil

The Certificate Database Tool, **certutil**, is a command-line utility that can create and modify certificate and key databases. It can specifically list, generate, modify, or delete certificates, create or change the password, generate new public and private key pairs, display the contents of the key database, or delete key pairs within the key database.

1. List all certificates.

    `certutil -L -d /var/lib/pki/ca1/alias/ -h all`

2. Show certificate (human-readable).

    `certutil -L -d /var/lib/pki/ca1/alias/ -n "caSigningCert cert-ca1 CA"`

3. Show certificate (ASCII).

    `certutil -L -d /var/lib/pki/ca1/alias/ -n "caSigningCert cert-ca1 CA" -a`

4. Output certificate to file.

    `certutil -L -d /var/lib/pki/ca1/alias/ -n "caSigningCert cert-ca1 CA" -a -o output.crt`

5. List keys (Internal password is in /etc/pki/ca1/password.conf).

    `certutil -K -d /var/lib/pki/ca1/alias/`

6. More documentation can be found in `man certutil` and the [RHDS Administration Guide](https://access.redhat.com/documentation/en-us/red_hat_directory_server/9.0/html/administration_guide/managing_ssl-using_certutil).

## pki

The pki command provides a command-line interface allowing clients to access various services on the Certificate System server.   These  services  include  certificates, groups, keys, security domains, and users.

### Show users using pki

1. List CA users. Accept default answers.

    `pki -C ~/.dogtag/ca1/client_password.txt -n "PKI Administrator for redhat.example.com" ca-user-find`

2. List KRA users.

    `pki -C ~/.dogtag/ca1/client_password.txt -n "PKI Administrator for redhat.example.com" kra-user-find`

3. List OCSP users.

    `pki -C ~/.dogtag/ca1/client_password.txt -n "PKI Administrator for redhat.example.com" ocsp-user-find`

4. List TKS users.

    `pki -C ~/.dogtag/ca1/client_password.txt -n "PKI Administrator for redhat.example.com" tks-user-find`

5. List TPS users.

    `pki -C ~/.dogtag/ca1/client_password.txt -n "PKI Administrator for redhat.example.com" tps-user-find`

### Show groups using pki

1. List CA groups.

    `pki -C ~/.dogtag/ca1/client_password.txt -n "PKI Administrator for redhat.example.com" ca-group-find`

2. List KRA groups.

    `pki -C ~/.dogtag/ca1/client_password.txt -n "PKI Administrator for redhat.example.com" kra-group-find`

3. List OCSP groups.

    `pki -C ~/.dogtag/ca1/client_password.txt -n "PKI Administrator for redhat.example.com" ocsp-group-find`

4. List TKS groups.

    `pki -C ~/.dogtag/ca1/client_password.txt -n "PKI Administrator for redhat.example.com" tks-group-find`

5. List TPS groups.

    `pki -C ~/.dogtag/ca1/client_password.txt -n "PKI Administrator for redhat.example.com" tps-group-find`

## pki-server

The pki-server command provides a command-line interface allowing administrators to perform various administrative operations on the Certificate System instances. These services include starting/stopping instances, enabling/disabling subsystems, performing certain migrations and enabling/disabling startup using nuxwdog.

Operations are performed using file system utilities, and can only be performed by an administrative user on the local host. This utility does not connect to any of the subsystem's WEB or REST interfaces.

### pki-server instance commands

1. Show instances.

    `pki-server instance-find`

2. Stop instance.

    `pki-server instance-stop ca1`

3. Start instance.

    `pki-server instance-start ca1`

### pki-server subsystem commands

1. List subsystems.

    `pki-server subsystem-find -i ca1`

2. List subsystem certs.

    `pki-server subsystem-cert-find -i ca1 ca`

3. Show details of certificate.

    `pki-server subsystem-cert-show -i ca1 ca sslserver --show-all`

4. Disable subsystem.

    `pki-server subsystem-disable -i ca1 ocsp`

5. Enable subsystem.

    `pki-server subsystem-enable -i ca1 ocsp`

## pkidaemon

The pkidaemon command with the 'status' argument provides a way to display the status of all existing PKI instances on a machine. Optionally, an individual PKI instance may be specified by using an optional [instance-name].

The pkidaemon 'start' argument is currently only used internally by the systemctl scripts.

1. Show status of instance.

    `pkidaemon status ca1`

        [CA Status Definitions]
        Unsecure URL        = http://ca1.redhat.example.com:8080/ca/ee/ca
        Secure Agent URL    = https://ca1.redhat.example.com:8443/ca/agent/ca
        Secure EE URL       = https://ca1.redhat.example.com:8443/ca/ee/ca
        Secure Admin URL    = https://ca1.redhat.example.com:8443/ca/services
        PKI Console Command = pkiconsole https://ca1.redhat.example.com:8443/ca
        Tomcat Port         = 8005 (for shutdown)

        [KRA Status Definitions]
        Secure Agent URL    = https://ca1.redhat.example.com:8443/kra/agent/kra
        Secure Admin URL    = https://ca1.redhat.example.com:8443/kra/services
        PKI Console Command = pkiconsole https://ca1.redhat.example.com:8443/kra
        Tomcat Port         = 8005 (for shutdown)

        [OCSP Status Definitions]
        Unsecure URL        = http://ca1.redhat.example.com:8080/ocsp/ee/ocsp/<ocsp request blob>
        Secure Agent URL    = https://ca1.redhat.example.com:8443/ocsp/agent/ocsp
        Secure EE URL       = https://ca1.redhat.example.com:8443/ocsp/ee/ocsp/<ocsp request blob>
        Secure Admin URL    = https://ca1.redhat.example.com:8443/ocsp/services
        PKI Console Command = pkiconsole https://ca1.redhat.example.com:8443/ocsp
        Tomcat Port         = 8005 (for shutdown)

        [TKS Status Definitions]
        Secure Agent URL    = https://ca1.redhat.example.com:8443/tks/agent/tks
        Secure Admin URL    = https://ca1.redhat.example.com:8443/tks/services
        PKI Console Command = pkiconsole https://ca1.redhat.example.com:8443/tks
        Tomcat Port         = 8005 (for shutdown)

        [TPS Status Definitions]
        Unsecure URL        = http://ca1.redhat.example.com:8080/tps
        Secure URL          = https://ca1.redhat.example.com:8443/tps
        Unsecure PHONE HOME = http://ca1.redhat.example.com:8080/tps/phoneHome
        Secure PHONE HOME   = https://ca1.redhat.example.com:8443/tps/phoneHome
        Tomcat Port         = 8005 (for shutdown)

        [CA Configuration Definitions]
        PKI Instance Name:   ca1

        PKI Subsystem Type:  Root CA (Security Domain)

        Registered PKI Security Domain Information:
        ==========================================================================
        Name:  redhat.example.com Security Domain
        URL:   https://ca1.redhat.example.com:8443
        ==========================================================================

        [KRA Configuration Definitions]
        PKI Instance Name:   ca1

        PKI Subsystem Type:  KRA

        Registered PKI Security Domain Information:
        ==========================================================================
        Name:  redhat.example.com Security Domain
        URL:   https://ca1.redhat.example.com:8443
        ==========================================================================

        [OCSP Configuration Definitions]
        PKI Instance Name:   ca1

        PKI Subsystem Type:  OCSP

        Registered PKI Security Domain Information:
        ==========================================================================
        Name:  redhat.example.com Security Domain
        URL:   https://ca1.redhat.example.com:8443
        ==========================================================================

        [TKS Configuration Definitions]
        PKI Instance Name:   ca1

        PKI Subsystem Type:  TKS

        Registered PKI Security Domain Information:
        ==========================================================================
        Name:  redhat.example.com Security Domain
        URL:   https://ca1.redhat.example.com:8443
        ==========================================================================

        [TPS Configuration Definitions]
        PKI Instance Name:   ca1

        PKI Subsystem Type:  TPS

        Registered PKI Security Domain Information:
        ==========================================================================
        Name:  redhat.example.com Security Domain
        URL:   https://ca1.redhat.example.com:8443
        ==========================================================================

The next lesson is [Unit 6: Issuing a certificate](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_6.md).
