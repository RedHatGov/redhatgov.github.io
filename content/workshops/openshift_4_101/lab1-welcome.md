---
title: Lab 1 - Welcome
workshops: openshift_4_101
workshop_weight: 11
layout: lab
---

# Welcome to OpenShift!
This lab provides a quick tour of the console to help you get familiar with the user interface along with some key terminology we will use in subsequent lab content.  If you are already familiar with the basics of OpenShift simply ensure you can login and create the project.

# Key Terms
We will be using the following terms throughout the workshop labs so here are some basic definitions you should be familiar with.  You'll learn more terms along the way, but these are the basics to get you started.

* Container - Your software wrapped in a complete filesystem containing everything it needs to run
* Image - We are talking about docker images; read-only and used to create containers
* Image Stream - An image stream comprises one or more OCI images identified by tags. 
* Pod - One or more docker containers that run together
* Service - Provides a common DNS name to access a pod (or replicated set of pods)
* Project - A project is a group of services that are related logically
* Deployment - an update to your application triggered by a image change or config change
* Build - The process of turning your source code into a runnable image
* BuildConfig - configuration data that determines how to manage your build
* Route - a labeled and DNS mapped network path to a service from outside OpenShift
* Operator - A method of packaging, deploying and managing a Kubernetes application
* Cluster masters - The foreman of the OpenShift architecture, the master schedules operations, watches for problems, and orchestrates everything
* Cluster worker - Where the compute happens, your software is run on worker nodes


# Accessing OpenShift
OpenShift provides a web console that allows you to perform various tasks via a web browser.

## Let's Login to the Web Console
> Use your browser to navigate to the URI provided by your instructor and login with the user/password provided.

```bash
{{< urishortfqdn "https://" "console-openshift-console.apps" >}}
```

<img src="../images/ocp-login.png" width="600"><br/>
*Login Webpage*

Once logged in you should see your available projects - or a button to create a project if none exist already:

<img src="../images/ocp-dev-view.png" width="600"><br/>
*Developer Default View*

## So this is what an empty project looks like
First let's create a new project to do our workshop work in.  We will use the student number you were given to ensure you don't clash with classmates:

> Click on the "Create Project" button and give it a name of demo-{{< span userid "YOUR#" >}}

> Populate "Name" with "demo-{{< span userid "YOUR#" >}}" and populate "Description" boxes with whatever you like.  And click "Create"

<img src="../images/ocp-admin-create-project.png" width="600"><br/><br>

This is going to take you to the next logical step of adding something to the project, but we don't want to do that just yet.

<blockquote>
Click "Administrator", and change it to "Developer"
</blockquote>
<img src="../images/ocp-menu-administrator.png" width="450"><br/><br>

## Let's launch a terminal.  
At the top of the screen, click the **[>_]** button.

<img src="../images/ocp-redhat-terminal-launch.png" width="900"><br/><br>
***Note:*** If the button does not exist, it may be necessary for the cluster administrator to load the **"Red Hat Terminal Operator"**.

> Ensure that the **Project** matches demo-{{< span "userid" "YOUR#" >}}, click **[Start]**

<img src="../images/ocp-redhat-terminal-launch-start.png"><br/><br>
The terminal will launch as a container in the project.  Once the container comes only, a command line will be presented.<br>
***Note:***  The terminal will time-out if inactice.  If it does, just close the terminal window and restart.<br>
<img src="../images/ocp-redhat-terminal-launch-window.png" width="900"><br/><br>

> <i class="fa fa-terminal"></i> Check to see what projects you have access to:

```bash
$ oc get projects
oc get projects
NAME          DISPLAY NAME   STATUS
demo-{{< span2 "userid" "YOUR#" >}}                  Active
```
> <i class="fa fa-terminal"></i> Type the following command to show services, deployment configs, build configurations, and active deployments (this will come in handy later):

```bash
$ oc status
```

# Summary
You should now be ready to get hands-on with our workshop labs.

{{< importPartial "footer/footer.html" >}}
