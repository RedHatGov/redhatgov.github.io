---
title: Exercise 1.18 - “Hello, World!” Automation Script
workshops: cloudforms41
workshop_weight: 280
layout: lab
---
# Exercise 1.18 - “Hello, World!” Automation Script
## Exercise Description
Let’s jump right in and start writing our first automation script.  In time-honored fashion we’ll write “Hello, World!” to the Automate Engine logfile.

Before we do anything, we need to ensure that the Automation Engine server role is selected on our CloudForms appliance.  We do this from the **Configure** → **Configuration** menu, selecting the CloudForms server in the Settings accordion.

<p>{{% alert info %}} The Automation Engine server role is now enabled by default in CloudForms 4.1, but it’s still worthwhile to check that this role is set on our CloudForms appliance. {{% /alert %}}</p>

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-settings-configure-automation-engine.png" width="1000"/><br/>
*Setting the Automation Engine server role*


## The Automation Engine Role

Setting the Automation Engine role is necessary to be able to run *queued* Automate tasks.  Automate actions initiated directly from the WebUI—such as running instances from Simulation, or processing methods to populate dynamic dialogs—are run on the WebUI appliance itself, regardless of whether it has the Automation Engine role enabled.


## Section 1: Creating the Environment

Before we create our first automation script, we need to put some things in place.  We’ll begin by adding a new domain called *ACME*. We’ll add all of our automation code into this new domain.

### Step 1. Goto **Automate** → **Explorer**, then **<i class="fa fa-cog fa-lg" aria-hidden="true"></i> Configuration** → **<i class="fa fa-plus-circle fa-lg" aria-hidden="true"></i> Add a New Domain**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-domain.png" width="1000"/><br/>
*Adding a new domain*

### Step 2. Name the domain **ACME**, type in the Description **ACME Corp.**, and ensure that the Enabled checkbox is selected.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-domain-acme.png" width="1000"/><br/>
*ACME Domain*


## Section 2: Adding a Namespace

### Step 1. Add a namespace into this domain, called **General**.  Highlight the ACME domain icon in the sidebar, and click **Configuration** → **Add a New Namespace**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-domain-namespace.png" width="1000"/><br/>
*Adding a new namespace*

### Step 2. Give the namespace the name **General** and the description **General Content**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-domain-namespace-general.png" width="1000"/><br/>
*General namespace*


## Section 3:  Adding a Class

### Step 1. Now we’ll add a new class, called *Methods*.

<p>{{% alert info %}} Naming a class Methods may seem somewhat confusing, but many of the generic classes in the ManageIQ and RedHat domains in the Automate Datastore are called Methods to signify their general-purpose nature. {{% /alert %}}</p>

### Step 2. Highlight the General domain icon in the sidebar, and click **Configuration** → **Add a New Class**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-namespace-class.png" width="1000"/><br/>
*Adding a new class*

### Step 3. Give the class the name **Methods** and the description **General Instances and Methods**. We’ll leave the display name empty for this example.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-namespace-class-methods.png" width="1000"/><br/>
*Methods class*


## Section 4: Editing the Schema

### Step 1. Now we’ll create a simple schema. Click the Schema tab for the *Methods* class, and click **Configuration** → **Edit selected Schema**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-schema.png" width="1000"/><br/>
*Editing the schema*

### Step 2. Click New Field, and add a single field with name **execute**, type **Method**, and data type **String**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-schema-field.png" /><br/>
*Adding a new schema field*

### Step 3. Click the checkmark in the lefthand column to save the field entry, and click the **Save** button to save the schema.  We now have our generic class definition called *Methods* set up, with a simple schema that executes a single method.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-schema-field-save.png" width="1000"/><br/>
*Save schema field*


# Hello, World!

### Step 4. Our first Automate method is very simple; we’ll write an entry to the *automation.log* file using this two-line script:

```bash
$evm.log(:info, "Hello, World!")
exit MIQ_OK
```


## Section 5. Adding a New Instance

### Step 1. First we need to create an instance from our class.  In the Instances tab of the new *Methods* class, select **Configuration** → **Add a New Instance**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-instance.png" width="1000"/><br/>
*Adding a new instance to our class*

