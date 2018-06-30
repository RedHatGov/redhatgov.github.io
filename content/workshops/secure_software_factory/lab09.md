---
title: Lab 09 - Archive App
workshops: secure_software_factory
workshop_weight: 19
layout: lab
---

# Add Archive Stage

Add Archive Stage Steps into your pipeline.

<img src="../images/pipeline_nexus.png" width="900" />

We leveraged the maven nexus plugin for this deployment.  The mvn deploy step is the last step in the maven lifecycle.  The built application is archived into the nexus repository.  We can see it later once we run the pipeline.

The "-P nexus3" option activates the nexus3 profile defined in the configuration/cicd-settings-nexus3.xml

<br>
# Append to Jenkins Pipeline Configuration

In Builds > Pipelines > tasks-pipeline > Actions > Edit

<img src="../images/pipeline_actions_edit.png" width="900" />

Append the text below to the bottom of the Jenkins Pipeline Configuration.  Please make sure to append to the beginning of the next line.  

```
    stage('Archive App') {
      steps {
        sh "${mvnCmd} deploy -DskipTests=true -P nexus3"
      }
    }
```
