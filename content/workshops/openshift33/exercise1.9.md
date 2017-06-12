---
title: Exercise 1.9 - JBoss Kitchen Sink
workshops: openshift33
workshop_weight: 190
layout: lab
---

### Introduction
The quickstarts demonstrate JBoss EAP, Java EE 7 and a few additional technologies. They provide small, specific, working examples that can be used as a reference for your own project.


### Let's Execute the S2I xPaaS JBoss EAP Build Pipeline and Deploy
<blockquote> Click "New Project" </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-projects.png" width="500"/></p>

<blockquote> Enter "jboss-xpaas" under name and click "Create" </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-newproject.png" width="500"/></p>

<blockquote> Type in "eap" in the box next to "Browse" and select "jboss-eap64-openshift:1.4" </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-catalog.png" width="500"/></p>

{{< alert warning >}} If you don't enter a unique user name, then we will have conflicting routes between users.{{< /alert >}}

<blockquote> Enter kitchensink-"your user name" under Name For example, if you are user1, please enter "kitchensink-user1" and so on. </blockquote>

<blockquote> Click "Try it" and Git Repository URL should automatically be filled </blockquote>

<blockquote> Click "Create" </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-eapimage.png" width="500"/></p>

<blockquote> Click "Continue to overview" </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-appcreated.png" width="500"/></p>

<blockquote> Click "View Log" </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-appcreatedoverview.png" width="500"/></p>

<blockquote> See the log start with cloning from the GIT repoistory </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-log1.png" width="500"/></p>

<blockquote> The build will be successful once it says "Push Successful" </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-log2.png" width="500"/></p>

<blockquote> Navigate to Applications > Routes </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-navigateroute.png" width="500"/></p>


<blockquote> Click the link under hostname. </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-route.png" width="500"/></p>

<blockquote> This takes you to the JBoss EAP.  Feel free to add your name to the JBoss EAP Application. </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-welcomejboss.png" width="500"/></p>


### Let's Delete the Project
{{< alert warning >}} Please follow these directions to delete your project so we can free up resources for the next lab. {{< /alert >}}

<blockquote> Find your jboss-xpaas project and click the trash can icon </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-navigateproject.png" width="500"/></p>

<blockquote> Enter "jboss-xpaas" and click "delete" </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-deleteroute1.png" width="500"/></p>

<blockquote> Confirm project has been deleted </blockquote>
<p><img title="login to OSE" src="../images/ose-lab-xpaas-deleteconfirm.png" width="500"/></p>
