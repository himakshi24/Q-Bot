# Final fix for .env files
Write-Host "Fixing .env files..." -ForegroundColor Green

# Fix server .env
$serverEnv = @"
# MongoDB Configuration
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/q-bot?retryWrites=true&w=majority

# OpenAI Configuration
OPENAI_API_KEY=your_openai_api_key_here

# Server Configuration
PORT=5000
NODE_ENV=development

# Optional: Rate Limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100
"@

$serverEnv | Out-File -FilePath "server\.env" -Encoding UTF8 -Force
Write-Host "Server .env fixed" -ForegroundColor Green

# Fix client .env
$clientEnv = @"
# API Configuration
REACT_APP_API_URL=http://localhost:5000

# Optional: Environment
REACT_APP_ENV=development
"@

$clientEnv | Out-File -FilePath "client\.env" -Encoding UTF8 -Force
Write-Host "Client .env fixed" -ForegroundColor Green

Write-Host ""
Write-Host ".env files have been fixed!" -ForegroundColor Green
Write-Host ""
Write-Host "Server .env:" -ForegroundColor Yellow
Get-Content "server\.env"
Write-Host ""
Write-Host "Client .env:" -ForegroundColor Yellow
Get-Content "client\.env"
