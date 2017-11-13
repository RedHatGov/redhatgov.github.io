---
title: Exercise 2 - Prepare the datasources
workshops: jdv_dev
workshop_weight: 1.2
layout: lab
---

# Get the course repositories

* There are two repositories, one that contains a sample JDV project with helper data/scripts and another which is the AngularJS frontend.

* Pull down the JDV project

```
git clone https://github.com/mechevarria/jdv-demo
```

* Next pull down the AngularJS client

```
https://github.com/mechevarria/jdv-demo-client
```

# Add the workshop data to PostgreSQL

* The script that needs to be run is

`jdv-demo/assets/postgres/create_insert.sql`

* If you are running the instance from [TurnKey Linux](https://www.turnkeylinux.org/postgresql), you can load the data via a browser.

{{% alert %}}
When running in a Virtual Machine, I add a second network adapter in addition to the default **NAT** adapter created by VirtualBox or KVM.  The second adapter is **host-only**.  With only **NAT** you cannot connect to your VM as a separate networked device.  The second adapter allows your host machine to talk to your VM without grabbing an additional IP address.  Another option is to change the default **NAT** to **bridged**, but that will not work on restricted networks.
{{% /alert %}}

* In your browser go to the IP address of your PostgreSQL VM.  The address below is the one available by using the host only network created by Docker.

<img src="../images/2-postgres-start.png" width="640px">
<br><br>

* Login to **Adminer** as the **postgres** user

<img src="../images/2-login-postgres.png" width="640px">
<br><br>

* Import into the **public** schema and select `jdv-demo/assets/postgres/create_insert.sql`

<img src="../images/2-import-sql.png" width="640px">
<br><br>

* To verify, check to make sure you have a **order_details** table like below

<img src="../images/2-check-data.png" width="640px">
