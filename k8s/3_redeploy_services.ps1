# redeploy_services.ps1
$yamls = Get-ChildItem -Filter *.yaml

foreach ($file in $yamls) {
    $result = kubectl apply -f $file
    if ($result -match "configured") {
        Write-Host "🔁 $($file.Name) updated."
    } elseif ($result -match "unchanged") {
        Write-Host "⏭️ $($file.Name) unchanged."
    } elseif ($result -match "created") {
        Write-Host "🆕 $($file.Name) created."
    } else {
        Write-Host "⚠️ $($file.Name): $result"
    }
}