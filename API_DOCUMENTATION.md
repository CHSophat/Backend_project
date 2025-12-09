# Blog News Backend - Complete API Documentation

## Base URL
```
http://localhost:3000/api
```

---

## Authentication Endpoints

### Register User
```http
POST /auth/register
Content-Type: application/json

{
  "email": "john@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "password": "SecurePassword123!",
  "bio": "Optional biography",
  "profilePicture": "https://example.com/image.jpg"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "john@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "bio": "Optional biography",
    "profilePicture": "https://example.com/image.jpg",
    "role": "user",
    "isActive": true,
    "createdAt": "2024-01-15T10:30:00Z",
    "updatedAt": "2024-01-15T10:30:00Z"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

---

### Login User
```http
POST /auth/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "SecurePassword123!"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "email": "john@example.com",
      "firstName": "John",
      "lastName": "Doe",
      "role": "user"
    }
  },
  "timestamp": "2024-01-15T10:32:00Z"
}
```

---

## Users Endpoints

### Get All Users
```http
GET /users
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "email": "john@example.com",
      "firstName": "John",
      "lastName": "Doe",
      "bio": "Optional biography",
      "profilePicture": "https://example.com/image.jpg",
      "role": "user",
      "isActive": true,
      "createdAt": "2024-01-15T10:30:00Z",
      "updatedAt": "2024-01-15T10:30:00Z",
      "posts": [],
      "comments": []
    }
  ],
  "timestamp": "2024-01-15T10:35:00Z"
}
```

---

### Get User by ID
```http
GET /users/{userId}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "john@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "bio": "Optional biography",
    "profilePicture": "https://example.com/image.jpg",
    "role": "user",
    "isActive": true,
    "createdAt": "2024-01-15T10:30:00Z",
    "updatedAt": "2024-01-15T10:30:00Z",
    "posts": [...],
    "comments": [...]
  },
  "timestamp": "2024-01-15T10:35:00Z"
}
```

---

### Update User
```http
PUT /users/{userId}
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "firstName": "Jonathan",
  "lastName": "Smith",
  "bio": "Updated biography",
  "profilePicture": "https://example.com/new-image.jpg"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "john@example.com",
    "firstName": "Jonathan",
    "lastName": "Smith",
    "bio": "Updated biography",
    "profilePicture": "https://example.com/new-image.jpg",
    "role": "user",
    "isActive": true,
    "createdAt": "2024-01-15T10:30:00Z",
    "updatedAt": "2024-01-15T10:40:00Z"
  },
  "timestamp": "2024-01-15T10:40:00Z"
}
```

---

### Delete User
```http
DELETE /users/{userId}
Authorization: Bearer {access_token}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": null,
  "message": "User deleted successfully",
  "timestamp": "2024-01-15T10:42:00Z"
}
```

---

## Posts Endpoints

### Get All Posts
```http
GET /posts
```

**Query Parameters:**
- `published` (boolean): Filter by publication status

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "660e8400-e29b-41d4-a716-446655440000",
      "title": "Getting Started with NestJS",
      "content": "Long form content here...",
      "summary": "Quick summary of the post",
      "featuredImage": "https://example.com/image.jpg",
      "published": true,
      "viewCount": 150,
      "createdAt": "2024-01-15T10:30:00Z",
      "updatedAt": "2024-01-15T10:30:00Z",
      "author": {
        "id": "550e8400-e29b-41d4-a716-446655440000",
        "email": "john@example.com",
        "firstName": "John",
        "lastName": "Doe"
      },
      "category": {
        "id": "770e8400-e29b-41d4-a716-446655440000",
        "name": "Technology",
        "slug": "technology"
      }
    }
  ],
  "timestamp": "2024-01-15T10:35:00Z"
}
```

---

