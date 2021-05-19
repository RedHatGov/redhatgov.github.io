# Unit 4: Accessing the Web Interface

In this unit you will access the web interface of each subsystem. Each Certificate System instance is a Tomcat server instance and each Certificate System subsystem (such as CA or KRA) is deployed as a web application in Tomcat.

All subsystems share a common administrative interface and have an agent interface that allows for agents to perform the tasks assigned to them. A CA Subsystem has an end-entity interface that allows end-entities to enroll in the PKI. An OCSP Responder subsystem has an end-entity interface allowing end-entities and applications to check for current certificate revocation status. Finally, a TPS has an operator interface.

## Import Admin certificate into browser

Since there are no users you'll need to use the admin certificate to access the Agent subsystem pages.

1. Copy the admin cert to your local computer.

    `/root/.dogtag/ca1/ca_admin_cert.p12`

2. Start Firefox with a new profile since we'll be adding certificates that you may not want included in your default profile.

    `firefox -P cs`

3. Import certificate into Firefox. The password is **redhat**.

        Preferences
        Privacy & Security
        View Certificates
        Your Certificates tab
        Import
        Select ca_admin_cert.p12
        Input password

## Import CA Chain

Next, you'll need to add the CA chain into Firefox.

1. Open CA webpage.

    `https://ca1.redhat.example.com:8443/ca`

2. Select `PKI Administrator` certificate.

3. Add Exception for insecure connection.

4. Click link for `SSL End Users Services`.

5. Click `Retrieval` tab.

6. Click link for `Import CA Certificate Chain`.

7. Choose `Import the CA certificate chain into your browser`.

8. Click Submit.

9. Check all 3 Trust boxes.

10. Click OK.

## View each subsystem page

The agent services pages are where almost all of the certificate and token management tasks are performed. The end-entities (ee) pages are where end users interact with the subsystems.

Test access with each subsystem webpage to become familiar with the web interface. For some of the webpages you will be prompted to choose a certificate. The admin certificate from the previous steps is the correct one. The password is **redhat**.

* Main page.

    `https://ca1.redhat.example.com:8443/`

* Subsystems page.

    `https://ca1.redhat.example.com:8443/pki/ui/`

* Certificate Authority pages.

    `https://ca1.redhat.example.com:8443/ca/ee/ca`

    `https://ca1.redhat.example.com:8443/ca/agent/ca`

* Key Recovery Authority page.

    `https://ca1.redhat.example.com:8443/kra/agent/kra`

* OCSP page.

    `https://ca1.redhat.example.com:8443/ocsp/agent/ocsp`

* TPS page.

    `https://ca1.redhat.example.com:8443/tps/`

The next lesson is [Unit 5: CLI tools](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_5.md).
