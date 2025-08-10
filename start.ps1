# Q-Bot Start Script for PowerShell
Write-Host "🚀 Starting Q-Bot..." -ForegroundColor Green
Write-Host ""

# Check if Node.js is installed
try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js version: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Error: Node.js is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Node.js from https://nodejs.org/" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if .env file exists
if (-not (Test-Path "server\.env")) {
    Write-Host "⚠️  Warning: server\.env file not found" -ForegroundColor Yellow
    Write-Host "Please run setup first: node setup.js" -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "Starting development servers..." -ForegroundColor Cyan
Write-Host "Server will run on http://localhost:5000" -ForegroundColor White
Write-Host "Client will run on http://localhost:3000" -ForegroundColor White
Write-Host ""
Write-Host "Press Ctrl+C to stop both servers" -ForegroundColor Yellow
Write-Host ""

# Start both servers using npm run dev
npm run dev
