---
title: Lab 5 - Webhooks and Rollbacks
workshops: openshift_4_101
workshop_weight: 15
layout: lab
---


# Build Triggers, Webhooks and Rollbacks - Oh My!
Once you have an app deployed in OpenShift you can take advantage of some continuous capabilities that help to enable DevOps and automate your management process.  We will cover some of those in this lab: Build triggers, webhooks, and rollbacks.


## A bit of configuration
We are going to do some integration and coding with an external git repository.  For this lab we are going to use github, if you don't already have an account, [you can create one here][1].

OK, let's fork the dc-metro-map app from **my** account into **your** github account.  Goto [https://github.com/RedHatGov/openshift-workshops][2] and look to the top right for the "Fork" button.

<img src="../images/ocp-lab-rollbacks-fork.png" width="500"><br/>

> Click the "Fork" button

Github should redirect you to the newly created fork of the source code.


## Build Trigger / Code Change Webhook
When using S2I there are a few different things that can be used to [trigger] a rebuild of your source code.  The first is a configuration change, the second is an image change, and the last (which we are covering here) is a webhook.  A webhook is basically your git source code repository telling OpenShift that the code we care about has changed.  Let's set that up for our project now to see it in action.

Jump back to your OpenShift web console and let's add the webapp to our project.  You should know how to do this from previous lab work, but this time point to *your* github URL for the source code.  If you need a refresher expand the box below.

{{< panel_group >}}
{{% panel "Web Console Steps" %}}

<blockquote>
Click the "Add to Project" button
</blockquote>
<img src="../images/ocp-addToProjectButton.png" width="400"><br/>
<br>
<blockquote>
Select the "From Git" icon
</blockquote>


Make sure that you replace <b>YOUR_ACCOUNT</b> with your GitHub user ID. Click on the "Show Advanced Git Options" expander to fill in the "Context Dir" field:

<p>
<table>
<tr><td><b>Git Repo URL</b></td><td>https://github.com/<b>YOUR_ACCOUNT</b>/openshift-workshops.git</td></tr>
<tr><td><b>Context Dir</b></td><td>/dc-metro-map</td></tr>
</table>
</p>
<br>

<blockquote>
Select Node.js
</blockquote>

<p>
<table>
<tr><td><b>Application Name</b></td><td>dc-metro-map</td></tr>
<tr><td><b>Name</b></td><td>dc-metro-map</td></tr>
</table>
</p>

<blockquote>
Select "Deployment Configuration"
</blockquote>

<blockquote>
When you are done, scroll to the bottom and click 'Create'
</blockquote>

{{% /panel %}}
{{< /panel_group >}}