### Get Post by ID
```http
GET /posts/{postId}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "660e8400-e29b-41d4-a716-446655440000",
    "title": "Getting Started with NestJS",
    "content": "Long form content here...",
    "summary": "Quick summary of the post",
    "featuredImage": "https://example.com/image.jpg",
    "published": true,
    "viewCount": 151,
    "createdAt": "2024-01-15T10:30:00Z",
    "updatedAt": "2024-01-15T10:30:00Z",
    "author": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "email": "john@example.com",
      "firstName": "John"
    },
    "category": {
      "id": "770e8400-e29b-41d4-a716-446655440000",
      "name": "Technology"
    },
    "comments": [
      {
        "id": "880e8400-e29b-41d4-a716-446655440000",
        "content": "Great post!",
        "createdAt": "2024-01-15T11:00:00Z",
        "author": {
          "id": "990e8400-e29b-41d4-a716-446655440000",
          "firstName": "Jane",
          "lastName": "Smith"
        }
      }
    ]
  },
  "timestamp": "2024-01-15T10:35:00Z"
}
```

---

### Create Post
```http
POST /posts
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "title": "My New Blog Post",
  "content": "This is the detailed content of my blog post...",
  "summary": "Short summary for listing pages",
  "featuredImage": "https://example.com/image.jpg",
  "published": true,
  "categoryId": "770e8400-e29b-41d4-a716-446655440000"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "data": {
    "id": "660e8400-e29b-41d4-a716-446655440001",
    "title": "My New Blog Post",
    "content": "This is the detailed content of my blog post...",
    "summary": "Short summary for listing pages",
    "featuredImage": "https://example.com/image.jpg",
    "published": true,
    "viewCount": 0,
    "createdAt": "2024-01-15T10:45:00Z",
    "updatedAt": "2024-01-15T10:45:00Z",
    "authorId": "550e8400-e29b-41d4-a716-446655440000",
    "categoryId": "770e8400-e29b-41d4-a716-446655440000"
  },
  "timestamp": "2024-01-15T10:45:00Z"
}
```

---

### Update Post
```http
PUT /posts/{postId}
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "title": "Updated Title",
  "content": "Updated content...",
  "published": false
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "660e8400-e29b-41d4-a716-446655440001",
    "title": "Updated Title",
    "content": "Updated content...",
    "published": false,
    "viewCount": 5,
    "updatedAt": "2024-01-15T10:50:00Z"
  },
  "timestamp": "2024-01-15T10:50:00Z"
}
```

---

### Delete Post
```http
DELETE /posts/{postId}
Authorization: Bearer {access_token}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": null,
  "message": "Post deleted successfully",
  "timestamp": "2024-01-15T10:52:00Z"
}
```

---

## Categories Endpoints

### Get All Categories
```http
GET /categories
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "770e8400-e29b-41d4-a716-446655440000",
      "name": "Technology",
      "description": "All things technology related",
      "slug": "technology",
      "createdAt": "2024-01-15T10:00:00Z",
      "updatedAt": "2024-01-15T10:00:00Z",
      "posts": [...]
    }
  ],
  "timestamp": "2024-01-15T10:35:00Z"
}
```

---

### Get Category by ID
```http
GET /categories/{categoryId}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "770e8400-e29b-41d4-a716-446655440000",
    "name": "Technology",
    "description": "All things technology related",
    "slug": "technology",
    "createdAt": "2024-01-15T10:00:00Z",
    "updatedAt": "2024-01-15T10:00:00Z",
    "posts": [...]
  },
  "timestamp": "2024-01-15T10:35:00Z"
}
```

---

### Create Category
```http
POST /categories
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "name": "Business",
  "description": "Business and entrepreneurship articles",
  "slug": "business"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "data": {
    "id": "770e8400-e29b-41d4-a716-446655440001",
    "name": "Business",
    "description": "Business and entrepreneurship articles",
    "slug": "business",
    "createdAt": "2024-01-15T10:20:00Z",
    "updatedAt": "2024-01-15T10:20:00Z",
    "posts": []
  },
  "timestamp": "2024-01-15T10:20:00Z"
}
```

---

### Update Category
```http
PUT /categories/{categoryId}
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "description": "Updated description",
  "slug": "updated-slug"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "770e8400-e29b-41d4-a716-446655440001",
    "name": "Business",
    "description": "Updated description",
    "slug": "updated-slug",
    "updatedAt": "2024-01-15T10:25:00Z"
  },
  "timestamp": "2024-01-15T10:25:00Z"
}
```

