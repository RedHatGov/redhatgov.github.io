---
title: Exercise 1.4 - Webhooks and Rollbacks
workshops: openshift33
workshop_weight: 140
layout: lab
---

### Build Triggers, Webhooks and Rollbacks - Oh My!
Once you have an app deployed in OpenShift you can take advantage of some continuous capabilities that help to enable DevOps and automate your management process.  We will cover some of those in this lab: Build triggers, webhooks, and rollbacks.


### A bit of configuration
We are going to do some integration and coding with an external git repository.  For this lab we are going to use github, if you don't already have an account, [you can create one here][3].

OK, let's fork the dc-metro-map app from **my** account into **your** github account.  Goto [https://github.com/dudash/openshift-workshops/][4] and look to the top right for the "Fork" button.

<p><img title="OpenShift Labs GitHub Fork" src="../images/ose-lab-rollbacks-fork.png" width="400"/></p>

> Click the "Fork" button

Github should redirect you to the newly created fork of the source code.


### Build Trigger / Code Change Webhook
When using S2I there are a few different things that can be used to [trigger][1] a rebuild of your source code.  The first is a configuration change, the second is an image change, and the last (which we are covering here) is a webhook.  A webhook is basically your git source code repository telling OpenShift that the code we care about has changed.  Let's set that up for our project now to see it in action.

Jump back to your OpenShift web console and let's add the webapp to our project.  You should know how to do this from previous lab work.  If you need a refresher expand the box below.

{{< panel_group >}}
{{% panel "Web Console Steps" %}}

<blockquote>
Click the "Add to Project" button
</blockquote>

<blockquote>
Select the node.js **builder**
</blockquote>

<blockquote>
Fill out the boxes to point to the fork and context dir
</blockquote>

<p>
<!-- :notebook: You will need to click to expand the "advanced options"<br/><br/> -->
{{< alert warning >}} You will need to click to expand the "advanced options" {{< /alert >}}

The GitHub repository URL is: <a href='#'>https://github.com/YOUR_ACCOUNT/openshift-workshops.git</a><br/><br/>
The GitHub context-dir is: <b>/dc-metro-map</b><br/><br/>
</p>

{{% /panel %}}
{{< /panel_group >}}

The node.js builder template creates a number of resources for you, but what we care about right now is the build configuration because that contains the webhooks.  So to get the URL:

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
oc describe bc/dc-metro-map | grep -i webhook
```

<blockquote>
Copy the Generic webhook to the clipboard
</blockquote>

{{% /panel %}}
{{% panel "Web Console Steps" %}}

<blockquote>
Hover over "Browse" and then click on "Builds"
</blockquote>

This is going to show basic details for all build configurations in this project
<p><img title="OpenShift Build Configuration" src="../images/ose-lab-rollbacks-buildconfigs.png" width="500"/></p>

<blockquote>
Click the "dc-metro-map" build config
</blockquote>

You will see the summary of builds using this build config
<p><img title="OpenShift Build Configuration Summary" src="../images/ose-lab-rollbacks-buildconfigsummary.png" width="500"/></p>

<blockquote>
Click the "Configuration" tab (next to the active Summary tab)
</blockquote>

<p><img title="OpenShift Deployment Configuration Summary" src="../images/ose-lab-devman-deployconfigconfig.png" width="500"/></p>
Now you can see the various configuration details including the Github specific and Generic webhook URLs.

<blockquote>
Copy the Generic webhook to the clipboard
</blockquote>

{{% /panel %}}
{{< /panel_group >}}

<br/>

> Now switch back over to github

{{< panel_group >}}
{{% panel "GitHub Steps" %}}

Let's put the webhook URL into the repository. At the main page for this repository (the fork), you should see a tab bar with code, pull requests, pulse, graphs, and settings.

<p><img title="OpenShift Gogs - Go Git Service - Settings" src="../images/ose-lab-rollbacks-settings.png" width="400"/></p>

<blockquote>
Click the "Settings" tab
</blockquote>

Now you will see a vertical list of settings groups.<br/><br/>

<blockquote>
Click the "Webhooks & services" item
</blockquote>

<p><img title="OpenShift Webhooks and Services" src="../images/ose-lab-rollbacks-githubwebhooks.png" width="600"/></p>

<blockquote>
Click the "Add webhook" button
</blockquote>

<blockquote>
Paste in the URL you copied
</blockquote>

<blockquote>
Disable SSL verification by clicking the button
</blockquote>

<!-- :information_source: You can learn how to setup SSH in the secrets lab<br/><br/> -->
**INFO:**You can learn how to setup SSH in the secrets lab.

<p><img title="OpenShift Add GitHub Webhook" src="../images/ose-lab-rollbacks-githubwebhooks-add.png" width="600"/></p>

<blockquote>
Click the button to "Add webhook"
</blockquote>

{{% /panel %}}
{{< /panel_group >}}

Good work!  Now any "push" to the forked repository will send a webhook that triggers OpenShift to: re-build the code and image using s2i, and then perform a new pod deployment.  In fact Github should have sent a test trigger and OpenShift should have kicked off a new build already.


### Deployment Triggers
<!-- :information_source: In addition to setting up triggers for rebuilding code, we can setup a different type of [trigger][2] to deploy pods.  Deployment triggers can be due to a configuration change (e.g. environment variables) or due to an image change.  This powerful feature will be covered in one of the advanced labs. -->
**INFO:** In addition to setting up triggers for rebuilding code, we can setup a different type of [trigger][2] to deploy pods.  Deployment triggers can be due to a configuration change (e.g. environment variables) or due to an image change.  This powerful feature will be covered in one of the advanced labs.


### Rollbacks
Well, what if something isn't quite right with the latest version of our app?  Let's say some feature we thought was ready for the world really isn't - and we didn't figure that out until after we deployed it.  No problem, we can roll it back with the click of a button.  Let's check that out:

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
oc rollback dc-metro-map-1
```

