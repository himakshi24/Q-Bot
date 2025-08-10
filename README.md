# Q-Bot 🤖

A ChatGPT-inspired MERN stack chatbot application with modern UI and advanced features.

## Features ✨

- 🤖 **AI-Powered Chat**: Powered by OpenAI GPT-4/4o
- 💬 **Real-time Messaging**: Instant responses with loading animations
- 🎨 **Modern UI**: ChatGPT-style dark mode interface
- 📱 **Responsive Design**: Works perfectly on mobile and desktop
- 🔄 **Auto-scroll**: Automatic scrolling to latest messages
- 📚 **Chat History**: Persistent conversation history in MongoDB
- 🎤 **Speech Features**: Text-to-speech and speech-to-text (optional)
- 🔒 **Secure**: Environment variables for API keys
- ⚡ **Fast**: Optimized performance with modern JavaScript

## Tech Stack 🛠️

- **Frontend**: React.js, Tailwind CSS
- **Backend**: Node.js, Express.js
- **Database**: MongoDB
- **AI**: OpenAI Chat Completions API
- **Deployment**: Render/Heroku (Backend) + Vercel/Netlify (Frontend)

## Quick Start 🚀

### Prerequisites
- Node.js (v16 or higher)
- MongoDB Atlas account
- OpenAI API key

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd Q-Bot
   ```

2. **Install dependencies**
   ```bash
   npm run install-all
   ```

3. **Environment Setup**
   
   Create `.env` file in the server directory:
   ```env
   MONGODB_URI=your_mongodb_atlas_connection_string
   OPENAI_API_KEY=your_openai_api_key
   PORT=5000
   NODE_ENV=development
   ```

4. **Run the application**
   ```bash
   npm run dev
   ```

   This will start both the backend server (port 5000) and frontend (port 3000).

## Project Structure 📁

```
Q-Bot/
├── client/                 # React frontend
│   ├── public/
│   ├── src/
│   │   ├── components/     # React components
│   │   ├── hooks/         # Custom hooks
│   │   ├── services/      # API services
│   │   └── styles/        # CSS styles
│   └── package.json
├── server/                 # Node.js backend
│   ├── controllers/        # Route controllers
│   ├── models/            # MongoDB models
│   ├── routes/            # API routes
│   ├── middleware/        # Custom middleware
│   └── package.json
├── package.json           # Root package.json
└── README.md
```

## API Endpoints 🔌

### Chat Endpoints
- `POST /api/chat` - Send message to OpenAI and save to database
- `GET /api/history` - Retrieve chat history from database

### Request/Response Format

**Send Message:**
```json
POST /api/chat
{
  "message": "Hello, how are you?",
  "sessionId": "optional-session-id"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "message": "Hello! I'm doing well, thank you for asking.",
    "timestamp": "2024-01-01T12:00:00.000Z"
  }
}
```

## Deployment 🌐

### Backend Deployment (Render/Heroku)

1. **Render Deployment:**
   - Connect your GitHub repository
   - Set environment variables in Render dashboard
   - Deploy automatically on push

2. **Heroku Deployment:**
   ```bash
   heroku create your-q-bot-app
   heroku config:set MONGODB_URI=your_mongodb_uri
   heroku config:set OPENAI_API_KEY=your_openai_key
   git push heroku main
   ```

### Frontend Deployment (Vercel/Netlify)

1. **Vercel Deployment:**
   - Connect your GitHub repository
   - Set build command: `npm run build`
   - Set output directory: `client/build`

2. **Netlify Deployment:**
   - Connect your GitHub repository
   - Set build command: `cd client && npm run build`
   - Set publish directory: `client/build`

### Environment Variables for Production

Update the frontend API base URL in `client/src/services/api.js`:
```javascript
const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:5000';
```

## Features in Detail 🎯

### Core Features
- **Real-time Chat**: Instant messaging with OpenAI
- **Message History**: Persistent storage in MongoDB
- **Loading States**: Smooth loading animations
- **Auto-scroll**: Automatic scrolling to new messages
- **Responsive Design**: Mobile-first approach

### Advanced Features (Optional)
- **Speech-to-Text**: Voice input for messages
- **Text-to-Speech**: Audio playback of responses
- **Multi-session**: Support for multiple chat sessions
- **Context Management**: Maintain conversation context

## Contributing 🤝

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License 📄

This project is licensed under the MIT License.

## Support 💬

For support, email support@q-bot.com or create an issue in the repository.

---

**Built with ❤️ using MERN Stack**
