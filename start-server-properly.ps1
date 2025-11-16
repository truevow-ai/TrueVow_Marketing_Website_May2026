# Start server properly and verify it's working

$port = 8000
$projectPath = "C:\Users\yasha\OneDrive\Documents\TrueVow\Cursor\2025-TrueVow-Website"

Write-Host "Stopping any existing Python servers..."
Stop-Process -Name python -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

Write-Host "Starting server in project directory..."
Set-Location $projectPath

# Start server in background
$job = Start-Job -ScriptBlock {
    Set-Location $using:projectPath
    python -m http.server $using:port
}

Start-Sleep -Seconds 4

# Test connection
Write-Host "Testing connection..."
$test = Test-NetConnection -ComputerName localhost -Port $port -InformationLevel Quiet -WarningAction SilentlyContinue

if ($test) {
    Write-Host "✅ SUCCESS: Server is running on port $port"
    Write-Host "🌐 Access at: http://localhost:$port/marketing/county-cap.html"
} else {
    Write-Host "❌ Server not responding on port $port"
    Write-Host "Trying port 8080..."
    
    Stop-Job $job -ErrorAction SilentlyContinue
    Remove-Job $job -ErrorAction SilentlyContinue
    
    $job2 = Start-Job -ScriptBlock {
        Set-Location $using:projectPath
        python -m http.server 8080
    }
    
    Start-Sleep -Seconds 3
    $test2 = Test-NetConnection -ComputerName localhost -Port 8080 -InformationLevel Quiet -WarningAction SilentlyContinue
    
    if ($test2) {
        Write-Host "✅ Server running on port 8080"
        Write-Host "🌐 Access at: http://localhost:8080/marketing/county-cap.html"
    } else {
        Write-Host "❌ Server failed to start. Try manually:"
        Write-Host "   cd '$projectPath'"
        Write-Host "   python -m http.server 8000"
    }
}

