---
title: Lab 1 - Welcome
workshops: openshift_4_101
workshop_weight: 11
layout: lab
---

# Welcome to OpenShift!
This lab provides a quick tour of the OpenShift console to help you get familiar with the user interface. If you are already familiar with the basics of OpenShift, this will be easy in that we are simply ensuring you can login and create a project.

# Accessing OpenShift
OpenShift provides a web console that allows you to perform various tasks via a web browser.

## Let's Login to the Web Console
> Use your browser to navigate to the URI provided by your instructor and login with the user/password provided.

``
{{< urishortfqdn "https://" "console-openshift-console.apps" >}}
``

<img src="../images/ocp-login.png" width="600"><br/>
*Login Webpage*

Once logged in you should see your available projects - or you will be provided with an informational box that "No projects exist"

<img src="../images/ocp-dev-view.png" width="600"><br/>
*Developer Default View*

## So this is what an empty project looks like
First let's create a new project to do our workshop work in.  We will use the student number you were given to ensure you don't clash with classmates:

> Click on the "Project: all projects" button and select "Create Project" from the drop down menu
<br><img src="../images/ocp-dev-create-project-terminal.gif"><br/>

> Populate "Name" with "terminal-{{< span userid "YOUR#" >}}" and populate "Description" boxes with whatever you like.  And click "Create"

This is going to take you to the next logical step of adding something to the project, but we don't want to do that just yet.

## Let's launch a terminal.  
At the top of the screen, click the **[>_]** button.

<img src="../images/ocp-redhat-terminal-launch.gif"<br>
***Note:*** If the button does not exist, it may be necessary for the cluster administrator to load the **"Red Hat Terminal Operator"**.


<i class="fa fa-terminal"></i> Check to see what projects you have access to:

```bash
$ oc get projects
oc get projects
NAME          DISPLAY NAME   STATUS
terminal-{{< span2 "userid" "YOUR#" >}}                  Active
```
> <i class="fa fa-terminal"></i> Type the following command to show services, deployment configs, build configurations, and active deployments (this will come in handy later):

```bash
$ oc status
```

# Summary
You should now be ready to get hands-on with our workshop labs.

{{< importPartial "footer/footer.html" >}}
