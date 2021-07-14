# Unit 1: Installing Directory Server

In this unit you will install [Red Hat Directory Server](https://www.redhat.com/en/technologies/cloud-computing/directory-server "Red Hat Directory Server"). Red Hat Directory Server provides a centralized directory service for an intranet, network, and extranet information. Directory Server integrates with existing systems and acts as a centralized repository for the consolidation of employee, customer, supplier, and partner information. Directory Server can even be extended to manage user profiles, preferences, and authentication. 

Red Hat Directory Server is used as the backend for Red Hat Certificate System. The setup script can be used interactively but we are going to use an automated install with pre-configured settings.

Note: The default password is **redhat**.

1. Install Directory Server. The **redhat-ds** package will install all the Directory Server packages.

    `yum install redhat-ds`

2. Change to the pki-workshop/unit_labs/rhds directory. This was cloned during the prerequisites.

    `cd pki-workshop/unit_labs/rhds` 

3. Run the setup script. This will automatically configure Directory Server based on the settings in [ds1-setup.ldif](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_labs/rhds/ds1-setup.ldif "ds1-setup.ldif") and [ds1-network.ldif](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_labs/rhds/ds1-network.ldif "ds1-network.ldif").

    `setup-ds.pl --silent --file=ds1-setup.ldif`

4. Ensure the Directory Server is running and enabled.

    `systemctl is-enabled dirsrv@ds1.service`

    `systemctl status dirsrv@ds1.service`
    or
    `status-dirsrv`

5. Query the LDAP server using **ldapsearch**.

    `ldapsearch -W -h ds1.redhat.example.com -p 389 -D "cn=Directory Manager" -b "cn=config"`

        Enter LDAP Password:

        # extended LDIF
        #
        # LDAPv3
        # base <cn=config> with scope subtree
        # filter: (objectclass=*)
        # requesting: ALL
        #

        # config
        dn: cn=config
        cn: config
        objectClass: top
        objectClass: extensibleObject
        objectClass: nsslapdConfig
        nsslapd-backendconfig: cn=config,cn=userRoot,cn=ldbm database,cn=plugins,cn=config
        nsslapd-betype: ldbm database
        nsslapd-privatenamespaces: cn=schema
        nsslapd-privatenamespaces:
        nsslapd-privatenamespaces: cn=monitor
        nsslapd-privatenamespaces: cn=config
        nsslapd-plugin: cn=binary syntax,cn=plugins,cn=config
        nsslapd-plugin: cn=bit string syntax,cn=plugins,cn=config
        ...

You now have a Directory Server running at **ds1.redhat.example.com** over port 389.

The next lesson is [Unit 2: Installing a Certificate Authority](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_2.md).
