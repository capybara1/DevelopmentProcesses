#!/bin/bash

script_directory=$(dirname "$0")

kubectl apply -f "${script_directory}/echoserver-deployment.yml"

kubectl expose deployment echoserver-deployment --type=NodePort

kubectl get pod

kubectl describe pod echoserver-deployment

curl $(minikube service echoserver-deployment --url)

kubectl delete deployment echoserver-deployment