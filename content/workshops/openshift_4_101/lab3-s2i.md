---
title: Lab 3 - Deploying an App with S2I
workshops: openshift_4_101
workshop_weight: 13
layout: lab
---

# Source to Image (S2I)
One of the useful components of OpenShift is its source-to-image capability.  S2I is a framework that makes it easy to turn your source code into runnable images.  The main advantage of using S2I for building reproducible docker images is the ease of use for developers.  You'll see just how simple it can be in this lab.

## Let's build a node.js web app, using S2I
We can do this either via the command line or the web console.  You decide which you'd rather do and follow the steps below.

{{< panel_group >}}
{{% panel "CLI Steps" %}}
Note: When using the CLI, OpenShift automatically detects the source code type and select the nodejs builder image.<br>

### Terminal access

<pre>
{{< urishortfqdn "https://" "console-openshift-console.apps" "/terminal" >}}
</pre>

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

<pre><code style="color:#FFFFFF">$ oc project demo-{{< span2 userid "YOUR#" >}}
$ oc new-app --name=dc-metro-map https://github.com/RedHatGov/openshift-workshops.git --context-dir=dc-metro-map --as-deployment-config=true
$ oc expose service dc-metro-map
</code></pre>

{{% /panel %}}
{{% panel "Web Console Steps" %}}

### Web Console access

<pre>
{{< urishortfqdn "https://" "console-openshift-console.apps" >}}
</pre>

<blockquote>
Click "Developer" profile", "+Add", and "From Git"
</blockquote>
<img src="../images/ocp-FromGitButton.gif"><br/>

<blockquote>
Fill out the "Git Repo URL" field as follows:
</blockquote>
<p>
<table>
<tr><td><b>Git Repo URL</b></td><td><a href>https://github.com/RedHatGov/openshift-workshops.git</a></td></tr>
</table>

<img src="../images/ocp-git-dc-metro-map.png" width="700"><br/>

<br>Ensure that the repository is validated (as shown above)</br><br>

<blockquote>
Click on the "Show Advanced Git Options" expender
</blockquote>
<img src="../images/ocp-lab-s2i-ago.png" width="200"><br/><br>

<blockquote>
Fill out the "Context Dir" field as follows:
</blockquote>
<p>
<table>
<tr><td><b>Context Dir</b></td><td>/dc-metro-map</td></tr>
</table>


<blockquote>
Under "Builder", click click on the "Node.js" icon
</blockquote>
<img src="../images/ocp-lab-s2i-builder.png" width="600"><br/>

<blockquote>
Select Node.js 
</blockquote>
<img src="../images/ocp-lab-s2i-nodejs.png" width="400"><br/>

<blockquote>
Fill out the fields, under "General" as follows:
</blockquote>
<p>
<table>
<tr><td><b>Application</b></td><td>Create Application</td></tr>
<tr><td><b>Application Name</b></td><td>dc-metro-map</td></tr>
<tr><td><b>Name</b></td><td>dc-metro-map</td></tr>
</table>
</p>

<blockquote>
Choose "Deployment Configuration" 
</blockquote>
<img src="../images/ocp-lab-s2i-nodejs-dc.png" width="400"><br/>

<blockquote>
Scroll to the bottom and click "Create"
</blockquote>

{{% /panel %}}
{{< /panel_group >}}

{{< importPartial "footer/footer.html" >}}
