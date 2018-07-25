---
title: Exercise 1.8 - Explore Group and User Access Controls
workshops: cloudforms41
workshop_weight: 180
layout: lab
---

# Explore Access Control

> Go to **Administrator** (in the top right corner of the screen) → **Configuration** and select the **Access Control** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/access_control-1.png" width="1000"/><br/>
*Configuration Dashboard*

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-dashboard-settings-configuration-2.png" width="1000"/><br/>
*Access Control*

Add a role by modifying a copy of an existing role:

> Select **Roles** → **EvmRole-user**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-evmrole-role.png" width="1000"/><br/>
*EvmRole-user Role*

> Click <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**), then click <i class="fa fa-files-o fa-lg" aria-hidden="true"></i> (**Copy**).

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-evmrole-role-copy.png" width="1000"/><br/>
*EvmRole-user Copy Role*

1.  For Name, enter **Consumer1-Role**.
2.  On the right, expand **Services** → **Catalogs Explorer** → **Service Catalogs**.
3.  Check the **Modify** box and click **Add**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-evmrole-user-role-add.png" width="1000"/><br/>
*EvmRole-user Add Role*

Add a group:

1.  Select **Groups**.
2.  Click <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**), then click <i class="fa fa-plus-circle fa-lg" aria-hidden="true"></i> (**Add**).
3.  For **Description**, enter **Consumer1-Group**.
4.  For **Role**, select **Consumer-Role**.
5.  For **Project/Tenant**, select **Red Hat**.
6.  Click **Add**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-add-group.png" width="1000"/><br/>
*Add Group*

Add a user:

1.  Select Users.
2.  Click <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**), then click <i class="fa fa-plus-circle fa-lg" aria-hidden="true"></i> (**Add**).
  * Fill out the resulting form with **consumer** as the username and a password of your choosing.
3.  Select **Consumer-Group** for Group and click Add.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-add-user.png" width="1000"/><br/>
*Add User*

# Account Verification
> In the top right corner, click **Administrator | EVM** and select Logout.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-logout.png" width="1000"/><br/>
*Logout*

<p>{{% alert info %}} Instead of logging in and out of the **admin** account to do this, you can open a new browser or a "private" or "incognito" window in the same browser. {{% /alert %}}</p>

1.  Log in to CloudForms as the consumer user with the password you set.
2.  Observe that the default dashboard is different from the administrator dashboard.
3.  This dashboard has a different set of widgets and fewer selections in the left bar (**Cloud Intelligence**, **Services**, **Compute**, and **Settings**).
4.  Explore the data provided.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-test-user.png" width="1000"/><br/>
*Customer-Group User*

<p>{{% alert info %}} This data is more specific and targeted to end users. {{% /alert %}}</p>
