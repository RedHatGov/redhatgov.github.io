---
title: Lab 17 - Trigger the Software Supply Chain
workshops: secure_software_factory
workshop_weight: 27
layout: lab
---

# Trigger the Trusted Software Supply Chain with Code Check-ins

Through automation, you will trigger the Trusted Software Supply Chain with code check-ins.

<br>
# Verify Webhook in Gogs

The Webhook is what triggers your pipeline upon code check-ins.  You want your SCM to trigger the pipeline as opposed to Jenkins constantly polling the source code for changes.

Click on the Gogs route url in the CI/CD project which takes you to the home page.  Sign in using the credentials given to you by your Instructor.

Go to the openshift-tasks repository.

Select Settings.

Select Webhooks

Verify the Webhook.  Make sure the url includes the name 'tasks-pipeline' of the your imported pipeline.

<img src="../images/gogs-webhook.png" width="900"><br/>

This should match the webhook of the pipeline you previously created except the domain will be openshift.default.svc.cluster.local because the gogs pod calls the internal dns to resolve the address.

The webhook url is located in builds > pipeline > tasks-pipeline > configuration > generic webhook url

<br>
# Using Eclipse Che for Editing Code

Click on Eclipse Che route url in the CI/CD project which takes you to the workspace administration page. Select the Java stack and click on the Create button to create a workspace for yourself.

<img src="../images/che-create-workspace.png" width="900"><br/>

You may need to start the workspace.  Click Start.

<img src="../images/eclipse_che_workspace_start.png" width="900"><br/>

It might take a little while before your workspace is set up and ready to be used in your browser. Once it's ready, click on Import Project... in order to import the openshift-tasks Gogs repository into your workspace.

<img src="../images/che-import-project.png" width="900"><br/>

Enter the Gogs repository http url for openshift-tasks as the Git repository url with Git username and password in the url.

See the url below as an example.  Replace [gogs-hostname] with your gogs server.
http://gogs:gogs@[gogs-hostname]/gogs/openshift-tasks.git

So it should look something like this:
http://gogs:gogs@gogs-cicd-user2.192.168.42.136.nip.io/gogs/openshift-tasks.git

You can find the repository url in Gogs web console. Make sure the check the Branch field and enter eap-7 in order to clone the eap-7 branch which is used in this demo.

Click on Import

<img src="../images/che-import-git2.png" width="900"><br/>

Change the project configuration to Maven and then click Save


<img src="../images/che-import-maven.png" width="900"><br/>

Configure you name and email to be stamped on your Git commity by going to Profile > Preferences > Git > Committer.  Click Save and Close the Window once Saved.

<img src="../images/che-configure-git-name2.png" width="900"><br/>

<br>
# Edit Code in your Workspace

Remove the @Ignore annotation from src/test/java/org/jboss/as/quickstarts/tasksrs/service/UserResourceTest.java test methods to enable the unit tests.

<img src="../images/remove_ignore.png" width="900"><br/>

Commit and push to the git repo.

<img src="../images/che_commit_push_git.png" width="900"><br/>

<img src="../images/che-commit_push.png" width="900"><br/>

Check out Jenkins, a pipeline instance is created and is being executed. The pipeline will fail during unit tests due to the enabled unit test.

<img src="../images/pipeline_failed_unittest.png" width="900"><br/>

Fix the test by modifying src/main/java/org/jboss/as/quickstarts/tasksrs/service/UserResource.java and uncommenting the sort function in getUsers method.

You can use CTRL+/ to uncomment multiple lines

<img src="../images/che-user_resource_fix.png" width="900"><br/>


Click on Git > Commit to commit the changes to the openshift-tasks git repository. Make sure Push commited changes to: origin/eap7 is checked. Click on Commit button.

<img src="../images/che-commit.png" width="900"><br/>

As soon the changes are committed to the git repository, a new instances of pipeline gets triggers to test and deploy the code changes.

Go Back to OpenShift and Promote to Stage to finish your Pipeline Run

<img src="../images/pipeline_execution.png" width="900"><br/>
