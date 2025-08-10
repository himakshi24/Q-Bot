const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🚀 Setting up Q-Bot...\n');

// Colors for console output
const colors = {
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  red: '\x1b[31m',
  blue: '\x1b[34m',
  reset: '\x1b[0m'
};

const log = (message, color = 'green') => {
  console.log(`${colors[color]}${message}${colors.reset}`);
};

const logError = (message) => {
  console.log(`${colors.red}❌ ${message}${colors.reset}`);
};

const logSuccess = (message) => {
  console.log(`${colors.green}✅ ${message}${colors.reset}`);
};

const logInfo = (message) => {
  console.log(`${colors.blue}ℹ️  ${message}${colors.reset}`);
};

const logWarning = (message) => {
  console.log(`${colors.yellow}⚠️  ${message}${colors.reset}`);
};

try {
  // Check if Node.js is installed
  logInfo('Checking Node.js installation...');
  const nodeVersion = execSync('node --version', { encoding: 'utf8' }).trim();
  logSuccess(`Node.js ${nodeVersion} is installed`);

  // Install root dependencies
  logInfo('Installing root dependencies...');
  execSync('npm install', { stdio: 'inherit' });
  logSuccess('Root dependencies installed');

  // Install server dependencies
  logInfo('Installing server dependencies...');
  execSync('cd server && npm install', { stdio: 'inherit' });
  logSuccess('Server dependencies installed');

  // Install client dependencies
  logInfo('Installing client dependencies...');
  execSync('cd client && npm install', { stdio: 'inherit' });
  logSuccess('Client dependencies installed');

  // Create .env file for server if it doesn't exist
  const serverEnvPath = path.join(__dirname, 'server', '.env');
  if (!fs.existsSync(serverEnvPath)) {
    logInfo('Creating server .env file...');
    const envContent = `# MongoDB Configuration
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/q-bot?retryWrites=true&w=majority

# OpenAI Configuration
OPENAI_API_KEY=your_openai_api_key_here

# Server Configuration
PORT=5000
NODE_ENV=development

# Optional: Rate Limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100
`;
    fs.writeFileSync(serverEnvPath, envContent);
    logSuccess('Server .env file created');
    logWarning('Please update the .env file with your actual MongoDB URI and OpenAI API key');
  }

  // Create .env file for client if it doesn't exist
  const clientEnvPath = path.join(__dirname, 'client', '.env');
  if (!fs.existsSync(clientEnvPath)) {
    logInfo('Creating client .env file...');
    const clientEnvContent = `# API Configuration
REACT_APP_API_URL=http://localhost:5000
`;
    fs.writeFileSync(clientEnvPath, clientEnvContent);
    logSuccess('Client .env file created');
  }

  // Add missing dependency to server package.json
  const serverPackagePath = path.join(__dirname, 'server', 'package.json');
  if (fs.existsSync(serverPackagePath)) {
    const serverPackage = JSON.parse(fs.readFileSync(serverPackagePath, 'utf8'));
    if (!serverPackage.dependencies.uuid) {
      logInfo('Adding missing uuid dependency to server...');
      serverPackage.dependencies.uuid = '^9.0.1';
      fs.writeFileSync(serverPackagePath, JSON.stringify(serverPackage, null, 2));
      logSuccess('Added uuid dependency to server');
    }
  }

  logSuccess('\n🎉 Q-Bot setup completed successfully!');
  logInfo('\nNext steps:');
  logInfo('1. Update server/.env with your MongoDB URI and OpenAI API key');
  logInfo('2. Run "npm run dev" to start both server and client');
  logInfo('3. Open http://localhost:3000 in your browser');
  logInfo('\nFor deployment instructions, see README.md');

} catch (error) {
  logError('Setup failed:');
  console.error(error);
  process.exit(1);
}
