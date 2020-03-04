---
title: Grafana
workshops: openshift_service_mesh
workshop_weight: 32
layout: lab
---

# Service Mesh Metrics with Grafana

Grafana[1] is a monitoring tool that can be integrated with Istio for metric observation.  Using Grafana, you can look at metrics associated with your services in your mesh. 

## Explore Grafana

Send load to the application user interface:
```
for ((i=1;i<=100;i++)); do curl -s -o /dev/null $GATEWAY_URL; done
```

Send load to the user profile service:
```
for ((i=1;i<=5;i++)); do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

KIALI_CONSOLE=https://$(oc get routes kiali -n istio-system -o jsonpath='{.spec.host}{"\n"}')
echo $KIALI_CONSOLE


<img src="../images/grafana-welcome.png" width="600"><br/>
*Grafana Welcome*




[1]: https://grafana.com

{{< importPartial "footer/footer.html" >}}