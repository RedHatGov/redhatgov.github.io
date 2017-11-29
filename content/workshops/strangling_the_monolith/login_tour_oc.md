---
title: Lab - Login & Tour of OpenShift
workshops: strangling_the_monolith
workshop_weight: 30
layout: lab
---


# Welcome to OpenShift!
This lab provides a quick tour of the console to help you get familiar with the user interface along with some key terminology we will use in subsequent lab content.  If you are already familiar with the basics of OpenShift you can skip this lab - after making sure you can login.

# Wetty Environment Links  

Your instructor will assign you an OpenShift environment and login.  

Please click "Return to Workshop" above to view the OpenShift Environment Links.

# Key Terms
We will be using the following terms throughout the workshop labs so here are some basic definitions you should be familiar with.  And you'll learn more terms along the way, but these are the basics to get you started.

* Container - Your software wrapped in a complete filesystem containing everything it needs to run
* Image - We are talking about Docker images; read-only and used to create containers
* Pod - One or more docker containers that run together
* Service - Provides a common DNS name to access a pod (or replicated set of pods)
* Project - A project is a group of services that are related logically (for this workshop we have setup your account to have access to just a single project)
* Deployment - an update to your application triggered by a image change or config change
* Build - The process of turning your source code into a runnable image
* BuildConfig - configuration data that determines how to manage your build
* Route - a labeled and DNS mapped network path to a service from outside OpenShift
* Master - The foreman of the OpenShift architecture, the master schedules operations, watches for problems, and orchestrates everything
* Node - Where the compute happens, your software is run on nodes

# Accessing OpenShift
OpenShift provides a web console that allow you to perform various tasks via a web browser.  Additionally, you can utilize a command line tool to perfrom tasks.  Let's get started by logging into both of these and checking the status of the platform.

# Let's Login
> Navigate to the URI provided by your instructor and login with the user/password provided (if there's an icon on the Desktop, just double click that)

<img src="../img/ose-login.png" width="1000" />
*Login Webpage*

Once logged in you should see your available projects.

An OpenShift project allows a community of users (or a user) to organize and manage their content in isolation from other communities. Each project has its own resources, policies (who can or cannot perform actions), and constraints (quotas and limits on resources, etc). Projects act as a "wrapper" around all the application services and endpoints you (or your teams) are using for your work.

Users must be given access to projects by administrators, or if allowed to create projects, automatically have access to their own projects.

Projects can have a separate **name**, **displayName**, and **description**.

- The mandatory **name** is a unique identifier for the project and is most visible when using the CLI tools or API.
- The optional **displayName** is how the project is displayed in the web console (defaults to name).
- The optional **description** can be a more detailed description of the project and is also visible in the web console.

{{% alert info %}}
A project is technically a Kubernetes namespace with additional annotations.
{{% /alert %}}

# So this is what an empty project looks like
> Click on one of the projects from the project list

Don't worry, it's supposed to look empty right now because you currently don't have anything in your project.  We'll fix that in the next lab.

{{% alert info %}}
If you do not see an available project, go ahead and click `New Project` and create one.
{{% /alert %}}

# Let's try the command line
> <i class="fa fa-terminal"></i> Open a terminal and login using the same URI/user/password with following command:

```bash
$ oc login [URI] --insecure-skip-tls-verify=true
```
See example below:

```bash
$ oc login https://<workshopname>master.0.redhatgov.io:8443 --insecure-skip-tls-verify=true
```


> <i class="fa fa-terminal"></i> Check to see what projects you have access to:

```bash
$ oc get projects
```

# It looks empty via the command line too
> <i class="fa fa-terminal"></i> Type the following command to use the demo project (replace 'demo' with the project you want to use if there isn't a demo project):

```bash
$ oc new-project demo
```
{{% alert info %}}
You may recieve the message "Error from server: project "demo" already exists". Try another project name i.e. your first initial and lastname.
{{% /alert %}}

> <i class="fa fa-terminal"></i> If you create more than one project, then you can switch projects with the following command:

```bash
$ oc project [NAME]
```

# Help about any command

To see the full list of commands supported, run `oc help`.

> <i class="fa fa-terminal"></i> Type the following command to read more information about services, deployment configs, build configurations, and active deployments:

```bash
$ oc status -h
```

# Summary
You should now be ready to get hands-on with our workshop labs.
