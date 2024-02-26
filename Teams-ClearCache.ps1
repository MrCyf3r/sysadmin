## Quick PowerShell script for closing Teams then removing the local cache when Teams has issues loading.

$clearCache = Read-Host "Clear local Teams cache? (Y/N)"
## Check if user input is "Y".
if ($clearCache.ToUpper() -eq "Y"){
  Write-Host "Closing Teams"
  
  try {
    if (Get-Process -ProcessName Teams -ErrorAction SilentlyContinue) { 
        Stop-Process -Name Teams -Force
        Start-Sleep -Seconds 3
        Write-Host "Teams sucessfully closed."
    } else {
        Write-Host "Teams is already closed."
    }
  } catch {
      echo $_
  }

  Write-Host "Clearing Teams cache"
## Try to to delete Teams cache and output any errors.
  try {
    Remove-Item -Path "$env:APPDATA\Microsoft\teams" -Recurse -Force -Confirm:$false
    Write-Host "Teams cache deleted."
  } catch {
    echo $_
  }
  ## After successful cache cleanup, restart local instance of Teams.
  Write-Host "Cache cleanup complete."
  Start-Process -FilePath "$env:LOCALAPPDATA\Microsoft\Teams\current\Teams.exe"
}