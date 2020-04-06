---
title: Installing Istio
workshops: openshift_service_mesh
workshop_weight: 12
layout: lab
---

# Installing Istio - the Easy Button

You will conduct these labs in an OpenShift cluster.  First, test you have access to your cluster via console and CLI.

## OpenShift

<blockquote>
<i class="fa fa-desktop"></i> Navigate to the console URI provided by your instructor and login with the username/password provided.
</blockquote>

For example:

```
http://console-openshift-console.apps.cluster-naa-xxxx.naa-xxxx.example.opentlc.com
```

Once logged in, you should see the following:

<img src="../images/openshift-welcome.png" width="1024"><br/>
 *OpenShift Welcome*

<br>

You will use the OpenShift 'oc' CLI  to execute commands for the majority of this lab.  


<blockquote>
<i class="fa fa-terminal"></i> Login using API endpoint and remember to add the '--insecure-skip-tls-verify=true' flag
</blockquote>

For example:

```
oc login https://api.cluster-naa-xxxx.naa-xxxx.example.opentlc.com:6443 --insecure-skip-tls-verify=true
```

<blockquote>
<i class="fa fa-terminal"></i> Check the status of the cluster:
</blockquote>

```
oc status
```

You should see two services running 'svc/openshift' and 'svc/kubernetes'.

<br>

## Application Code
Next we need a local copy of our application code.  The application code includes the resources to install Istio.

<blockquote>
<i class="fa fa-terminal"></i> Clone the repository in your home directory:
</blockquote>

```
cd $HOME
git clone https://github.com/dudash/openshift-microservices.git
```

<blockquote>
<i class="fa fa-terminal"></i> Checkout the workshop-stable branch:
</blockquote>

```
cd $HOME/openshift-microservices
git checkout workshop-stable
```

<br>

## Istio
Let's install Istio in our cluster. 

<blockquote>
<i class="fa fa-terminal"></i>
Navigate to the directory for installing Istio:
</blockquote>

```
cd $HOME/openshift-microservices/deployment/install/istio
```

Start by installing the Istio [Operator][1].  The operator is used to install and manage Istio in the cluster.

<br>

<blockquote>
<i class="fa fa-terminal"></i>Run the following command:
</blockquote>

```
oc apply -f ./istio-operator.yaml
```

<br>

<blockquote>
<i class="fa fa-terminal"></i> Use oc to watch the operator installation:
</blockquote>

```
oc get pods -n openshift-operators -l name=istio-operator --watch
```

The Istio operator should be in a running state.  For example:
```
istio-operator-xxxxxxxxx-xxxxx   1/1   Running   0     17s
```

Once the operator is running, install the Istio control plane in its own namespace 'istio-system':

<br>

<blockquote>
<i class="fa fa-terminal"></i>Run the following 2 commands:
</blockquote>

```
oc new-project istio-system
```
```
oc create -n istio-system -f ./istio-resources.yaml
```

<br>

<blockquote>
<i class="fa fa-terminal"></i>Watch the control plane installation:
</blockquote>

```
oc get servicemeshcontrolplane/istio-demo -n istio-system --template='{{range .status.conditions}}{{printf "%s=%s, reason=%s, message=%s\n\n" .type .status .reason .message}}{{end}}' --watch
```

Wait a couple of minutes.  The installation should complete.  For example:

```
Installed=True, reason=InstallSuccessful, message=Successfully installed all mesh components

Reconciled=True, reason=InstallSuccessful, message=Successfully installed version 1.0.6-1.el8-1

Ready=True, reason=ComponentsReady, message=All component deployments are Available

```

<br>

<blockquote>
<i class="fa fa-terminal"></i>
List all the Istio components:
</blockquote>

```
oc get pods -n istio-system
```

Output:

```
NAME                                      READY   STATUS    RESTARTS   AGE
grafana-xxxxxxxxx-xxxxx                  2/2     Running   0          17m
istio-citadel-xxxxxxxxx-xxxxx            1/1     Running   0          20m
istio-egressgateway-xxxxxxxx-xxxxx       1/1     Running   0          17m
istio-galley-xxxxxxxx-xxxxx              1/1     Running   0          19m
istio-ingressgateway-xxxxxxxxx-xxxxx     1/1     Running   0          17m
istio-pilot-xxxxxxxxx-xxxxx              2/2     Running   0          18m
istio-policy-xxxxxxxxx-xxxxx             2/2     Running   0          19m
istio-sidecar-injector-xxxxxxxxx-xxxxx   1/1     Running   0          17m
istio-telemetry-xxxxxxxxx-xxxxx          2/2     Running   0          19m
jaeger-xxxxxxxxx-xxxxx                   2/2     Running   0          19m
kiali-xxxxxxxxx-xxxxx                    1/1     Running   0          16m
prometheus-xxxxxxxxx-xxxxx               2/2     Running   0          19m
```

The primary control plane components are [Pilot][2], [Mixer][3], and [Citadel][4].  Pilot handles traffic management.  Mixer handles policy and telemetry.  Citadel handles security.

<br>

## Setup Projects

{{< panel_group >}}
{{% panel "Run these steps if you are an instructor setting up a workshop class" %}}

As the instructor, you will create projects for users (identified as users1...x).  You also need to grant each user view access to the Istio namespace 'istio-system'. 

<blockquote>
<i class="fa fa-terminal"></i>
Run the following:
</blockquote>

```
NUM_USERS=<enter number of users>
```

```
for (( i=1 ; i<=$NUM_USERS ; i++ ))
do 
  oc new-project user$i --as=user$i \
    --as-group=system:authenticated --as-group=system:authenticated:oauth
  oc adm policy add-role-to-user view user$i -n istio-system
done
```

<br>

Next, add projects to the service mesh using a Member Roll resource.  If you do not add the projects to the mesh, the users' microservices will not be added to the service mesh.


<blockquote>
<i class="fa fa-terminal"></i>
Add projects to the mesh.  Adjust the number of user projects if needed:
</blockquote>

```
oc apply -f - <<EOF
apiVersion: maistra.io/v1
kind: ServiceMeshMemberRoll
metadata:
  name: default
  namespace: istio-system
spec:
  members:
    - user1
    - user2
    - user3
    - user4
    - user5
    - user6
    - user7
    - user8
    - user9
    - user10
    - user11
    - user12
    - user13
    - user14
    - user15
    - user16
    - user17
    - user18
    - user19
    - user20
EOF
```
{{% /panel %}}
{{< /panel_group >}}

<br>

## Summary

Congratulations, you installed Istio!  

A few key highlights are:

* The Istio control plane can be installed in OpenShift using the Service Mesh Operator
* The primary control plane components are Pilot, Mixer, and Citadel
* Projects must be added to the service mesh via the [Member Roll][6] resource

If you want to learn more about Istio's architecture, the best place to start is the [Istio documentation][7].

[1]: https://www.openshift.com/learn/topics/operators
[2]: https://istio.io/docs/concepts/traffic-management/
[3]: https://istio.io/docs/concepts/observability/
[4]: https://istio.io/docs/concepts/security/
[5]: https://maistra.io/docs/installation/installation-options/
[6]: https://docs.openshift.com/container-platform/4.1/service_mesh/service_mesh_install/installing-ossm.html#ossm-member-roll_installing-ossm
[7]: https://istio.io/docs/ops/deployment/architecture/


{{< importPartial "footer/footer.html" >}}