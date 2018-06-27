---
title: Lab 09 - Archive App
workshops: trusted_software_supply_chain
workshop_weight: 19
layout: lab
---

# Add Archive Stage

Add Archive Stage Steps into your pipeline.

<img src="../images/pipeline_nexus.png" width="900" />

We leveraged the maven nexus plugin for this deployment.  The mvn deploy step is the last step in the maven lifecycle.  The built application is archived into the nexus repository.  We can see it later once we run the pipeline.

The "-P nexus3" option activates the nexus3 profile defined in the configuration/cicd-settings-nexus3.xml

Append the text below to your text file or into the YAML/JSON field for tasks-pipeline in the OpenShift Console. 

```
                steps {
                  sh "${mvnCmd} deploy -DskipTests=true -P nexus3"
                }
              }
```
