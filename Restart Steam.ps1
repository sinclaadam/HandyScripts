$SteamExe = "C:\Program Files (x86)\Steam\steam.exe"

Write-Host "Stopping Steam Process"
$steam = Get-Process steam -ErrorAction SilentlyContinue
if ($steam) {
  # try gracefully first
  &$SteamExe -shutdown
  # kill after ten seconds
  Sleep 10
  if (!$steam.HasExited) {
    Write-Host "Steam doesn't want to cooperate, killing it forcefully"
    $steam | Stop-Process -Force
  }
}

Write-Host "Starting Steam"
Start-Process -FilePath $SteamExe