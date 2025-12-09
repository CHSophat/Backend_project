# Blog News Backend - Quick Start Guide

## Prerequisites
- Node.js (v18+)
- MySQL (v8+)
- npm or yarn

## Installation Steps

### 1. Install Dependencies
```bash
npm install
```

### 2. Database Setup
```bash
# Create database in MySQL
mysql -u root -p
> CREATE DATABASE blog_news_db;
> EXIT;
```

### 3. Configure Environment
Edit `.env` file with your settings:
```env
DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=your_password
DB_NAME=blog_news_db
JWT_SECRET=your_secret_key_here
JWT_EXPIRES_IN=7d
PORT=3000
NODE_ENV=development
```

### 4. Start Development Server
```bash
npm run start:dev
```

Server will run on `http://localhost:3000`

## Testing the API

### Register a User
```bash
curl -X POST http://localhost:3000/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "password": "Password123!"
  }'
```

### Login
```bash
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "Password123!"
  }'
```

Response will include `access_token`. Use this token in headers for authenticated requests:
```bash
-H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Create a Category
```bash
curl -X POST http://localhost:3000/categories \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Technology",
    "description": "Latest tech news",
    "slug": "technology"
  }'
```

### Create a Post
```bash
curl -X POST http://localhost:3000/posts \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -d '{
    "title": "My First Blog Post",
    "content": "This is the content of my blog post",
    "summary": "Short summary",
    "published": true,
    "categoryId": "CATEGORY_ID_HERE"
  }'
```

### Get All Posts
```bash
curl http://localhost:3000/posts
```

### Get Published Posts Only
```bash
curl http://localhost:3000/posts?published=true
```

### Add a Comment
```bash
curl -X POST http://localhost:3000/posts/POST_ID/comments \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -d '{
    "content": "Great post!"
  }'
```

## Available Scripts

```bash
# Development
npm run start:dev        # Start with file watching
npm run start:debug      # Start in debug mode

# Production
npm run build            # Build for production
npm run start:prod       # Start production build

# Testing
npm run test             # Run unit tests
npm run test:watch       # Watch mode
npm run test:cov         # Coverage report
npm run test:e2e         # E2E tests

# Code Quality
npm run lint             # Run ESLint
npm run format           # Format code with Prettier
```

## Project Modules

### 1. Auth Module (`src/auth/`)
- User registration
- User login with JWT
- JWT strategy implementation
- Auth guard for protected routes

### 2. Users Module (`src/users/`)
- List all users
- Get user by ID
- Update user profile
- Delete user account

### 3. Posts Module (`src/posts/`)
- Create blog posts
- View all posts
- View published posts
- View post details
- Update own posts
- Delete own posts
- Track view counts

### 4. Categories Module (`src/categories/`)
- Manage post categories
- List categories
- Filter posts by category

### 5. Comments Module (`src/comments/`)
- Add comments to posts
- View post comments
- Update own comments
- Delete own comments

## Database Schema

### Users Table
- id (UUID)
- email (unique)
- firstName
- lastName
- password (hashed)
- bio
- profilePicture
- role (user/admin)
- isActive
- createdAt
- updatedAt

### Posts Table
- id (UUID)
- title
- content
- summary
- featuredImage
- published
- viewCount
- authorId (FK -> Users)
- categoryId (FK -> Categories)
- createdAt
- updatedAt

### Categories Table
- id (UUID)
- name (unique)
- description
- slug
- createdAt
- updatedAt

### Comments Table
- id (UUID)
- content
- authorId (FK -> Users)
- postId (FK -> Posts)
- createdAt
- updatedAt

## Common Issues

### Database Connection Error
- Check MySQL is running
- Verify .env database credentials
- Ensure database exists

### Port Already in Use
- Change PORT in .env
- Or kill process using port 3000

### JWT Token Issues
- Ensure JWT_SECRET is set in .env
- Check token format: `Bearer <token>`
- Verify token hasn't expired

## Project Structure
See `PROJECT_STRUCTURE.md` for detailed directory structure and file explanations.

## Documentation
See `README.md` for complete API documentation and features.

## Contributing
1. Create feature branch
2. Make changes
3. Run tests: `npm run test`
4. Submit pull request

## License
MIT
