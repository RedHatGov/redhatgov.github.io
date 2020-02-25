---
title: Circuit Breaking
workshops: openshift_service_mesh
workshop_weight: 44
layout: lab
---

# Circuit Breaking Your Services

Fault Injection lets you see how the service mesh behaves when there are failures in network calls to a specific service.  But how do you protect a service if it has overloaded or failing instances serving traffic?  Ideally, you would like to identify an instance that is failing and prevent clients from connecting to it once it meets a certain threshold.

> In OpenShift, an instance is equivalent to a Kubernetes pod running the microservice.

This concept is called Circuit Breaking - you set threshold limits for instances that run a microservice and if the threshold limits are reached, the circuit breaker "trips" and Istio prevents any further connections to that instance.  Circuit breaking is another way to build resilient services in your service mesh.

In Istio, you can define circuit breaking limits using destination rules.

## Define Threshold Limits

Navigate to the workshop directory:
```
cd $HOME/openshift-microservices/deployment/workshop
```

A circuit breaking rule has already been written for you for the user profile service.

View the destination rule in your favorite editor or via bash:
```
cat ./istio-configuration/destinationrule-circuitbreaking.yaml
```

Output (snippet):
```
...
  trafficPolicy:
    tls:
      mode: ISTIO_MUTUAL
    connectionPool:
      http:
        http1MaxPendingRequests: 1
        maxRequestsPerConnection: 1
    outlierDetection:
      consecutiveErrors: 1
      interval: 1s
      baseEjectionTime: 3m
      maxEjectionPercent: 100
...
```

The connection pool settings restrict the maximum number of requests to each instance to 1 (this makes it easier for you to trip the circuit for demo purposes).  The outlier detection settings define the thresholds - an instance that fails once with a 502/503/504 error is ejected from the mesh for 3 minutes.  You can read about the various settings in the Istio [docs][1].

Deploy this circuit breaking rule:
```
oc apply -f ./istio-configuration/destinationrule-circuitbreaking.yaml
```

## Trip the Circuit Breaker

First, scale the user profile service to two instances:
```
oc scale --replicas=2 dc userprofile
```

Apply CPU stress to one instance to force it to return a 503 error.
```
USERPROFILE_POD=$(oc get pod -l app=userprofile -o jsonpath='{.items[0].metadata.name}{"\n"}')
oc exec $USERPROFILE_POD -- apt-get update
oc exec $USERPROFILE_POD -- apt-get install stress
oc exec $USERPROFILE_POD -- stress --cpu 2 --timeout 300s
```

Load test with 20 clients sending 2 concurrent requests to the user profile service:
```
siege -r 20 -c 2 -v $GATEWAY_URL/profile
```



[1]: https://istio.io/docs/reference/config/networking/destination-rule/#OutlierDetection

{{< importPartial "footer/footer.html" >}}