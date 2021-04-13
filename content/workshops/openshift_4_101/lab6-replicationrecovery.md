---
title: Lab 6 - Application Replication
workshops: openshift_4_101
workshop_weight: 16
layout: lab
---

# Things will go wrong, and that's why we have replication and recovery
Things will go wrong with your software, or your hardware, or from something completely out of your control.  But, we can plan for such failures, thus minimizing their impact.  OpenShift supports this via the replication and recovery functionality.

## Replication
Let's walk through a simple example of how the replication controller can keep your deployment at a desired state.  Assuming you still have the dc-metro-map project running we can manually scale up our replicas to handle increased user load.

{{< panel_group >}}
{{% panel "CLI Steps" %}}

### Terminal access

<pre>
{{< urishortfqdn "https://" "console-openshift-console.apps" "/terminal" >}}
</pre>

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and try the following:
</blockquote>

```bash
$ oc scale --replicas=4 dc/dc-metro-map
```

<blockquote>
<i class="fa fa-terminal"></i> Check out the new pods:
</blockquote>

```bash
$ oc get pods
```

Notice that you now have 4 unique pods available to inspect.  If you want go ahead and inspect them, using 'oc describe pod/<b>POD NAME</b>'. You can see that each has its own IP address and logs.

{{% /panel %}}

{{% panel "Web Console Steps" %}}


### Web Console access

<pre>
{{< urishortfqdn "https://" "console-openshift-console.apps" >}}
</pre>

<blockquote>
Click "Workloads", then "Deployment Configuration", and then "dc-metro-map"
</blockquote>
<blockquote>
In the Deployment Config Details, click the up arrow 3 times.
</blockquote>
The deployment should indicate that it is scaling to 4 pods, and eventually you will have 4 running pods.  Keep in mind that each pod has it's own container which is an identical deployment of the webapp.  OpenShift is now (by default) round robin load-balancing traffic to each pod.
<img src="../images/ocp-lab-replicationrecovery-4pods.png" width="900"><br/>

<blockquote>
Click the Pods tab, and select one of the pods (ex: dc-metro-map-X-XXXX)
</blockquote>
Notice that you now have 4 unique webapp pods available to inspect.  If you want go ahead and inspect them you can see that each has its own IP address and logs.
<img src="../images/ocp-lab-replicationrecovery-4podslist.png" width="900"><br/>

{{% /panel %}}
{{< /panel_group >}}

So you've told OpenShift that you'd like to maintain 4 running, load-balanced, instances of our web app.

{{< importPartial "footer/footer.html" >}}
