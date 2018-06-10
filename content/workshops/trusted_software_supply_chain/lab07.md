---
title: Lab 07 - Archive App
workshops: trusted_software_supply_chain
workshop_weight: 17
layout: lab
---

# Add Archive Stage

Add Archive Stage into Pipeline Text File

As previously mentioned, mvn deploy is the last step in the maven lifecycle.  The built application is archived into the nexus repository.  We can see it later once we run the pipeline.

```
                steps {
                  sh "${mvnCmd} deploy -DskipTests=true -P nexus3"
                }
              }
```
