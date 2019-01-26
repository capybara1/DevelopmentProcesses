# Kubernetes

## Terminolgy

Node
- A worker machine
- Runs [node components](https://kubernetes.io/docs/concepts/overview/components/#node-components)
- Spezialization
  - Master
    - Runs [master components](https://kubernetes.io/docs/concepts/overview/components/#master-components)

Workload
- Either a [Pod](#pod) or [Controller](#controller)

Pod
- Smallest deployable units of computing
- A Pod encapsulates
  - One or more application containers
  - Storage resources
  - A unique network IP
  - Options

Controller
- E.g. a [ReplicaSet](#replicaset) or [Deployment](#deployment)

ReplicaSet
- Ensures that a specified number of [Pod](#pod) replicas are running at any one time

Deployment
- Defines a desired state of an application
- Provides declarative updates for [Pods](#pod) and [ReplicaSets](#replicaset)

Service
- An abstraction which defines a logical set of Pods and a policy by which to access them.
- Services types:
  - `ClusterIP` (default) exposes the service on an internal IP in the cluster
  - `NodePort` exposes the service using the container port
  - `LoadBalancer` creates an external load balancer service (if supported) and assigns a fixed, external IP to the service
  - `ExternalName` exposes the service using an arbitrary name

Resources:
- [Using Source IP](https://kubernetes.io/docs/tutorials/services/source-ip/)
- [Connecting Applications with Services](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/)
- [Labels and Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)