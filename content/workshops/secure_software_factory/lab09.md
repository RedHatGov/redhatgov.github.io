---
title: Lab 09 - Archive App
workshops: secure_software_factory
workshop_weight: 19
layout: lab
---

# Add Archive Stage

Archiving the built and tested application into a trusted repository is important to making sure you are building with trusted parts.  You assume this application is built properly and all the previous stages have passed.  With that confidence, your built and tested application should be immutable in a trusted repository.  The repository will version or audit any changes to the application, configuration, and dependencies.

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
# Test Your Pipeline
If you'd like to do a test of first pipeline stage, add the following brackets at the end of your Jenkinsfile. Make sure to append to the beginning of the last line.

```
  }
}
```

Save your Jenkinsfile.

Go back to Builds > Pipelines

Click Start Pipeline

# Delete Brackets
Please delete the brackets you just added once testing is complete. We can add them later if you'd like to test your pipeline as you go along.

```
  }
}
```

Click Save
{{< importPartial "footer/footer.html" >}}
