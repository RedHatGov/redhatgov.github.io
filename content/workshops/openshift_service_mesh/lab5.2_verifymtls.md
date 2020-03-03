---
title: Verifying mTLS
workshops: openshift_service_mesh
workshop_weight: 52
layout: lab
---

# Checking and Verification of mTLS
OK, now that all our services are encrypting traffic Let's take a look in Kiali to see our encryption setup.


TODO KIALI STEPS


## More About mTLS Options
mTLS in the service mesh isn't just an ON/OFF capability. We kept it basic for the lab, but you could have easily chosen specific services to enforce it on. Especially in a scenario where want to migrate your existing services’ traffic from plain text to mTLS without breaking live traffic. 

You can also configure the Service Mesh with an [existing root certificate, signing certificate and key][2]. Read about additional security configuration [in the docs here][1] [and here][3].

## mTLS Summary
* Provides each service with a strong identity with interoperability across clusters and clouds
* Provides a key management system to automate key and certificate generation, distribution, and rotation
* Secures service-to-service communication 

The architecture to make all this work is somewhat complicated. If you want to dig into the details, the best place to start is [on this Security Overview page][1].

[1]: https://istio.io/docs/concepts/security/
[2]: https://istio.io/docs/tasks/security/citadel-config/plugin-ca-cert/
[3]: https://istio.io/docs/tasks/security/citadel-config/

{{< importPartial "footer/footer.html" >}}