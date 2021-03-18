---
title: Lab 2.2 - Clean-up & Summary
workshops: openshift_4_101
workshop_weight: 12
layout: lab
---

### Terminal access
``
{{< urishortfqdn "https://" "console-openshift-console.apps" "/terminal" >}}
``

## Let's clean this up

> <i class="fa fa-terminal"></i> Let's clean up all this to get ready for the next lab:

```bash
$ oc project demo-{{< span2 userid "YOUR#" >}}
$ oc delete all --selector app=nexus
```

# Summary
In this lab, you've deployed an example container image into a pod running in OpenShift.  You exposed a route for clients to access that service via their web browsers.  And you learned how to get and describe resources using the command line and the web console.  Hopefully, this basic lab also helped to get you familiar with using the CLI and navigating within the web console.

{{< importPartial "footer/footer.html" >}}
