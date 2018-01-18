---
title: Login Tour - Wetty
workshops: openshift_v3_7_101
workshop_weight: 5
layout: lab
---

# Introduction to Wetty (Browser-based SSH)

This lab provides a quick tour of the browser based SSH client Wetty. To help you get familiar with lab environment along with some key terminology we will use in subsequent lab content.


# Accessing Wetty

Use this URL to access the Wetty node, just change the workshopname. Ask your instructor for the workshopname. 

## Your terminal environment resides here:

https://A_CUSTOMER.{YOUR#}.demo-dlt.com/wetty/ssh/ec2-user

When your browser session appears in your browser, it will prompt you for a login ID; use "ec2-user"

You will then be prompted for a password for which you will not see when typed; <see instructor>

# use "redhat!@#"

After successful login, you will have a command prompt!

```bash
https://A_CUSTOMER.{YOUR#}.demo-dlt.com/wetty/ssh/ec2-user
```

### Login Info
```bash
login:    ec2-user
Password: <Instructor Provided>
```

After logging in, you should see a shell.

<img src="../images/wetty.png" width="1000" />

The wetty instance will already have the 'oc' command installed on them. The 'oc' command is used to connect to the OpenShift Master. 
