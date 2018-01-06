---
title: Lab 7 - Labels
workshops: openshift_101_dcmetromap
workshop_weight: 17
layout: lab
---

# Labels
This is a pretty simple lab, we are going to explore labels.  You can use labels to organize, group, or select API objects. 

For example, pods are "tagged" with labels, and then services use label selectors to identify the pods they proxy to. This makes it possible for services to reference groups of pods, even treating pods with potentially different docker containers as related entities.

## Labels on a pod
In a previous lab we added our web app using a S2I template.  When we did that, OpenShift labeled our objects for us.  Let's look at the labels on our running pod.

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and try the following:
</blockquote>

```bash
$ oc get pods
$ oc describe pod/<POD NAME> | more
```

You can see the Labels automatically added contain the app, deployment, and deploymentconfig.  Let's add a new label to this pod.

<blockquote>
<i class="fa fa-terminal"></i> Add a label
</blockquote>

```bash
$ oc label pod/<POD NAME> testdate=4.30.2018 testedby=mylastname
```

<blockquote>
<i class="fa fa-terminal"></i> Look at the labels
</blockquote>

```bash
$ oc describe pod/<POD NAME> | more
```

<blockquote>
<i class="fa fa-info-circle"></i> Here's a handy way to search through all objects and look at all the labels:<br/>
</blockquote>

```bash
$ oc describe all | grep -i "labels:"
```

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click "Applications" and then click on "Pods"
</blockquote>
This is going to show basic details for all pods in this project (including the builders).
<img src="../images/ocp-lab-labels-pods.png" width="900"></br>
</br>

Next let's look at the log for the pod running our application.
</br>

<blockquote>
Click the pod for the dc metro map webapp (it shoud have a status of Running)
</blockquote>
<img src="../images/ocp-lab-labels-poddetails.png" width="900"></br>
Here, at the top, you can see the labels on this pod

<blockquote>
Click the "Actions" button, then click "Edit YAML" for the pod
</blockquote>
<img src="../images/ocp-lab-labels-podedit.png" width="900"><br/>
You will see all the labels under the metadata->labels section.

<blockquote>
Add a new label into the labels section

testdate: 4.30.2018
testedby: mylastname
</blockquote>

<img src="../images/ocp-lab-labels-podedit2.png" width="300"><br/>

Your updated label will show up in the running pod's.

Select Application -> Pods -> dc-metro-map (Running POD)

<blockquote>
If you see "More labels..", then click that link
<img src="../images/ocp-lab-labels-podedit3.png" width="500"><br/>
</blockquote>

Labels will appear in the list:</br>
<img src="../images/ocp-lab-labels-podedit4.png" width="600"><br/>

{{% /panel %}}
{{< /panel_group >}}

# Summary
That's it for this lab. Now you know that all the objects in OpenShift can be labeled.  This is important because those labels can be used as part of your CI/CD process.  An upcoming lab will cover using labels for Blue/Green deployments. Labels can also be used for running your apps on specific nodes (e.g. just on SSD nodes or just on east coast nodes).  You can read more about labels [here][1] and [here][2].


[1]: https://docs.openshift.com/enterprise/latest/architecture/core_concepts/pods_and_services.html#labels
[2]: http://kubernetes.io/docs/user-guide/labels/

{{< importPartial "footer/footer.html" >}}
