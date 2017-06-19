---
title: Workshop Content
workshops: example
workshop_weight: 30
layout: lab
---

## Setting Expectations For Your Audience

- Clearly tell your audience what the lab is, what things they will be doing, and what kind of skills are required to be successful at your workshop.

- Examples of expectation setting:
	- 'This is a hands-on workshop.'
	- 'You should be comfortable with the command line.'
	- 'You should be comfortable being a Java developer.'
	- 'You understand classes and how to create them.'
	- 'You can write, understand and create html/jsp/servlets.'


- Teaching someone something about the why you are doing the things in you workshop and possibly some history on why this way is better compared to previous version. 

- Do not replicate official Red Hat training. Workshops are to get the audience more interested in Red Hat products and services. They should leave learning something but not to the point they can go get a certification. 

- The best workshops are the ones that can tell a story.  Addressing or overcome previous technological issues help to show the value of Red Hat products. 

- Every lab should end with a writeup of what was accomplished. 

## Workshop Design: Format

#### Screenshots:

Each lab should include plenty of screen shots and use the built-in image or accordion short codes. All images should be less than `1000px`, and placed in the `images` directory inside your current workshop, for example;

{{< panel_group >}}
{{% panel "OpenShift Dev Deployment" %}}

<img src="../images/lab1_oc_coolstore_dev1.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

Here is a sample of the code that renders the accordion. 

```bash
{{</* panel_group */>}}
{{%/* panel "OpenShift Dev Deployment" */%}}

<img src="../images/lab1_oc_coolstore_dev1.png" width="1000" />

{{%/* /panel */%}}
{{</* /panel_group */>}}
```

#### Numbering:

Number the tasks they should do to accomplish that particular part of the lab. Be consistent in your numbering if you start with something like exercise 1, dont jump to lab 2 or section 2, it will confuse students. Keep a clean and concise numbering scheme that is easy to follow (especially if you get lost). 

Be careful with how much content you put on one page, it can be confusing if there is multiple topics or labs on one page. It is sometimes better to keep it short and concise with one topic or similar exercises on one page. It also helps the students to feel progress as they advance to new pages in the lab. 

##### Asciidoc:

```bash
= Exercise 1.0 - Running Ad-hoc commands

== Section 1: Ad-hoc commands

For our first exercise...

=== Step 0:

Define your inventory...  

=== Step 1:

Let's start with something really basic - pinging a host...
```

##### Markdown:

```bash
# Exercise 1.0 - Running Ad-hoc commands

## Section 1: Ad-hoc commands

For our first exercise...

### Step 0:

Define your inventory...  

### Step 1:

Let's start with something really basic - pinging a host...
```

#### Layout: 

We dont want to bind everyone to a ridged format to the point where people dont want to use this site, but there are some generally agreed upon conventions that we will go over here. Workshops should have at a minimum the following layout in Asciidoc or Markdown. It is recommended to have at least 5 exercises for a four hour workshop. If your workshop is a whole 8 hour day you would need at least 10 exercises. Some students work faster than others so it might also be a good idea to have bonus content so that they stay engaged in the workshop. 
	
- _index.md
- setup.md
- exercise1.0.md
- exercise1.1.md
- exercise1.2.md
- exercise1.3.md 
- exercise1.4.md
- exercise1.5.md
- wrapup.md

## Run This At Home

This is an optional page.  You might use it – for example - to provide your students additional information that is required to get the lab going at home. 

Example, several of the workshop deployment repos have `Vagrant` files in them with bindings to run the Ansible playbook against a local virtualmachine, (currently `RHEL 7.3`, but `Fedora` or `CentOS` could be used).  

```bash
vagrant up

vagrant provision

vagrant ssh
```