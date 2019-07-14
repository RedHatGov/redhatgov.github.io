---
title: Lab 5 - Managing Images
workshops: rhosp_101
workshop_weight: 15
layout: lab
---

# Where Shall We Store Our Golden Images?

## Glance

The Image service (glance) project provides a service where users can upload and discover data assets that are meant to be used with other services. This currently includes images and metadata definitions.

Glance image services include discovering, registering, and retrieving virtual machine (VM) images. Glance has a RESTful API that allows querying of VM image metadata as well as retrieval of the actual image.

VM images made available through Glance can be stored in a variety of locations from simple filesystems to object-storage systems like the OpenStack Swift project.

# Let's Go Upload a New Image to Glance

> Navigate to Compute -> Images using the second level navigation tabs  

{{< figure src="../images/lab5-images-1.png" title="Lab 5 Figure 1: Project Image Listing" >}}

{{% alert info %}}
To complete this lab, you need to download a Cirros cloud test image from the link below. Save it to a good location locally to be used later in the lab.

http://192.168.0.8/images/cirros.img
{{% /alert %}}

> Click **Create Image** on the right hand side of the screen  
> Enter **{{< student "" "-cirros" >}}** for **Name**  
> Enter **Cirros Cloud Image (cirros/gocubsgo)** for **Image Description**  
> Click **Browse...** under **File** and select the Cirros image you downloaded for this lab  
> Select **Raw** for **Format**  
> Leave **Kernel** and **Ramdisk** alone. No need to select them for this lab  
> Leave **Architecture** empty  
> Enter **1** for Minimum Disk (GB)  
> Enter **64** for Minimum RAM (MB)  
> Leave **Protected** set to **No**  
> Click **Create Image**

{{< figure src="../images/lab5-images-2.png" title="Lab 5 Figure 2: Details for New cirros Image" >}}

{{% alert info %}}
Then the image will begin processing for uploading to glance.

You will see the **Create Image** button get disabled, but there is no progress bar for the file upload. Please be patient and wait until you see the dialog disappear and a success message appear in the upper right.
{{% /alert %}}

{{% alert success %}}
After a little bit, You should see a green box appear in the upper right corner of the screen that says something similar to "Success: Image {{< student "" "-cirros" >}} was successfully created."

If you did not, let the intstructor know now
{{% /alert %}}

{{< figure src="../images/lab5-images-3.png" title="Lab 5 Figure 4: New Image Uploaded to Glance and Available to Project" >}}

{{% alert info %}}
Note that the image list may be stuck with "saving" status. If you reload the page, you should see it with "Active" status.
{{% /alert %}}

# Summary

We have now learned how to upload images to our project. We can now use these images in our project as a basis for launching instances.

Building images is beyond the scope of this workshop. There are many resources on this topic both officially from Red Hat and from OpenStack.org

OpenStack Foundation does maintain a list of ready cloud images at https://docs.openstack.org/image-guide/obtain-images.html

In our next lab, we will start working with instances.

{{< importPartial "footer/footer-hattrick.html" >}}
