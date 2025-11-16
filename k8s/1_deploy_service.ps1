# deploy_services.ps1
function Wait-ForPod {
    param (
        [string]$Label
    )

    Write-Host "Checking pod with label app=$Label..."

    while ($true) {
        $pod = kubectl get pods -l app=$Label -o jsonpath="{.items[0].metadata.name}" 2>$null
        if (-not $pod) {
            Write-Host "No pod found with label app=$Label. Waiting..."
            Start-Sleep -Seconds 5
            continue
        }

        $status = kubectl get pod $pod -o jsonpath="{.status.phase}"
        Write-Host "Waiting for $Label to be Running... Current status: $status"
        if ($status -eq "Running") {
            Write-Host "✅ $Label is Running."
            break
        }

        Start-Sleep -Seconds 5
    }
}

Write-Host "`n================================"
Write-Host "Deploying config-server..."
Write-Host "================================"
kubectl apply -f config-server-deployment.yaml
kubectl apply -f config-server-service.yaml
Wait-ForPod "config-server"

Write-Host "`n================================"
Write-Host "Deploying eureka-server..."
Write-Host "================================"
kubectl apply -f eureka-server-deployment.yaml
kubectl apply -f eureka-server-service.yaml
Wait-ForPod "eureka-server"

Write-Host "`n================================"
Write-Host "Deploying user-service..."
Write-Host "================================"
kubectl apply -f user-service-deployment.yaml
kubectl apply -f user-service-service.yaml
Wait-ForPod "user-service"

Write-Host "`n================================"
Write-Host "Deploying api-gateway..."
Write-Host "================================"
kubectl apply -f api-gateway-deployment.yaml
kubectl apply -f api-gateway-service.yaml
Wait-ForPod "api-gateway"

Write-Host "`n✅ All services are deployed and running!"