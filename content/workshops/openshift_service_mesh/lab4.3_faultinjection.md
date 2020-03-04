---
title: Fault Injection
workshops: openshift_service_mesh
workshop_weight: 43
layout: lab
---

# Testing Resiliency with Fault Injection

[Chaos Engineering][1] is the discipline of testing a software's tolerance to failure in production.  For microservices, this means injecting failure into the production environment to test how resilient your services are to errors.

Istio provides ways to inject failure at the application layer with [Delay Faults][2] and [Abort Faults][3] using virtual services.

## Abort Faults

Navigate to the workshop directory:
```
cd $HOME/openshift-microservices/deployment/workshop
```

View the virtual service in your favorite editor or via bash:
```
cat ./istio-configuration/virtual-service-userprofile-503.yaml
```

Output (snippet):
```
...
  http:
  - fault:
      abort:
        httpStatus: 503
        percent: 50
    route:
    - destination:
        host: userprofile
        subset: v3
...
```

This configurtion tells Istio to inject 503 errors into 50% of the traffic sent to the user profile service.

Deploy the routing rule:
```
oc apply -f ./istio-configuration/virtual-service-userprofile-503.yaml
```

Send load to the user profile service:
```
while true; do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

Inspect the change in Kiali.  Navigate to 'Graph' in the left navigation bar. If you lost the URL, you can retrieve it via:
```
echo $KIALI_CONSOLE
```

Switch to the 'Versioned app graph' view and change to 'Last 1m'.  Change the 'No edge labels' dropdown to 'Requests percentage'

Click on the connection between  the 'app-ui' (square) and 'userprofile' service (triangle).  On the right, you should see roughly 50% of requests returned as HTTP errors.

<img src="../images/kiali-userprofile-503.png" width="600"><br/>
*Kiali Graph with abort faults*

Let's test the application in the browser.

Navigate to the 'Profile' section in the header.  If you lost the URL, you can retrieve it via:
```
echo $GATEWAY_URL
```

Refresh the brower a couple of times.  Sometimes you will see the profile page show up; other times, you will see 'Unknown User'.

Injecting an abort fault is a great mechanism to test how your application handles failure.  In more complex service meshes, you can use this to prevent cascading failures in which an erroring service causes a chain of other services to fail.

## Delay Faults

Version 2 of the user profile service had a performance issue.  You can synthetically simulate this scenario with delay faults in Istio.

View the virtual service in your favorite editor or via bash:
```
cat ./istio-configuration/virtual-service-userprofile-delay.yaml
```

Output (snippet):
```
...
  http:
  - fault:
      delay:
        fixedDelay: 5s
        percent: 50
    route:
    - destination:
        host: userprofile
        subset: v3
...
```

This configurtion tells Istio to inject a 5 second delay into 50% of the traffic sent to the user profile service.

Deploy the routing rule:
```
oc apply -f ./istio-configuration/virtual-service-userprofile-delay.yaml
```

Send load to the user profile service:
```
while true; do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

Inspect the change in Jaeger.  If you lost the URL, you can retrieve it via:
```
echo $JAEGER_CONSOLE
```

Inspect the traces.  On the left bar under 'Search', select 'app-ui.microservies-demo' for 'Service' and 'userprofile-microservices-demo.svc.cluster.local'for 'Operation'.  Select 'Find Traces' and Jaeger should reload with traces to the user profile service.

<img src="../images/jaeger-userprofile-traces-delay.png" width="600"><br/>
*Traces to User Profile Service with Fault Delays*

Notice some the traces are about 5s in duration while others are in the millisecond range.

Injecting a delay fault is a great mechanism to test how your application handles slow outbound service calls.

## Clean up
Revert the changes you made before ending this lab.
```
oc apply -f ./istio-configuration/virtual-service-userprofile-v3.yaml
```

Congratulations, you configured fault injection with Istio!


[1]: https://en.wikipedia.org/wiki/Chaos_engineering
[2]: https://istio.io/docs/tasks/traffic-management/fault-injection/#injecting-an-http-delay-fault
[3]: https://istio.io/docs/tasks/traffic-management/fault-injection/#injecting-an-http-abort-fault

{{< importPartial "footer/footer.html" >}}