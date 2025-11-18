#!/bin/bash

echo "🛑 Stopping selected services..."

# config-server (8888)
pids=$(pgrep -f "ssh .*:8888")
if [ -n "$pids" ]; then
  echo "Stopping config-server tunnel (PID: $pids)..."
  kill -9 $pids
else
  echo "✅ config-server not running"
fi

# eureka-server (8761)
pids=$(pgrep -f "ssh .*:8761")
if [ -n "$pids" ]; then
  echo "Stopping eureka-server tunnel (PID: $pids)..."
  kill -9 $pids
else
  echo "✅ eureka-server not running"
fi

# restapi-service (8082)
pids=$(pgrep -f "ssh .*:8082")
if [ -n "$pids" ]; then
  echo "Stopping restapi-service tunnel (PID: $pids)..."
  kill -9 $pids
else
  echo "✅ restapi-service not running"
fi

# user-service (8081)
pids=$(pgrep -f "ssh .*:8081")
if [ -n "$pids" ]; then
  echo "Stopping user-service tunnel (PID: $pids)..."
  kill -9 $pids
else
  echo "✅ user-service not running"
fi

# api-gateway port-forward (8000 → 5000)
pids=$(pgrep -f "kubectl port-forward svc/api-gateway 5000:8000")
if [ -n "$pids" ]; then
  echo "Stopping api-gateway port-forward (PID: $pids)..."
  kill -9 $pids
else
  echo "✅ api-gateway port-forward not running"
fi

echo "🎉 Selected services stopped!"
