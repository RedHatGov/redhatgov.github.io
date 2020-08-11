---
title: Login Tour - Butterfly
workshops: openshift_101_dcmetromap
workshop_weight: 10
layout: lab
---

# Accessing OpenShift
OpenShift provides a web console that allows you to perform various tasks via a web browser.

## Let's Login to the Web Console
> Use your browser to navigate to the URI provided by your instructor and login with the user/password provided.

```bash
{{< urishortfqdn "https://" "master" ":8443" >}}
```

<img src="../images/ocp-login.png" width="600"><br/>
*Login Webpage*

Once logged in you should see your available projects - or a button to create a project if none exist already.

## So this is what an empty project looks like
First let's create a new project to do our workshop work in.  We will use the student number you were given to ensure you don't clash with classmates, so in the steps below replace 'YOUR#' with your student number (if applicable).

> Click on the "Create Project" button and give it a name of demo-{{< span userid "YOUR#" >}}

> Populate "Name" with "demo-{{< span userid "YOUR#" >}}" and populate "Description" boxes with whatever you like.  And click "Create"

This is going to take you to the next logical step of adding something to the project, but we don't want to do that just yet.

> Click the "demo-{{< span userid "YOUR#" >}}" link on the top left to goto your project

Don't worry, it's supposed to look empty right now because you currently don't have anything in your project (we'll fix that in the next lab).

## Let's deploy Butterfly (Browser-based SSH)

<blockquote>
Click "Add to Project"
</blockquote>
<img src="../images/ocp-addToProjectButton.png" width="150"><br/>

<blockquote>
Select the "Deploy Image" option from the drop down
</blockquote>
<img src="../images/ocp-deploy-image.png" width="600"><br/>

<blockquote>
Select the option for "Image Name" and enter "quay.io/openshifthomeroom/workshop-terminal", then click the magnifying glass to the far right to search for the image.
</blockquote>
<img src="../images/ocp-butterfly-imagename-expand.png" width="600"><br/>

<blockquote>
Observe default values that are populated in the search results
</blockquote>
<img src="../images/ocp-butterfly-create-1.png" width="600"><br/>

<blockquote>
Click "Deploy" then click "Close"
</blockquote>

## Does this Butterfly do anything?
Good catch, your service is running but there is no way for users to access it yet.  We can fix that from the web console.

<blockquote>
"Overview"
</blockquote>

<img src="../images/ocp-butterfly-overview.png" width="400"><br/>

<blockquote>
Select the arrow '>' next to 'workshop-terminal, #'
</blockquote>

<img src="../images/ocp-butterfly-arrow1.png" width="200"><br/>
<img src="../images/ocp-butterfly-arrow2.png" width="200"><br/>

<blockquote>
To get to this view
</blockquote>

<img src="../images/ocp-butterfly-noroute.png" width="600"><br/>

<p>Notice there is no exposed route </p>

<blockquote>
Click on the "Create Route" link
</blockquote>

<img src="../images/ocp-butterfly-createRoute.png" width="600"><br/>

<p>This is where you could specify route parameters, but we will just use the defaults.</p>

<blockquote>
Click "Create"
</blockquote>

## Test out the Butterfly webapp
Notice that in the web console overview, you now have a URL in the service box.  You can see the webapp running by clicking the route you just exposed.

<img src="../images/ocp-butterfly-route.png" width="600"><br/>

After clicking on the URL, you should see a shell.

<img src="../images/butterfly-session.png" width="600"><br/>

Now, type the command oc. We'll explain what this tool is later in the workshop.

{{< importPartial "footer/footer.html" >}}
