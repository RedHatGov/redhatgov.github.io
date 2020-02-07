---
title: Deploying an App
workshops: openshift_service_mesh
workshop_weight: 13
layout: lab
---

# Deploying an App into the Service Mesh

It's time to deploy your microservices application.  The application you are working on is a paste board application in which users can post comments in shared boards.  Here is a diagram of the architecture:

*Show architecture*

Some of the microservices include the UI, the boards application, and the context scraper.  In this scenario, we are going to deploy these services and then add a new user profile service.


## Deploy Microservices

Navigate to the application resources.

``
cd ../microservices/openshift-configuration
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

Deploy the app UI:
```
oc new-app -f ./app-ui-fromsource.yaml \
  -p APPLICATION_NAME=app-ui \
  -p NODEJS_VERSION_TAG=8-RHOAR \
  -p GIT_BRANCH=develop \
  -p GIT_URI=https://github.com/dudash/openshift-microservices.git
```

Watch the microservices demo installation:

```
oc get pods -n microservices-demo --watch
```

Wait a couple minutes.  You should see the `app-ui`, `boards`, and `context-scraper` pods running.  For example:

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

Print the containers in the `app-ui` pod:

```
oc get pods -l app=app-ui -o jsonpath='{.items[*].spec.containers[*].name}{"\n"}'clear
```

Output:
```
app-ui istio-proxy
```






{{< importPartial "footer/footer.html" >}}