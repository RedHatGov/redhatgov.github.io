---
title: Welcome to OpenShift
workshops: agile_integrations
workshop_weight: 11
layout: lab
---
# Welcome to Red Hat OpenShift Container Platform!
This workshop provides a quick tour of the console to help you get familiar with the user interface, along with some key terminology we will use in subsequent exercise content.

# Key Terms
We will be using the following terms throughout the workshop exercises. So, here are some basic definitions you should be familiar with. You'll learn more terms along the way, but these are the basics to get you started.

* Container - Your software wrapped in a complete filesystem containing everything it needs to run
* Image - We are talking about docker images; read-only and used to create containers
* Pod - One or more docker containers that run together
* Service - Provides a common DNS name to access a pod (or replicated set of pods)
* Project - A project is a group of services that are related logically
* Deployment - An update to your application, triggered by a image change or configuration change
* Build - The process of turning your source code into a runnable image
* BuildConfig - Configuration data that determines how to manage your build
* Route - A labeled and DNS-mapped network path to a service, from outside OpenShift
* Master - The foreman of the OpenShift architecture; the master schedules operations, watches for problems, and orchestrates everything.
* Node - Where the compute happens; your software is run on nodes
* Pipeline - Automates the control, build, deployment, and promotion of your applications on OpenShift.

# Accessing OpenShift
OpenShift provides a web console that enables you to perform various tasks via a web browser; you can also utilize a command line tool to perform tasks.  Let's get started by logging into both of these options and checking the status of the platform.

## Section 1: Log in to the Web Console
Use your browser to navigate to the URI provided by your instructor and log in, using the user/password provided.

<img src="../images/ocp-login.png" width="600"><br/>

*Login Webpage*

Once logged in your available projects display. If there are no available projects, a button displays to enable you to create a project.

## Section 2: Try the 'oc' command line (CLI) tool

### Step 1. Open a terminal and log in, using the same URI, with the following command:

```
$ oc login https://ocp-ai.redhatgov.io/ --insecure-skip-tls-verify=true
Authentication required for https://ocp-naps.redhatgov.io/ "master" ":8443" >}} (openshift)
 Username: user#
 Password:
Login successful.
```

### Step 2. Check to see the projects you have access to:

```
$ oc get projects
```

### Step 3. Type the following command to show services, deployment configs, build configurations, and active deployments (this will come in handy later):

```
$ oc status
```

## Summary
You should now be ready to get hands-on with our workshop labs.
