#!/bin/bash

# Wait for pod to be running
wait_for_pod() {
  label=$1
  echo "Checking pod with label app=$label..."

  while true; do
    pod=$(kubectl get pods -l app=$label -o jsonpath="{.items[0].metadata.name}" 2>/dev/null)
    if [ -z "$pod" ]; then
      echo "No pod found with label app=$label. Waiting..."
      sleep 5
      continue
    fi

    status=$(kubectl get pod "$pod" -o jsonpath="{.status.phase}")
    echo "Waiting for $label to be Running... Current status: $status"
    if [ "$status" = "Running" ]; then
      echo "✅ $label is Running."
      break
    fi

    sleep 5
  done
}

echo -e "\n================================"
echo "Deploying config-server..."
echo "================================"
kubectl apply -f config-server-deployment.yaml
kubectl apply -f config-server-service.yaml
wait_for_pod "config-server"

echo -e "\n================================"
echo "Deploying eureka-server..."
echo "================================"
kubectl apply -f eureka-server-deployment.yaml
kubectl apply -f eureka-server-service.yaml
wait_for_pod "eureka-server"

echo -e "\n================================"
echo "Deploying user-service..."
echo "================================"
kubectl apply -f user-service-deployment.yaml
kubectl apply -f user-service-service.yaml
wait_for_pod "user-service"

echo -e "\n================================"
echo "Deploying restapi-service..."
echo "================================"
kubectl apply -f restapi-service-deployment.yaml
kubectl apply -f restapi-service-service.yaml
wait_for_pod "restapi-service"

echo -e "\n================================"
echo "Deploying api-gateway..."
echo "================================"
kubectl apply -f api-gateway-deployment.yaml
kubectl apply -f api-gateway-service.yaml
wait_for_pod "api-gateway"

echo -e "\n✅ All services are deployed and running!"
