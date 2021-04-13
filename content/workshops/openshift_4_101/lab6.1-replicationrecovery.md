---
title: Lab 6.1 - Application Recovery
workshops: openshift_4_101
workshop_weight: 16
layout: lab
---

## Recovery
Okay, now that we have a slightly more interesting replication state, we can test a service outages scenario. In this scenario, the dc-metro-map replication controller will ensure that other pods are created to replace those that become unhealthy.  Let's forcibly inflict an issue and see how OpenShift responds.

{{< panel_group >}}
{{% panel "CLI Steps" %}}

### Terminal access

<pre>
{{< urishortfqdn "https://" "console-openshift-console.apps" "/terminal" >}}
</pre>

<blockquote>
<i class="fa fa-terminal"></i> Choose a random pod and delete it:
</blockquote>

```bash
$ oc get pods
$ oc delete pod/PODNAME
$ oc get pods -w
```

If you're fast enough you'll see the pod you deleted go "Terminating" and you'll also see a new pod immediately get created and transition from "Pending" to "Running".  If you weren't fast enough you can see that your old pod is gone and a new pod is in the list with an age of only a few seconds.

<blockquote>
<i class="fa fa-info-circle"></i>  You can see the more details about your deployment configuration with:
</blockquote>

```bash
$ oc describe dc/dc-metro-map
```

{{% /panel %}}

{{% panel "Web Console Steps" %}}


### Web Console access

<pre>
{{< urishortfqdn "https://" "console-openshift-console.apps" >}}
</pre>

From the browse pods list:

<blockquote>
Click one of the running pods (not a build pod)
</blockquote>
<blockquote>
Click the "Actions" button in the top right and then select "Delete Pod"
</blockquote>
<img src="../images/ocp-lab-replicationrecovery-podaction.png" width="900"><br/>

<blockquote>
Now click the "Delete" button in the popup to confirm the pod deletion
</blockquote>
<img src="../images/ocp-lab-replicationrecovery-deletepod.png" width="900"><br/>

<blockquote>
Quickly switch back to the deployment configuration overview
</blockquote>

If you're fast enough you'll see the pod you deleted unfill a portion of the deployment circle, and then a new pod fill it back up.

<img src="../images/ocp-lab-replicationrecovery-poddelete.png" width="300"><br/>

You can browse the pods list again to see the old pod was deleted and a new pod with a recent age.

<img src="../images/ocp-lab-replicationrecovery-podrecovery.png" width="900"><br/>

{{% /panel %}}
{{< /panel_group >}}


{{< importPartial "footer/footer.html" >}}
