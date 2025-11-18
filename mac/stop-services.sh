#!/bin/bash

echo "🛑 Stopping services..."

# ssh 포트포워딩 프로세스 종료
pids=$(pgrep -f "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o IdentitiesOnly=yes -N docker@127.0.0.1")
if [ -n "$pids" ]; then
  echo "Stopping ssh tunnel processes (PID: $pids)..."
  kill -9 $pids
else
  echo "✅ no ssh tunnel processes running"
fi

# api-gateway port-forward 종료
pids=$(pgrep -f "kubectl port-forward svc/api-gateway 5000:8000")
if [ -n "$pids" ]; then
  echo "Stopping api-gateway port-forward (PID: $pids)..."
  kill -9 $pids
else
  echo "✅ api-gateway port-forward not running"
fi

echo "🎉 All services stopped!"
