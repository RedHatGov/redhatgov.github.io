---
title: Lab - Building and Deploying a Fast-Moving Monolith
workshops: strangling_the_monolith
workshop_weight: 40
layout: lab
---



# FAST-MOVING MONOLITH
- Large organizations have a tremendous amount of resources invested in existing monolith applications
- Looking for a sane way to capture the benefits of containers and orchestration without having to complete rewrite
- OpenShift provides the platform for their existing investment with the benefit of a path forward for microservice based apps in the future


# FAST-MOVING MONOLITH ADVANTAGES
- Easier to develop since all dependencies are included
- Single code base for teams to work on
- No API backwards compatibility issues since all logic is packaged with the application
- Single deployable unit


# Step 1
- In this lab, the coolstore monolith will be built and deployed to OpenShift from your local workstation demonstrating a typical Java application developer workflow
- A sample pipeline is included which will be used to deploy across dev and prod environment

> First, deploy the coolstore monolith dev project (don’t forget to include -b app-partner when you run git clone - this is the branch in use for this lab!):


```bash
$ mkdir ~/coolstore
```

```bash
$ cd ~/coolstore
```

```bash
$ git clone -b app-partner https://github.com/epe105/monolith
```

```bash
$ cd monolith
```
{{% alert info %}}

Please update ``<USERNAME>`` below with your assigned username

{{% /alert %}}


```bash
$ oc new-project coolstore-<USERNAME>
```

```bash
$ oc process -f src/main/openshift/template.json | oc create -f -
```


# Step 2
> Notice there is no deployment yet as there is no build yet:

{{< panel_group >}}
{{% panel "OpenShift Dev Deployment" %}}

<img src="../img/lab1_oc_coolstore_dev1.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

# Step 3
  - A number of OpenShift objects were created:
  - A Postgres database deployment, service, and route
  - A coolstore binary BuildConfig
    - Binary builds accept source code through stdin in later commands (vs. kicking off a build within an OpenShift pod)
  - Services, Routes and DeploymentConfig for coolstore-dev
  - Service Accounts and Secrets (for cluster permissions)  

> Build the coolstore monolith (.war file) locally and deploy into the OpenShift via the binary build:

```bash
$ cd ~/coolstore/monolith
```

```bash
$ mvn clean package -Popenshift
```

```bash
$ oc start-build coolstore --from-file deployments/ROOT.war --follow
```

# Step 4
- Binary builds still produce Linux container images and are stored into the container registry.

> In the web console, navigate to Builds → Images to see the new image created as a result of combining the monolith .war file with the JBoss EAP builder image

{{< panel_group >}}
{{% panel "OpenShift Cool Store Build" %}}

<img src="../img/lab1_oc_build_coolstore1.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

# Step 5
> Once the deployment is complete, navigate to the application by clicking on its route in the OpenShift web console Overview and exercise the app by adding/removing products to your shopping cart:

{{< panel_group >}}
{{% panel "Cool Store UI" %}}

<img src="../img/lab1_oc_coolstore_gui1.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

# Step 6

- The app contains an AngularJS web frontend which makes REST calls to its backend (e.g. /services/products)
- The app’s backend contains services implement as Stateless and Stateful EJBs backed by JPA entities
- The product catalog and inventory are stored together in the database.

> Log into the database pod (with postgresql in the pod name) and inspect the values stored (you will need to copy/paste the password from the POSTGRESQL_PASSWORD environment variable when running the psql command):

> Make note of POSTGRESQL_PASSWORD

```bash
$ oc env dc/coolstore-dev-postgresql --list       # copy value of POSTGRESQL_PASSWORD to clipboard
```
> Make note of postgresql pod

```bash
$ oc get pods
```
> oc rsh into postresql pod

```bash
$ oc rsh coolstore-dev-postgresql-1-3rfuw
sh-4.2$ psql -h $HOSTNAME -d $POSTGRESQL_DATABASE -U $POSTGRESQL_USER
Password for user userV31:XXXXXXXX
psql (9.5.4)
Type "help" for help.

monolith=> select * from INVENTORY;
monolith=> select * from PRODUCT_CATALOG;

```


> Exit out of psql and then the postgresql pod

```bash
monolith=> \q
sh-4.2$ exit
exit
```

    
# Step 7

- The coolstore-dev build and deployment is responsible for building new versions of the app after code changes and deploying them to the development environment.
- Production environments will ideally use different projects, and even different nodes in an OpenShift cluster. For simplicity we have dev and prod in the same project.

> Create the production deployment objects that will be used to promote builds from dev to prod using the supplied CI/CD pipeline:

```bash
$ oc process -f ~/coolstore/monolith/src/main/openshift/template-prod.json | oc create -f -
```

# Step 8
- Several types of OpenShift objects are created:
  - A production Postgres database deployment, service, and route
  - Services, Routes and DeploymentConfig for coolstore-prod (production env)
  - Service Accounts and Secrets (for cluster permissions)
  - A CI/CD server (Jenkins)
  - A CI/CD pipeline
- Notice that no deployment occurs for the production version of the app.
- Deployment of the production app occurs as a result of images from the dev environment being appropriately tagged.

>Inspect the pipeline and observe the steps it executes during the pipeline run. Notice at the end of the script, the latest coolstore image is tagged with :prod, triggering a production deployment:

```bash
$ oc get bc/monolith-pipeline -o yaml
...
          openshiftTag(sourceStream: 'coolstore', sourceTag: 'latest', namespace: '', destinationStream: 'coolstore', destinationTag: 'prod', destinationNamespace: '')
...

```

# Step 9

>Wait for the jenkins service to be completely available, then execute the pipeline by navigating to Builds→ Pipelines and click on Start Pipeline next to the Monolith Pipeline:

{{< panel_group >}}
{{% panel "Monolith Pipeline" %}}

<img src="../img/lab1_oc_pipeline_coolstore1.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

# Step 10
- Observe the pipeline as it executes its stages
- Once the pipeline is complete, the production app is deployed.
- Typically there would be a human approval step before going live
- Pipelines are also good at executing advanced deployment strategies (blue/green, canary)

> Return to the Overview page, wait for the deployment to complete, then click on the route for the coolstore-prod deployment to test the production app (identical to coolstore-dev).

{{< panel_group >}}
{{% panel "Pipelines" %}}

<img src="../img/lab1_oc_pipeline_coolstore2.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

# Step 11

> You should now have two identical copies of the app deployed, along with two databases:

{{< panel_group >}}
{{% panel "OpenShift Dev and Prod Container Deployment" %}}

<img src="../img/lab1_oc__coolstore_prod1.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

# Step 12
> Scale down the coolstore-dev environment by clicking the down arrow next to the coolstore-dev and coolstore-dev-postgresql pods:

{{< panel_group >}}
{{% panel "Scale Down Dev Containers" %}}

<img src="../img/lab1_oc_dev_containers1.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

{{% alert info %}}

If your build pipeline fails to start, you can manually tag the images:

```bash
$ oc tag coolstore:latest coolstore:prod
```

{{% /alert %}}