The node.js builder template creates a number of resources for you, but what we care about right now is the build configuration because that contains the webhooks.  So to get the URL:

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
$ oc get bc/dc-metro-map -o yaml | grep github-webhook
```

<blockquote>
<i class="fa fa-terminal"></i> ...which returns the name of the secret that we need to find:
</blockquote>

```bash
name: dc-metro-map-github-webhook-secret
```

<blockquote>
<i class="fa fa-terminal"></i> Now that you have the name of the secret, you can get its value:
</blockquote>

```bash
$ curl -o jq -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
$ chmod 0755 jq
$ SECRET=`oc get secrets dc-metro-map-github-webhook-secret -o json | ./jq ".data.WebHookSecretKey" | base64 -di`
```

<blockquote>
<i class="fa fa-terminal"></i> Last, we can get the URL for the webhook, this way:
</blockquote>

```bash
$ oc describe bc/dc-metro-map | awk '/github$/{print $2}' | sed "s/<secret>/${SECRET}/"
```

<blockquote>
... which results in the information that we need:
</blockquote>

```bash
https://api.alexocp43.redhatgov.io:6443/apis/build.openshift.io/v1/namespaces/cicd-1/buildconfigs/dc-metro-map/webhooks/1234abcd5678efgh/github
```

<blockquote>
Copy the "Webhook Generic" URL to the clipboard, so that we can use it in GitHub.
</blockquote>

{{% /panel %}}

{{% panel "Web Console Steps" %}}
        
<blockquote>
in "Administrator" mode, click on "Builds" and then click on "Build Configs"
</blockquote>
This is going to show basic details for all build configurations in this project
<img src="../images/ocp-lab-rollbacks-buildsList.png" width="600"><br/>

<blockquote>
Click the "dc-metro-map" build config
</blockquote>
You will see the summary of builds using this build config
<img src="../images/ocp-lab-rollbacks-buildconfigsummary.png" width="600"><br/>

<blockquote>
Scroll to the bottom of the window.
</blockquote>
<img src="../images/ocp-lab-rollbacks-deployconfigconfig.png" width="600"><br/>
Now you can see the links to get the various secrets.

<blockquote>
Copy the Generic webhook to the clipboard, by clicking on "Copy URL with Secret"
</blockquote>

{{% /panel %}}
{{< /panel_group >}}

<br/>

> Now switch back over to github 

{{< panel_group >}}
{{% panel "Github Steps" %}}

Let's put the webhook URL into the repository. At the main page for this repository (the fork), you should see a tab bar with code, pull requests, pulse, graphs, and settings.

<img src="../images/ocp-lab-rollbacks-settings.png" width="900"><br/>

<blockquote>
Click the "Settings" tab
</blockquote>

Now you will see a vertical list of settings groups.<br/><br/>

<blockquote>
Click the "Webhooks" link
</blockquote>
<img src="../images/ocp-lab-rollbacks-githubwebhooks.png" width="900"><br/>

<blockquote>
Click the "Add webhook" button
</blockquote>
<blockquote>
In the Payload URL field, paste the URL that you copied.
</blockquote>
<blockquote>
Change content type to "application/json"
</blockquote>
<blockquote>
Disable SSL verification by clicking the button
</blockquote>

<blockquote>
<i class="fa fa-info-circle"></i> You can learn how to setup SSL in the secrets lab<br/><br/>
</blockquote>

<img src="../images/ocp-lab-rollbacks-githubwebhooks-add.png" width="600"><br/>

<blockquote>
Click the "Add webhook" button
</blockquote>

{{% /panel %}}
{{< /panel_group >}}

Good work! Now any "push" to the forked repository will send a webhook that triggers OpenShift to: re-build the code and image using s2i, and then perform a new pod deployment.  In fact Github should have sent a test trigger and OpenShift should have kicked off a new build already.


## Deployment Triggers

{{% alert info %}}
In addition to setting up triggers for rebuilding code, we can setup a different type of trigger to deploy pods.  Deployment triggers can be due to a configuration change (e.g. environment variables) or due to an image change.  This powerful feature will be covered in one of the advanced labs. See the Triggers link under More Information below.
{{% /alert %}}


## Rollbacks
Well, what if something isn't quite right with the latest version of our app?  Let's say some feature we thought was ready for the world really isn't - and we didn't figure that out until after we deployed it.  No problem, we can roll it back with the click of a button.

{{% alert info %}}
This will not work in today's workshop, as we have not yet made a second deployment.
{{% /alert %}}


{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
$ oc rollout undo dc/dc-metro-map
$ oc get pods -w
```



{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click on "Builds" and then click on "Builds"
<br/>
This is going to show basic details for all builds, for the dc-metro-map application.
</blockquote>
<img src="../images/ocp-lab-rollbacks-builds-builds.png" width="900"><br/>

<blockquote>
Click the "dc-metro-map" build that you want to roll back to. For the purposes of this lab, click dc-metro-map-1.
<br/>
Click on 'Actions', and then 'Rebuild', from the menu, in the upper right corner of the window.
</blockquote>
<img src="../images/ocp-lab-rollbacks-actions-rebuild.png" width="900"><br/>

You can go back to the 'Workloads', 'Deployments', 'dc-metro-map' page, and click on the 'Events' tab, to see your previous deployment spinning down and your new one spinning up.<br/>
<img src="../images/ocp-lab-rollbacks-workloads-deployments-dcmm-events.png" width="900"><br/>

{{% /panel %}}
{{< /panel_group >}}

OpenShift has done a graceful removal of the old pod and created a new one.  

{{% alert info %}}
Note that the old pod wasn't killed until the new pod was successfully started and ready to be used.  This is so that OpenShift could continue to route traffic to the old pod until the new one was ready.
{{% /alert %}}

{{% alert info %}}
You can integrate your CI/CD tools to do rollbacks with the REST API. See the Rollbacks With the REST API link under More Information below.
{{% /alert %}}

# Summary
In this lab we saw how you can configure a source code repository to trigger builds with webhooks.  This webhook could come from Github, Jenkins, Travis-CI, or any tool capable of sending a URL POST.  Keep in mind that there are other types of build triggers you can setup.  For example: if a new version of the upstream RHEL image changes.  We also inspected our deployment history and did a rollback of our running deployment to one based on an older image with the click of a button.

[1]: https://github.com/join?source=header-home
[2]: https://github.com/RedHatGov/openshift-workshops.git

{{< importPartial "footer/footer.html" >}}