### Step 2. We’ll call the instance **HelloWorld**, and it’ll run (execute) a method called *hello_world*.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-instance-helloworld.png" /><br/>
*Entering the instance details*

### Step 3. Click the **Add** button.


## Section 6. Adding a New Method

### Step 1. In the Methods tab of the new *Methods* class, select **Configuration** → **Add a New Method**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-method.png" width="1000"/><br/>
*Adding a new method to our class*

### Step 2. Name the method **hello_world**, and paste our two lines of code into the Data window.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-add-new-method-helloworld.png" /><br/>
*Entering the method details*

### Step 3. Click **Validate** and then **Add**.

<p>{{% alert info %}} Get into the habit of using the Validate button; it can save you a lot of time catching Ruby syntactical typos when you develop more complex scripts. {{% /alert %}}</p>


## Section 7:  Running the Instance

### Step 1. We’ll run our new instance using the *Simulation* functionality of Automate. Before we do that, log in to CloudForms again from another browser or a private browsing tab and navigate to **Automate** → **Log**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-log.png" width="1000"/><br/>
*Automate log file*

<p>{{% alert info %}} The CloudForms WebUI uses browser session cookies, so if we want two or more concurrent login sessions (particularly as different users), it helps to use different web browsers or private/incognito windows. {{% /alert %}}</p>

Alternatively, *ssh* into the CloudForms appliance as root and enter:

```bash
tail -f /var/www/miq/vmdb/log/automation.log
```

In the simulation, we actually run an instance called Call_Instance in the */System/Request/* namespace of the *ManageIQ* domain, and this in turn calls our *HelloWorld* instance using the namespace, class, and instance attribute/value pairs that we pass to it.

### Step 2. From the **Automate** → **Simulation** menu, complete the details.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-simulation-helloworld.png" /><br/>
*Completing the Simulation details*

### Step 3. Click **Submit**.

If all went well, we should see our “Hello, World!” message appear in the *automation.log* file:

```
Invoking [inline] method [/ACME/General/Methods/hello_world] with inputs [{}]
<AEMethod [/ACME/General/Methods/hello_world]> Starting
<AEMethod hello_world> Hello, World!
<AEMethod [/ACME/General/Methods/hello_world]> Ending
Method exited with rc=MIQ_OK
```

Or, like so from a private browser session:

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-automate-log-helloworld.png" /><br/>
*"Hello World!" log message*

Success!


## Section 8: Exit Status Codes

In our example we used an exit status code of MIQ_OK.  Although with simple methods such as this we don’t strictly need to specify an exit code, it’s good practice to do so.  When we build more advanced multi-method classes and state machines, an exit code can signal an error condition to the Automation Engine so that action can be taken.

There are four exit codes that we can use:

```
MIQ_OK (0)
  Continues normal processing. This is logged to automation.log as:
  Method exited with rc=MIQ_OK
MIQ_WARN(4)
  Warning message, continues processing. This is logged to automation.log as:
  Method exited with rc=MIQ_WARN
MIQ_ERROR / MIQ_STOP (8)
  Stops processing current object. This is logged to automation.log as:
  Stopping instantiation because [Method exited with rc=MIQ_STOP]
MIQ_ABORT (16)
  Aborts entire automation instantiation. This is logged to automation.log as:
  Aborting instantiation because [Method exited with rc=MIQ_ABORT]
```

<p>{{% alert info %}} The difference between **MIQ_STOP** and **MIQ_ABORT** is subtle but comes into play as we develop more advanced Automate workflows. {{% /alert %}}</p>

**MIQ_STOP** stops the currently running instance, but if this instance was called via a reference from another “parent” instance, the subsequent steps in the parent instance would still complete.

**MIQ_ABORT** stops the currently running instance and any parent instance that called it, thereby terminating the Automate task altogether.


# Summary

In this exercise we’ve seen how simple it is to create our own domain, namespace, class, instance, and method, and run our script from Simulation.  These are the fundamental techniques that we use for all of automation scripts!
