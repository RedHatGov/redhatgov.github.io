---
title: Lab 6.2 - Application Health
workshops: openshift_4_101
workshop_weight: 16
layout: lab
---

## Application Health
In addition to the health of your application's pods, OpenShift will watch the containers inside those pods.  Let's forcibly inflict some issues and see how OpenShift responds.  

{{< panel_group >}}
{{% panel "CLI Steps" %}}

### Terminal access

<pre>
{{< urishortfqdn "https://" "console-openshift-console.apps" "/terminal" >}}
</pre>

<blockquote>
<i class="fa fa-terminal"></i> Choose a running pod and shell into it:
</blockquote>

```bash
$ oc get pods
$ oc exec PODNAME -it /bin/bash
```

You are now executing a bash shell running in the container of the pod.  Let's kill our webapp and see what happens.

<blockquote>
<i class="fa fa-info-circle"></i> If we had multiple containers in the pod we could use "-c CONTAINER_NAME" to select the right one
</blockquote>

<blockquote>
<i class="fa fa-terminal"></i> Choose a running pod and shell into its container:
</blockquote>

```bash
$ pkill -9 node
```

This will kick you out off the container with an error like "Error executing command in container"

<blockquote>
<i class="fa fa-terminal"></i> Do it again - shell in and execute the same command to kill node
</blockquote>

<blockquote>
<i class="fa fa-terminal"></i> Watch for the container restart
</blockquote>

```bash
$ oc get pods -w
```

If a container dies multiple times quickly, OpenShift is going to put the pod in a CrashBackOff state.  This ensures the system doesn't waste resources trying to restart containers that are continuously crashing.

{{% /panel %}}

{{% panel "Web Console Steps" %}}


### Web Console access

<pre>
{{< urishortfqdn "https://" "console-openshift-console.apps" >}}
</pre>

<blockquote>
Navigate to browse the pods list, and click on a running pod
</blockquote>
<blockquote>
In the tab bar for this pod, click on "Terminal"
</blockquote>
<blockquote>
Click inside the terminal view and type $ pkill -9 node
</blockquote>
<img src="../images/ocp-lab-replicationrecovery-terminal.png" width="900"><br/>

</br>This is going to kill the node.js web server, and kick you off of the container's terminal.</br></br>

<img src="../images/ocp-lab-replicationrecovery-terminalkick.png" width="400"><br/>

</br>

<blockquote>
Click the refresh button (on your web browser), and do that a couple more times
</blockquote>

<blockquote>
Go back to the pod overview
</blockquote>

<img src="../images/ocp-lab-replicationrecovery-backoff.png" width="900"><br/>

The container died multiple times so quickly that OpenShift is going to put the pod in a CrashBackOff state.  This ensures the system doesn't waste resources trying to restart containers that are continuously crashing.

{{% /panel %}}
{{< /panel_group >}}


## Clean up
Let's scale back down to 1 replica.  If you are using the web console just click the down arrow from the Deployments Configs Overview page.  If you are using the command line use the "oc scale" command.

<img src="../images/ocp-lab-replicationrecovery-cleanup.png" width="900"><br/>

# Summary
In this lab we learned about replication controllers and how they can be used to scale your applications and services.  We also tried to break a few things and saw how OpenShift responded to heal the system and keep it running.  

{{< importPartial "footer/footer.html" >}}
