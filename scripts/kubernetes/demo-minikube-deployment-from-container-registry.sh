#!/bin/bash

kubectl run hello-minikub --image=gcr.io/google-containers/echoserver:1.10

kubectl expose deployment hello-minikube --type=NodePort

kubectl get pod

kubectl describe pod hello-minikube

curl $(minikube service hello-minikube --url)

kubectl delete deployment hello-minikube