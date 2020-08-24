---
title: Lab 7 - Labels
workshops: openshift_4_101
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
$ oc describe pod/<POD NAME> | grep Labels: --context=4
Namespace:    demo-1
Priority:     0
Node:         ip-10-0-132-38.us-east-2.compute.internal/10.0.132.38
Start Time:   Tue, 14 Apr 2020 17:41:58 +0000
Labels:       app=dc-metro-map
              deploymentconfig=dc-metro-map
              pod-template-hash=7bc46bf89d
Annotations:  k8s.v1.cni.cncf.io/networks-status:
                [{
```

You can see the Labels automatically added contain the app, deployment, and deploymentconfig.  Let's add a new label to this pod.

<blockquote>
<i class="fa fa-terminal"></i> Add a label
</blockquote>

```bash
$ oc label pod/<POD NAME> testdate=4.14.2020 testedby=mylastname
```

<blockquote>
<i class="fa fa-terminal"></i> Look at the labels
</blockquote>

```bash
$ oc describe pod/<POD NAME> | grep Labels: --context=4
Namespace:    demo-1
Priority:     0
Node:         ip-10-0-132-38.us-east-2.compute.internal/10.0.132.38
Start Time:   Tue, 14 Apr 2020 17:41:58 +0000
Labels:       app=dc-metro-map
              deploymentconfig=dc-metro-map
              pod-template-hash=7bc46bf89d
              testdate=4.14.2020
              testedby=mylastname
```

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click "Workloads", click on "Pods", then click on the three vertical dots next to the "Running" pod.  Consider filtering for Status "Running".
</blockquote>

<img src="../images/ocp-lab-labels-pods.png" width="900"></br>
</br>

<blockquote>
Click "Edit Labels"
</blockquote>
<img src="../images/ocp-lab-labels-poddetails.png" width="500"></br>
Here, at the top, you can see the labels on this pod

<blockquote>
Add 'testedby=mylastname' and click "Save"
</blockquote>
<img src="../images/ocp-lab-labels-podedit.png" width="500"><br/>

Your updated label will show up in the running pods.

<blockquote>
Select Workloads -> Pods -> dc-metro-map (Running POD), then scroll down to "Labels"
</blockquote>
<img src="../images/ocp-lab-labels-podedit3.png" width="900"><br/>

{{% /panel %}}
{{< /panel_group >}}

# Summary
That's it for this lab. Now you know that all the objects in OpenShift can be labeled.  This is important because those labels can be used as part of your CI/CD process.  An upcoming lab will cover using labels for Blue/Green deployments. Labels can also be used for running your apps on specific nodes (e.g. just on SSD nodes or just on east coast nodes).  


{{< importPartial "footer/footer.html" >}}
