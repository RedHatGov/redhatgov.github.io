---
title: Fault Injection
workshops: openshift_service_mesh
workshop_weight: 43
layout: lab
---

# Testing Resiliency with Fault Injection

One of the core principles behind microservices development is to not assume that the network is reliable.  More generally, these concepts are codified in [Distributed Computing][1].

But how do you do this in practice?  [Chaos Engineering][2] is the discipline of testing a software's tolerance to failure in production.  In the context of microservices, we do this by injecting failure into a production environment to test service resiliency - how does my service behave when things break down?

Istio provides ways to inject failure into the network to test the resiliency of the service.

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


[1]: https://en.wikipedia.org/wiki/Fallacies_of_distributed_computing
[2]: https://en.wikipedia.org/wiki/Chaos_engineering

{{< importPartial "footer/footer.html" >}}