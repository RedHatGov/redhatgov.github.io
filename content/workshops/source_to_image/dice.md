---
title: Lab - Roll Dice
workshops: source_to_image
workshop_weight: 17
layout: lab
---
In an attempt at nostalgia, we are going to once again create an S2I builder, this time for a Fortran app.  Yes, **Fortran**.  The objective is to make our little chat program a bit more interesting.

## Step 1 - Create the S2I Project
```terminal
cd ~
```
```terminal
s2i create fortran-s2i fortran-s2i
```
## Step 2 - Edit the Dockerfile
```terminal
cd ~
```
```terminal
cat /dev/null > ~/fortran-s2i/Dockerfile
```
```terminal
vi ~/fortran-s2i/Dockerfile
```
Copy the following text and paste it in to the editor.
```Dockerfile
# fortran-s2i
FROM openshift/base-centos7

LABEL maintainer="Kenneth Evensen <kdevensen@gmail.com>"

ENV BUILDER_VERSION 1.0

LABEL io.k8s.description="Platform for building Fortran apps" \
      io.k8s.display-name="builder 1.0.0" \
      io.openshift.tags="fortran"


RUN yum install -y gcc-gfortran && \
    yum clean all && \
    rm -rf /var/cache/yum/*

COPY ./s2i/bin/ /usr/libexec/s2i

RUN chown -R 1001:1001 /opt/app-root

USER 1001

CMD ["/usr/libexec/s2i/usage"]
```
To exit vi:

shift+z

shift+z
## Step 3 - Edit the Assemble Script
```terminal
cat /dev/null > ~/fortran-s2i/s2i/bin/assemble
```
```terminal
vi ~/fortran-s2i/s2i/bin/assemble
```
Copy the following into the editor.
```terminal
#!/bin/bash -e

echo "---> Installing application source..."
cp -Rf /tmp/src/. ./

echo "---> Building application from source..."
gfortran app.f90 -o /opt/app-root/fortran-app
```
To exit vi:

shift+z

shift+z
## Step 4 - Edit the Run Script
```terminal
cat /dev/null > ~/fortran-s2i/s2i/bin/run
```
```terminal
vi ~/fortran-s2i/s2i/bin/run
```
Copy the following into the editor.
```terminal
#!/bin/bash -e
exec /opt/app-root/fortran-app $ARGS
```
To exit vi:

shift+z

shift+z
## Step 5 - Enusre You are Still in the Gochat-s2i Porject
In the Wetty terminal, change to the **gochat-s2i-user{{< span "userid" "YOUR#">}}** project space
```terminal
oc project gochat-s2i-user{{< span "userid" "YOUR#">}}
```
## Step 6 - Create the Fortran S2I Builder Image
Create a new build for the Fortran S2I builder image
```terminal
oc new-build fortran-s2i/ --to=fortran-s2i
```
Start the new build for the Fortran S2I builder image
```terminal
oc start-build fortran-s2i --from-dir=fortran-s2i/
```
## Step 7 - Create the Fortran-Dice Container from Source
```terminal
oc new-build https://github.com/kevensen/fortran-dice.git --image-stream=fortran-s2i --name=dice --allow-missing-imagestream-tags
```
## Step 8 - Roll Some Dice
In the chat window, try:

**//roll**

or

**//roll-dice2-sides6**

{{< importPartial "footer/footer.html" >}}