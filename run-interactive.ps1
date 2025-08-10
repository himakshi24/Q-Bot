# Q-Bot Interactive Startup Script
Write-Host "🚀 Starting Q-Bot with Interactive Monitoring..." -ForegroundColor Green
Write-Host ""

# Function to check if a port is in use
function Test-Port {
    param($Port)
    $connection = Get-NetTCPConnection -LocalPort $Port -ErrorAction SilentlyContinue
    return $connection -ne $null
}

# Function to start server with monitoring
function Start-ServerWithMonitoring {
    param($Name, $Port, $Command)
    
    Write-Host "Starting $Name on port $Port..." -ForegroundColor Yellow
    
    # Start the process
    $process = Start-Process -FilePath "powershell" -ArgumentList "-NoExit", "-Command", $Command -PassThru -WindowStyle Normal
    
    # Wait and check if it's running
    Start-Sleep -Seconds 3
    
    if (Test-Port $Port) {
        Write-Host "✅ $Name is RUNNING on port $Port" -ForegroundColor Green
        return $true
    } else {
        Write-Host "❌ $Name failed to start on port $Port" -ForegroundColor Red
        return $false
    }
}

# Check if .env files exist
if (-not (Test-Path "server\.env")) {
    Write-Host "❌ server\.env not found!" -ForegroundColor Red
    Write-Host "Please run setup first: node setup.js" -ForegroundColor Yellow
    exit 1
}

if (-not (Test-Path "client\.env")) {
    Write-Host "❌ client\.env not found!" -ForegroundColor Red
    Write-Host "Please run setup first: node setup.js" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Environment files found" -ForegroundColor Green
Write-Host ""

# Start Backend Server
$serverStarted = Start-ServerWithMonitoring -Name "Backend Server" -Port 5000 -Command "cd '$PWD\server'; node server.js"

# Wait a moment
Start-Sleep -Seconds 2

# Start Frontend Client
$clientStarted = Start-ServerWithMonitoring -Name "Frontend Client" -Port 3000 -Command "cd '$PWD\client'; npm start"

Write-Host ""
Write-Host "=== Final Status ===" -ForegroundColor Cyan

if ($serverStarted) {
    Write-Host "✅ Backend Server: http://localhost:5000" -ForegroundColor Green
} else {
    Write-Host "❌ Backend Server: Failed to start" -ForegroundColor Red
}

if ($clientStarted) {
    Write-Host "✅ Frontend Client: http://localhost:3000" -ForegroundColor Green
} else {
    Write-Host "❌ Frontend Client: Failed to start" -ForegroundColor Red
}

Write-Host ""
if ($serverStarted -and $clientStarted) {
    Write-Host "🎉 Q-Bot is ready! Open http://localhost:3000 in your browser" -ForegroundColor Green
    Write-Host "Press any key to continue monitoring..." -ForegroundColor Yellow
    Read-Host
} else {
    Write-Host "⚠️ Some services failed to start. Check the opened windows for errors." -ForegroundColor Yellow
    Write-Host "Press any key to exit..." -ForegroundColor Yellow
    Read-Host
}
