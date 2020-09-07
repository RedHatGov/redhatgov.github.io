---
title: Lab 5 - Deploying an App with S2I
workshops: openshift_4_101_dynatrace
workshop_weight: 15
layout: lab
---

# Source to Image (S2I)
One of the useful components of OpenShift is its source-to-image capability.  S2I is a framework that makes it easy to turn your source code into runnable images.  The main advantage of using S2I for building reproducible docker images is the ease of use for developers.  You'll see just how simple it can be in this lab.

## Let's build a node.js web app, using S2I
We can do this either via the command line or the web console.  You decide which you'd rather do and follow the steps below.

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
$ oc new-app --name=dc-metro-map https://github.com/RedHatGov/openshift-workshops.git --context-dir=dc-metro-map
$ oc expose service dc-metro-map
```

{{% /panel %}}

{{% alert info %}}
When using the CLI, OpenShift automatically detects the source code type and select the nodejs builder image.
{{% /alert %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Switch to developer mode, if you're not already there
</blockquote>
<img src="../images/ocp-switch-developer.png" width="500"><br/>

<blockquote>
Click "+Add"
</blockquote>
<img src="../images/ocp-addToProjectButton.png" width="450"><br/>

<blockquote>
Click "From Git"
</blockquote>
<img src="../images/ocp-FromGitButton.png" width="200"><br/>

<blockquote>
Fill out the "Git Repo URL" field as follows:
</blockquote>
<p>
<table>
<tr><td><b>Git Repo URL</b></td><td><a href>https://github.com/RedHatGov/openshift-workshops.git</a></td></tr>
</table>

<img src="../images/ocp-git-dc-metro-map.png" width="700"><br/>

<br>Ensure that the repository is validated (as shown above)</br><br>

<blockquote>
Click on the "Show Advanced Git Options" expender
</blockquote>
<img src="../images/ocp-lab-s2i-ago.png" width="200"><br/><br>

<blockquote>
Fill out the "Context Dir" field as follows:
</blockquote>
<p>
<table>
<tr><td><b>Context Dir</b></td><td>/dc-metro-map</td></tr>
</table>


<blockquote>
Under "Builder", click click on the "Node.js" icon
</blockquote>
<img src="../images/ocp-lab-s2i-builder.png" width="600"><br/>

<blockquote>
Select Node.js 
</blockquote>
<img src="../images/ocp-lab-s2i-nodejs.png" width="400"><br/>

<blockquote>
Fill out the fields, under "General" as follows:
</blockquote>
<p>
<table>
<tr><td><b>Application</b></td><td>Create Application</td></tr>
<tr><td><b>Application Name</b></td><td>dc-metro-map</td></tr>
<tr><td><b>Name</b></td><td>dc-metro-map</td></tr>
</table>
</p>

<blockquote>
Choose "Deployment Configuration" 
</blockquote>
<img src="../images/ocp-lab-s2i-nodejs-dc.png" width="400"><br/>

<blockquote>
Scroll to the bottom and click "Create"
</blockquote>

{{% /panel %}}
{{< /panel_group >}}

## Check out the build details
We can see the details of what the S2I builder did.  This can be helpful to diagnose issues if builds are failing.

<i class="fa fa-magic fa-2x"></i> TIP: For a node.js app, running "npm shrinkwrap" is a good practice to perform on your branch before releasing changes that you plan to build/deploy as an image with S2I

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
$ oc get builds
```

<blockquote>
Note the name of your build from the above command output and use it to see the logs with:
</blockquote>

```bash
$ oc logs builds/[BUILD_NAME]
```

The console will print out the full log for your build.  Note, you could pipe this to more or less for easier viewing in the CLI.

{{% /panel %}}
{{% panel "Web Console Steps" %}}

<blockquote>
Click on "Topology", the "node"/"dc-metro-map" icon, and then on "View logs"
</blockquote>
<img src="../images/ocp-lab-s2i-topology.png" width="800"><br/>

You should see a log output similar to the one below:<br>
<img src="../images/ocp-lab-s2i-logs.png" width="700"><br/>

{{% /panel %}}
{{< /panel_group >}}

## See the app in action
Let's see this app in action!

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
$ oc get routes
```

<blockquote>
Copy the HOST/PORT and paste into your favorite web browser:
</blockquote>

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click on "Topology"
</blockquote>
<img src="../images/ocp-TopologyButton.png" width="150"><br/>

<blockquote>
Click the arrow, at the top right corner of the "dc-metro-map" icon, to launch a new tab/window, with the running app
</blockquote>
<img src="../images/ocp-dc-metro-map-icon.png" width="150"><br/>

{{% /panel %}}
{{< /panel_group >}}

The app should look like this in your web browser:

<img src="../images/ocp-lab-s2i-apprunning.png" width="900"><br/>

Clicking the checkboxes will toggle on/off the individual metro stations on each colored line.  A numbered icon indicates there is more than one metro station in that area and they have been consolidated - click the number or zoom in to see more.

# Summary
In this lab we deployed a sample application using source to image.  This process built our code and wrapped that in a docker image.  It then deployed the image into our OpenShift platform in a pod and exposed a route to allow outside web traffic to access our application.  In the next lab we will look at some details of this app's deployment and make some changes to see how OpenShift can help to automate our development processes. More information about creating new applications can be found [here][1].

[1]: https://docs.openshift.com/container-platform/3.4/dev_guide/application_lifecycle/new_app.html

{{< importPartial "footer/footer.html" >}}
