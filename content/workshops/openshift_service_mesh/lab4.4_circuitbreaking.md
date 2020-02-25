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

The circuit breaking rule is only applied to v3 of the user profile service.  The connection pool settings restrict the maximum number of requests to each instance to 1 (this makes it easier for you to trip the circuit for demo purposes).  The outlier detection settings define the thresholds - an instance that fails once with a 502/503/504 error is ejected from the mesh for 3 minutes.  You can read about the various settings in the Istio [docs][1].

Deploy this circuit breaking rule:
```
oc apply -f ./istio-configuration/destinationrule-circuitbreaking.yaml
```

## Trip the Circuit Breaker

First, route traffic evenly between v1 and v3 of the user profile service.
```
oc apply -f ./istio-configuration/virtual-service-userprofile-50-50.yaml
```

Apply CPU stress to v3 to force it to return a 503 error.
```
USERPROFILE_POD=$(oc get pod -l app=userprofile,version=3.0)
oc exec $USERPROFILE_POD -- apt-get update
oc exec $USERPROFILE_POD -- apt-get install stress
oc exec $USERPROFILE_POD -- stress --cpu 2 --timeout 300s
```

Send load to the user profile service:
```
for ((i=1;i<=100;i++)); do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

Inspect the change in Kiali.  Navigate to 'Graph' in the left navigation bar. If you lost the URL, you can retrieve it via:
```
echo $KIALI_CONSOLE
```

Switch to the 'Versioned app graph' view.  Change the 'No edge labels' dropdown to 'Requests percentage'.  

*Show circuit breaking in Kiali*

You should see a small percentage of traffic directed to v3.  The lightning icon indicates a circuit breaking rule, and the circuit breaker was tripped so most traffic was routed to v1.

Congratulations, you configured circuit breaking in Istio!

[1]: https://istio.io/docs/reference/config/networking/destination-rule/#OutlierDetection

{{< importPartial "footer/footer.html" >}}