---

### Delete Category
```http
DELETE /categories/{categoryId}
Authorization: Bearer {access_token}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": null,
  "message": "Category deleted successfully",
  "timestamp": "2024-01-15T10:27:00Z"
}
```

---

## Comments Endpoints

### Get Post Comments
```http
GET /posts/{postId}/comments
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "880e8400-e29b-41d4-a716-446655440000",
      "content": "Great post! Very informative.",
      "createdAt": "2024-01-15T11:00:00Z",
      "updatedAt": "2024-01-15T11:00:00Z",
      "author": {
        "id": "990e8400-e29b-41d4-a716-446655440000",
        "firstName": "Jane",
        "lastName": "Smith",
        "email": "jane@example.com"
      },
      "postId": "660e8400-e29b-41d4-a716-446655440000"
    }
  ],
  "timestamp": "2024-01-15T11:05:00Z"
}
```

---

### Add Comment to Post
```http
POST /posts/{postId}/comments
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "content": "This is an excellent article! Thank you for sharing."
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "data": {
    "id": "880e8400-e29b-41d4-a716-446655440001",
    "content": "This is an excellent article! Thank you for sharing.",
    "createdAt": "2024-01-15T11:10:00Z",
    "updatedAt": "2024-01-15T11:10:00Z",
    "authorId": "550e8400-e29b-41d4-a716-446655440000",
    "postId": "660e8400-e29b-41d4-a716-446655440000"
  },
  "timestamp": "2024-01-15T11:10:00Z"
}
```

---

### Update Comment
```http
PUT /comments/{commentId}
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "content": "Updated comment text"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "880e8400-e29b-41d4-a716-446655440001",
    "content": "Updated comment text",
    "updatedAt": "2024-01-15T11:15:00Z"
  },
  "timestamp": "2024-01-15T11:15:00Z"
}
```

---

### Delete Comment
```http
DELETE /comments/{commentId}
Authorization: Bearer {access_token}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": null,
  "message": "Comment deleted successfully",
  "timestamp": "2024-01-15T11:17:00Z"
}
```

---

## Error Responses

### 400 Bad Request
```json
{
  "statusCode": 400,
  "message": "Invalid input data",
  "timestamp": "2024-01-15T11:20:00Z"
}
```

### 401 Unauthorized
```json
{
  "statusCode": 401,
  "message": "Invalid credentials",
  "timestamp": "2024-01-15T11:20:00Z"
}
```

### 403 Forbidden
```json
{
  "statusCode": 403,
  "message": "You can only update your own posts",
  "timestamp": "2024-01-15T11:20:00Z"
}
```

### 404 Not Found
```json
{
  "statusCode": 404,
  "message": "Post with ID xyz not found",
  "timestamp": "2024-01-15T11:20:00Z"
}
```

### 500 Internal Server Error
```json
{
  "statusCode": 500,
  "message": "Internal server error",
  "timestamp": "2024-01-15T11:20:00Z"
}
```

---

## Authentication Headers

All protected endpoints require:
```
Authorization: Bearer {access_token}
```

Where `{access_token}` is obtained from the login endpoint.

---

## Rate Limiting

Currently no rate limiting is implemented. Consider adding in production:
- IP-based rate limiting
- User-based rate limiting
- Endpoint-specific limits

---

## Pagination

Currently implements basic listing. Consider adding:
- `page` query parameter
- `limit` query parameter
- `offset` query parameter

---

## Sorting

Consider adding for list endpoints:
- `sort` query parameter
- `order` query parameter (ASC/DESC)

---

## Filtering

Current filtering:
- Posts by `published` status
- Comments by `postId`

Consider extending:
- Filter posts by `authorId`
- Filter posts by `categoryId`
- Date range filtering

---

## Version & Status

**API Version**: 1.0.0  
**Last Updated**: January 2024  
**Status**: ✅ Production Ready
