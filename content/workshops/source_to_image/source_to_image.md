---
title: Lab - Source-to-Image
workshops: source_to_image
workshop_weight: 15
layout: lab
---
## Step 1 - Create a new Project Space
In the Wetty terminal, create a new project.
```terminal
oc new-project s2i-user{{< span "userid" "YOUR#">}}
```
## Step 2 - Go Get S2I Library
```bash
cd ~
```
```terminal
go get github.com/openshift/source-to-image
```
## Step 3 - Build the S2I Tooling
```terminal
cd $GOPATH/src/github.com/openshift/source-to-image
```
```terminal
hack/build-go.sh
```
```terminal
export PATH=$PATH:${GOPATH}/src/github.com/openshift/source-to-image/_output/local/bin/linux/amd64/
```
## Step 4 - Create the S2I Project
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
## Step 5 - Edit the Dockerfile
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
    yum install -y git-remote-bzr \
                   golang \
		           glide && \
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

## Step 6 - Edit the Assemble Script
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
if [ -z "$GO_REPO" ]; then
  export GO_REPO=$(grep ^package /opt/app-root/destination/src/glide.yaml | sed 's/package: //')
fi

mkdir -p $GOPATH/src/$GO_REPO

# Copy the source
cp -ar /opt/app-root/destination/src/* $GOPATH/src/$GO_REPO
rm -rf /opt/app-root/destination/src/*

# Restore build artifacts
if [ "$(ls /opt/app-root/destination/artifacts/ 2>/dev/null)" ]; then
    echo "Using artifacts from previous build."
    mv /opt/app-root/destination/artifacts/vendor $GOPATH/src/$GO_REPO/vendor
else
    pushd $GOPATH/src/$GO_REPO
    echo "Obtaining artifacts."
    glide install -v
    popd

fi

go build -o goexec $GO_REPO
```
To exit vi:

shift+z

shift+z
## Step 7 - Edit the Run Script
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
## Step 8 - Edit the Save Artifacts Script
```terminal
cat /dev/null > ~/golang-s2i/s2i/bin/save-artifacts
```
```terminal
vi ~/golang-s2i/s2i/bin/save-artifacts
```
Copy the following into the editor.
```terminal
#!/bin/bash

export GO_REPO=$(echo $OPENSHIFT_BUILD_SOURCE | sed --expression='s/\.git//g' | sed --expression='s/https:\/\///g')
if [ -z "$GO_REPO" ]; then
  export GO_REPO=$(grep ^package /opt/app-root/destination/src/glide.yaml | sed 's/package: //')
fi
cd $GOPATH/src/$GO_REPO
tar cf - vendor
```
To exit vi:

shift+z

shift+z
## Step 9 - Edit the Usage Script
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
## Step 10 - Create the Golang S2I Builder Image
Create a new build for the Golang S2I builder image
```terminal
cd ~
```
```terminal
oc new-build golang-s2i/ --to=golang-s2i
```
Start the new build for the Golang S2I builder image
```terminal
oc start-build golang-s2i --from-dir=golang-s2i/
```
## Step 11 - Wait for Build to Complete
Watch the deployment
```terminal
oc logs -f bc/golang-s2i
```

## Step 12 - Deploy the App from the S2I Builder Image
```terminal
oc new-app https://github.com/kevensen/openshift-gochat-client.git --image-stream=golang-s2i --env ARGS="-host :8080 -chatServer gochat-server.gochat-server.svc.cluster.local:8080 -templatePath /opt/app-root/gopath/src/github.com/kevensen/openshift-gochat-client/templates -logtostderr -insecure"
```

## Step 13 - Expose the App
```terminal
oc expose svc openshift-gochat-client
```
## Step 14 - Annotate the Service Account to Use OpenShift Authorization
As in the previous lab, we must annotate the service account for the Gochat Client to communicate to the OpenShift API for user credential verification.
```terminal
oc annotate sa/default serviceaccounts.openshift.io/oauth-redirectreference.1='{"kind":"OAuthRedirectReference","apiVersion":"v1","reference":{"kind":"Route","name":"openshift-gochat-client"}}' --overwrite
```
```terminal
oc annotate sa/default serviceaccounts.openshift.io/oauth-redirecturi.1=auth/callback/openshift --overwrite
```

## Step 15 - Sign in to the App
Click the blue "Login" button.
{{< panel_group >}}
{{% panel "Gochat Signin" %}}

<img src="../images/gochat_signin.png" width="800" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}
Log in to the app with your OpenShift credentials.  The workshop moderator will provide you with the URL, your username, and password.

{{< panel_group >}}
{{% panel "OpenShift WebUI Login" %}}

<img src="../images/webui.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

## Step 16 - Test the App
Send a message!

## Step 17 - Logout
{{< panel_group >}}
{{% panel "Gochat Logout" %}}

<img src="../images/gochat_logout.png" width="600" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

{{< importPartial "footer/footer.html" >}}