# redeploy_services.ps1
$yamls = Get-ChildItem -Filter *.yaml

foreach ($file in $yamls) {
    $result = kubectl apply -f $file

    if ($result -match "configured") {
        Write-Host "🔁 $($file.Name) updated."

        # Deployment 파일일 경우 rollout restart
        if ($file.Name -match "-deployment\.yaml$") {
            $deploymentName = ($file.Name -replace "-deployment\.yaml$", "")
            Write-Host "🔄 Restarting deployment: $deploymentName"
            kubectl rollout restart deployment $deploymentName
        }

    } elseif ($result -match "unchanged") {
        Write-Host "⏭️ $($file.Name) unchanged."
    } elseif ($result -match "created") {
        Write-Host "🆕 $($file.Name) created."
    } else {
        Write-Host "⚠️ $($file.Name): $result"
    }
}