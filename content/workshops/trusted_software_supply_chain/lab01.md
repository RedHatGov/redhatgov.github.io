---
title: Lab 01 - OpenShift Environment
workshops: trusted_software_supply_chain
workshop_weight: 11
layout: lab
---
# Welcome to OpenShift!
This lab provides a quick tour of the console to help you get familiar with the user interface along with some key terminology we will use in subsequent lab content.  If you are already familiar with the basics of OpenShift simply ensure you can login and create the project.

# Accrediting the OpenShift Container Platform

Having a secure foundation to your applications are a key component to a Trusted Software Supply Chain.  Your applications will inherit security controls from an accredited OpenShift Container Platform.

The approach to the Authorization and Accreditation (A&A) process with OpenShift follows a Landlord/Tenant model. OpenShift is a container hosting infrastructure and, when assessing system boundaries, a delineation should be made between the OpenShift system itself which operates as a Landlord and the tenant application, who consume the OpenShift service. In Landlord/Tenant system security plans (SSP), many security controls are inherited from the Landlord’s SSP, but some controls remain the responsibility of the OpenShift consumers. Following this division of responsibilities, approximately 73 controls would be considered the responsibility of the tenant, whereas 621 controls that are already taken care of by the Landlord.

<img src="../images/security_inheritance_model.png" width="700" />


# Key Terms
We will be using the following terms throughout the workshop labs so here are some basic definitions you should be familiar with.  You'll learn more terms along the way, but these are the basics to get you started.

* Container - Your software wrapped in a complete filesystem containing everything it needs to run
* Image - We are talking about docker images; read-only and used to create containers
* Pod - One or more docker containers that run together
* Service - Provides a common DNS name to access a pod (or replicated set of pods)
* Project - A project is a group of services that are related logically
* Deployment - an update to your application triggered by a image change or config change
* Build - The process of turning your source code into a runnable image
* BuildConfig - configuration data that determines how to manage your build
* Route - a labeled and DNS mapped network path to a service from outside OpenShift
* Master - The foreman of the OpenShift architecture, the master schedules operations, watches for problems, and orchestrates everything
* Node - Where the compute happens, your software is run on nodes
* Pipeline - Automates the control, building, deploying, and promoting your applications on OpenShift

# Accessing OpenShift
OpenShift provides a web console that allows you to perform various tasks via a web browser.  Additionally, you can utilize a command line tool to perfrom tasks.  Let's get started by logging into both of these and checking the status of the platform.

## Let's Login to the Web Console
Use your browser to navigate to the URI provided by your instructor and login with the user/password provided.

```bash
https://master.ocp-naps.redhatgov.io:8443/
```

<img src="../images/ocp-login.png" width="600"><br/>
*Login Webpage*

Once logged in you should see your available projects

# Accessing Wetty (Browser-based SSH)

Ask your instructor for the URL of Wetty.  On a separate tab, go the Wetty URL.

```bash
https://master.ocp-naps.redhatgov.io:8888
```

### Login Info
```bash
login:    user{{< span "userid" "YOUR#" >}}
Password: <Instructor Provided>
```

After logging in, you should see a shell.

<img src="../images/wetty.png" width="1000" />

The Wetty instance will already have the 'oc' command installed on them. The 'oc' command is used to connect to the OpenShift Master.

## Let's try the 'oc' command line (CLI) tool
On your Wetty Instance, enter the following:

```
$ oc login https://master.ocp-naps.redhatgov.io:8443/ --insecure-skip-tls-verify=true
Authentication required for https://master.ocp-naps.redhatgov.io:8443/ "master" ":8443" >}} (openshift)
 Username: user{{< span "userid" "YOUR#" >}} Password:
Login successful.
```

Check to see what projects you have access to:

```
$ oc get projects
```

Type the following command to show services, deployment configs, build configurations, and active deployments (this will come in handy later):

```
$ oc status
```

# Summary
You should now be ready to get hands-on with our workshop labs.
