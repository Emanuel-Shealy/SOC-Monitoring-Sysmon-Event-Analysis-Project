Write-Host "=== SECURITY MONITOR STARTED ==="

while ($true) {

    $events = Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 15

    foreach ($event in $events) {

        # Detect PowerShell activity
        if ($event.Message -match "powershell") {
            Write-Host "[ALERT] PowerShell activity detected!" -ForegroundColor Yellow
            Write-Host $event.TimeCreated
        }

        # Detect Command Prompt usage
        if ($event.Message -match "cmd.exe") {
            Write-Host "[ALERT] Command Prompt execution detected!" -ForegroundColor Cyan
            Write-Host $event.TimeCreated
        }

        # Detect network connections
        if ($event.Id -eq 3) {
            Write-Host "[NETWORK] Network connection detected!" -ForegroundColor Green
            Write-Host $event.TimeCreated
        }

        # Detect file creation
        if ($event.Id -eq 11) {
            Write-Host "[FILE EVENT] File creation detected!" -ForegroundColor Magenta
            Write-Host $event.TimeCreated
        }
    }

    Start-Sleep -Seconds 5
}Set-ExecutionPolicy RemoteSignedSet-ExecutionPolicy RemoteSigned