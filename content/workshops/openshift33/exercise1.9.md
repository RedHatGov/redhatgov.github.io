---
title: Exercise 1.9 - JBoss Kitchen Sink
workshops: openshift33
workshop_weight: 190
layout: lab
---

# Introduction

The quickstarts demonstrate JBoss EAP, Java EE 7 and a few additional technologies. They provide small, specific, working examples that can be used as a reference for your own project.


# Let's Execute the S2I xPaaS JBoss EAP Build Pipeline and Deploy

> Click "New Project"

<p><img title="login to OSE" src="../images/ose-lab-xpaas-projects.png" width="1000"/></p>

> Enter "jboss-xpaas" under name and click "Create"

<p><img title="login to OSE" src="../images/ose-lab-xpaas-newproject.png" width="1000"/></p>

> Type in "eap" in the box next to "Browse" and select "jboss-eap64-openshift:1.4"

<p><img title="login to OSE" src="../images/ose-lab-xpaas-catalog.png" width="1000"/></p>

<p>{{< alert warning >}} If you don't enter a unique user name, then we will have conflicting routes between users.{{< /alert >}}</p>

> Enter kitchensink-"your user name" under Name For example, if you are user1, please enter "kitchensink-user1" and so on.
>
> Click "Try it" and Git Repository URL should automatically be filled
>
> Click "Create"

<p><img title="login to OSE" src="../images/ose-lab-xpaas-eapimage.png" width="1000"/></p>

> Click "Continue to overview"

<p><img title="login to OSE" src="../images/ose-lab-xpaas-appcreated.png" width="1000"/></p>

> Click "View Log"

<p><img title="login to OSE" src="../images/ose-lab-xpaas-appcreatedoverview.png" width="1000"/></p>

> See the log start with cloning from the GIT repoistory

<p><img title="login to OSE" src="../images/ose-lab-xpaas-log1.png" width="1000"/></p>

> The build will be successful once it says "Push Successful"

<p><img title="login to OSE" src="../images/ose-lab-xpaas-log2.png" width="1000"/></p>

> Navigate to Applications > Routes

<p><img title="login to OSE" src="../images/ose-lab-xpaas-navigateroute.png" width="1000"/></p>

> Click the link under hostname.

<p><img title="login to OSE" src="../images/ose-lab-xpaas-route.png" width="1000"/></p>

> This takes you to the JBoss EAP.  Feel free to add your name to the JBoss EAP Application.

<p><img title="login to OSE" src="../images/ose-lab-xpaas-welcomejboss.png" width="1000"/></p>


# Let's Delete the Project

<p>{{< alert warning >}} Please follow these directions to delete your project so we can free up resources for the next lab. {{< /alert >}}</p>

> Find your jboss-xpaas project and click the trash can icon

<p><img title="login to OSE" src="../images/ose-lab-xpaas-navigateproject.png" width="1000"/></p>

> Enter "jboss-xpaas" and click "delete"

<p><img title="login to OSE" src="../images/ose-lab-xpaas-deleteroute1.png" width="1000"/></p>

> Confirm project has been deleted

<p><img title="login to OSE" src="../images/ose-lab-xpaas-deleteconfirm.png" width="1000"/></p>
