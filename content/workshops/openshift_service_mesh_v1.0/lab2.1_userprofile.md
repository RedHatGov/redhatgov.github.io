---
title: Intro to Service Mesh - Building a Microservice
workshops: openshift_service_mesh_v1.0
workshop_weight: 21
layout: lab
---

# Building a Microservice

<blockquote>
<i class="fa fa-desktop"></i>
In the browser, navigate to the 'Profile' section in the header.
</blockquote>

<p><i class="fa fa-info-circle"></i> If you lost the URL, you can retrieve it via:</p>
`echo $GATEWAY_URL`

<br>

You should see the following:

<img src="../images/app-unknownuser.png" width="1024"><br/>
 *Unknown Profile Page*

The UI shows an unknown user and that's because there's no profile service for your application.  You are going to build a new microservice for user profiles and add this to your service mesh.

## Application Code

Your new application is written in Java, whereas the other backend components such as 'app-ui' and 'boards' are written in NodeJS.  One of the advantages of Istio is that it is agnostic to the programming languages of the running microservices.


<blockquote>
<i class="fa fa-desktop"></i>
Navigate to the 'UserProfile' class in your browser:
</blockquote>

```
https://github.com/RedHatGov/openshift-microservices/blob/workshop-stable/code/userprofile/src/main/java/org/microservices/demo/json/UserProfile.java
```

Output (snippet):
```
...
    }
    public UserProfile(String id, String firstname, String lastname, String aboutme) {
        this.id = id;
        this.firstName = firstname;
        this.lastName = lastname;
        this.aboutMe = aboutme;
        this.createdAt = Calendar.getInstance().getTime();
    }
...
```

This class encapsulates information about the user such as the first and last name.

<br>

Your application also exposes a REST API to interact with the service.

<blockquote>
<i class="fa fa-terminal"></i>
Navigate to the 'UserProfileService' interface in your browser:
</blockquote>

```
https://github.com/RedHatGov/openshift-microservices/blob/workshop-stable/code/userprofile/src/main/java/org/microservices/demo/service/UserProfileService.java
```

Output (snippet):
```
...
    /**
     * return a specific profile
     * @param id
     * @return the specified profile
     */
    UserProfile getProfile(@NotBlank String id);
...
```

This interface includes the REST methods for getting and setting user profile information.

<br>

## Build Application

You are ready to build the application.  

Use a [BuildConfig][1] to build the application image.  A 'BuildConfig' template was already created for you.

<blockquote>
<i class="fa fa-terminal"></i>
Verify the base image used to build the application:
</blockquote>

```
cat ./openshift-configuration/userprofile-build.yaml | grep -A 4 sourceStrategy
```

Output (snippet):
```
      sourceStrategy:
        from:
          kind: ImageStreamTag
          name: java:11
          namespace: openshift
```

Notice the build uses a base Java image to build the application.

<br>

<blockquote>
<i class="fa fa-terminal"></i>
Create the build:
</blockquote>

```
oc new-app -f ./openshift-configuration/userprofile-build.yaml \
  -p APPLICATION_NAME=userprofile \
  -p APPLICATION_CODE_URI=https://github.com/RedHatGov/openshift-microservices.git \
  -p APPLICATION_CODE_BRANCH=workshop-stable \
  -p APP_VERSION_TAG=1.0
```

<blockquote>
<i class="fa fa-terminal"></i>
Start the build:
</blockquote>

```
oc start-build userprofile-1.0
```

<blockquote>
<i class="fa fa-terminal"></i>
Follow the build:
</blockquote>

```
oc logs -f bc/userprofile-1.0
```

The builder will compile the source code and use the base image to create your deployable image artifact.  You should eventually see a successful build.

Output (snippet):
```
...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:35 min
[INFO] Finished at: 2020-02-19T21:00:22Z
[INFO] ------------------------------------------------------------------------
...
```

<br>

Once the build is complete, the image is stored in the OpenShift local repository.

<blockquote>
<i class="fa fa-terminal"></i>
Verify the image was created:
</blockquote>

```
oc get is userprofile
```

Output:
```
NAME          IMAGE REPOSITORY                                                                  TAGS     UPDATED
userprofile   image-registry.openshift-image-registry.svc:5000/microservices-demo/userprofile   1.0   3 minutes ago
```

[1]: https://docs.openshift.com/container-platform/4.2/builds/understanding-buildconfigs.html

{{< importPartial "footer/footer.html" >}}