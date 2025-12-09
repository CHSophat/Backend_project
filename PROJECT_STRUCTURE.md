# Blog News Backend - Project Structure Overview

## 📁 Complete Directory Structure

```
blog-news-backend/
│
├── src/
│   ├── app.module.ts                    # Root NestJS module
│   ├── main.ts                          # Application entry point
│   │
│   ├── common/                          # Shared utilities, filters, interceptors, pipes
│   │   ├── filters/
│   │   │   └── http-exception.filter.ts    # Global exception filter
│   │   ├── interceptors/
│   │   │   └── transform.interceptor.ts    # Response transformation interceptor
│   │   └── pipes/
│   │       └── parse-uuid.pipe.ts          # UUID validation pipe
│   │
│   ├── config/                          # Configuration files
│   │   └── database.config.ts           # TypeORM database configuration
│   │
│   ├── auth/                            # Authentication & Authorization module
│   │   ├── auth.module.ts               # Auth module definition
│   │   ├── auth.service.ts              # Authentication logic (register, login)
│   │   ├── auth.controller.ts           # Auth endpoints
│   │   ├── strategies/
│   │   │   └── jwt.strategy.ts          # JWT Passport strategy
│   │   ├── guards/
│   │   │   └── jwt-auth.guard.ts        # JWT authentication guard
│   │   └── dto/
│   │       └── login.dto.ts             # Login request DTO
│   │
│   ├── users/                           # User Management module
│   │   ├── users.module.ts              # Users module definition
│   │   ├── users.service.ts             # User business logic
│   │   ├── users.controller.ts          # User endpoints
│   │   ├── entities/
│   │   │   └── user.entity.ts           # User database entity
│   │   └── dto/
│   │       ├── create-user.dto.ts       # Create user request DTO
│   │       └── update-user.dto.ts       # Update user request DTO
│   │
│   ├── posts/                           # Blog/News Posts module
│   │   ├── posts.module.ts              # Posts module definition
│   │   ├── posts.service.ts             # Post business logic
│   │   ├── posts.controller.ts          # Post endpoints
│   │   ├── entities/
│   │   │   └── post.entity.ts           # Post database entity
│   │   └── dto/
│   │       ├── create-post.dto.ts       # Create post request DTO
│   │       └── update-post.dto.ts       # Update post request DTO
│   │
│   ├── categories/                      # Categories for Posts module
│   │   ├── categories.module.ts         # Categories module definition
│   │   ├── categories.service.ts        # Category business logic
│   │   ├── categories.controller.ts     # Category endpoints
│   │   ├── entities/
│   │   │   └── category.entity.ts       # Category database entity
│   │   └── dto/
│   │       ├── create-category.dto.ts   # Create category request DTO
│   │       └── update-category.dto.ts   # Update category request DTO
│   │
│   ├── comments/                        # Comments module
│   │   ├── comments.module.ts           # Comments module definition
│   │   ├── comments.service.ts          # Comment business logic
│   │   ├── comments.controller.ts       # Comment endpoints
│   │   ├── entities/
│   │   │   └── comment.entity.ts        # Comment database entity
│   │   └── dto/
│   │       ├── create-comment.dto.ts    # Create comment request DTO
│   │       └── update-comment.dto.ts    # Update comment request DTO
│   │
│   └── shared/                          # Shared DTOs, interfaces, and constants
│       ├── dto/
│       │   ├── api-response.dto.ts      # Standard API response format
│       │   └── pagination.dto.ts        # Pagination DTO
│       └── interfaces/
│           ├── user.interface.ts        # User interface
│           ├── post.interface.ts        # Post interface
│           ├── category.interface.ts    # Category interface
│           ├── comment.interface.ts     # Comment interface
│           └── jwt-payload.interface.ts # JWT payload interface
│
├── test/                                # Testing folder
│   ├── jest-e2e.json                   # E2E test configuration
│   ├── app.e2e-spec.ts                 # End-to-end tests
│   └── users.service.spec.ts           # Unit tests example
│
├── .env                                 # Environment variables (local)
├── .gitignore                           # Git ignore rules
├── .npmrc                               # NPM configuration
├── package.json                         # Project dependencies & scripts
├── tsconfig.json                        # TypeScript configuration
├── jest.config.js                       # Jest testing configuration
├── README.md                            # Project documentation
└── nest-cli.json                        # NestJS CLI configuration (optional)
```

