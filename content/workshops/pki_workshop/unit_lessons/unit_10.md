# Unit 10: Token Management System

In this unit you will login to the TPS web interface, add a new user, and generate a virtual token.

## TPS Web Interface

The admin certificate needs to be in your browser. This was completed during [Unit 4](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_4.md).

* Open the TPS webpage.

    `https://ca1.redhat.example.com:8443/tps/`

* Click the **Log In** button.

* Go through the different tabs to become familiar with the interface. It will be mostly blank until we create users and tokens.

## Add new user

In this section you will use **ldapmodify** to create the user directly in the Directory Server. You can add a new user on the TPS subsytem page but the password will need to be manually changed in Directory Server. Apache Directory Studio can be used.

1. Change to the pki-workshop/unit_labs/rhcs directory. This was cloned during the prerequisites.

2. Modify the **tps-user.ldif** to replace **brian** with another user name.

3. Run this command to add the user.

    `ldapmodify -x -W -h ds1.redhat.example.com -p 389 -D "cn=Directory Manager" -c -f tps-user.ldif`

4. Verify the user was added.

    `ldapsearch -W -h ds1.redhat.example.com -p 389 -D "cn=Directory Manager" -b "ou=People,dc=tps,dc=redhat,dc=example,dc=com"`

## Generate Virtual Token

1. Edit the **phoneHome.xml** file and change the Operation URL from https to http. Ensure the port listed is the unsecured port (by default 8080).

    `vim /etc/pki/ca1/tps/phoneHome.xml`

2. Restart the CA (certificate authority) service.

    `systemctl restart pki-tomcatd@ca1.service`

3. Change to the pki-workshop/unit_labs/rhcs directory. This was cloned during the prerequisites.

4. Edit **tps_format** and **tps_enroll** to ensure the username and passwords match.

    `vim tps_format`

    `vim tps_enroll`

5. Format the virtual token.

    `tpsclient < tps_format`

6. Enroll the virtual token.

    `tpsclient < tps_enroll`

7. View the token.

    `pki -C ~/.dogtag/ca1/client_password.txt -n "PKI Administrator for redhat.example.com" tps-token-find`

8. View the certificates.

    `pki -C ~/.dogtag/ca1/client_password.txt -n "PKI Administrator for redhat.example.com" tps-cert-find`

9. The token and certs can be viewed on the TPS subsystem page.

The next lesson is [Unit 11: Certificate profiles](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_11.md).
