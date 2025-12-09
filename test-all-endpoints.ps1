# Test All API Endpoints
# This script tests all GET, POST, PUT, DELETE endpoints

$baseUrl = "http://localhost:3000"
$headers = @{
    "Content-Type" = "application/json"
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Testing Blog News Backend API Endpoints" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Variables to store IDs and tokens
$userId = $null
$token = $null
$postId = $null
$categoryId = $null
$commentId = $null

# ============================================
# 1. AUTH ENDPOINTS (POST)
# ============================================
Write-Host "1. Testing AUTH Endpoints" -ForegroundColor Yellow
Write-Host "----------------------------" -ForegroundColor Yellow

# Register User
Write-Host "POST /auth/register - Register new user" -ForegroundColor Green
$registerBody = @{
    email = "test$(Get-Random)@example.com"
    firstName = "Test"
    lastName = "User"
    password = "SecurePassword123!"
    bio = "Test user biography"
} | ConvertTo-Json

try {
    $registerResponse = Invoke-RestMethod -Uri "$baseUrl/auth/register" -Method Post -Body $registerBody -Headers $headers
    $userId = $registerResponse.id
    Write-Host "✓ Register successful - User ID: $userId" -ForegroundColor Green
} catch {
    Write-Host "✗ Register failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Login User
Write-Host "POST /auth/login - Login user" -ForegroundColor Green
$loginBody = @{
    email = ($registerBody | ConvertFrom-Json).email
    password = "SecurePassword123!"
} | ConvertTo-Json

try {
    $loginResponse = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -Body $loginBody -Headers $headers
    $token = $loginResponse.access_token
    Write-Host "✓ Login successful - Token received" -ForegroundColor Green
} catch {
    Write-Host "✗ Login failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Update headers with auth token
$authHeaders = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $token"
}

# ============================================
# 2. USERS ENDPOINTS
# ============================================
Write-Host "2. Testing USERS Endpoints" -ForegroundColor Yellow
Write-Host "----------------------------" -ForegroundColor Yellow

# GET All Users
Write-Host "GET /users - Get all users" -ForegroundColor Green
try {
    $users = Invoke-RestMethod -Uri "$baseUrl/users" -Method Get -Headers $headers
    Write-Host "✓ Get all users successful - Found $($users.Count) users" -ForegroundColor Green
} catch {
    Write-Host "✗ Get all users failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# GET User by ID
Write-Host "GET /users/:id - Get user by ID" -ForegroundColor Green
try {
    $user = Invoke-RestMethod -Uri "$baseUrl/users/$userId" -Method Get -Headers $headers
    Write-Host "✓ Get user by ID successful - User: $($user.firstName) $($user.lastName)" -ForegroundColor Green
} catch {
    Write-Host "✗ Get user by ID failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# PUT Update User
Write-Host "PUT /users/:id - Update user" -ForegroundColor Green
$updateUserBody = @{
    firstName = "Updated"
    lastName = "Name"
    bio = "Updated biography"
} | ConvertTo-Json

try {
    $updatedUser = Invoke-RestMethod -Uri "$baseUrl/users/$userId" -Method Put -Body $updateUserBody -Headers $authHeaders
    Write-Host "✓ Update user successful - New name: $($updatedUser.firstName) $($updatedUser.lastName)" -ForegroundColor Green
} catch {
    Write-Host "✗ Update user failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# ============================================
# 3. CATEGORIES ENDPOINTS
# ============================================
Write-Host "3. Testing CATEGORIES Endpoints" -ForegroundColor Yellow
Write-Host "----------------------------" -ForegroundColor Yellow

# POST Create Category
Write-Host "POST /categories - Create category" -ForegroundColor Green
$createCategoryBody = @{
    name = "Technology"
    description = "All things technology"
    slug = "technology"
} | ConvertTo-Json

try {
    $category = Invoke-RestMethod -Uri "$baseUrl/categories" -Method Post -Body $createCategoryBody -Headers $authHeaders
    $categoryId = $category.id
    Write-Host "✓ Create category successful - Category ID: $categoryId" -ForegroundColor Green
} catch {
    Write-Host "✗ Create category failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# GET All Categories
Write-Host "GET /categories - Get all categories" -ForegroundColor Green
try {
    $categories = Invoke-RestMethod -Uri "$baseUrl/categories" -Method Get -Headers $headers
    Write-Host "✓ Get all categories successful - Found $($categories.Count) categories" -ForegroundColor Green
} catch {
    Write-Host "✗ Get all categories failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# GET Category by ID
Write-Host "GET /categories/:id - Get category by ID" -ForegroundColor Green
try {
    $category = Invoke-RestMethod -Uri "$baseUrl/categories/$categoryId" -Method Get -Headers $headers
    Write-Host "✓ Get category by ID successful - Category: $($category.name)" -ForegroundColor Green
} catch {
    Write-Host "✗ Get category by ID failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# PUT Update Category
Write-Host "PUT /categories/:id - Update category" -ForegroundColor Green
$updateCategoryBody = @{
    description = "Updated technology description"
} | ConvertTo-Json

try {
    $updatedCategory = Invoke-RestMethod -Uri "$baseUrl/categories/$categoryId" -Method Put -Body $updateCategoryBody -Headers $authHeaders
    Write-Host "✓ Update category successful" -ForegroundColor Green
} catch {
    Write-Host "✗ Update category failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# ============================================
# 4. POSTS ENDPOINTS
# ============================================
Write-Host "4. Testing POSTS Endpoints" -ForegroundColor Yellow
Write-Host "----------------------------" -ForegroundColor Yellow

# POST Create Post
Write-Host "POST /posts - Create post" -ForegroundColor Green
$createPostBody = @{
    title = "Test Blog Post"
    content = "This is the content of the test blog post"
    summary = "Test summary"
    featuredImage = "https://example.com/image.jpg"
    published = $true
    categoryId = $categoryId
} | ConvertTo-Json

try {
    $post = Invoke-RestMethod -Uri "$baseUrl/posts" -Method Post -Body $createPostBody -Headers $authHeaders
    $postId = $post.id
    Write-Host "✓ Create post successful - Post ID: $postId" -ForegroundColor Green
} catch {
    Write-Host "✗ Create post failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# GET All Posts
Write-Host "GET /posts - Get all posts" -ForegroundColor Green
try {
    $posts = Invoke-RestMethod -Uri "$baseUrl/posts" -Method Get -Headers $headers
    Write-Host "✓ Get all posts successful - Found $($posts.Count) posts" -ForegroundColor Green
} catch {
    Write-Host "✗ Get all posts failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# GET Posts with filter
Write-Host "GET /posts?published=true - Get published posts" -ForegroundColor Green
try {
    $publishedPosts = Invoke-RestMethod -Uri "$baseUrl/posts?published=true" -Method Get -Headers $headers
    Write-Host "✓ Get published posts successful - Found $($publishedPosts.Count) posts" -ForegroundColor Green
} catch {
    Write-Host "✗ Get published posts failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# GET Post by ID
Write-Host "GET /posts/:id - Get post by ID" -ForegroundColor Green
try {
    $post = Invoke-RestMethod -Uri "$baseUrl/posts/$postId" -Method Get -Headers $headers
    Write-Host "✓ Get post by ID successful - Post: $($post.title)" -ForegroundColor Green
} catch {
    Write-Host "✗ Get post by ID failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# PUT Update Post
Write-Host "PUT /posts/:id - Update post" -ForegroundColor Green
$updatePostBody = @{
    title = "Updated Blog Post Title"
    content = "Updated content"
} | ConvertTo-Json

try {
    $updatedPost = Invoke-RestMethod -Uri "$baseUrl/posts/$postId" -Method Put -Body $updatePostBody -Headers $authHeaders
    Write-Host "✓ Update post successful - New title: $($updatedPost.title)" -ForegroundColor Green
} catch {
    Write-Host "✗ Update post failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# ============================================
# 5. COMMENTS ENDPOINTS
# ============================================
Write-Host "5. Testing COMMENTS Endpoints" -ForegroundColor Yellow
Write-Host "----------------------------" -ForegroundColor Yellow

# POST Create Comment
Write-Host "POST /posts/:postId/comments - Create comment" -ForegroundColor Green
$createCommentBody = @{
    content = "This is a test comment"
} | ConvertTo-Json

try {
    $comment = Invoke-RestMethod -Uri "$baseUrl/posts/$postId/comments" -Method Post -Body $createCommentBody -Headers $authHeaders
    $commentId = $comment.id
    Write-Host "✓ Create comment successful - Comment ID: $commentId" -ForegroundColor Green
} catch {
    Write-Host "✗ Create comment failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# GET Post Comments
Write-Host "GET /posts/:postId/comments - Get post comments" -ForegroundColor Green
try {
    $comments = Invoke-RestMethod -Uri "$baseUrl/posts/$postId/comments" -Method Get -Headers $headers
    Write-Host "✓ Get post comments successful - Found $($comments.Count) comments" -ForegroundColor Green
} catch {
    Write-Host "✗ Get post comments failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# GET Comment by ID
Write-Host "GET /comments/:id - Get comment by ID" -ForegroundColor Green
try {
    $comment = Invoke-RestMethod -Uri "$baseUrl/comments/$commentId" -Method Get -Headers $headers
    Write-Host "✓ Get comment by ID successful - Comment: $($comment.content)" -ForegroundColor Green
} catch {
    Write-Host "✗ Get comment by ID failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# PUT Update Comment
Write-Host "PUT /comments/:id - Update comment" -ForegroundColor Green
$updateCommentBody = @{
    content = "Updated comment text"
} | ConvertTo-Json

try {
    $updatedComment = Invoke-RestMethod -Uri "$baseUrl/comments/$commentId" -Method Put -Body $updateCommentBody -Headers $authHeaders
    Write-Host "✓ Update comment successful - New content: $($updatedComment.content)" -ForegroundColor Green
} catch {
    Write-Host "✗ Update comment failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# ============================================
# 6. DELETE ENDPOINTS
# ============================================
Write-Host "6. Testing DELETE Endpoints" -ForegroundColor Yellow
Write-Host "----------------------------" -ForegroundColor Yellow

# DELETE Comment
Write-Host "DELETE /comments/:id - Delete comment" -ForegroundColor Green
try {
    Invoke-RestMethod -Uri "$baseUrl/comments/$commentId" -Method Delete -Headers $authHeaders
    Write-Host "✓ Delete comment successful" -ForegroundColor Green
} catch {
    Write-Host "✗ Delete comment failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# DELETE Post
Write-Host "DELETE /posts/:id - Delete post" -ForegroundColor Green
try {
    Invoke-RestMethod -Uri "$baseUrl/posts/$postId" -Method Delete -Headers $authHeaders
    Write-Host "✓ Delete post successful" -ForegroundColor Green
} catch {
    Write-Host "✗ Delete post failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# DELETE Category
Write-Host "DELETE /categories/:id - Delete category" -ForegroundColor Green
try {
    Invoke-RestMethod -Uri "$baseUrl/categories/$categoryId" -Method Delete -Headers $authHeaders
    Write-Host "✓ Delete category successful" -ForegroundColor Green
} catch {
    Write-Host "✗ Delete category failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# DELETE User
Write-Host "DELETE /users/:id - Delete user" -ForegroundColor Green
try {
    Invoke-RestMethod -Uri "$baseUrl/users/$userId" -Method Delete -Headers $authHeaders
    Write-Host "✓ Delete user successful" -ForegroundColor Green
} catch {
    Write-Host "✗ Delete user failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# ============================================
# SUMMARY
# ============================================
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Testing Complete!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
