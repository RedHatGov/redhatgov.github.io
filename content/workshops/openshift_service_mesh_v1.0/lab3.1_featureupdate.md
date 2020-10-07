---
title: Observability - Feature Update
workshops: openshift_service_mesh_v1.0_v1.0
workshop_weight: 31
layout: lab
---

# Digging into Observability 

Istio provides additional capabilities to analyze the service mesh and its performance.  Let's deploy a new version of the user profile service and analyze its effect on the service mesh.

## Feature Update

The code has already been written for you on the 'workshop-feature-update' branch of the repo.

<blockquote>
<i class="fa fa-terminal"></i>
Create a new build on this feature branch:
</blockquote>

```
oc new-app -f ./openshift-configuration/userprofile-build.yaml \
  -p APPLICATION_NAME=userprofile \
  -p APPLICATION_CODE_URI=https://github.com/RedHatGov/openshift-microservices.git \
  -p APPLICATION_CODE_BRANCH=workshop-feature-update \
  -p APP_VERSION_TAG=2.0
```

<p><i class="fa fa-info-circle"></i> Ignore the failure since the imagestream already exists.</p>

<br>

<blockquote>
<i class="fa fa-terminal"></i>
Start the build:
</blockquote>

```
oc start-build userprofile-2.0
```

<blockquote>
<i class="fa fa-terminal"></i>
Follow the build:
</blockquote>

```
oc logs -f bc/userprofile-2.0
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

<br>

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
2.0
  no spec tag

  * image-registry.openshift-image-registry.svc:5000/microservices-demo/userprofile@sha256:147d836e9f7331a27b26723cbb99f2b667e176b4d5dd356fea947c7ca4fc24a6
      2 minutes ago

1.0
  no spec tag

  * image-registry.openshift-image-registry.svc:5000/microservices-demo/userprofile@sha256:f01d00409f44962ab321517e18fb06483fadfc07b2f70c088f567acf20dc65eb
      23 hours ago
```

<p><i class="fa fa-info-circle"></i> The latest image should have the '2.0' tag.</p>

<br>

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

<br>

The deployment file 'userprofile-deploy-v2.yaml' was created for you to deploy the application.

<blockquote>
<i class="fa fa-terminal"></i>
Deploy the service using the image URI:
</blockquote>

```
sed "s|%USER_PROFILE_IMAGE_URI%|$USER_PROFILE_IMAGE_URI|" ./openshift-configuration/userprofile-deploy-v2.yaml | oc create -f -
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
userprofile-2-xxxxxxxxxx-xxxxx            2/2     Running        0          22s
userprofile-xxxxxxxxxx-xxxxx              2/2     Running        0          2m55s
```

<br>

## Access Application

Let's test the new version of our profile service in the browser (spoiler: you added a bug).

<blockquote>
<i class="fa fa-desktop"></i>
Navigate to the 'Profile' section in the header.  
</blockquote>

<p><i class="fa fa-info-circle"></i> If you lost the URL, you can retrieve it via:</p>
`echo $GATEWAY_URL`

<br>

The profile page will round robin between versions 1 and 2.  Version 2 loads really slowly and looks like this:

<img src="../images/app-profilepage-v2.png" width="1024"><br/>
 *Profile Page*


## Next, we will use the Service Mesh to debug the problem.

<br>

{{< importPartial "footer/footer.html" >}}