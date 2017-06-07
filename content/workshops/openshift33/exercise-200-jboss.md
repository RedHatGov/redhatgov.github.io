---
title: Deploying Java Code on JBoss EAP
workshops: openshift33
workshop_weight: 200
layout: lab
---

### Background: Source-to-Image (S2I)

In lab four we learned how to deploy a pre-existing Docker image from a Docker
registry. Now we will expand on that a bit by learning how OpenShift builds a
Docker images using source code from an existing repository.

[Source-to-Image (S2I)](https://github.com/openshift/source-to-image) is another
open source project sponsored by Red Hat. Its goal:

```bash
Source-to-image (S2I) is a tool for building reproducible Docker images. S2I
produces ready-to-run images by injecting source code into a Docker image and
assembling a new Docker image which incorporates the builder image and built
source. The result is then ready to use with docker run. S2I supports
incremental builds which re-use previously downloaded dependencies, previously
built artifacts, etc.
```

OpenShift is S2I-enabled and can use S2I as one of its build mechanisms (in
addition to building Docker images from Dockerfiles, and "custom" builds).

OpenShift runs the S2I process inside a special *Pod*, called a Build
Pod, and thus builds are subject to quotas, limits, resource scheduling, and
other aspects of OpenShift.

A full discussion of S2I is beyond the scope of this class, but you can find
more information abuot it either in the [OpenShift S2I
documentation](https://docs.openshift.com/enterprise/latest/creating_images/s2i.html#overview)
or on GitHub (following the link above). The only key concept you need to
remember about S2I is that it's magic.

For a current list of supported runtimes, you can check out the [OpenShift
Technologies](https://enterprise.openshift.com/features/#technologies) page.


### Creating a JBoss EAP application

The sample application that we will be deploying as part of this exercise is
called `mlbparks`.  This application is a Java EE-based application that
performs 2D geo-spatial queries against a MongoDB database to locate and map all
Major League Baseball stadiums in the United States. That was just a fancy way
of saying that we are going to deploy a map of baseball stadiums.

<blockquote>The first thing you need to do is create a new project called `userXX-mlbparks`: </blockquote>

**Note:** Remember to replace userXX-mlbparks with your correct user number.

```bash
oc new-project userXX-mlbparks
```

You should see the following output:

```bash
Now using project "mlbparks" on server "[URI]".
```

### Fork application code on GitHub

OpenShift can work with Git repositories on GitHub. You can even register
webhooks to initiate OpenShift builds triggered by any update to the application
code on GitHub.

The repository that we are going to fork is located at the following URL:

[https://github.com/gshipley/openshift3mlbparks.git](https://github.com/gshipley/openshift3mlbparks.git "https://github.com/gshipley/openshift3mlbparks.git")

Go ahead and fork the `mlbparks` repository into your own GitHub account. Later
in the lab, we want you to make a code change and then rebuild your application.
If you are familiar with Java EE applications, you will notice that there is
nothing special about our application - it is a standard, plain-old JEE
application.

**Note:** If you are not familiar with how to fork applications on GitHub, or if
you don't have a GitHub account, please raise your hand and let your instructor
know.  They can walk you through the process.


### Combine the code with the Docker image on OpenShift

While the `new-app` command makes it very easy to get OpenShift to build code
from a GitHub repository into a Docker image, we can also use the web console to
do the same thing -- it's not all command line and green screen where we're
going! Now that you have your own GitHub repository let's use it with
OpenShift's JBoss EAP S2I image.

In the OpenShift web console, find your `userXX-mlbparks` project, and then
click the *"Add to Project"* button. You will see a number of runtimes that you
can choose from, but you will want to select the one titled
`jboss-eap64-openshift:1.1`. As you might guess, this is going to use an S2I
builder image that contains JBoss EAP 6.4.

<!-- TODO: image missing
<img title="OpenShift Runtimes" src="../images/runtimes.png" width="600"/> -->

After you click *"Add to Project"*, on the next screen you will need to enter a
name and a Git repository URL. For the name, enter `openshift3mlbparks`, and for
the Git repository URL, enter:

```bash
https://github.com/YOURUSER/openshift3mlbparks.git
```

**Note:** Ensure that you use your repository URL if you want to see S2I and
webhooks in action later.

**Note:** Make sure that you change `YOURUSER` to whatever your GitHub ID is
(for example, joecoder22).

**Note:** All of these runtimes shown are made available via *Templates*, which
will be discussed in a later lab.

You can then hit the button labeled *"Create"*. Then click *Continue to
overview*. You will see this in the web console:

```bash
Build openshift3mlbparks #1 is running. A new deployment will be created
automatically once the build completes. View Log
```

Go ahead and click *"View Log"*. This is a new Java-based project that uses
Maven as the build and dependency system.  For this reason, the initial build
will take a few minutes as Maven downloads all of the dependencies needed for
the application. You can see all of this happening in real time!

From the command line, you can also see the *Builds*:

```bash
oc get builds
```

You'll see output like:

```bash
NAME     TYPE      FROM         STATUS     STARTED              DURATION
openshift3mlbparks-1   Source    Git@master   Running    3 minutes ago        1m2s
```

You can also view the build logs with the following command:

```bash
oc build-logs openshift3mlbparks-1
```

After the build has completed and successfully:

* The S2I process will push the resulting Docker image to the internal OpenShift registry
* The *DeploymentConfiguration* (DC) will detect that the image has changed, and this
  will cause a new deployment to happen.
* A *ReplicationController* (RC) will be spawned for this new deployment.
* The RC will detect no *Pods* are running and will cause one to be deployed, as
    our default replica count is just 1.

In the end, when issuing the `oc get pods` command, you will see that the build Pod
has finished (exited) and that an application *Pod* is in a ready and running state:

```bash
NAME                         READY     STATUS      RESTARTS   AGE
openshift3mlbparks-1-build   0/1       Completed   0          4m
openshift3mlbparks-1-7e3ij   1/1       Running     0          2m
```

If you look again at the web console, you will notice that, when you create the
application this way, OpenShift also creates a *Route* for you. You can see the
URL in the web console, or via the command line:

```bash
oc get routes
```

Where you should see something like the following:

```bash
NAME   HOST/PORT     PATH      SERVICE     LABELS      INSECURE POLICY
openshift3mlbparks   [URI]           openshift3mlbparks   app=openshift3mlbparks
```

Verify your application is working by viewing the URL in a web browser.  You should see the following:

<!-- TODO: image missing
<img title="MLBParks Application" src="../images/mlbparks1.png" width="600"/> -->

Wait a second!  Why are the baseball stadiums not showing up?  Well, that is
because we haven't actually added a database to the application yet.  We will do
that in the next lab. Congratulations on deploying your first application
using S2I on the OpenShift 3 Platform!
