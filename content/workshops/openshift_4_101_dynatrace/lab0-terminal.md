---
title: Lab 0 - Deploy Your Own Terminal
workshops: openshift_4_101_dynatrace
workshop_weight: 10
layout: lab
---

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

<img src="../images/ocp-admin-default.png" width="600"><br/>
*Administrator Default View, with No Projects*

## So this is what an empty project looks like
First let's create a new project to do our workshop work in.  We will use the student number you were given to ensure you don't clash with classmates:

> Click on the "Create Project" button and give it a name of terminal-{{< span userid "YOUR#" >}}

> Populate "Name" with "terminal-{{< span userid "YOUR#" >}}" and populate "Description" boxes with whatever you like.  And click "Create"

<img src="../images/ocp-admin-create-project.png" width="600"><br/><br>

This is going to take you to the next logical step of adding something to the project, but we don't want to do that just yet.

## Let's deploy Butterfly (Browser-based SSH)

First, we need to change views from the "Administrator" view to the "Developer" view. There is a pop-up menu, in the top left corner of the screen, just below the menu (three horizontal lines) button.

<blockquote>
Click "Administrator", and change it to "Developer"
</blockquote>
<img src="../images/ocp-menu-administrator.png" width="450"><br/><br>


<blockquote>
Click "+Add", to add a new item to the project
</blockquote>
<img src="../images/ocp-addToProjectButton.png" width="450"><br/><br>


<blockquote>
Click "Container Image", to add an existing image from the container registry
</blockquote>
<img src="../images/ocp-ContainerImageButton.png" width="300"><br/>

<blockquote>
In the dialog box under the default radio button, "Image name from external registry", enter "quay.io/openshifthomeroom/workshop-terminal", the image should be "Validated" when found.
</blockquote>
<img src="../images/ocp-deploy-image.png" width="600"><br/>

<blockquote>
Observe default values that are populated in the search results
</blockquote>
<img src="../images/ocp-butterfly-create-1.png" width="600"><br/>

<blockquote>
Click "Create"
</blockquote>

You will now see a screen that shows a thumbnail view of your deployed application. Click on it, to expand the screen, and see details of the running pod:

<img src="../images/ocp-workshop-terminal-thumb.png" width="150"><br/>

<blockquote>
"Topology"
</blockquote>

<img src="../images/ocp-butterfly-topology.png" width="600"><br/>

## Test out the Butterfly webapp
Notice that in the web console overview, you now have a URL in the service box.  You can see the webapp running by clicking the route you just exposed.

<img src="../images/ocp-butterfly-route.png" width="600"><br/>

After clicking on the URL, you should see a shell.

<img src="../images/butterfly-session.png" width="600"><br/>

Now, type the command `oc`. We'll explain what this tool is, later in the workshop.

{{< importPartial "footer/footer.html" >}}
