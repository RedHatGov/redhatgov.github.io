---
title: Adding a New Service
workshops: openshift_service_mesh
workshop_weight: 22
layout: lab
---

# Adding a New Service to the Mesh

You built the user profile service and now you need to deploy it into the service mesh.

## Deploy Application

Navigate to the application resources.

``
cd $HOME/openshift-microservices/deployment/install/microservices/openshift-configuration
``


The deployment file `userprofile.yaml` was created for you to deploy the application.  The file creates the user profile service and an accompanying PostgreSQL database.  Similar to the other source files, an annotation `sidecar.istio.io/inject` was added to tell Istio to inject a sidecar proxy and add this to the mesh.

Verify the annotation in the `userprofile` file:
```
cat userprofile.yaml | grep -B 1 sidecar.istio.io/inject
```

Output:
```
	annotations:
	  sidecar.istio.io/inject: "true"
```

Before deploying the service, you need to a reference to the local image you built in the previous lab.
```
export USER_PROFILE_IMAGE_URI=$(oc get is userprofile -o jsonpath='{.status.dockerImageRepository}{"\n"}')
echo $USER_PROFILE_IMAGE_URI
```

Output (sample):
```
image-registry.openshift-image-registry.svc:5000/microservices-demo/userprofile
```

Deploy the service using this image URI:
```
oc new-app -f ./userprofile.yaml \
  -p APPLICATION_NAME=userprofile \
  -p APPLICATION_IMAGE_URI=$USER_PROFILE_IMAGE_URI \
  -p APP_VERSION_TAG=latest \
  -p DATABASE_SERVICE_NAME=userprofile-postgresql
```

Watch the deployment of the user profile:
```
oc get pods -l app=userprofile --watch
```

Output:
```
userprofile-1-xxxxx              2/2     Running		    0          2m55s
userprofile-postgresql-1-xxxxx   2/2     Running            0          2m55s
```

Similar to the other microservices, the user profile services run the application and the Istio proxy.

Print the containers in the `userprofile` pod:

```
oc get pods -l deploymentconfig=userprofile -o jsonpath='{.items[*].spec.containers[*].name}{"\n"}'
```

Output:
```
userprofile istio-proxy
```

## Access Application

The user profile service is deployed!  Let's test this in the browser.

Navigate to the `Profile` section in the header.  If you lost the URL, you can retrieve it via:
```
echo $GATEWAY_URL
```

You should see the following:

*Show profile page*

Congratulations, you deployed the user profile service and added it to the service mesh!

{{< importPartial "footer/footer.html" >}}