## 🔑 Key Files Explanation

### Configuration Files
- **package.json**: Contains all dependencies, scripts, and project metadata
- **tsconfig.json**: TypeScript compiler options and path aliases
- **.env**: Environment variables (database, JWT, port)
- **jest.config.js**: Testing framework configuration

### Core Application Files
- **main.ts**: Application bootstrap with global pipes and CORS
- **app.module.ts**: Root module importing all feature modules

### Feature Modules Structure

Each feature module follows this pattern:
```
feature/
├── feature.module.ts      # Module definition & imports
├── feature.service.ts     # Business logic
├── feature.controller.ts  # HTTP endpoints
├── entities/
│   └── feature.entity.ts  # Database model
└── dto/
    ├── create-feature.dto.ts
    └── update-feature.dto.ts
```

## 📊 Database Entities Relationships

```
User (1) ──────────────── (M) Post
  ↓
  └─ (1) ──────────────── (M) Comment

Category (1) ──────────────── (M) Post
```

## 🔐 Authentication Flow

1. User registers via `POST /auth/register`
2. User logs in via `POST /auth/login` → receives JWT token
3. JWT token used in Authorization header for protected routes
4. JwtAuthGuard validates token on protected endpoints

## 📡 API Endpoints

### Authentication
```
POST   /auth/register          # Register new user
POST   /auth/login             # Login user
```

### Users
```
GET    /users                  # Get all users
GET    /users/:id              # Get user by ID
PUT    /users/:id              # Update user (JWT)
DELETE /users/:id              # Delete user (JWT)
```

### Posts
```
GET    /posts                  # Get all posts
GET    /posts?published=true   # Get published posts
GET    /posts/:id              # Get post details
POST   /posts                  # Create post (JWT)
PUT    /posts/:id              # Update post (JWT, author only)
DELETE /posts/:id              # Delete post (JWT, author only)
```

### Categories
```
GET    /categories             # Get all categories
GET    /categories/:id         # Get category details
POST   /categories             # Create category (admin)
PUT    /categories/:id         # Update category (admin)
DELETE /categories/:id         # Delete category (admin)
```

### Comments
```
GET    /posts/:postId/comments           # Get post comments
POST   /posts/:postId/comments           # Add comment (JWT)
GET    /comments/:id                     # Get comment details
PUT    /comments/:id                     # Update comment (JWT, author)
DELETE /comments/:id                     # Delete comment (JWT, author)
```

## 🛠️ Installation & Running

### Install Dependencies
```bash
npm install
```

### Development
```bash
npm run start:dev
```

### Production Build
```bash
npm run build
npm run start:prod
```

### Testing
```bash
npm run test          # Run unit tests
npm run test:watch    # Watch mode
npm run test:cov      # Coverage report
npm run test:e2e      # E2E tests
```

## 📝 Database Setup

1. Create MySQL database:
```sql
CREATE DATABASE blog_news_db;
```

2. Update `.env` with database credentials:
```
DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=your_password
DB_NAME=blog_news_db
```

3. Application will auto-sync tables on startup (development)

## 🔒 Security Features

- JWT authentication with expiration
- Password hashing with bcrypt
- Role-based access control (user/admin)
- Input validation with class-validator
- Exception filtering
- CORS enabled
- UUID validation

## 📦 Key Dependencies

- **@nestjs/core**: NestJS framework core
- **@nestjs/typeorm**: ORM integration
- **typeorm**: SQL ORM
- **mysql2**: MySQL driver
- **@nestjs/jwt**: JWT authentication
- **passport-jwt**: JWT strategy
- **bcrypt**: Password hashing
- **class-validator**: Input validation
- **class-transformer**: DTO transformation

## 🧪 Testing

- Unit tests with Jest
- E2E tests with Supertest
- Mock repositories for services
- 100% module coverage

## 📈 Scalability Features

- Modular architecture (feature-based)
- Service abstraction layer
- Database connection pooling
- JWT token-based stateless auth
- Ready for Docker containerization
