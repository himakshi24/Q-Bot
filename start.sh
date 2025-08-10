#!/bin/bash

echo "Starting Q-Bot..."
echo

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "Error: Node.js is not installed or not in PATH"
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi

# Check if .env file exists
if [ ! -f "server/.env" ]; then
    echo "Warning: server/.env file not found"
    echo "Please run setup first: node setup.js"
    echo
fi

echo "Starting development servers..."
echo "Server will run on http://localhost:5000"
echo "Client will run on http://localhost:3000"
echo
echo "Press Ctrl+C to stop both servers"
echo

npm run dev
