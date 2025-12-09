# Quick Start Guide - SQLite Version

## Installation
```bash
yarn install
```

## Running the Application

### Development (with hot-reload)
```bash
yarn start:dev
```
The server will start on `http://localhost:3000`

### Production
```bash
yarn build
yarn start:prod
```

## Database
- **Type**: SQLite (sql.js)
- **File**: `database.sqlite` (auto-created on first run)
- **Location**: Project root directory

## API Endpoints

### Authentication
- **POST** `/auth/register` - Register new user
- **POST** `/auth/login` - Login user

### Users
- **GET** `/users` - Get all users
- **GET** `/users/:id` - Get user by ID
- **PUT** `/users/:id` - Update user
- **DELETE** `/users/:id` - Delete user

### Posts
- **GET** `/posts` - Get all posts
- **GET** `/posts/:id` - Get post by ID
- **POST** `/posts` - Create new post
- **PUT** `/posts/:id` - Update post
- **DELETE** `/posts/:id` - Delete post

### Categories
- **GET** `/categories` - Get all categories
- **POST** `/categories` - Create category
- **PUT** `/categories/:id` - Update category
- **DELETE** `/categories/:id` - Delete category

### Comments
- **GET** `/posts/:postId/comments` - Get comments for post
- **POST** `/posts/:postId/comments` - Add comment
- **PUT** `/comments/:id` - Update comment
- **DELETE** `/comments/:id` - Delete comment

## Environment Variables
Create a `.env` file in the root directory:
```env
DB_PATH=database.sqlite
JWT_SECRET=your_super_secret_jwt_key_change_this_in_production
JWT_EXPIRES_IN=7d
PORT=3000
NODE_ENV=development
```

## Testing
```bash
# Unit tests
yarn test

# Watch mode
yarn test:watch

# Coverage
yarn test:cov

# E2E tests
yarn test:e2e
```

## Common Commands
```bash
# Format code
yarn format

# Lint code
yarn lint

# Build for production
yarn build

# Clean build
yarn prebuild
```

## Troubleshooting

### Database not created
- Make sure you have write permissions in the project directory
- Check that `DB_PATH` in `.env` is set correctly

### Port already in use
- Change `PORT` in `.env` file
- Or stop the process using port 3000

### Build errors
- Run `yarn install` to ensure all dependencies are installed
- Delete `node_modules` and `yarn.lock`, then run `yarn install` again

## Features
✅ JWT Authentication
✅ User Management
✅ Blog Posts Management
✅ Categories System
✅ Comments System
✅ Role-based Access Control
✅ Data Validation
✅ SQLite Database

## Support
For more details, see:
- `SQLITE_MIGRATION_SUMMARY.md` - Complete migration details
- `README.md` - General project information
- `API_DOCUMENTATION.md` - Detailed API documentation
