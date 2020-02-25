---
title: Fault Injection
workshops: openshift_service_mesh
workshop_weight: 43
layout: lab
---

# Testing Resiliency with Fault Injection

[Chaos Engineering][1] is the discipline of testing a software's tolerance to failure in production.  For microservices, this means injecting failure into the production environment to test how resilient your services are to errors.

Istio provides ways to inject failure at the application layer with [Delay Faults][2] and [Abort Faults][3] using virtual services.

## Inject Failure

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
for ((i=1;i<=100;i++)); do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

Inspect the change in Kiali.  Navigate to 'Graph' in the left navigation bar. If you lost the URL, you can retrieve it via:
```
echo $KIALI_CONSOLE
```

Switch to the 'Versioned app graph' view.  Change the 'No edge labels' dropdown to 'Requests percentage'

> TODO: Show 50% failed requests in Kiali

Revert the change before ending this lab.

```
oc apply -f ./istio-configuration/virtual-service-userprofile-v3.yaml
```

Congratulations, you configured fault injection with Istio!


[1]: https://en.wikipedia.org/wiki/Chaos_engineering
[2]: https://istio.io/docs/tasks/traffic-management/fault-injection/#injecting-an-http-delay-fault
[3]: https://istio.io/docs/tasks/traffic-management/fault-injection/#injecting-an-http-abort-fault

{{< importPartial "footer/footer.html" >}}