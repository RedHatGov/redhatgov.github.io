---
title: Intro to Service Mesh - Deploying an App
workshops: openshift_service_mesh_v1.0_v1.0
workshop_weight: 13
layout: lab
---

# Deploying an App into the Service Mesh

It's time to deploy your microservices application.  The application you are working on is a paste board application in which users can post comments in shared boards.  Here is a diagram of the architecture:


<img src="../images/architecture-highlevel.png" width="800"><br/>

*App Architecture*

The microservices include single sign-on (SSO), user interface (UI), the boards application, and the context scraper.  In this scenario, you are going to deploy these services and then add a new user profile service.

<br>

## Deploy Microservices

You are going to build the application images from source code and then deploy the resources in the cluster.

The source files are labeled '{microservice}-fromsource.yaml'.  In each file, an annotation 'sidecar.istio.io/inject' was added to tell Istio to inject a sidecar proxy.

<blockquote>
<i class="fa fa-terminal"></i>
Verify the annotation in the 'app-ui' file:
</blockquote>

```
cat openshift-configuration/app-ui-fromsource.yaml | grep -B 1 sidecar.istio.io/inject
```

Output:
```
	annotations:
	  sidecar.istio.io/inject: "true"
```

<br>

Now let's deploy the microservices.

<blockquote>
<i class="fa fa-terminal"></i>
Deploy the boards service:
</blockquote>

```
oc new-app -f ./openshift-configuration/boards-fromsource.yaml \
  -p APPLICATION_NAME=boards \
  -p NODEJS_VERSION_TAG=10 \
  -p GIT_URI=https://github.com/RedHatGov/openshift-microservices.git \
  -p GIT_BRANCH=workshop-stable \
  -p DATABASE_SERVICE_NAME=boards-mongodb \
  -p MONGODB_DATABASE=boardsDevelopment
```

<blockquote>
<i class="fa fa-terminal"></i>
Deploy the context scraper service:
</blockquote>

```
oc new-app -f ./openshift-configuration/context-scraper-fromsource.yaml \
  -p APPLICATION_NAME=context-scraper \
  -p NODEJS_VERSION_TAG=10 \
  -p GIT_BRANCH=workshop-stable \
  -p GIT_URI=https://github.com/RedHatGov/openshift-microservices.git
```

<blockquote>
<i class="fa fa-terminal"></i>
Deploy the user interface:
</blockquote>

```
oc new-app -f ./openshift-configuration/app-ui-fromsource.yaml \
  -p APPLICATION_NAME=app-ui \
  -p NODEJS_VERSION_TAG=10 \
  -p GIT_BRANCH=workshop-stable \
  -p GIT_URI=https://github.com/RedHatGov/openshift-microservices.git \
  -e FAKE_USER=true
```

<blockquote>
<i class="fa fa-terminal"></i>
Watch the microservices demo installation:
</blockquote>

```
oc get pods --watch
```

<br>

Wait a couple minutes.  You should see the 'app-ui', 'boards', 'context-scraper', and 'sso' pods running.  For example:

```
NAME                       READY   STATUS      RESTARTS   AGE
app-ui-1-build             0/1     Completed   0          64m
app-ui-1-xxxxx             2/2     Running     0          62m
app-ui-1-deploy            0/1     Completed   0          62m
boards-1-xxxxx             2/2     Running     0          62m
boards-1-build             0/1     Completed   0          64m
boards-1-deploy            0/1     Completed   0          62m
boards-mongodb-1-xxxxx     2/2     Running     0          64m
boards-mongodb-1-deploy    0/1     Completed   0          64m
context-scraper-1-build    0/1     Completed   0          64m
context-scraper-1-xxxxx    2/2     Running     0          62m
context-scraper-1-deploy   0/1     Completed   0          62m
```

<br>

Each microservices pod runs two containers: the application itself and the Istio proxy.

<blockquote>
<i class="fa fa-terminal"></i>
Print the containers in the 'app-ui' pod:
</blockquote>

```
oc get pods -l app=app-ui -o jsonpath='{.items[*].spec.containers[*].name}{"\n"}'
```

Output:
```
app-ui istio-proxy
```

<br>

## Access Application

The application is deployed!  But you need a way to access the application via the user interface.

Istio provides a [Gateway][1] resource, which can configure a load balancer at the edge of the service mesh.  In the previous lab, you verified that a load balancer was already created for you in your project.  The next step is to deploy a Gateway resource and configure the load balancer to route to the application user interface.

<blockquote>
<i class="fa fa-terminal"></i>
Create the gateway configuration and routing rules:
</blockquote>

```
oc process -f ./istio-configuration/ingress-gateway.yaml \
  -p INGRESS_GATEWAY_NAME=demogateway-$PROJECT_NAME | oc create -f -
```

To access the application, you need the endpoint of your load balancer.

<blockquote>
<i class="fa fa-terminal"></i>
Retrieve the URL of the load balancer:
</blockquote>

```
GATEWAY_URL=$(oc get route istio-demogateway-$(oc project -q) --template='http://{{.spec.host}}')
echo $GATEWAY_URL
```

<blockquote>
<i class="fa fa-desktop"></i>
Navigate to this URL in the browser.  For example:
</blockquote>

```
http://istio-demogateway-userX-userX.apps.cluster-naa-xxxx.naa-xxxx.example.opentlc.com:6443
```

<br>

You should see the application user interface.  Try creating a new board and posting to the shared board.

For example:

<img src="../images/app-pasteboard.png" width="1024"><br/>
 *Create a new board*

## Summary

Congratulations, you installed the microservices application!  

A few key highlights are:

* The demo microservices application is a paste board application
* The annotation 'sidecar.istio.io/inject' tells Istio to inject a sidecar proxy into the microservice pod
* A Gateway resource configures an edge load balancer to allow inbound connections into the service mesh


[1]: https://istio.io/docs/reference/config/networking/gateway/

{{< importPartial "footer/footer.html" >}}