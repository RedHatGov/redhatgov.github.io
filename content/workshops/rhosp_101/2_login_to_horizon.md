---
title: Lab 1 - Login to Horizon
workshops: rhosp_101
workshop_weight: 11
layout: lab
---

# Welcome to Red Hat OpenStack Platform (RHOSP)!
This lab provides a quick tour of the Horizon dashboard to help you get familiar with the user interface.  If you are already familiar with the basics of Horizon simply ensure you can login and have access to your student project.

# Accessing Horizon
RHOSP provides a web dashboard that allows you to perform various tasks via a web browser. Let's get started by logging into Horizon and checking the status of the platform.

In later labs we will explore accomplishing some of the same tasks using the OpenStack CLI.

## Let's Login
> Navigate to the URI provided by your instructor and login with the user/password provided. Ask if not sure

{{% alert info %}}
Remember that you were assigned a number at the beginning of the workshop. At the bottom of each lab page is a form to set your student number. Please do that now if you have not.

Your username, based on the form, is: <b>{{< student "" "" >}}</b>

In the screenshot below, see that this is student1 logging in.
{{% /alert %}}

{{< figure src="../images/lab1-horizon-login-screen.png" title="Lab 1 Figure 1: RHOSP Horizon Login Screen" >}}

> Once logged in you should see your student project overview.

{{< figure src="../images/lab1-horizon-project-overview.png" title="Lab 1 Figure 2: Horizon - Project Overview" >}}

## So this is what an empty project looks like

The first screen you are taken to is the project overview. Here you can see very quickly your project usage measured against the assigned project quotas.

As an example, you can see here that even though this is a brand new project, we are already using 1 of the 10 secruity groups we are allowed.

## Navigation within Horizon

Notice at the top of the screen there are two levels of navigation.

The very top level is for navigating between overall functions like project, identity and (if you have priviledge) admin. If you are a member of multiple projects, there is a project selector in the upper right. Lastly in the top navigation, is your user profile and sign out drop down.

The second level of navigation is for working within the current project. Using this secondary navigation, we can work with compute, storage, network and access resources.

# Summary
You should now be ready to get hands-on with our workshop labs.

{{< importPartial "footer/footer-hattrick.html" >}}
