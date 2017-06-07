---
title: Adding a Database (MongoDB)
workshops: openshift33
workshop_weight: 210
layout: lab
---

Most useful applications are "stateful" or "dynamic" in some way, and this is
usually achieved with a database or other data storage. In this next lab we are
going to add MongoDB to our `userXX-mlbparks` project and then rewire our
application to talk to the database using environment variables.

We are going to use the MongoDB image that is included with OpenShift, as listed
on the [OpenShift
Technologies](https://enterprise.openshift.com/features/#technologies) page.

By default, this will use *EmptyDir* for data storage, which means if the *Pod*
disappears the data does as well. In a real application you would use
OpenShift's persistent storage mechanism with the database *Pods* to give them a
persistent place to store their data.


### Environment Variables
As you saw in the last lab, the web console makes it pretty easy to deploy
application components as well. When we deploy the database, we need to pass in
some environment variables to be used inside the container. These environment
variables are required to set the username, password, and name of the database.
You can change the values of these environment variables to anything you would
like.  The variables we are going to be setting are as follows:

- MONGODB_USER
- MONGODB_PASSWORD
- MONGODB_DATABASE
- MONGODB_ADMIN_PASSWORD

By setting these variables when creating the Mongo database, the image will
ensure that:

- A database exists with the specified name
- A user exists with the specified name
- The user can access the specified database with the specified password

In the web console in your `userXX-mlbparks` project, again click the *"Add to
Project"* button, and then find the `mongodb-ephemeral` template, and click it.

Your view on the next page is slightly different than before. Since this
template requires several environment variables, they are predominantly
displayed:

<!-- TODO: image missing
<img title="OpenShift MongoDB Template" src="../images/mongodb-template.png" width="600"/> -->

You can see that some of the fields say *"generated if empty"*. This is a
feature of *Templates* in OpenShift that will be covered in the next lab. For
now, let's use the following values:

* `MONGODB_USER` : `mlbparks`
* `MONGODB_PASSWORD` : `mlbparks`
* `MONGODB_DATABASE`: `mlbparks`
* `MONGODB_ADMIN_PASSWORD` : `mlbparks`

You can leave the rest of the values as their defaults, and then click
*"Create"*. Then click *Continue to overview*. The MongoDB instance should
quickly be deployed.


### Wiring the JBoss EAP pod(s) to communicate with our MongoDB database
When we initially created our JBoss EAP application, we provided no environment
variables. The application is looking for a database, but can't find one, and it
fails gracefully (you don't see an error).

In order for our JBoss EAP *Pod*(s) to be able to connect to and use the MongoDB
Pod that we just created, we need to wire them together by providing values for
the environment variables to the EAP *Pod*(s).  In order to do this, we simply
need to modify the *DeploymentConfiguration*.

<blockquote>First, find the name of the DC:</blockquote>

```bash
oc get dc
```

<blockquote>Then, use the `oc env` command to set environment variables directly on the DC:</blockquote>

```bash
oc env dc openshift3mlbparks -e MONGODB_USER=mlbparks \
                             -e MONGODB_PASSWORD=mlbparks \
                             -e MONGODB_DATABASE=mlbparks
```

<blockquote>After you have modified the *DeploymentConfig* object, you can verify the environment variables have been added by viewing the JSON document of the configuration:</blockquote>

```bash
oc get dc openshift3mlbparks -o json
```

You should see the following section:

```bash
env": [
	{
		"name": "MONGODB_USER",
		"value": "mlbparks"
	},
	{
		"name": "MONGODB_PASSWORD",
		"value": "mlbparks"
	},
	{
		"name": "MONGODB_DATABASE",
		"value": "mlbparks"
	}
],
```


### OpenShift magic
As soon as we set the environment variables on the *DeploymentConfiguration*, some
magic happened. OpenShift decided that this was a significant enough change to
warrant updating the internal version number of the *DeploymentConfiguration*.

<blockquote>You can verify this by looking at the output of `oc get dc`:</blockquote>

```bash
...
openshift3mlbparks   ConfigChange, ImageChange   2
```

Something that increments the version of a *DeploymentConfiguration*, by default,
causes a new deployment.

<blockquote>You can verify this by looking at the output of `oc get </blockquote>
rc`:

```bash
openshift3mlbparks-1   openshift3mlbparks ... 0
openshift3mlbparks-2   openshift3mlbparks ... 1
```

We see that the replica count for the "-1" deployment is 0. The replica count
for the "-2" deployment is 1. This means that OpenShift has gracefully torn down
our "old" application and stood up a "new" instance.

<blockquote>If you refresh your application:</blockquote>

```bash
http://openshift3mlbparks-userXX-mlbparks.cloudapps.URI.com/
```

You'll notice that the ballparks suddenly are showing up. That's really cool!

You are probably wondering how this magically started working?  When deploying
applications to OpenShift, it is always best to use environment variables to
define connections to dependent systems.  This allows for application
portability across different environments.  The source file that performs the
connection as well as creates the database schema can be viewed here:

[DBConnection.java](https://github.com/gshipley/openshift3mlbparks/blob/master/src/main/java/org/openshift/mlbparks/mongo/DBConnection.java)

In short summary: By referring to environment variables to connect to services
(like databases), it can be trivial to promote applications throughout different
lifecycle environments on OpenShift without having to modify application code.

You can learn more about environment variables in the [environment
variables](https://docs.openshift.com/enterprise/3.1/dev_guide/environment_variables.html)
section of the Developer Guide.


### Using the Mongo command line shell in the container

To interact with our database we will use the `oc exec` command, which allows us
to run arbitrary commands in our *Pods*. If you are familiar with `docker exec`,
the `oc` command essentially is proxying `docker exec` through the OpenShift API
-- very slick!

In this example we are going to use the `bash` shell that already
exists in the MongoDB Docker image, and then invoke the `mongo` command while
passing in the credentials needed to authenticate to the database.

<blockquote>First, find the name of your MongoDB Pod:</blockquote>

```bash
oc get pods
NAME                         READY     STATUS      RESTARTS   AGE
mongodb-1-dkzsp              1/1       Running     0          10m
openshift3mlbparks-1-build   0/1       Completed   0          29m
openshift3mlbparks-2-mxs0r   1/1       Running     0          7m
```

```bash
oc exec -it mongodb-1-dkzsp -- bash -c 'mongo -u mlbparks -p mlbparks mlbparks'
```

**Note:** If you used different credentials when you created your MongoDB Pod,
ensure that you substitute them for the values above.

**Note:** You will need to substitute the correct name for your MongoDB Pod.

<blockquote>Once you are connected to the database, run the following command to count the number of MLB teams added to the database:</blockquote>

```bash
> db.teams.count();
```

<blockquote>You can also view the json documents with the following command:</blockquote>

```bash
> db.teams.find();
```


### OpenShift's web console terminal

If you go back to the web console in your `userXX-mlbparks` *Project* and then
mouse-over *"Browse"* and then select *Pods*, you'll be taken to the list of
your pods. Click the MongoDB pod, and then click the tab labeled *Terminal*.

OpenShift's web console gives you the ability to execute shell commands inside
any of the *Pods* in your *Project*.

<blockquote>In the terminal for your Mongo *Pod*, run the same `mongo` command from before:</blockquote>

```bash
mongo -u mlbparks -p mlbparks mlbparks
```

Then you can issue the same `db.teams.count();` command from before, without
having to use the CLI! This is seriously cool.

**Note:** Don't forget to use the right user and password and database
information.

**Note:** You currently can't copy/paste into the terminal.
