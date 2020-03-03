---
title: mTLS
workshops: openshift_service_mesh
workshop_weight: 51
layout: lab
---

# Mutual TLS
One of the key features of the Service Mesh is its ability to bring additional security to your applications. It does this in a several different ways that will be explored in the next few labs. The first of which is a concept known as "Mutual TLS" or mTLS for short.

Imagine a scenario where you are deploying a microservices application and are expecting a lot of PII to flow between the services. In that scenario there are probably all sorts of security requirements to adhere to. One big requirement that's typical (and could cause a lot of consternation on the development/operations team) is to encrypt all service communications. That's going to mean managing and exchanging SSL keys, validating and authenticating, encrypting and decrypting network traffic, and figuring out how to do it in each application stack (Node.js, Java, Go, etc.).

## Current State of No Encryption
Currently, the services you deployed in earlier labs are secured from access by the outside world by standard OpenShift networking/routing. Essentially, there is no ingress to most services (controlled via the gateway you created). However, a rogue pod running in the project could snoop on our data and it could even make direct HTTP requests. Let's launch a pod to show that:
```
oc run curl-boards --attach --restart=Never --image=appropriate/curl --timeout=10s -- http://boards:8080/shareditems
```

This job just executes a direct HTTP curl request for the current shared boards list. It'll print out something similar to this:

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0[
  {
    "_id": "5e5d75b33396fe0043f63e5c",
    "owner": "anonymous",
    "type": "string",
    "raw": "something goes here",
    "name": "",
    "id": "MNCkr3mK",
    "created_at": "2020-03-02T21:08:03+00:00"
  },
  {
    "_id": "5e5d75b63396fe0043f63e5d",
    "owner": "anonymous",
    "type": "string",
    "raw": "another item",
    "name": "",
    "id": "x5ORoJu8",
    "created_at": "2020-03-02T21:08:06+00:00"
  }
100   423  100   423    0     0  23500      0 --:--:-- --:--:-- --:--:-- 23500
]pod "curl-boards" deleted
```

## Adding mTLS to Our Existing Services
Now we will show how the Service Mesh can encrypt all traffic without requiring code changes, without complicated networking updates, and without installing/using tools (e.g. ssh-keygen) or servers.

TBD STEPS HERE


[1]: https://xxxx

{{< importPartial "footer/footer.html" >}}