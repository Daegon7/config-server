#!/bin/bash

resources=(
  "config-server-deployment.yaml"
  "config-server-service.yaml"
  "eureka-server-deployment.yaml"
  "eureka-server-service.yaml"
  "user-service-deployment.yaml"
  "user-service-service.yaml"
  "restapi-service-deployment.yaml"
  "restapi-service-service.yaml"
  "api-gateway-deployment.yaml"
  "api-gateway-service.yaml"
)

for res in "${resources[@]}"; do
  echo "Deleting $res..."
  kubectl delete -f "$res" --ignore-not-found
done

echo -e "\n🧼 All services and deployments deleted."
