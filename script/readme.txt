1. 도커 빌드
docker build -t daegon7/msa-config-app .
docker login
docker push daegon7/msa-config-app

docker build -t daegon7/msa-eureka-app .
docker push daegon7/msa-eureka-app

docker build -t daegon7/msa-user-app .
docker push daegon7/msa-user-app

docker build -t daegon7/msa-gateway-app .
docker push daegon7/msa-gateway-app

2. 쿠버네티스
kubectl apply -f k8s/config-server-deployment.yaml
kubectl apply -f k8s/config-server-service.yaml

kubectl apply -f k8s/eureka-server-deployment.yaml
kubectl apply -f k8s/eureka-server-service.yaml

kubectl apply -f k8s/user-service-deployment.yaml
kubectl apply -f k8s/user-service-service.yaml

kubectl apply -f k8s/api-gateway-deployment.yaml
kubectl apply -f k8s/api-gateway-service.yaml

minikube service config-server
minikube service eureka-server
minikube service user-service
minikube service api-gateway

kubectl get services

kubectl get svc -o wide

3. 쿠버네티스 확인

클러스터 상태 확인
minikube status  (host, kubelet, apiserver가 모두 Running)

실행 중이 아니라면:
minikube start

4. 쿠버네티스 다시 시작 (도커 빌드 -> apply *.yaml 후)
kubectl rollout restart deployment config-server
kubectl rollout restart deployment eureka-server
kubectl rollout restart deployment user-service
kubectl rollout restart deployment api-gateway