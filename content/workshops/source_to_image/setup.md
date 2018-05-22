---
title: The Setup
workshops: source_to_image
workshop_weight: 12
layout: lab
---

## Step 1 - Log in to the Web User Interface

The workshop moderator will provide you with the URL, your username, and password.

{{< panel_group >}}
{{% panel "OpenShift WebUI Login" %}}

<img src="../images/webui.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

## Step 2 - Create a Project for Your Wetty Terminal

Create a new project by clicking the "New Project" button in the upper right of the WebUI.

{{< panel_group >}}
{{% panel "Create a Project" %}}

<img src="../images/new_project.png" width="300" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

## Step 3 - Name Your Project

Name your project as follows.

* wetty-user{{< span "userid" "YOUR#">}}

{{< panel_group >}}
{{% panel "Name the Project" %}}

<img src="../images/new_project_name.png" width="300" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

## Step 4 - Add Wetty to the Project

In the *Search Catalog* bar, enter the name of the template to search for, in this case **wetty-persistant**.  

{{< panel_group >}}
{{% panel "Search for the Template" %}}

<img src="../images/template_search.png" width="400" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

Click the template.

## Step 5 - Overview

Click **Next** to procede past the overview.

## Step 6 - Configuration

In the *Configuration* screen ensure the **Add to Project** value is the name of the **wetty-{{USER_NAME}}** project.

Click **Next** to procede past the configuration.

## Step 7 - Results

On the *Results* screen, click **Continue to the project overview**.

## Step 8 - Copy the CLI Login Command

The CLI login command can be copied from the upper right context menu by your user name.

{{< panel_group >}}
{{% panel "OpenShift CLI Login" %}}

<img src="../images/cli_login.png" width="300" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

## Step 9 - Open the Wetty Terminal

On the project overview page, click the URL.

{{< panel_group >}}
{{% panel "Wetty" %}}

<img src="../images/wetty_url.png" width="700" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

## Step 10 - Connect in the Wetty Terminal
When asked - 

Are you sure you want to continue connecting (yes/no)?

Answer **yes**

Enter the Wetty password.  The workshop moderator will provide this to you.

## Step 11 - Connect to OpenShift via the CLI

Paste the command from **Step 8**.

{{< panel_group >}}
{{% panel "OpenShift CLI Login" %}}

<img src="../images/cli_login_for_real.png" width="700" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

## Step 12 - Create a Shared Screen
Creating a shared screen will allow the moderators to assist you better by viewing your terminal session.
```terminal
screen -m -S shared-user{{< span "userid" "YOUR#">}}
```

{{< importPartial "footer/footer.html" >}}