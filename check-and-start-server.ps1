# Check if server is running and start if needed

$port = 8000
$processName = "python"

Write-Host "Checking if server is running on port $port..."

# Check if Python process is running
$pythonProcess = Get-Process -Name $processName -ErrorAction SilentlyContinue

if ($pythonProcess) {
    Write-Host "✅ Python process found (PID: $($pythonProcess.Id))"
    
    # Check if port is actually listening
    $connection = Test-NetConnection -ComputerName localhost -Port $port -WarningAction SilentlyContinue -InformationLevel Quiet
    
    if ($connection) {
        Write-Host "✅ Server is running and responding on port $port"
        Write-Host "🌐 Access at: http://localhost:$port/marketing/county-cap.html"
        exit 0
    } else {
        Write-Host "⚠️ Python is running but port $port is not responding"
        Write-Host "Stopping old process and restarting..."
        Stop-Process -Name $processName -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
    }
} else {
    Write-Host "❌ Server is not running"
}

# Start the server
Write-Host "Starting server on port $port..."
Start-Process python -ArgumentList "-m", "http.server", "$port" -WindowStyle Hidden

# Wait a moment for server to start
Start-Sleep -Seconds 3

# Verify it's running
$connection = Test-NetConnection -ComputerName localhost -Port $port -WarningAction SilentlyContinue -InformationLevel Quiet

if ($connection) {
    Write-Host "✅ Server started successfully!"
    Write-Host "🌐 Access at: http://localhost:$port/marketing/county-cap.html"
} else {
    Write-Host "⚠️ Server may not have started. Try manually: python -m http.server $port"
}

