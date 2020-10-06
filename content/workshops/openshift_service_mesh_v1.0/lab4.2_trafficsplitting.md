---
title: Traffic Control - Traffic Splitting
workshops: openshift_service_mesh_v1.0
workshop_weight: 42
layout: lab
---

# Splitting Traffic Amongst Service Versions

It's time to fix the performance issue of the application.  Previously, you deployed a new version of the application and routed 100% of traffic to the new version.  This time, you'll use Istio traffic routing to do canary rollouts and split traffic.

## Feature Fix

The code to fix the performance issue of the user profile service has already been written for you on the 'workshop-feature-fix' branch.  

<blockquote>
<i class="fa fa-terminal"></i>
Create a new build on this feature branch:
</blockquote>

```
oc new-app -f ./openshift-configuration/userprofile-build.yaml \
  -p APPLICATION_NAME=userprofile \
  -p APPLICATION_CODE_URI=https://github.com/RedHatGov/openshift-microservices.git \
  -p APPLICATION_CODE_BRANCH=workshop-feature-fix \
  -p APP_VERSION_TAG=3.0
```

<p><i class="fa fa-info-circle"></i> Ignore the failure since the imagestream already exists.</p>

<blockquote>
<i class="fa fa-terminal"></i>
Start the build:
</blockquote>

```
oc start-build userprofile-3.0
```

<blockquote>
<i class="fa fa-terminal"></i>
Follow the build:
</blockquote>

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

<blockquote>
<i class="fa fa-terminal"></i>
Verify the image was created:
</blockquote>

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

<blockquote>
<i class="fa fa-terminal"></i>
Grab a reference to the local image:
</blockquote>

```
USER_PROFILE_IMAGE_URI=$(oc get is userprofile --template='{{.status.dockerImageRepository}}')
echo $USER_PROFILE_IMAGE_URI
```

Output (sample):
```
image-registry.openshift-image-registry.svc:5000/microservices-demo/userprofile
```

The deployment file 'userprofile-deploy-v3.yaml' was created for you to deploy the application.

<blockquote>
<i class="fa fa-terminal"></i>
Deploy the service using the image URI:
</blockquote>

```
sed "s|%USER_PROFILE_IMAGE_URI%|$USER_PROFILE_IMAGE_URI|" ./openshift-configuration/userprofile-deploy-v3.yaml | oc create -f -
```

<blockquote>
<i class="fa fa-terminal"></i>
Watch the deployment of the user profile:
</blockquote>

```
oc get pods -l deploymentconfig=userprofile --watch
```

Output:
```
userprofile-3-xxxxxxxxxx-xxxxx              2/2     Running        0          53s
userprofile-2-xxxxxxxxxx-xxxxx              2/2     Running        0          13m
userprofile-xxxxxxxxxx-xxxxx                2/2     Running        0          22h
```

<br>

## Traffic Routing

Let's start with a [Canary Release][1] of the new version of the user profile service.  You'll route 90% of user traffic to version 1 and route 10% of traffic to the latest version.

<blockquote>
<i class="fa fa-terminal"></i>
View the virtual service in your favorite editor or via bash:
</blockquote>

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
    - destination:
        host: userprofile
        subset: v3
      weight: 10 
---
...
```

The weights determine the amount of traffic sent to the service subset.

<blockquote>
<i class="fa fa-terminal"></i>
Deploy the routing rule:
</blockquote>

```
oc apply -f ./istio-configuration/virtual-service-userprofile-90-10.yaml
```

<blockquote>
<i class="fa fa-terminal"></i>
If you aren't already (from the Grafana lab) - send load continuously to the user profile service:
</blockquote>

```
while true; do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

<br>

Inspect the change in Kiali.
<blockquote>
<i class="fa fa-desktop"></i>
Navigate to 'Graph' in the left navigation bar. 
</blockquote>

<p><i class="fa fa-info-circle"></i> If you lost the URL, you can retrieve it via:</p>

`echo $KIALI_CONSOLE`

