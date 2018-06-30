---
title: 'Lab 8: Deploy Sample Application'
workshops: openshift_install
layout: lab
workshop_weight: 80
---

## Summary

To wrap up this workshop, we will finish by deploying a sample application in
our newly installed OpenShift cluster.

## Create New User

To start, you will to create a new user that does not have the `cluster-admin`
role.

Since we used the `HTPasswd` identity provider for this installation, you are
going to create user credentials for your cluster. The file that contains the
users for your `HTPasswd` identity provider is located at
`/etc/origin/master/htpasswd` on the **master** node.

As we did previously when creating the `admin` user, connect to your **master**
node via SSH and run the following command to create a new user in your
`/etc/origin/master/htpasswd` file.

{{< highlight bash >}}
sudo htpasswd -b /etc/origin/master/htpasswd user1 openshift123
{{< /highlight >}}

You can now log into the Web Console using the username `user1` and password
`openshift123`. If you are already logged in as the `admin` user, you can
click the username dropdown in the top right corner and select **Log out**.

## Create Project

When you first log in as `user1`, you'll notice that you do not have any projects.

Start by clicking the blue **Create Project** button to create your first project.

{{< figure src="../images/app_create_project.png" class="img-thumbnail" >}}

In the project details, use the following values:

- **Name:** `test-project`
- **Display Name:** `My Test Project`
- **Description:** \<empty\>

{{< figure src="../images/app_project_details.png" class="img-thumbnail" >}}

Since this is an empty project, you will be brought to a screen showing the
available images that come with OpenShift.

Click the **Java** category.

{{< figure src="../images/app_java_tile.png" class="img-thumbnail" >}}

Then click the **Red Hat JBoss EAP** section.

{{< figure src="../images/app_eap_tile.png" class="img-thumbnail" >}}

You will now see all of the images available that are related to JBoss EAP.

Find the **Red Hat JBoss EAP 7.0** image and click the **Select** button.

{{< figure src="../images/app_eap7_tile.png" class="img-thumbnail" >}}

You will now be asked to fill out the details of the application you're going
to deploy. We are going to use the example application mentioned on the page.

Use the following values:

- **Name:** `kitchensink`
- **Git Repository URL:** `https://github.com/jboss-developer/jboss-eap-quickstarts.git` (click the **Try it** link)
- **Git Reference:** `7.0.0.GA` (automatically populated by the **Try it** link)
- **Context Dir:** `kitchensink` (automatically populated by the **Try it** link)

Then click the blue **Create** button at the bottom of the page.

{{< figure src="../images/app_create_details.png" class="img-thumbnail" >}}

Your application is now being built and deployed. Click the **Continue to
overview** link the page to go back and watch the progress.

{{< figure src="../images/app_continue_to_overview.png" class="img-thumbnail" >}}

Click on the right arrow next to **DEPLOYMENT kitchensink** to expand the details.

You should see towards the bottom of the details the output from the build of
the application.

{{< figure src="../images/app_build.png" class="img-thumbnail" >}}

Once the build is complete, you will see a deployment of the generated application
happen. Once that is finished, you will see the dark blue circle with **1 pod**
inside of it.

This means your application is now up and running.

Click the URL above the **DEPLOYMENT kitchensink** to navgiate to your
application. The link will be in the format of
http://kitchensink-test-project.apps.studentXX.example.com

{{< figure src="../images/app_route.png" class="img-thumbnail" >}}

In a new tab, you should see the JBoss EAP kitchen sink sample application
running.

{{< figure src="../images/app_final.png" class="img-thumbnail" >}}

## You Did It!

That's the end of the workshop.

You have successfully deployed an OpenShift cluster and done an end-to-end
test to verify that everything is functioning properly!
