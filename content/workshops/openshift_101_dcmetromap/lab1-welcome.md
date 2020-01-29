---
title: Lab 1 - Welcome
workshops: openshift_101_dcmetromap
workshop_weight: 11
layout: lab
---

# Welcome to OpenShift!
This lab provides a quick tour of the console to help you get familiar with the user interface along with some key terminology we will use in subsequent lab content.  If you are already familiar with the basics of OpenShift simply ensure you can login and create the project.

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

# Accessing OpenShift
Additionally, you can utilize a command line tool to perfrom tasks.

## Let's try the command line (CLI)
> <i class="fa fa-terminal"></i> Open a terminal and login using the same URI with following command:

```bash
$ oc login {{< urishortfqdn "https://" "master" ":8443" >}} --insecure-skip-tls-verify=true
Authentication required for {{< urishortfqdn "https://" "master" ":8443" >}} (openshift)
 Username: user{{< span "userid" "YOUR#" >}} Password:
Login successful.
```

> <i class="fa fa-terminal"></i> Check to see what projects you have access to:

```bash
$ oc get projects
```

## It looks empty via the command line too
You just created a project using the web console, let's tell the terminal command line tool to use it.

> <i class="fa fa-terminal"></i> Type the following command to use the demo project:

```bash
$ oc project demo-{{< span userid "YOUR#" >}}
```

> <i class="fa fa-terminal"></i> Type the following command to show services, deployment configs, build configurations, and active deployments (this will come in handy later):

```bash
$ oc status
```

# Summary
You should now be ready to get hands-on with our workshop labs.

{{< importPartial "footer/footer.html" >}}
