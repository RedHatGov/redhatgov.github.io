---
title: 'Lab 2: Environment'
workshops: openshift_install
layout: lab
workshop_weight: 20
---

## Environment

For this workshop, you will have your own environment to use as we go through
the labs.

**Each student will be given a unique student number**, in the format
`studentXX` where `XX` is the student number. If you are assigned a student
number less than 10, your number will be zero padded (e.g. `student03`).

{{% alert warning %}}
**Warning**

If you have **NOT** received a student number, please speak up now! You will
need this student number to participate in this workshop.
{{% /alert %}}

{{< figure src="../images/architecture.png" class="text-center" >}}

The environment for each student will consist of 5 nodes:

- `bastion.studentXX.example.com`
- `master.studentXX.example.com`
- `infra.studentXX.example.com`
- `app01.studentXX.example.com`
- `app02.studentXX.example.com`

**Please refer to the details provided by your instructor for the actual
hostnames in your environment.**

## Required Downloads

### SSH Client

Most of the interaction we will be doing during this workshop will be over
SSH. Therefore, you will need an SSH client to use in order to connect to your
environment.

If you are running **macOS** or a **Linux** distribution, you should already have an
SSH client installed by default.

If you are running **Windows**, by default you do not have an SSH client installed.
We recommend using PuTTY if you do not already have an SSH client installed.
PuTTY can be downloaded from https://www.chiark.greenend.org.uk/~sgtatham/putty/

### Browser

You will also need a browser to access the OpenShift Web Console after we have
successfully installed OpenShift.

It is recommended that you use either **Firefox** or **Chrome**.

## Check Connectivity

Before we move on, let's verify that you are able to SSH into your environment.

{{% alert info %}}
**Information**

The  password for the `ec2-user` is **openshift123** unless otherwise noted by
your instructor.
{{% /alert %}}

{{% alert warning %}}
**Warning**

Don't forget to update `studentXX` and the hostname in the command below.
{{% /alert %}}

The only node that exposed externally to SSH is your **bastion** host. Verify
that you are able to SSH into that node:

{{< highlight bash >}}
ssh ec2-user@bastion.studentXX.example.com
{{< /highlight >}}

Once you are connected to your **bastion** host, you will be able to connect
to the other nodes in your cluster:

{{< highlight bash >}}
for host in master infra app01 app02; do
  ssh ec2-user@${host}.studentXX.example.com 'echo "Connected to $(hostname)!"'
done
{{< /highlight >}}
