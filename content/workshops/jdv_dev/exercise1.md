---
title: Exercise 1 - Install JDV and JBDS
workshops: jdv_dev
workshop_weight: 1.1
layout: lab
---

# Table of Contents

* [Download JDV](#link1)
* [Download JBDS](#link2)
* [Install JDV](#link3)
  * [Run JDV](#link4)
* [Install JBDS](#link5)
  * [Run JBDS](#link6)
  * [Install teiid designer](#link7)
  * [Configure server settings](#link8)

# Download [JBoss Data Virtualization](https://developers.redhat.com/products/datavirt/download/) <a name="link1"></a>

* `jboss-dv-6.3.0-1-installer.jar`

<img src="../images/1-download-jdv.png" width="640px">

# Download [JBoss Developer Studio](https://developers.redhat.com/products/devstudio/download/) <a name="link2"></a>

* `devstudio-11.0.0.GA-installer-standalone.jar`

<img src="../images/1-download-jbds.png" width="640px">

# Install JBoss Data Virtualization (JDV) <a name="link3"></a>

* In the location where you downloaded the installer, run the following command

```
java -jar jboss-dv-6.3.0-1-installer.jar
```

* Follow the default prompts with the following exceptions below

<img src="../images/1-jdv-location.png" width="640px">
{{% alert info %}}
Take note of the directory you use to install JDV, it will be helpful when installing JBoss Developer studio.  In the instructions it will be referred to as `$JBOSS_HOME`
{{% /alert %}}


* On the **Create Users** form, enable **Check to use one password for all default passwords**

* Use the following password **Password1!**

* Also check the Add **OData** role

<img src="../images/1-user-password.png" width="640px">

## Run JDV <a name="link4"></a>

* In `$JBOSS_HOME/bin` directory run the following

```
./standalone.sh
```
<img src="../images/1-jdv-run.png" width="640px">

{{% alert info %}}
If you are connecting to this server from machines other than `localhost`.  You need to allow outside connections like this
```
./standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
```
{{% /alert %}}

* Verify your installation by going to http://localhost:9990/console and logging in as `admin/Password1!`

<img src="../images/1-admin.png" width="640px">

* Your server is now up!  Leave it running and proceed to the next steps

# Install JBoss Developer Studio (JBDS) <a name="link5"></a>

* In the location where you downloaded the installer, run the following command 

```
java -jar devstudio-11.0.0.GA-installer-standalone.jar
```

* Follow the default prompts with the following exceptions

* In step 5, **Select Platforms and Servers**, add the location of `$JBOSS_HOME` to the location to scan for runtimes.  Make sure **Scan every start** is unchecked.

<img src="../images/1-jbds-jdv-location.png">

## Run JBDS <a name="link6"></a>
* The path where you installed JBoss Developer Studio will be referred to as `$STUDIO_HOME`

* Launch JBDS with the following command in the `$STUDIO_HOME` directory
```
./devstudio
```

* On startup select ok add the datavirt server install you specified during installation

<img src="../images/1-jbds-runtime.png">

{{% alert info %}}
For Linux and/or Mac users running via the command prompt, if you see the following errors:

```
(Red Hat JBoss Developer Studio:23670): Gtk-WARNING **: Negative content width -5 (allocation 1, extents 3x3) while allocating gadget (node toolbar, owner GtkToolbar)
```

You need a tweak to the launcher to force usage of GTK2 instead of GTK3.  
Either create a wrapper script like this

```
#!/bin/bash
export SWT_GTK3=0

$STUDIO_HOME/./devstudio
```

or edit 
`$STUDIO_HOME/studio/devstudio.ini`
and add

```
--launcher.GTK_version
2
```

at the very beginning of the file
{{% /alert %}}

## Install teiid Designer <a name="link7"></a>


* In the **Red Hat Central** window in the center, click the **Software/Update** tab at the bottom

* Check the box next to **JBoss Data Virtualization Development**

* Click the **Install/Update** button to install the teiid designer

{{% alert %}}
If you do not see **JBoss Data Virtualization Development** listed, check the **Enable Early Access** checkbox in the lower right.  Sometimes the teiid designer release does not sync with the JBDS release.

{{% /alert %}}

<img src="../images/1-teiid-designer.png" width="640px">


* After installation, restart JBDS.  On reboot you will be asked for a **secure storage password**, you can choose something simple like `redhat`

## Configure the server settings <a name="link8"></a>

* Click the **green arrow** in the bottom of the server tab to start the server.  
{{% alert %}}
  It is recommended to start the JDV outside of the designer to keep the server running between designer restarts.  If you start the server outside the designer you will receive a prompt to **Mark the server as started**.  This is fine.
{{% /alert %}}

* Then double-click the server name and go to the **teiid instance** tab

* Click **test the administration connection** and check for **ok**
* Enter the jdbc connection username of **teiidUser** with the password from installation, **Password1!**
* Click **Test the JDBC connection** and check for **ok**  
* Finally, **save** the changes by clicking the disk icon in the upper left or **ctrl+s**

<img src="../images/1-teiid-settings.png" width="640px">
