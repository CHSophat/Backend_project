# Blog News Backend API

A powerful NestJS-based backend API for a blog/news platform with user authentication, post management, categories, and comments.

> **Note**: This project uses **SQLite** database. For migration details from MySQL, see [SQLITE_MIGRATION_SUMMARY.md](SQLITE_MIGRATION_SUMMARY.md). For quick start, see [QUICK_START_SQLITE.md](QUICK_START_SQLITE.md).

## Features

- 🔐 JWT Authentication
- 👤 User Management
- 📝 Blog Posts Management
- 📑 Categories System
- 💬 Comments System
- 🛡️ Role-based Access Control
- ✅ Data Validation
- 🗄️ SQLite Database

## Prerequisites

- Node.js (v18+)
- npm or yarn

## Installation

```bash
npm install
```

## Environment Setup

Create a `.env` file in the root directory:

```env
# Database Configuration (SQLite)
DB_PATH=database.sqlite

# JWT Configuration
JWT_SECRET=your_jwt_secret_key
JWT_EXPIRES_IN=7d

# Server Configuration
PORT=3000
NODE_ENV=development
```

## Running the Application

### Development
```bash
npm run start:dev
```

### Production
```bash
npm run build
npm run start:prod
```

## API Endpoints

### Authentication
- `POST /auth/register` - Register new user
- `POST /auth/login` - Login user

### Users
- `GET /users` - Get all users (admin only)
- `GET /users/:id` - Get user by ID
- `PUT /users/:id` - Update user
- `DELETE /users/:id` - Delete user

### Posts
- `GET /posts` - Get all posts
- `GET /posts/:id` - Get post by ID
- `POST /posts` - Create new post (authenticated)
- `PUT /posts/:id` - Update post (author/admin)
- `DELETE /posts/:id` - Delete post (author/admin)

### Categories
- `GET /categories` - Get all categories
- `POST /categories` - Create category (admin)
- `PUT /categories/:id` - Update category (admin)
- `DELETE /categories/:id` - Delete category (admin)

### Comments
- `GET /posts/:postId/comments` - Get comments for post
- `POST /posts/:postId/comments` - Add comment (authenticated)
- `PUT /comments/:id` - Update comment (author)
- `DELETE /comments/:id` - Delete comment (author/admin)

## Testing

```bash
# Unit tests
npm run test

# Watch mode
npm run test:watch

# Coverage
npm run test:cov

# E2E tests
npm run test:e2e
```

## Project Structure

```
src/
├── app.module.ts          # Root module
├── main.ts                # Entry point
├── common/                # Shared utilities, filters, interceptors, pipes
├── config/                # Configuration (database, env variables)
├── auth/                  # Authentication module
├── users/                 # User module
├── posts/                 # Blog/news posts module
├── categories/            # Categories for posts
├── comments/              # Comments module
└── shared/                # Shared DTOs, interfaces, and constants
```

## License

MIT
