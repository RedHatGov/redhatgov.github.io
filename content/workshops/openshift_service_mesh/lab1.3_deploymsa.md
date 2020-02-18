---
title: Deploying an App
workshops: openshift_service_mesh
workshop_weight: 13
layout: lab
---

# Deploying an App into the Service Mesh

It's time to deploy your microservices application.  The application you are working on is a paste board application in which users can post comments in shared boards.  Here is a diagram of the architecture:

*Show architecture*

Some of the microservices include SSO, user interface, the boards application, and the context scraper.  In this scenario, we are going to deploy these services and then add a new user profile service.


## Deploy Microservices

Navigate to the application resources.

``
cd $HOME/openshift-microservices/deployment/install/microservices/openshift-configuration
``

We are going to build the application images from source code and then deploy the resources in the cluster.

Create a new project for the microservices.  The project `microservices-demo` was already added to the service mesh in the previous lab.

```
oc new-project microservices-demo --display-name="OpenShift Microservices Demo"
```

The source files are labeled `{microservice}-fromsource.yaml`.  In each file, an annotation `sidecar.istio.io/inject` was added to tell Istio to inject a sidecar proxy.

Verify the annotation in the `app-ui` file:
```
cat app-ui-fromsource.yaml | grep -B 1 sidecar.istio.io/inject
```

Output:
```
	annotations:
	  sidecar.istio.io/inject: "true"
```

Now let's deploy the microservices.

Deploy the boards service:
```
oc new-app -f ./boards-fromsource.yaml \
  -p APPLICATION_NAME=boards \
  -p NODEJS_VERSION_TAG=8-RHOAR \
  -p GIT_URI=https://github.com/dudash/openshift-microservices.git \
  -p GIT_BRANCH=develop \
  -p DATABASE_SERVICE_NAME=boards-mongodb \
  -p MONGODB_DATABASE=boardsDevelopment
```

Deploy the context scraper service:
```
oc new-app -f ./context-scraper-fromsource.yaml \
  -p APPLICATION_NAME=context-scraper \
  -p NODEJS_VERSION_TAG=8-RHOAR \
  -p GIT_BRANCH=develop \
  -p GIT_URI=https://github.com/dudash/openshift-microservices.git
```

Deploy the app user interface:
```
oc new-app -f ./app-ui-fromsource.yaml \
  -p APPLICATION_NAME=app-ui \
  -p NODEJS_VERSION_TAG=8-RHOAR \
  -p GIT_BRANCH=develop \
  -p GIT_URI=https://github.com/dudash/openshift-microservices.git
```

Deploy SSO:
```
oc new-app -f ./sso73-x509-https.yaml \
  -p APPLICATION_NAME=sso
```

Watch the microservices demo installation:

```
oc get pods -n microservices-demo --watch
```

Wait a couple minutes.  You should see the `app-ui`, `boards`, `context-scraper`, and `sso` pods running.  For example:

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
sso73-x509-1-xxxxx         2/2     Running     0          62m
sso73-x509-1-deploy        1/1     Completed   0          62m
```

Each microservices pod runs two containers: the application itself and the Istio proxy.

Print the containers in the `app-ui` pod:

```
oc get pods -l app=app-ui -o jsonpath='{.items[*].spec.containers[*].name}{"\n"}'
```

Output:
```
app-ui istio-proxy
```

## Access Application

The application is deployed!  But we need a way to access the application via the user interface.

Istio provides a [Gateway][1] resource, which is a load balancer at the edge of the service mesh that accepts incoming connections.  We need to deploy a Gateway resource and configure it to route to the application user interface.

Navigate to the Istio resources.
```
cd $HOME/openshift-microservices/deployment/install/microservices/istio-configuration
```

Deploy the Gateway and routing rules:
```
oc apply -f ./ingress-gateway.yaml
```

For the last step, we need the endpoint of the load balancer that is accepting connections for our application.  This is the `istio-ingressgateway` in our service mesh.

Export the URL of this gateway:
```
export GATEWAY_URL=$(oc -n istio-system get route istio-ingressgateway -o jsonpath='{.spec.host}')
echo $GATEWAY_URL
```

Navigate to this URL in the browser.  For example:

```
https://istio-ingressgateway-istio-system.apps.cluster-naa-xxxx.naa-xxxx.example.opentlc.com:6443 
```

You should see the application user interface.  Try creating a new board and posting to the shared board.

For example:

*Application user interface*

Congratulations, you installed the microservices application!

[1]: https://istio.io/docs/reference/config/networking/gateway/

{{< importPartial "footer/footer.html" >}}