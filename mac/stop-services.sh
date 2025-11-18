#!/bin/bash

#chmod +x stop-services.sh

# 종료할 서비스 목록
services=("config-server" "eureka-server" "restapi-service" "user-service")

echo "🛑 Stopping services..."

# minikube service 터널 종료
for svc in "${services[@]}"; do
  # 해당 서비스 프로세스 찾기
  pid=$(ps -ef | grep "minikube service $svc" | grep -v grep | awk '{print $2}')
  if [ -n "$pid" ]; then
    echo "Stopping $svc (PID: $pid)..."
    kill -9 $pid
  else
    echo "✅ $svc not running"
  fi
done

# api-gateway port-forward 종료
pid=$(ps -ef | grep "kubectl port-forward svc/api-gateway 5000:8000" | grep -v grep | awk '{print $2}')
if [ -n "$pid" ]; then
  echo "Stopping api-gateway port-forward (PID: $pid)..."
  kill -9 $pid
else
  echo "✅ api-gateway port-forward not running"
fi

echo "🎉 All services stopped!"
