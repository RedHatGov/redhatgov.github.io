---
title: Lab 15 - Eclipse Che
workshops: trusted_software_supply_chain
workshop_weight: 25
layout: lab
---

# Automate Code Check-ins that trigger the Trusted Software Supply Chain

You will automate code check-ins that trigger the Trusted Software Supply Chain.

You will fail a Unit Test and fix it Eclipse Che to trigger a Webhook Pipeline Run

- Clone and checkout the eap-7 branch of the openshift-tasks git repository and using an IDE (e.g. JBoss Developer Studio), remove the @Ignore annotation from src/test/java/org/jboss/as/quickstarts/tasksrs/service/UserResourceTest.java test methods to enable the unit tests. Commit and push to the git repo.
- Check out Jenkins, a pipeline instance is created and is being executed. The pipeline will fail during unit tests due to the enabled unit test.
- Check out the failed unit and test src/test/java/org/jboss/as/quickstarts/tasksrs/service/UserResourceTest.java and run it in the IDE.
- Fix the test by modifying src/main/java/org/jboss/as/quickstarts/tasksrs/service/UserResource.java and uncommenting the sort function in getUsers method.
- Run the unit test in the IDE. The unit test runs green.
- Commit and push the fix to the git repository and verify a pipeline instance is created in Jenkins and executes successfully.


Click on Eclipse Che route url in the CI/CD project which takes you to the workspace administration page. Select the Java stack and click on the Create button to create a workspace for yourself.

<img src="../images/che-create-workspace.png" width="900"><br/>

Once the workspace is created, click on Open button to open your workspace in the Eclipse Che in the browser.

<img src="../images/che-open-workspace.png" width="900"><br/>

It might take a little while before your workspace is set up and ready to be used in your browser. Once it's ready, click on Import Project... in order to import the openshift-tasks Gogs repository into your workspace.

<img src="../images/che-import-project.png" width="900"><br/>

Enter the Gogs repository HTTPS url for openshift-tasks as the Git repository url with Git username and password in the url:
http://gogs:gogs@[gogs-hostname]/gogs/openshift-tasks.git

You can find the repository url in Gogs web console. Make sure the check the Branch field and enter eap-7 in order to clone the eap-7 branch which is used in this demo. Click on Import

<img src="../images/che-import-git.png" width="900"><br/>

Change the project configuration to Maven and then click Save


<img src="../images/che-import-maven.png" width="900"><br/>

Configure you name and email to be stamped on your Git commity by going to Profile > Preferences > Git > Committer.

<img src="../images/che-configure-git-name.png" width="900"><br/>

Follow the steps to edit the code in your workspace.

Clone and checkout the eap-7 branch of the openshift-tasks git repository and using an IDE (e.g. JBoss Developer Studio), remove the @Ignore annotation from src/test/java/org/jboss/as/quickstarts/tasksrs/service/UserResourceTest.java test methods to enable the unit tests. Commit and push to the git repo.

Check out Jenkins, a pipeline instance is created and is being executed. The pipeline will fail during unit tests due to the enabled unit test.

Check out the failed unit and test src/test/java/org/jboss/as/quickstarts/tasksrs/service/UserResourceTest.java and run it in the IDE.

Fix the test by modifying src/main/java/org/jboss/as/quickstarts/tasksrs/service/UserResource.java and uncommenting the sort function in getUsers method.

Run the unit test in the IDE. The unit test runs green.

<img src="../images/che-edit-file.png" width="900"><br/>

In order to run the unit tests within Eclipse Che, wait till all dependencies resolve first. To make sure they are resolved, run a Maven build using the commands palette icon or by clicking on Run > Commands Palette > build.

Make sure you run the build again, after fixing the bug in the service class.

Run the unit tests in the IDE after you have corrected the issue by right clicking on the unit test class and then Run Test > Run JUnit Test

<img src="../images/che-junit-success.png" width="900"><br/>

Click on Git > Commit to commit the changes to the openshift-tasks git repository. Make sure Push commited changes to ... is checked. Click on Commit button.

<img src="../images/che-commit.png" width="900"><br/>

As soon the changes are committed to the git repository, a new instances of pipeline gets triggers to test and deploy the code changes.
