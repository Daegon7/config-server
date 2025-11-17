1. 도커 빌드
docker build -t daegon7/msa-config-app .
docker login
docker push daegon7/msa-config-app

docker build -t daegon7/msa-eureka-app .
docker push daegon7/msa-eureka-app

docker build -t daegon7/msa-user-app .
docker push daegon7/msa-user-app

docker build -t daegon7/msa-restapi-app .
docker push daegon7/msa-restapi-app

docker build -t daegon7/msa-gateway-app .
docker push daegon7/msa-gateway-app

2. 클러스터 상태 확인
minikube status  (host, kubelet, apiserver가 모두 Running)

실행 중이 아니라면:
minikube start

kubectl get services
kubectl get svc -o wide

3. 쿠버네티스

PS C:\intelij_workspace\config-server\k8s> minikube service --all

"PS C:\intelij_workspace\config-server\k8s> Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass" (powershell로 실행)
- 1_deploy_service.ps1 (배포)
- 2_health_check.ps1 (점검)
- 3_redeploy_services.ps1 (재배포)
- 4. undeploy_services.ps1 (삭제)

http://127.0.0.1:50185/           (eureka 서버)
http://127.0.0.1:50189/users/a123 (users 서버)
http://127.0.0.1:50181/users/a123 (gateway 서버 -> Front 서버 단에서 호출)

4. 로컬 배포 시
user-service 서버의 application.properties 파일 수정 (Local, Minikube)
api-gateway  서버의 application.properties 파일 수정 (Local, Minikube)