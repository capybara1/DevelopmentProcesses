#!/bin/bash

script_directory=$(dirname "$0")

minikube start

kubectl apply -f "${script_directory}/echoserver-deployment.yml"

kubectl expose deployment hello-minikube --type=NodePort

kubectl get pod

kubectl describe pod hello-minikube

curl $(minikube service hello-minikube --url)

kubectl delete deployment hello-minikube

minikube stop