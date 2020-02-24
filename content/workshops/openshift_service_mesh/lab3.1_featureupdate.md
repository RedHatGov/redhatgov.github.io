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

The code has already been written for you.  Navigate to the repo directory:
```
cd $HOME/openshift-microservices
```

Check out the 'feature_update' branch:
```
git checkout -b feature_update
```

Your application also exposes a REST API to interact with the service.

View the interface in your favorite editor or via bash:
```
cat code/userprofile/src/main/java/org/microservices/demo/service/UserProfileService.java
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

Trigger a new build on the application:
```
oc start-build userprofile --from-file=.
```

Follow the build:
```
oc logs -f bc/userprofile
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
latest
  no spec tag

  * image-registry.openshift-image-registry.svc:5000/openshift-console/userprofile@sha256:81d9863567f23557358ef31737d22f47bc05b320e6b8504d59eccb3047c4a55b
      4 minutes ago
    image-registry.openshift-image-registry.svc:5000/openshift-console/userprofile@sha256:d84b0fd5e9f3f416ae6f7e92aff5b5c8c073678d2a8916392935d5ee39206c0b
      About an hour ago
```

The latest tag is applied to the most recently created image.

> TODO: Check deployment config picked up latest tag

## Access Application

Let's test the new version of our profile service in the browser.

Navigate to the 'Profile' section in the header.  If you lost the URL, you can retrieve it via:
```
echo $GATEWAY_URL
```

You should see the following:

*Show profile page loading*

The profile page loads after several seconds, but it's really slow.  Let's use Istio to debug the problem.

