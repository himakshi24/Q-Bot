@echo off
echo Starting Q-Bot...
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Node.js is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

REM Check if .env file exists
if not exist "server\.env" (
    echo Warning: server\.env file not found
    echo Please run setup first: node setup.js
    echo.
)

echo Starting development servers...
echo Server will run on http://localhost:5000
echo Client will run on http://localhost:3000
echo.
echo Press Ctrl+C to stop both servers
echo.

REM Start server in background
start "Q-Bot Server" cmd /k "cd server && node server.js"

REM Wait a moment for server to start
timeout /t 3 /nobreak >nul

REM Start client in background
start "Q-Bot Client" cmd /k "cd client && npm start"

echo Both servers are starting...
echo Check the opened windows for server status
pause
