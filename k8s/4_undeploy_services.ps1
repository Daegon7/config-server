# undeploy_services.ps1
$resources = @(
    "config-server-deployment.yaml",
    "config-server-service.yaml",
    "eureka-server-deployment.yaml",
    "eureka-server-service.yaml",
    "user-service-deployment.yaml",
    "user-service-service.yaml",
    "api-gateway-deployment.yaml",
    "api-gateway-service.yaml"
)

foreach ($res in $resources) {
    Write-Host "Deleting $res..."
    kubectl delete -f $res --ignore-not-found
}

Write-Host "`n🧼 All services and deployments deleted."