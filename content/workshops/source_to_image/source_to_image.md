---
title: Lab - Source-to-Image
workshops: source_to_image
workshop_weight: 15
layout: lab
---

## Step 1 - Go Get S2I Library
```bash
cd ~
```
```terminal
go get github.com/openshift/source-to-image
```
## Step 2 - Build the S2I Tooling
```terminal
cd $GOPATH/src/github.com/openshift/source-to-image
```
```terminal
hack/build-go.sh
```
```terminal
export PATH=$PATH:${GOPATH}/src/github.com/openshift/source-to-image/_output/local/bin/linux/amd64/
```
## Step 3 - Create the S2I Project
```terminal
cd ~
```
```terminal
s2i create golang-s2i golang-s2i
```
Now let's inspect the project directory
```terminal
tree -a golang-s2i
```
## Step 4 - Edit the Dockerfile
```terminal
cd ~
```
```terminal
cat /dev/null > ~/golang-s2i/Dockerfile
```
```terminal
vi ~/golang-s2i/Dockerfile
```
Copy the following text and paste it in to the editor.
```Dockerfile
# golang-s2i
FROM fedora

ENV BUILDER_VERSION 1.0
ENV HOME /opt/app-root
ENV GOPATH $HOME/gopath
ENV PATH $PATH:$GOROOT/bin:$GOBIN

LABEL io.k8s.description="Platform for building go based programs" \
      io.k8s.display-name="gobuilder 0.0.1" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="gobuilder,0.0.1" \
      io.openshift.s2i.scripts-url="image:///usr/local/s2i" \
      io.openshift.s2i.destination="/opt/app-root/destination"

RUN yum clean all && \
    yum install -y tar \
                   git-remote-bzr \
                   golang && \
    yum clean all && rm -rf /var/cache/yum/*

COPY ./s2i/bin/ /usr/local/s2i
RUN useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin -c "Default Application User" default && \
    mkdir -p /opt/app-root/destination/{src,artifacts} && \ 
    chown -R 1001:0 $HOME && \
    chmod -R og+rwx ${HOME}

WORKDIR ${HOME}
USER 1001
EXPOSE 8080
```
To exit vi:

shift+z

shift+z

## Step 5 - Edit the Assemble Script
```terminal
cat /dev/null > ~/golang-s2i/s2i/bin/assemble
```
```terminal
vi ~/golang-s2i/s2i/bin/assemble
```
Copy the following into the editor.
```terminal
#!/bin/bash
#
# S2I assemble script for the 'golang-s2i' image.
export GO_REPO=$(echo $OPENSHIFT_BUILD_SOURCE | sed --expression='s/\.git//g' | sed --expression='s/https:\/\///g')
go get -d $GO_REPO
go build -o goexec $GO_REPO
```
To exit vi:

shift+z

shift+z
## Step 6 - Edit the Run Script
```terminal
cat /dev/null > ~/golang-s2i/s2i/bin/run
```
```terminal
vi ~/golang-s2i/s2i/bin/run
```
Copy the following into the editor.
```terminal
#!/bin/bash
exec /opt/app-root/goexec $ARGS
```
To exit vi:

shift+z

shift+z
## Step 7 - Edit the Save Artifacts Script
```terminal
cat /dev/null > ~/golang-s2i/s2i/bin/save-artifacts
```
```terminal
vi ~/golang-s2i/s2i/bin/save-artifacts
```
Copy the following into the editor.
```terminal
#!/bin/bash

cd $GOPATH
tar cf - pkg bin src
```
To exit vi:

shift+z

shift+z
## Step 8 - Edit the Usage Script
```terminal
cat /dev/null > ~/golang-s2i/s2i/bin/usage
```
```terminal
vi ~/golang-s2i/s2i/bin/usage
```
Create your own script!  Use the following as an example.
```terminal
#!/bin/bash

echo "Hello Golang"
```
To exit vi:

shift+z

shift+z
## Step 9 - Create a new Project Space
In the Wetty terminal, create a new project.
```terminal
oc new-project s2i-$OCP_USER
```
## Step 10 - Create the Golang S2I Builder Image
Create a new build for the Golang S2I builder image
```terminal
oc new-build golang-s2i/ --to=golang-s2i
```
Start the new build for the Golang S2I builder image
```terminal
oc start-build golang-s2i --from-dir=golang-s2i/
```
## Step 11 - Wait for Build to Complete
Take a breath

## Step 12 - Deploy the App from the S2I Builder Image
```terminal
oc new-app https://github.com/kevensen/openshift-gochat-client.git --image-stream=golang-s2i --env ARGS="-host :8080 -chatServer gochat-server-gochat-server.$APP_DOMAIN -templatePath /opt/app-root/gopath/src/github.com/kevensen/openshift-gochat-client/templates -logtostderr -chatServerDomain $APP_DOMAIN"
```

## Step 13 - Expose the App
```terminal
oc expose svc openshift-gochat-client
```

## Step 14 - Sign in to the App
Log in to the app with your OpenShift token.

{{< panel_group >}}
{{% panel "Gochat Signin" %}}

<img src="../images/gochat_signin.png" width="600" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

## Step 15 - Test the App
Send a message!

## Step 16 - Logout
{{< panel_group >}}
{{% panel "Gochat Logout" %}}

<img src="../images/gochat_logout.png" width="600" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}