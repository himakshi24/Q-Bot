# Q-Bot Deployment Guide 🚀

This guide will help you deploy Q-Bot to production environments.

## Prerequisites

- Node.js 16+ installed
- MongoDB Atlas account
- OpenAI API key
- Git repository (GitHub, GitLab, etc.)

## Environment Setup

### 1. MongoDB Atlas Setup

1. Create a MongoDB Atlas account at [mongodb.com](https://mongodb.com)
2. Create a new cluster (free tier is sufficient)
3. Create a database user with read/write permissions
4. Get your connection string:
   ```
   mongodb+srv://username:password@cluster.mongodb.net/q-bot?retryWrites=true&w=majority
   ```

### 2. OpenAI API Setup

1. Create an OpenAI account at [openai.com](https://openai.com)
2. Generate an API key in your dashboard
3. Note your API key for deployment

## Deployment Options

### Option 1: Render (Recommended)

#### Backend Deployment on Render

1. **Connect Repository**
   - Go to [render.com](https://render.com)
   - Connect your GitHub repository
   - Create a new Web Service

2. **Configure Backend**
   - **Name**: `q-bot-backend`
   - **Root Directory**: `server`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - **Environment**: Node

3. **Environment Variables**
   ```
   MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/q-bot?retryWrites=true&w=majority
   OPENAI_API_KEY=your_openai_api_key_here
   NODE_ENV=production
   PORT=10000
   ```

4. **Deploy**
   - Click "Create Web Service"
   - Wait for deployment to complete
   - Note your backend URL (e.g., `https://q-bot-backend.onrender.com`)

#### Frontend Deployment on Render

1. **Create Static Site**
   - Create a new Static Site in Render
   - Connect the same repository

2. **Configure Frontend**
   - **Name**: `q-bot-frontend`
   - **Root Directory**: `client`
   - **Build Command**: `npm install && npm run build`
   - **Publish Directory**: `build`

3. **Environment Variables**
   ```
   REACT_APP_API_URL=https://q-bot-backend.onrender.com
   ```

4. **Deploy**
   - Click "Create Static Site"
   - Wait for deployment to complete

### Option 2: Heroku

#### Backend Deployment on Heroku

1. **Install Heroku CLI**
   ```bash
   npm install -g heroku
   ```

2. **Create Heroku App**
   ```bash
   heroku create q-bot-backend
   ```

3. **Set Environment Variables**
   ```bash
   heroku config:set MONGODB_URI="mongodb+srv://username:password@cluster.mongodb.net/q-bot?retryWrites=true&w=majority"
   heroku config:set OPENAI_API_KEY="your_openai_api_key_here"
   heroku config:set NODE_ENV="production"
   ```

4. **Deploy**
   ```bash
   git subtree push --prefix server heroku main
   ```

#### Frontend Deployment on Netlify

1. **Connect Repository**
   - Go to [netlify.com](https://netlify.com)
   - Connect your GitHub repository

2. **Configure Build**
   - **Base directory**: `client`
   - **Build command**: `npm run build`
   - **Publish directory**: `build`

3. **Environment Variables**
   ```
   REACT_APP_API_URL=https://q-bot-backend.herokuapp.com
   ```

### Option 3: Vercel

#### Full Stack Deployment

1. **Install Vercel CLI**
   ```bash
   npm install -g vercel
   ```

2. **Configure Project**
   Create `vercel.json` in root:
   ```json
   {
     "version": 2,
     "builds": [
       {
         "src": "server/server.js",
         "use": "@vercel/node"
       },
       {
         "src": "client/package.json",
         "use": "@vercel/static-build",
         "config": {
           "distDir": "build"
         }
       }
     ],
     "routes": [
       {
         "src": "/api/(.*)",
         "dest": "server/server.js"
       },
       {
         "src": "/(.*)",
         "dest": "client/$1"
       }
     ]
   }
   ```

3. **Deploy**
   ```bash
   vercel
   ```

## Environment Variables Reference

### Backend (.env)
```env
# Required
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/q-bot?retryWrites=true&w=majority
OPENAI_API_KEY=your_openai_api_key_here

# Optional
PORT=5000
NODE_ENV=development
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100
```

### Frontend (.env)
```env
# Required for production
REACT_APP_API_URL=https://your-backend-url.com
```

## Production Checklist

- [ ] MongoDB Atlas cluster configured
- [ ] OpenAI API key obtained
- [ ] Environment variables set
- [ ] Backend deployed and accessible
- [ ] Frontend deployed and connected to backend
- [ ] SSL certificates configured
- [ ] Domain configured (optional)
- [ ] Monitoring set up (optional)

## Troubleshooting

### Common Issues

1. **CORS Errors**
   - Ensure backend CORS configuration includes frontend URL
   - Check environment variables

2. **MongoDB Connection Issues**
   - Verify connection string format
   - Check network access in MongoDB Atlas
   - Ensure database user has correct permissions

3. **OpenAI API Errors**
   - Verify API key is correct
   - Check API key has sufficient credits
   - Ensure API key has access to GPT-4

4. **Build Failures**
   - Check Node.js version compatibility
   - Verify all dependencies are installed
   - Check for syntax errors in code

### Performance Optimization

1. **Database Indexing**
   ```javascript
   // Add to server/models/Chat.js
   chatSchema.index({ sessionId: 1, createdAt: -1 });
   chatSchema.index({ updatedAt: -1 });
   ```

2. **Caching**
   - Consider adding Redis for session caching
   - Implement response caching for static content

3. **Rate Limiting**
   - Adjust rate limits based on usage
   - Monitor API usage and costs

## Monitoring and Maintenance

### Health Checks
- Backend: `GET /health`
- Frontend: Check if API calls succeed

### Logs
- Monitor application logs for errors
- Set up error tracking (Sentry, etc.)

### Updates
- Regularly update dependencies
- Monitor security advisories
- Keep OpenAI API key secure

## Support

For deployment issues:
1. Check the troubleshooting section
2. Review platform-specific documentation
3. Check application logs
4. Verify environment variables

---

**Happy Deploying! 🎉**
