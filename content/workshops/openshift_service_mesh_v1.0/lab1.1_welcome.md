---
title: Microservices
workshops: openshift_service_mesh_v1.0_v1.0
workshop_weight: 11
layout: lab
---

# A Brief Introduction to Microservices
Microservices, also known as the microservice architecture, is a software development technique that structures an application as a collection of loosely coupled services. Microservice architectures enable the continuous delivery/deployment/scaling of complex applications.

## Why microservices?
Agility. Deliver application updates faster. Isolate and fix bugs easier. Done right, a microservices architecture will you help to meet several important non-functional requirements for your software:

* scalability
* performance
* reliability
* resiliency
* extensibility
* availability

## What is a Service Mesh?
Red Hat OpenShift Service Mesh is a platform that provides behavioral insight and operational control over the service mesh, providing a uniform way to connect, secure, and monitor microservice applications.

The term service mesh describes the network of microservices that make up applications in a distributed microservice architecture and the interactions between those microservices. As a service mesh grows in size and complexity, it can become harder to understand and manage.

Based on the open source Istio project, Red Hat OpenShift Service Mesh adds a transparent layer on existing distributed applications without requiring any changes to the service code. You add Red Hat OpenShift Service Mesh support to services by deploying a special sidecar proxy throughout your environment that intercepts all network communication between microservices. You configure and manage the service mesh using the control plane features.

Red Hat OpenShift Service Mesh provides an easy way to create a network of deployed services that provides discovery, load balancing, service-to-service authentication, failure recovery, metrics, and monitoring. A service mesh also provides more complex operational functionality, including A/B testing, canary releases, rate limiting, access control, and end-to-end authentication.

[1]: https://xxxx

{{< importPartial "footer/footer.html" >}}