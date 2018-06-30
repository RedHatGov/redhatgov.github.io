---
title: Lab 15 - Deploy Stage
workshops: secure_software_factory
workshop_weight: 25
layout: lab
---
# Add Deploy Stage

Add the Deploy Stage into your pipeline.

<img src="../images/pipeline_deploy_stage.png" width="900" />

If the deployment config for the application already exists in the Stage Project or Environment the deployment config , service, and route are deleted.  This allows for the pipeline to be rerun.

The new-app is recreated in the Stage Environment from the image that you tagged in the previous stage.  The image also has a route created for with the svc.expose command.


<br>
# Append to Jenkins Pipeline Configuration

In Builds > Pipelines > tasks-pipeline > Actions > Edit

<img src="../images/pipeline_actions_edit.png" width="900" />

Append the text below to the bottom of the Jenkins Pipeline Configuration.  Please make sure to append to the beginning of the next line.  


```
    stage('Deploy STAGE') {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject(env.STAGE_PROJECT) {
              if (openshift.selector('dc', 'tasks').exists()) {
                openshift.selector('dc', 'tasks').delete()
                openshift.selector('svc', 'tasks').delete()
                openshift.selector('route', 'tasks').delete()
              }

              openshift.newApp("tasks:${version}").narrow("svc").expose()
            }
          }
        }
      }
    }
  }
}
```      

Congratulations, this should be the final step in your Trusted Software Supply Chain.  Go on to the next lab to verify and run the pipeline.
