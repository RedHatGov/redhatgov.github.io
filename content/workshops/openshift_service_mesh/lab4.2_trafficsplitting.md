---
title: Traffic Splitting
workshops: openshift_service_mesh
workshop_weight: 42
layout: lab
---

# Splitting Traffic Amongst Service Versions

It's time to fix the performance issue of the application.  Previously, you deployed a new version of the application and routed 100% of traffic to the new version.  This time, you'll use Istio traffic routing to do canary rollouts and split traffic.

## Feature Fix

The code to fix the performance issue of the user profile service has already been written for you.  Navigate to the workshop directory:
```
cd $HOME/openshift-microservices/deployment/workshop
```

Check out the 'feature_fix' branch:
```
git checkout -b feature_fix
```

Create a new build on this feature branch:
```
oc new-app -f ./openshift-configuration/userprofile-build.yaml \
  -p APPLICATION_NAME=userprofile \
  -p APPLICATION_CODE_URI=https://github.com/dudash/openshift-microservices.git \
  -p APPLICATION_CODE_BRANCH=moving-to-four \
  -p APP_VERSION_TAG=3.0
```

Start the build:
```
oc start-build userprofile-3.0
```

Follow the build:
```
oc logs -f bc/userprofile-3.0
```

The builder will compile the source code and use the base image to create your deployable image artifact.  You should eventually see a successful build.

Output (snippet):
```
...
[INFO] [io.quarkus.deployment.pkg.steps.JarResultBuildStep] Building thin jar: /tmp/src/target/userprofile-1.0-SNAPSHOT-runner.jar
[INFO] [io.quarkus.deployment.QuarkusAugmentor] Quarkus augmentation completed in 7988ms
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:41 min
[INFO] Finished at: 2020-02-24T19:13:59Z
[INFO] ------------------------------------------------------------------------...
```

Once the build is complete, the image is stored in the OpenShift local repository.

Verify the image was created:
```
oc describe is userprofile
```

Output (snippet):
```
...

3.0
  no spec tag

  * image-registry.openshift-image-registry.svc:5000/microservices-demo/userprofile@sha256:da74d277cc91c18226fb5cf8ca25d6bdbbf3f77a7480d0583f23023fb0d0d7df
      12 seconds ago

2.0
  no spec tag

  * image-registry.openshift-image-registry.svc:5000/microservices-demo/userprofile@sha256:147d836e9f7331a27b26723cbb99f2b667e176b4d5dd356fea947c7ca4fc24a6
      16 minutes ago
...
```

The latest image should have the '3.0' tag.

Grab a reference to the local image:
```
USER_PROFILE_IMAGE_URI=$(oc get is userprofile -o jsonpath='{.status.dockerImageRepository}{"\n"}')
echo $USER_PROFILE_IMAGE_URI
```

Output (sample):
```
image-registry.openshift-image-registry.svc:5000/microservices-demo/userprofile
```

The deployment file 'userprofile-deploy-v3.yaml' was created for you to deploy the application.

Deploy the service using the image URI:
```
sed "s|%USER_PROFILE_IMAGE_URI%|$USER_PROFILE_IMAGE_URI|" ./openshift-configuration/userprofile-deploy-v3.yaml | oc create -f -
```

Watch the deployment of the user profile:
```
oc get pods -l deploymentconfig=userprofile --watch
```

Output:
```
userprofile-3-xxxxx              2/2     Running        0          53s
userprofile-2-xxxxx              2/2     Running        0          13m
userprofile-1-xxxxx              2/2     Running        0          22h
```

## Traffic Routing

Navigate to the workshop directory:
```
cd $HOME/openshift-microservices/deployment/workshop
```

Let's start with a [Canary Release][1] of the new version of the user profile service.  You'll route 90% of user traffic to version 1 and route 10% of traffic to the latest version.

View the virtual service in your favorite editor or via bash:
```
cat ./istio-configuration/virtual-service-userprofile-90-10.yaml
```

Output (snippet):
```
...
---
  http:
  - route:
    - destination:
        host: userprofile
        subset: v1
      weight: 90
  http:
  - route:
    - destination:
        host: userprofile
        subset: v3
      weight: 10 
---
...
```

The weights determine the amount of traffic sent to the service subset.

Deploy the routing rule:
```
oc apply -f ./istio-configuration/virtual-service-userprofile-90-10.yaml
```

Send load to the user profile service:
```
for ((i=1;i<=100;i++)); do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

Inspect the change in Kiali.  Navigate to 'Graph' in the left navigation bar. If you lost the URL, you can retrieve it via:
```
echo $KIALI_CONSOLE
```

Switch to the 'Versioned app graph' view.  Change the 'No edge labels' dropdown to 'Requests percentage'.  

You should see a 90/10 percentage split between versions 1 and 3 of the user profile service.

*Show versioned app graph with 90-10 split*

By doing this, you can isolate the new user profile experience for a small subset of your users without impacting everyone at once.  

Once you are comfortable with the change, you can increase the traffic load to the latest version.

View the virtual service in your favorite editor or via bash:
```
cat ./istio-configuration/virtual-service-userprofile-50-50.yaml
```

Output (snippet):
```
...
---
  http:
  - route:
    - destination:
        host: userprofile
        subset: v1
      weight: 50
  http:
  - route:
    - destination:
        host: userprofile
        subset: v3
      weight: 50
---
...
```

In this example, you will route traffic evenly between the two versions.  This is commonly known as a [Blue-Green Deployment][2].

Deploy the routing rule:
```
oc apply -f ./istio-configuration/virtual-service-userprofile-50-50.yaml
```

Send load to the user profile service:
```
for ((i=1;i<=100;i++)); do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

Inspect the change again in Kiali.  Navigate to 'Graph' in the left navigation bar.  Switch to the 'Versioned app graph' view.  Change the 'No edge labels' dropdown to 'Requests percentage'.  

You should see a 50/50 percentage split between versions 1 and 3 of the user profile service.

*Show versioned app graph with 50-50 split*

Finally, you are ready to roll this new version to everyone.

View the virtual service in your favorite editor or via bash:
```
cat ./istio-configuration/virtual-service-userprofile-v3.yaml
```

Output (snippet):
```
...
---
  http:
  - route:
    - destination:
        host: userprofile
        subset: v3
---
...
```

Deploy the routing rule:
```
oc apply -f ./istio-configuration/virtual-service-userprofile-v3.yaml
```

Test the new version of your profile service in the browser.

Navigate to the 'Profile' section in the header.  If you lost the URL, you can retrieve it via:
```
echo $GATEWAY_URL
```

You should see the following:

*Show profile page version 3*

Congratulations, you configured traffic splitting in Istio!

[1]: https://martinfowler.com/bliki/CanaryRelease.html
[2]: https://martinfowler.com/bliki/BlueGreenDeployment.html

{{< importPartial "footer/footer.html" >}}