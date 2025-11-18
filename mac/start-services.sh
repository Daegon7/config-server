#!/bin/bash

# 서비스 실행 여부 확인 함수
is_service_running() {
  local svc_name=$1
  # minikube service list로 확인
  minikube service list | grep -q "$svc_name"
}

# 4개 서비스 (minikube service)
for svc in config-server eureka-server restapi-service user-service; do
  if is_service_running $svc; then
    echo "✅ $svc already running"
  else
    echo "▶ Starting $svc..."
    minikube service $svc --url &
  fi
done

# api-gateway는 port-forward 필요
# 포트가 이미 열려 있는지 확인
if lsof -i :5000 | grep -q LISTEN; then
  echo "✅ api-gateway already running on port 5000"
else
  echo "▶ Starting port-forward for api-gateway..."
  kubectl port-forward svc/api-gateway 5000:8000 &
fi

echo "🎉 All required services are now running!"
