---
title: Exercise 1.5 - Replication and Recovery
workshops: openshift33
workshop_weight: 150
layout: lab
---

# The site's dow...oh nevermind, it's good
# Things will go wrong, and that's why we have replication and recovery

Things will go wrong with your software, or your hardware, or from something out of your control.  But we can plan for that failure, and planning for it let's us minimize the impact.  OpenShift supports this via what we call replication and recovery.


# Replication

Let's walk through a simple example of how the replication controller can keep your deployment at a desired state.  Assuming you still have the dc-metro-map project running we can manually scale up our replicas to handle increased user load.


{{< panel_group >}}

{{% panel "CLI Steps" %}}

> <i class="fa fa-terminal"></i> Goto the terminal and try the following:

```bash
oc scale --replicas=4 dc/dc-metro-map
```

> <i class="fa fa-terminal"></i> Check out the new pods:

```bash
oc get pods
```

Notice that you now have 4 unique pods available to inspect.  If you want go ahead and inspect them you can see that each have their own IP address and logs (oc describe).


{{% /panel %}}

{{% panel "Web Console Steps" %}}

> Click "Overview"
>
> In the deployment, click the up arrow 3 times.

The deployment should indicate that it is scaling to 4 pods, and eventually you will have 4 running pods.  Keep in mind that each pod has it's own container which is an identical deployment of the webapp.  OpenShift is now (by default) round robin load-balancing traffic to each pod.

<p><img title="OpenShift Scaling Pods" src="../images/ose-lab-replicationrecovery-4pods.png" width="750"/></p>

> Hover over "Browse" and click "Pods"

Notice that you now have 4 unique webapp pods available to inspect.  If you want go ahead and inspect them you can see that each have their own IP address and logs.

<p><img title="OpenShift List Pods" src="../images/ose-lab-replicationrecovery-4podslist.png" width="750"/></p>

{{% /panel %}}

{{< /panel_group >}}


So you've told OpenShift that you'd like to maintain 4 running, load-balanced, instances of our web app.


# Recovery

OK, now that we have a slightly more interesting desired replication state, we can test a service outages scenario. In this scenario, the dc-metro-map replication controller will ensure that other pods are created to replace those that become unhealthy.  Let's force inflict an issue and see how OpenShift reponds.


{{< panel_group >}}

{{% panel "CLI Steps" %}}

> <i class="fa fa-terminal"></i> Choose a random pod and delete it:

```bash
oc get pods
```

```bash
oc delete pod/POD_NAME
```

```bash
oc get pods -w
```

If you're fast enough you'll see the pod you deleted go "Terminating" and you'll also see a new pod immediately get created and from "Pending" to "Running".  If you weren't fast enough you can see that your old pod is gone and a new pod is in the list with an age of only a few seconds.

<p>{{< alert info >}} You can see the more details about your replication controller with:
```bash
oc describe rc
```
{{< /alert >}}</p>

{{% /panel %}}

{{% panel "Web Console Steps" %}}

Assuming you are in the browse pods list:

> Click one of the running pods (not a build pod)
>
> Click the vertically stacked "..." button in the top right and then delete

<p><img title="OpenShift Delete Pod" src="../images/ose-lab-replicationrecovery-deletepod.png" width="400"/></p>

> Quick switch back to the Overview

If you're fast enough you'll see the pod you deleted unfill a portion of the deployment circle, and then a new pod fill it back up.  You can browse the pods list again to see the old pod was deleted and a new pod with an age of "a few seconds" has been created to replace it.

<p><img title="OpenShift Recover Pod Automatically" src="../images/ose-lab-replicationrecovery-podrecovery.png" width="750"/></p>

{{% /panel %}}

{{< /panel_group >}}


# Application Health

In addition to the health of your application's pods, OpenShift will watch the containers inside those pods.  Let's force inflict some issues and see how OpenShift reponds.

{{< panel_group >}}

{{% panel "CLI Steps" %}}

> <i class="fa fa-terminal"></i> Choose a running pod and shell into it:

```bash
oc get pods
```

```bash
oc exec POD_NAME -it /bin/bash
```

You are now executing a bash shell running in the container of the pod.  Let's kill our webapp and see what happens.

<p>{{< alert info >}} If we had multiple containers in the pod we could use the "-c CONTAINER_NAME" switch to select a specific container. {{< /alert >}}</p>

> <i class="fa fa-terminal"></i> Choose a running pod and shell into its container:

```bash
pkill -9 node
```

This will kick you out off the container with an error like "Error executing command in container"
<br/><br/>

> <i class="fa fa-terminal"></i> Do it again - shell in and execute the same command to kill node
>
> <i class="fa fa-terminal"></i> Watch for the container restart

```bash
oc get pods -w
```

If a container dies multiple times quickly, OpenShift is going to put the pod in a CrashBackOff state.  This ensures the system doesn't waste resources trying to restart containers that are continuously crashing.

{{% /panel %}}

{{% panel "Web Console Steps" %}}

> Navigate to browse the pods list, and click on a running pod
>
> In the tab bar for this pod, click on "Terminal"
> Click inside the terminal view and type pkill -9 node

<p><img title="OpenShift Process Kill Node Terminal Command" src="../images/ose-lab-replicationrecovery-terminal.png" width="750"/></p>

This is going to kill the node.js web server and kick you off the container.

<p><img title="OpenShift Process Kill Node Terminal Kick" src="../images/ose-lab-replicationrecovery-terminalkick.png" width="750"/></p>

> Click the refresh button (on the terminal) and do that a couple more times
>
> Go back to the pods list

<p><img title="OpenShift Replication Controller Backoff Autorecovery" src="../images/ose-lab-replicationrecovery-backoff.png" width="750"/></p>

The container died multiple times so quickly that OpenShift is going to put the pod in a CrashBackOff state.  This ensures the system doesn't waste resources trying to restart containers that are continuously crashing.

{{% /panel %}}

{{< /panel_group >}}


# Clean up

Let's scale back down to 1 replica.  If you are using the web console just click the down arrow from the Overview page.  If you are using the command line use the **oc scale** command.


# Summary

In this lab we learned about replication controllers and how they can be used to scale your applications and services.  We also tried to break a few things and saw how OpenShift responded to heal the system and keep it running.  This topic can get deeper than we've experimented with here, but getting deeper into application health and recovery is an advanced topic.  If you're interested you can read more about it in the documentation [here][1], [here][2], and [here][3].


[1]: https://docs.openshift.com/container-platform/3.3/dev_guide/application_health.html
[2]: https://docs.openshift.com/container-platform/3.3/dev_guide/deployments.html#scaling
[3]: http://kubernetes.io/docs/user-guide/walkthrough/k8s201/#health-checking
