#!/bin/bash

kubectl run hello-minikub --image=gcr.io/google-containers/echoserver:1.10

# A deployment is any set of deployable resources (container(s), application, pod(s))
# A deployment define a desired state of an application
# Types
# - NodePort tells Kubernetes to expose the container port
# - Node 
kubectl expose deployment hello-minikube --type=NodePort

kubectl get pod

kubectl describe pod hello-minikube

curl $(minikube service hello-minikube --url)

kubectl delete deployment hello-minikube