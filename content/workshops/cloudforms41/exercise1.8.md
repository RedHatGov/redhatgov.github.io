---
title: Exercise 1.8 - Explore Group and User Access Controls
workshops: cloudforms41
workshop_weight: 180
layout: lab
---

# Exercise 1.8 - Explore Group and User Access Controls
## Exercise Description
This exercise is designed to provide an understanding of Red Hat CloudForms group controls and access controls.

## Section 1: Explore Access Control

###  Step 1. Go to **Administrator** (in the top right corner of the screen) → **Configuration** and select the **Access Control** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/access_control-1.png" width="1000"/><br/>
*Configuration Dashboard*

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-dashboard-settings-configuration-2.png" width="1000"/><br/>
*Access Control*

### Step 2. Add a role by modifying a copy of an existing role:

### Step 3. Select **Roles** → **EvmRole-user**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-evmrole-role.png" width="1000"/><br/>
*EvmRole-user Role*

### Step 4. Click <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**), then click <i class="fa fa-files-o fa-lg" aria-hidden="true"></i> (**Copy**).

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-evmrole-role-copy.png" width="1000"/><br/>
*EvmRole-user Copy Role*

### Step 5. Enter the following details.
* For Name, enter **Consumer1-Role**.
* On the right, expand **Services** → **Catalogs Explorer** → **Service Catalogs**.
* Check the **Modify** box and click **Add**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-evmrole-user-role-add.png" width="1000"/><br/>
*EvmRole-user Add Role*

## Section 2: Add a group


### Step 1.  Select **Groups**.

### Step 2.  Click <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**), then click <i class="fa fa-plus-circle fa-lg" aria-hidden="true"></i> (**Add**).

### Step 3.  For **Description**, enter **Consumer1-Group**.

### Step 4.  For **Role**, select **Consumer-Role**.

### Step 5.  For **Project/Tenant**, select **Red Hat**.

### Step 6.  Click **Add**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-add-group.png" width="1000"/><br/>
*Add Group*

## Section 3: Add a user:

### Step 1.  Select Users.

### Step 2.  Click <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**), then click <i class="fa fa-plus-circle fa-lg" aria-hidden="true"></i> (**Add**).

  * Fill out the resulting form with **consumer** as the username and a password of your choosing.

### Step 3.  Select **Consumer-Group** for Group and click Add.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-add-user.png" width="1000"/><br/>
*Add User*

## Section 4: Account Verification
### Step 1. In the top right corner, click **Administrator | EVM** and select Logout.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-logout.png" width="1000"/><br/>
*Logout*

<p>{{% alert info %}} Instead of logging in and out of the **admin** account to do this, you can open a new browser or a "private" or "incognito" window in the same browser. {{% /alert %}}</p>

### Step 2. Log in to CloudForms as the consumer user with the password you set.

### Step 3. Observe that the default dashboard is different from the administrator dashboard.

### Step 4. This dashboard has a different set of widgets and fewer selections in the left bar (**Cloud Intelligence**, **Services**, **Compute**, and **Settings**).

### Step 5. Explore the data provided.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-test-user.png" width="1000"/><br/>
*Customer-Group User*

<p>{{% alert info %}} This data is more specific and targeted to end users. {{% /alert %}}</p>
