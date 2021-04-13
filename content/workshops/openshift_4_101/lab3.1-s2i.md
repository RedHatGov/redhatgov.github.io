---
title: Lab 3.1 - Check out the build details
workshops: openshift_4_101
workshop_weight: 13
layout: lab
---

## Check out the build details
We can see the details of what the S2I builder did.  This can be helpful to diagnose issues if builds are failing.

<i class="fa fa-magic fa-2x"></i> TIP: For a node.js app, running "npm shrinkwrap" is a good practice to perform on your branch before releasing changes that you plan to build/deploy as an image with S2I

{{< panel_group >}}
{{% panel "CLI Steps" %}}

### Terminal access

<pre>
{{< urishortfqdn "https://" "console-openshift-console.apps" "/terminal" >}}
</pre>

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

### Web Console access

<pre>
{{< urishortfqdn "https://" "console-openshift-console.apps" >}}
</pre>

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
### Terminal access

<pre>
{{< urishortfqdn "https://" "console-openshift-console.apps" "/terminal" >}}
</pre>

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following (ensure you are in the right project):
</blockquote>

```bash
$ oc get routes
```

<blockquote>
Copy the HOST/PORT and paste into your favorite web browser:
</blockquote>

{{% /panel %}}

{{% panel "Web Console Steps" %}}

### Web Console access

<pre>
{{< urishortfqdn "https://" "console-openshift-console.apps" >}}
</pre>

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

<img src="../images/dc-metro-map-app.png" width="900"><br/>

Clicking the checkboxes will toggle on/off the individual metro stations on each colored line.  A numbered icon indicates there is more than one metro station in that area and they have been consolidated - click the number or zoom in to see more.

# Summary
In this lab we deployed a sample application using source to image.  This process built our code and wrapped that in a docker image.  It then deployed the image into our OpenShift platform in a pod and exposed a route to allow outside web traffic to access our application.  In the next lab we will look at some details of this app's deployment and make some changes to see how OpenShift can help to automate our development processes. More information about creating new applications can be found [here][1].

[1]: https://docs.openshift.com/container-platform/3.4/dev_guide/application_lifecycle/new_app.html

{{< importPartial "footer/footer.html" >}}
