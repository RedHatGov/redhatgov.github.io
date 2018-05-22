---
title: Lab - Gochat S2I
workshops: source_to_image
workshop_weight: 16
layout: lab
---

## Step 1 - Create a New Project Space
In the Wetty terminal, create a new project.
```terminal
oc new-project gochat-s2i-user{{< span "userid" "YOUR#">}}
```
## Step 2 - Create the Golang S2I Builder Image
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
## Step 3 - Import YAML Template in to OpenShift
In the OpenShift WebUI, on the catalog page, seclect Import YAML/JSON
{{< panel_group >}}
{{% panel "Import YAML/JSON" %}}

<img src="../images/import_yaml_json.png" width="600" />

{{% /panel %}}
{{< /panel_group >}}

## Step 4 - Configure the Import
Select the project to which you want to import the template

*gochat-s2i-user{{< span "userid" "YOUR#">}}*

Copy and paste the following YAML in to the text box.
{{< panel_group >}}
{{% panel "Golang Template" %}}
```yaml
apiVersion: v1
kind: Template
labels:
  template: golang
metadata:
  annotations:
    description: A basic builder for Golang applications
    iconClass: icon-go-gopher
    openshift.io/display-name: Golang
    openshift.io/long-description: This template defines resources needed to develop
      a Golang application, including a build configuration, application deployment
      configuration, and database deployment configuration.
    openshift.io/provider-display-name: Community
    template.openshift.io/bindable: "false"
    tags: golang
  creationTimestamp: null
  name: golang
objects:
- apiVersion: v1
  kind: ImageStream
  metadata:
    annotations:
      description: Keeps track of changes in the application image
    name: ${APPLICATION_NAME}
- apiVersion: v1
  kind: BuildConfig
  metadata:
    annotations:
      description: Defines how to build the application
    name: ${APPLICATION_NAME}
  spec:
    output:
      to:
        kind: ImageStreamTag
        name: ${APPLICATION_NAME}:latest
    source:
      contextDir: ${APP_CONTEXT_DIR}
      git:
        ref: ${APP_SOURCE_REPOSITORY_REF}
        uri: ${APP_SOURCE_REPOSITORY_URL}
      type: Git
    strategy:
      sourceStrategy:
        from:
          kind: ImageStreamTag
          name: golang-s2i:latest
      type: Source
    triggers:
    - type: ImageChange
    - type: ConfigChange
    - github:
        secret: ${APP_GITHUB_WEBHOOK_SECRET}
      type: GitHub
- apiVersion: v1
  kind: DeploymentConfig
  metadata:
    annotations:
      description: Defines how to deploy the application server
    name: ${APPLICATION_NAME}
  spec:
    replicas: 1
    selector:
      name: ${APPLICATION_NAME}
    strategy:
      type: Rolling
    template:
      metadata:
        labels:
          name: ${APPLICATION_NAME}
        name: ${APPLICATION_NAME}
      spec:
        containers:
        - env:
          - name: ARGS
            value: ${APP_ARGS}
          image: ${APPLICATION_NAME}
          name: ${APPLICATION_NAME}
          ports:
          - containerPort: 8080
    triggers:
    - imageChangeParams:
        automatic: true
        containerNames:
        - ${APPLICATION_NAME}
        from:
          kind: ImageStreamTag
          name: ${APPLICATION_NAME}:latest
      type: ImageChange
    - type: ConfigChange
- apiVersion: v1
  kind: Service
  metadata:
    annotations:
      description: Exposes and load balances the application pods
    name: ${APPLICATION_NAME}
  spec:
    ports:
    - name: web
      port: 8080
      targetPort: 8080
    selector:
      name: ${APPLICATION_NAME}
- apiVersion: v1
  id: ${APPLICATION_NAME}
  kind: Route
  metadata:
    annotations:
      description: Route for application's http service.
    labels:
      application: ${APPLICATION_NAME}
    name: ${APPLICATION_NAME}
  spec:
    host: ${APPLICATION_DOMAIN}
    to:
      name: ${APPLICATION_NAME}
parameters:
- description: The URL of the repository with your Golang application code
  name: APP_SOURCE_REPOSITORY_URL
  displayName: Application Source URL
- description: Set this to a branch name, tag or other ref of your repository if you
    are not using the default branch
  name: APP_SOURCE_REPOSITORY_REF
  displayName: Application Source Branch
- description: Set this to the relative path to your project if it is not in the root
    of your repository
  name: APP_CONTEXT_DIR
  displayName: Application Source Directory
- description: A secret string used to configure the GitHub webhook for the app repo
  from: '[a-zA-Z0-9]{40}'
  generate: expression
  name: APP_GITHUB_WEBHOOK_SECRET
  displayName: Application GitHub Web Hook Secret
- description: The name for the application.
  name: APPLICATION_NAME
  required: true
  value: golang-app
  displayName: Application Name
- description: 'Custom hostname for service routes.  Leave blank for default hostname,
    e.g.: <application-name>.<project>.<default-domain-suffix>'
  name: APPLICATION_DOMAIN
  displayName: Application Domain
- description: Command line arguments to provide to the Golang application
  name: APP_ARGS
  displayName: Application Command Line Arguments
```
{{% /panel %}}
{{< /panel_group >}}
## Step 5 - Create the Import
Ensure your configuration looks similar to the following.  If so, click **Create**.

