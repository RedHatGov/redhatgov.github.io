---
title: Feature Update
workshops: openshift_service_mesh
workshop_weight: 31
layout: lab
---

# Digging into Observability 

Istio provides additional capabilities to analyze the service mesh and its performance.  Let's deploy a new version of the user profile service and analyze its effect on the service mesh.

## Feature Update

The profile page returns basic information about the user.  Let's add a feature update to show a profile photo on the profile page.

The code has already been written for you on the 'feature_update' branch of the repo.

Navigate to the URL via your browser:
```
https://github.com/dudash/openshift-microservices/blob/master/code/userprofile/src/main/java/org/microservices/demo/service/UserProfileService.java
```

Output (snippet):
```
...
    /**
     * return the photo information for a specific profile
     * @param id
     * @return
     */
    UserProfilePhoto getUserProfilePhoto(@NotBlank String id);
...
```

The interface also includes a method for getting the user profile's photo, which has been implemented for you.

## Build and Deploy

Navigate to the workshop directory:
```
cd $HOME/openshift-microservices/deployment/workshop
```

Create a new build on this feature branch:
```
oc new-app -f ./openshift-configuration/userprofile-build.yaml \
  -p APPLICATION_NAME=userprofile \
  -p APPLICATION_CODE_URI=https://github.com/dudash/openshift-microservices.git \
  -p APPLICATION_CODE_BRANCH=feature_update \
  -p APP_VERSION_TAG=2.0
```

> Ignore the failure since the imagestream already exists.

Start the build:
```
oc start-build userprofile-2.0
```

Follow the build:
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

Once the build is complete, the image is stored in the OpenShift local repository.

Verify the image was created:
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

The latest image should have the '2.0' tag.

Grab a reference to the local image:
```
USER_PROFILE_IMAGE_URI=$(oc get is userprofile -o jsonpath='{.status.dockerImageRepository}{"\n"}')
echo $USER_PROFILE_IMAGE_URI
```

Output (sample):
```
image-registry.openshift-image-registry.svc:5000/microservices-demo/userprofile
```

The deployment file 'userprofile-deploy-v2.yaml' was created for you to deploy the application.

Deploy the service using the image URI:
```
sed "s|%USER_PROFILE_IMAGE_URI%|$USER_PROFILE_IMAGE_URI|" ./openshift-configuration/userprofile-deploy-v2.yaml | oc create -f -
```

Watch the deployment of the user profile:
```
oc get pods -l deploymentconfig=userprofile --watch
```

Output:
```
userprofile-2-xxxxxxxxxx-xxxxx            2/2     Running        0          22s
userprofile-xxxxxxxxxx-xxxxx              2/2     Running        0          2m55s
```

## Access Application

Let's test the new version of our profile service in the browser.

Navigate to the 'Profile' section in the header.  If you lost the URL, you can retrieve it via:
```
echo $GATEWAY_URL
```

The profile page will round robin between versions 1 and 2.  Refresh a couple of times, and you'll notice that sometimes the page loads really slowly.  Let's use Istio to debug the problem.


{{< importPartial "footer/footer.html" >}}