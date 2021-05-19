## Introduction

[Red Hat Certificate System](https://www.redhat.com/en/technologies/cloud-computing/certificate-system "Red Hat Certificate System") is an enterprise software system that gives you a scalable, secure framework to establish and maintain trusted identities and keep communications private.

Red Hat Certificate System provides certificate life-cycle management-issue, renew, suspend, revoke, archive and recover, and manage single and dual-key X.509v3 certificates needed to handle strong authentication, single sign-on, and secure communications.

The upstream release is called [Dogtag](http://www.dogtagpki.org "Dogtag PKI").

## Curriculum overview

* [Unit 1: Installing Directory Server](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_1.md)
* [Unit 2: Installing a Certificate Authority](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_2.md)
* [Unit 3: Installing other subsytems](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_3.md)
* [Unit 4: Accessing the Web Interface](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_4.md)
* [Unit 5: CLI tools](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_5.md)
* [Unit 6: Issuing a certificate](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_6.md)
* [Unit 7: Recovering a certificate](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_7.md)
* [Unit 8: Revoking a certificate](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_8.md)
* [Unit 9: OCSP Responder](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_9.md)
* [Unit 10: Token Management System](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_10.md)
* [Unit 11: Certificate profiles](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_11.md)
* [Unit 12: Troubleshooting](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_12.md)

## Preparation

Everything is installed on one (1) VM or physical machine but some preparation is needed prior to starting this workshop.

### Requirements

* Red Hat Enterprise Linux 7 (fully patched)
* RHDS (**rhel-7-server-rhds**) and RHCS (**rhel-7-server-rhcmsys-9-rpms**) entitlements
* Clone this repository

    `git clone https://gitlab.consulting.redhat.com/pki/pki-workshop.git`

* Add /etc/hosts entries (IPs can be changed)

        192.168.124.10 ds1.redhat.example.com
        192.168.124.11 ca1.redhat.example.com

* Configure separate interfaces with above IPs. Can be virtual.
* Firewall rules

    `firewall-cmd --permanent --add-service=ldap`

    `firewall-cmd --permanent --add-service=ldaps`

    `firewall-cmd --permanent --add-port=8080/tcp`

    `firewall-cmd --permanent --add-port=8443/tcp`

    `firewall-cmd --reload`

## Get started

Ready to get started? Start the first lesson [Unit 1: Installing Directory Server](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_1.md).

## After the workshop

### Additional Resources

Links

| [CS Deployment Guide](https://access.redhat.com/documentation/en-us/red_hat_certificate_system/9/html/planning_installation_and_deployment_guide/) | [CS Administration Guide](https://access.redhat.com/documentation/en-us/red_hat_certificate_system/9/html/administration_guide/) | [CS CLI Guide](https://access.redhat.com/documentation/en-us/red_hat_certificate_system/9/html/command-line_tools_guide/) |

| [DS Deployment Guide](https://access.redhat.com/documentation/en-us/red_hat_directory_server/10/html/deployment_guide/) | [DS Installation Guide](https://access.redhat.com/documentation/en-us/red_hat_directory_server/10/html/installation_guide/) | [DS Administration Guide](https://access.redhat.com/documentation/en-us/red_hat_directory_server/10/html/administration_guide/) |

| [Dogtag Wiki](http://www.dogtagpki.org/wiki/PKI_Main_Page) |

