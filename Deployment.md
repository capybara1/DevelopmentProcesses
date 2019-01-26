# Deployment

## Strategies

References:
- [Deployment Strategies and Release Best Practices](http://cgrant.io/article/deployment-strategies/)

### Decentral

### Central

#### Highlander Deployment

"There can be only one"

Process:
- The changes are deployed to all servers at the same time

#### Rolling Deployment

Precondition:
- All Potentially Shippable Increment are downward compatible

Process:
- The changes are deployed to the servers one after another

#### Blue/Green Deployment

Preconditions:
- Two systems with the same infratructure exist
- One system is serving requests (connected) the other is not available to the public (disconnected)

Process:
- The changes are deployed to the servers in the disconnected system
- Acceptance tests are performed in the disconnected system
- The disconnected system is connected while the other is disconnected

#### Canary Deployment

Preconditions:
- Sessions are sticky
- A subset of the servers have been selected to act as canary server(s)

Process:
- The changes are deployed to the cabary server(s)
- The changes are evalaluated by the users that are redirected to the canary servers
- In case there are no major issues, the deployment can be extended to the remainng servers

## Technologies

### Virtualization

![virtualization overview](./media/virtualization.svg)

#### Hypervisor based Virtualization

Products:
- VMWare
- VirtualBox
- Hyper-V
- ...

#### Container based Virtualization

Container Formats:
- Docker (de-facto standard)
- Windows Containers
- ...

Container Orchestration Frameworks:
- Kubernetes (de-facto standard)
- Docker Swarm
- Apache Mesos
- ...

Resources:
- [Cloud Native Computing Foundation](https://www.cncf.io/)
- [Kubernetes Tutorial | Kubernetes | Kubernetes tutorial for beginners](https://www.youtube.com/watch?v=gpmerrSpbHg)