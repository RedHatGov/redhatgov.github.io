# Unit 11: Certificate profiles

In this unit you will go over the caUserCert profile. This certificate profile is for enrolling user certificates.

The CA profiles are located here:

    /var/lib/pki/ca1/ca/profiles/ca

The [caUserCert.cfg](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_labs/rhcs/caUserCert.cfg) profile is located in the rhcs labs folder.

## Example caUserCert Profile

The first part of a certificate profile is the description. This shows the name, long description, whether it is enabled, and who enabled it.

    desc=This certificate profile is for enrolling user certificates.
    visible=true
    enable=true
    enableBy=admin
    name=Manual User Dual-Use Certificate Enrollment

***

The missing auth.instance_id= entry in this profile means that with this profile, authentication is not needed to submit the enrollment request.

    auth.class_id=

***

Next, the profile lists all of the required inputs for the profile. For the **caUserCert** profile, this defines the keys to generate, the fields to use in the subject name, and the fields to use for the person submitting the certificate. 

    input.list=i1,i2,i3
    input.i1.class_id=keyGenInputImpl
    input.i2.class_id=subjectNameInputImpl
    input.i3.class_id=submitterInfoInputImpl

***

Next, the profile must define the output, meaning the format of the final certificate. There are several pre-defined outputs. More than one of these can be used, but none of the values of the output can be modified.

    output.list=o1
    output.o1.class_id=certOutputImpl

***

The last — largest — block of configuration is the policy set for the profile. Policy sets list all of the settings that are applied to the final certificate, like its validity period, its renewal settings, and the actions the certificate can be used for. The policyset.list parameter identifies the block name of the policies that apply to one certificate; the policyset.userCertSet.list lists the individual policies to apply.

For example, the sixth policy populates the Key Usage Extension automatically in the certificate, according to the configuration in the policy. It sets the defaults and requires the certificate to use those defaults by setting the constraints.

    policyset.list=userCertSet
    policyset.userCertSet.list=1,10,2,3,4,5,6,7,8,9
    ...
    policyset.userCertSet.6.constraint.class_id=keyUsageExtConstraintImpl
    policyset.userCertSet.6.constraint.name=Key Usage Extension Constraint
    policyset.userCertSet.6.constraint.params.keyUsageCritical=true
    policyset.userCertSet.6.constraint.params.keyUsageDigitalSignature=true
    policyset.userCertSet.6.constraint.params.keyUsageNonRepudiation=true
    policyset.userCertSet.6.constraint.params.keyUsageDataEncipherment=false
    policyset.userCertSet.6.constraint.params.keyUsageKeyEncipherment=true
    policyset.userCertSet.6.constraint.params.keyUsageKeyAgreement=false
    policyset.userCertSet.6.constraint.params.keyUsageKeyCertSign=false
    policyset.userCertSet.6.constraint.params.keyUsageCrlSign=false
    policyset.userCertSet.6.constraint.params.keyUsageEncipherOnly=false
    policyset.userCertSet.6.constraint.params.keyUsageDecipherOnly=false
    policyset.userCertSet.6.default.class_id=keyUsageExtDefaultImpl
    policyset.userCertSet.6.default.name=Key Usage Default
    policyset.userCertSet.6.default.params.keyUsageCritical=true
    policyset.userCertSet.6.default.params.keyUsageDigitalSignature=true
    policyset.userCertSet.6.default.params.keyUsageNonRepudiation=true
    policyset.userCertSet.6.default.params.keyUsageDataEncipherment=false
    policyset.userCertSet.6.default.params.keyUsageKeyEncipherment=true
    policyset.userCertSet.6.default.params.keyUsageKeyAgreement=false
    policyset.userCertSet.6.default.params.keyUsageKeyCertSign=false
    policyset.userCertSet.6.default.params.keyUsageCrlSign=false
    policyset.userCertSet.6.default.params.keyUsageEncipherOnly=false
    policyset.userCertSet.6.default.params.keyUsageDecipherOnly=false
    ...

***

The last lesson is [Unit 12: Troubleshooting](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_12.md).
