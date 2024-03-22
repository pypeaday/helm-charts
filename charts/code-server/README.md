# VS Code Server

Helm Chart and Dockerfile for a VS Code Server Instance with oAuth2 Proxy

## How-To

1. build Dockerfile and push to a registry
2. deploy clusterrole.yaml to k8s
    - basic clusterrole for our serviceaccount to create and get pods and services
3. helm install --namespace NAMESPACE . -f your_values.yaml

Stolen shamelessly from https://git.ai.wu.ac.at/sysadmin/k8s-public/code-server
