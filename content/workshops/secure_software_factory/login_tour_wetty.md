---
title: Login Tour - Wetty
workshops: secure_software_factory
workshop_weight: 10
layout: lab
---

# Introduction to Wetty (Browser-based SSH)

This lab provides a quick tour of the browser based SSH client Wetty. To help you get familiar with lab environment along with some key terminology we will use in subsequent lab content.


# Accessing Wetty

Use this URL to access the Wetty node, just change the workshopname. Ask your instructor for the workshopname.

```bash
{{< urishortfqdn "https://" "master" ":8888" >}}
```

### Login Info
```bash
login:    user{{< span "userid" "YOUR#" >}}
Password: <Instructor Provided>
```

After logging in, you should see a shell.

<img src="../images/wetty.png" width="1000" />

The wetty instance will already have the 'oc' command installed on them. The 'oc' command is used to connect to the OpenShift Master.