<blockquote>
<i class="fa fa-desktop"></i>
Switch to the 'Versioned app graph' view and change to 'Last 1m'.  
</blockquote>
<blockquote>
<i class="fa fa-desktop"></i>
Change the 'No edge labels' dropdown to 'Requests percentage'.  
</blockquote>

The traffic splits between versions 1 and 3 of the user profile service at roughly 90% and 10% split.

<img src="../images/kiali-userprofile-90-10.png" width="1024"><br/>
*Kiali Graph with 90-10 Traffic Split*

By doing this, you can isolate the new user profile experience for a small subset of your users without impacting everyone at once.  

Once you are comfortable with the change, you can increase the traffic load to the latest version.


<blockquote>
<i class="fa fa-terminal"></i>
View the virtual service in your favorite editor or via bash:
</blockquote>

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
    - destination:
        host: userprofile
        subset: v3
      weight: 50
---
...
```

In this example, you will route traffic evenly between the two versions. This is a technique that could be used for advanced deployments, for example A/B testing.

<blockquote>
<i class="fa fa-terminal"></i>
Deploy the routing rule:
</blockquote>

```
oc apply -f ./istio-configuration/virtual-service-userprofile-50-50.yaml
```

<blockquote>
<i class="fa fa-terminal"></i>
If you aren't already - send load to the user profile service:
</blockquote>

```
while true; do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

<br>

Inspect the change again in Kiali.

<blockquote>
<i class="fa fa-desktop"></i>
Navigate to 'Graph' in the left navigation bar.
</blockquote>
<blockquote>
<i class="fa fa-desktop"></i>
Switch to the 'Versioned app graph' view.  Change the 'No edge labels' dropdown to 'Requests percentage'.  
</blockquote>

You should see a roughly 50/50 percentage split between versions 1 and 3 of the user profile service.

<img src="../images/kiali-userprofile-50-50.png" width="1024"><br/>
*Kiali Graph with 50-50 Traffic Split*

Finally, you are ready to roll this new version to everyone.

<br>

<blockquote>
<i class="fa fa-terminal"></i>
View the virtual service in your favorite editor or via bash:
</blockquote>

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

<blockquote>
<i class="fa fa-terminal"></i>
Deploy the routing rule:
</blockquote>

```
oc apply -f ./istio-configuration/virtual-service-userprofile-v3.yaml
```

<blockquote>
<i class="fa fa-terminal"></i>
If you aren't already - Send load to the user profile service:
</blockquote>

```
while true; do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

<br>

Inspect the change again in Kiali.
<blockquote>
<i class="fa fa-desktop"></i>
Navigate to 'Graph' in the left navigation bar. 
</blockquote>
<blockquote>
<i class="fa fa-desktop"></i>
Switch to the 'Versioned app graph' view.  Change the 'No edge labels' dropdown to 'Requests percentage'.  
</blockquote>


You should see traffic routed to v3 of the user profile service.

<img src="../images/kiali-userprofile-v3.png" width="1024"><br/>
*Kiali Graph with v3 Routing*

<br>

Let's test this version of the profile service in the browser.

<blockquote>
<i class="fa fa-desktop"></i>
Navigate to the 'Profile' section in the header.  
</blockquote>

<p><i class="fa fa-info-circle"></i> If you lost the URL, you can retrieve it via:</p>
`echo $GATEWAY_URL`

<br>

You should see the following:

<img src="../images/app-profilepage-v3.png" width="1024"><br/>
 *Profile Page*

<br>

## Summary

Congratulations, you configured traffic splitting in Istio!

A few key highlights are:

* We can change the percentage of traffic sent to different versions of services by modifying the 'weight' parameter in a Virtual Service
* The Kiali service graph captures traffic splitting dynamically as traffic flows in the mesh

[1]: https://martinfowler.com/bliki/CanaryRelease.html
[2]: https://martinfowler.com/bliki/BlueGreenDeployment.html

{{< importPartial "footer/footer.html" >}}