{{< panel_group >}}
{{% panel "Configure Import YAML/JSON" %}}

<img src="../images/import_config.png" width="700" />

{{% /panel %}}
{{< /panel_group >}}

## Step 6 - Add the Template
Uncheck **Process the template**

Check **Save template**

{{< panel_group >}}
{{% panel "Add Template" %}}

<img src="../images/add_template.png" width="400" />

{{% /panel %}}
{{< /panel_group >}}

Click **Add**.

On the next screen click **Close**.

## Step 7 - Select the Template
From the Catalog page, click **Select from Project**.
{{< panel_group >}}
{{% panel "Select Template" %}}

<img src="../images/select_from_project.png" width="600" />

{{% /panel %}}
{{< /panel_group >}}

## Step 8 - Really Select the Template 
On the next screen, choose your **gochat-s2i-{{USERNAME}}** project, then the **golang-s2i** template.
{{< panel_group >}}
{{% panel "Really Select Template" %}}

<img src="../images/golang_template.png" width="600" />

{{% /panel %}}
{{< /panel_group >}}

## Step 9 - Configure the Deployment
Click **Next** to get to the *Information* screen.

Click **Next** again to get to the *Configuration* screen.

In the **Add to Project** field, select your **gochat-s2i-user{{< span "userid" "YOUR#">}}** project.

In the **Application Source URL** field, enter https://github.com/kevensen/openshift-gochat-client.git

In the **Application Name** field, enter **gochat-client**

In the **Application Command Line Arguments** field, enter the following:
```terminal
-host :8080 -chatServer gochat-server.gochat-server.svc.cluster.local:8080 -templatePath /opt/app-root/gopath/src/github.com/kevensen/openshift-gochat-client/templates -logtostderr -insecure
```  
Click **Create**
## Step 10 - Annotate the Service Account to Use OpenShift Authorization
As in the previous lab, we must annotate the service account for the Gochat Client to communicate to the OpenShift API for user credential verification.
```terminal
oc annotate sa/default serviceaccounts.openshift.io/oauth-redirectreference.1='{"kind":"OAuthRedirectReference","apiVersion":"v1","reference":{"kind":"Route","name":"gochat-client"}}' --overwrite
```
```terminal
oc annotate sa/default serviceaccounts.openshift.io/oauth-redirecturi.1=auth/callback/openshift --overwrite
```

## Step 11 - Sign in to the App
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

## Step 12 - Test the App
Send a message and chat with friends!

## Step 13 - Logout
{{< panel_group >}}
{{% panel "Gochat Logout" %}}

<img src="../images/gochat_logout.png" width="600" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

{{< importPartial "footer/footer.html" >}}