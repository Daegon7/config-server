#!/bin/bash

echo "🚀 Starting selected services..."

# config-server
if pgrep -f "ssh .*:8888" > /dev/null; then
  echo "✅ config-server already running"
else
  echo "▶ Starting config-server..."
  minikube service config-server --url >/dev/null 2>&1 &
  sleep 2
  echo "🔗 config-server started"
fi

# eureka-server
if pgrep -f "ssh .*:8761" > /dev/null; then
  echo "✅ eureka-server already running"
else
  echo "▶ Starting eureka-server..."
  minikube service eureka-server --url >/dev/null 2>&1 &
  sleep 2
  echo "🔗 eureka-server started"
fi

# restapi-service
if pgrep -f "ssh .*:8082" > /dev/null; then
  echo "✅ restapi-service already running"
else
  echo "▶ Starting restapi-service..."
  minikube service restapi-service --url >/dev/null 2>&1 &
  sleep 2
  echo "🔗 restapi-service started"
fi

# user-service
if pgrep -f "ssh .*:8081" > /dev/null; then
  echo "✅ user-service already running"
else
  echo "▶ Starting user-service..."
  minikube service user-service --url >/dev/null 2>&1 &
  sleep 2
  echo "🔗 user-service started"
fi

# api-gateway (port-forward)
if pgrep -f "kubectl port-forward svc/api-gateway 5000:8000" > /dev/null; then
  echo "✅ api-gateway already running on port 5000"
else
  echo "▶ Starting port-forward for api-gateway..."
  kubectl port-forward svc/api-gateway 5000:8000 >/dev/null 2>&1 &
  sleep 2
  echo "🔗 api-gateway available at http://127.0.0.1:5000"
fi

echo "🎉 Selected services are now running!"
