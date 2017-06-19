---
title: Lab 6 - Managing Instances
workshops: rhosp_101
workshop_weight: 16
layout: lab
---

# Now We are Ready to Launch an OpenStack Instance

## First, What is an Instance?

Instances are virtual machines that run inside the OpenStack cloud. You can launch an instance from the following sources:

- Images uploaded to the Image service  
- Image that you have copied to a persistent volume. The instance launches from the volume, which is provided by the cinder-volume API through iSCSI  
- Instance snapshot that you took

# Let's Go Launch a New Instance

> Navigate to Compute -> Instances using the second level navigation tabs  

{{< figure src="../images/lab6-instances-1.png" title="Lab 6 Figure 1: Project Instance Listing" >}}

> Click **Launch Instance** on the right hand side of the screen  
> Enter **studentX-instance** for **Name**  
> Leave **Availability** set to **nova**  
> Enter **2** for **Count**  
> Click **Next**

{{< figure src="../images/lab6-instances-2.png" title="Lab 6 Figure 2: Details for New Instance" >}}

> Leave **Select Boot Source** set to **Image**  
> Click **No** for **Create New Volume**    
> Click the **Up** arrow to the right of **studentX-cirros** to move that image up to the **Allocated** section    
> Click **Next**

{{< figure src="../images/lab6-instances-3.png" title="Lab 6 Figure 3: Source for New Instance" >}}

> Click the **Up** arrow to the right of **m1.tiny** to move that flavor up to the **Allocated** section    
> Click **Next**

{{< figure src="../images/lab6-instances-4.png" title="Lab 6 Figure 4: Flavor for New Instance" >}}

> Click the **Up** arrow to the right of **private-a** to move that network up to the **Allocated** section    
> Click **Next** until you get to Security Groups

{{< figure src="../images/lab6-instances-5.png" title="Lab 6 Figure 5: Networks for New Instance" >}}

> Enter **studentX-instance** for **Name**  
> Leave **Availability** set to **nova**  
> Enter **2** for **Count**  
> Click **Next**

{{< figure src="../images/lab6-instances-6.png" title="Lab 6 Figure 6: Security Groups for New Instance" >}}

> Enter **studentX-instance** for **Name**  
> Leave **Availability** set to **nova**  
> Enter **2** for **Count**  
> Click **Next**

{{< figure src="../images/lab6-instances-7.png" title="Lab 6 Figure 7: Key Pair for New Instance" >}}

> Enter **studentX-instance** for **Name**  
> Leave **Availability** set to **nova**  
> Enter **2** for **Count**  
> Click **Next**

{{< figure src="../images/lab6-instances-8.png" title="Lab 6 Figure 8: Key Pair Created and Launching New Instance" >}}

> Leave **Architecture** empty  
> Enter **1** for Minimum Disk (GB)  
> Enter **512** for Minimum RAM (MB)
> Click **Private** under **Visibility** (this image will only be available to your project)
> Leave **Protected** set to **No**  
> Click **Create Image**

{{% alert info %}}
You will first see the image file get uploaded via a progress bar on the create image dialog

Then the image will begin processing to get uploaded to glance
{{% /alert %}}

{{< figure src="../images/lab5-images-3.png" title="Lab 5 Figure 3: Details Continued for New cirros Image" >}}

{{% alert success %}}
You should see a green box appear in the upper right corner of the screen that says "Success: 2 instances launched."

If you did not, let the intstructor know now
{{% /alert %}}

{{< figure src="../images/lab6-instances-9.png" title="Lab 6 Figure 9: New Instances Created and Active in Project" >}}

# Summary

We have now learned how to upload images to our project. We can now use these images in our project as a basis for launching instances.

Building images is beyond the scope of this workshop. There are many resources on this topic both officially from Red Hat and from OpenStack.org

In our next lab, we will start working with instances.
