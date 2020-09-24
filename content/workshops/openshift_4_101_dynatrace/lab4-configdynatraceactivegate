---
title: Lab 4 - Configuring Dynatrace ActiveGate (Optional)
workshops: openshift_4_101_dynatrace
workshop_weight: 14
layout: lab
---

# Connect your OpenShift clusters to Dynatrace with an ActiveGate to take advantage of the dedicated OpenShift overview page 
  
Connecting your OpenShift clusters to Dynatrace to take advantage of the dedicated OpenShift overview page 
requires that you run an ActiveGate in your environment (version 1.163+).

See https://www.dynatrace.com/support/help/technology-support/cloud-platforms/openshift/monitoring/monitor-openshift-clusters-with-dynatrace/

```bash
oc project dynatrace
oc apply -f https://www.dynatrace.com/support/help/codefiles/kubernetes/kubernetes-monitoring-service-account.yaml

serviceaccount/dynatrace-monitoring created
clusterrole.rbac.authorization.k8s.io/dynatrace-monitoring-cluster created
clusterrolebinding.rbac.authorization.k8s.io/dynatrace-monitoring-cluster created
```

```bash
oc config view --minify -o jsonpath='{.clusters[0].cluster.server}'

https://api.ocp4.local:6443
```

<blockquote>
Get the Bearer token for the OpenShift cluster using the following command:

Copy the secret returned by the following command:
</blockquote>

```bash
oc get secret $(oc get sa dynatrace-monitoring -o jsonpath='{.secrets[1].name}' -n dynatrace) \ 
-o yaml | grep token

echo "<token>" | base64 --decode
```

<blockquote>
The result of the command above is the Bearer token that you'll use to connect your OpenShift cluster to Dynatrace.
</blockquote>

```bash
#oc get secret $(oc get sa dynatrace-monitoring -o jsonpath='{.secrets[1].name}' -n dynatrace) -o jsonpath='{.data.token}' -n dynatrace | base64 --decode
#oc get secret $(oc get sa dynatrace-monitoring -o jsonpath='{.secrets[1].name}' -n dynatrace) -o yaml | grep token
```

<blockquote>
Connect your OpenShift cluster to Dynatrace 
You'll need the Bearer token and the Kubernetes API URL mentioned above to set up the connection to the Kubernetes API.

Go to Settings > Cloud and virtualization > Kubernetes.
Click Connect new cluster.
Provide a Name, Kubernetes API URL, and the Bearer token for the OpenShift cluster.

<img src="../images/ocp-lab-dynatrace-1.png" width="900"><br/>
</blockquote>

<blockquote>
If your OpenShift cluster does not already have a Dynatrace ActiveGate, 
you'll be required to install one.
Click on "Install a new Environment ActiveGate" 

<img src="../images/ocp-lab-dynatrace-2.png" width="900"><br/>

<img src="../images/ocp-lab-dynatrace-3.png" width="900"><br/>

<img src="../images/ocp-lab-dynatrace-4.png" width="900"><br/>

<img src="../images/ocp-lab-dynatrace-5.png" width="900"><br/>

<img src="../images/ocp-lab-dynatrace-6.png" width="900"><br/>

<img src="../images/ocp-lab-dynatrace-7.png" width="900"><br/>
</blockquote>

{{< importPartial "footer/footer.html" >}}
