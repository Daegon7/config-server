# health_check.ps1
$services = @(
    @{ name = "config-server"; port = 8888 },
    @{ name = "eureka-server"; port = 8761 },
    @{ name = "user-service"; port = 8081 },
    @{ name = "api-gateway"; port = 8000 }
)

foreach ($svc in $services) {
    $name = $svc.name
    $port = $svc.port

    $pod = kubectl get pods -l app=$name -o jsonpath="{.items[0].metadata.name}" 2>$null
    if (-not $pod) {
        Write-Host "❌ $name pod not found."
        continue
    }

    Write-Host "🔌 Port-forwarding $name on port $port..."
    $pf = Start-Process -FilePath "kubectl" -ArgumentList @("port-forward", $pod, "${port}:${port}") -NoNewWindow -PassThru
    Start-Sleep -Seconds 2

    try {
        $response = Invoke-WebRequest -Uri "http://localhost:$port/actuator/health" -UseBasicParsing -TimeoutSec 5
        $status = ($response.Content | ConvertFrom-Json).status
        Write-Host "✅ $name health: $status"
    } catch {
        Write-Host "❌ $name health check failed."
    }

    Stop-Process -Id $pf.Id -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 1
}