```bash
oc get pods -w
```

{{% /panel %}}
{{% panel "Web Console Steps" %}}

<blockquote>
Hover over "Browse" and then click on "Deployments"
</blockquote>

This is going to show basic details for all deployment configurations in this project

<blockquote>
Click the "dc-metro-map" deployment config
</blockquote>

Toward the bottom of the screen you will see a table of deployments using this deployment config
<p><img title="OpenShift Deployment Configuration Summary" src="../images/ose-lab-rollbacks-deploymentconfigsummary.png" width="600"/></p>

<blockquote>
In the Deployments table click the #1
</blockquote>

<p><img title="OpenShift Deployment Configuration #1" src="../images/ose-lab-rollbacks-deploymentconfig1.png" width="500"/></p>

<blockquote>
Click the "Rollback button", accept defaults, and click "Rollback" again
</blockquote>

You can go back to the overview page to see your previous deployment spinning down and your new one spinning up.

{{% /panel %}}
{{< /panel_group >}}

OpenShift has done a graceful removal of the old pod and created a new one.

<!-- :information_source: The old pod wasn't killed until the new pod was successfully started and ready to be used.  This is so that OpenShift could continue to route traffic to the old pod until the new one was ready. -->
**INFO:** The old pod wasn't killed until the new pod was successfully started and ready to be used.  This is so that OpenShift could continue to route traffic to the old pod until the new one was ready.

<!-- :information_source: You can integrate your CI/CD tools to do [rollbacks with the REST API][5]. -->
**INFO:** You can integrate your CI/CD tools to do [rollbacks with the REST API][5].


### Summary
In this lab we saw how you can configure a source code repository to trigger builds with webhooks.  This webhook could come from Github, Jenkins, Travis-CI, or any tool capable of sending a URL POST.  Keep in mind that there are other types of build triggers you can setup.  For example: if a new version of the upstream RHEL image changes.  We also inspected our deployment history and did a rollback of our running deployment to one based on an older image.

[1]: https://docs.openshift.com/container-platform/3.3/dev_guide/builds.html#build-triggers
[2]: https://docs.openshift.com/container-platform/3.3/dev_guide/deployments.html#triggers
[3]: https://github.com/join?source=header-home
[4]: https://github.com/RedHatGov/openshift-workshops
[5]: https://docs.openshift.com/container-platform/3.3/rest_api/openshift_v1.html#create-a-deploymentconfigrollback-2
