# API Testing Script
$baseUrl = "http://localhost:3000"

Write-Host ""
Write-Host "========================================"
Write-Host "Testing Blog News Backend API"
Write-Host "========================================"
Write-Host ""

# Test counter
$passed = 0
$failed = 0

function Test-Endpoint {
    param(
        [string]$Method,
        [string]$Url,
        [string]$Description,
        [hashtable]$Headers = @{"Content-Type"="application/json"},
        [string]$Body = $null
    )
    
    Write-Host "$Method $Url" -ForegroundColor Yellow
    Write-Host "  $Description" -ForegroundColor Gray
    
    try {
        $params = @{
            Uri = $Url
            Method = $Method
            Headers = $Headers
        }
        
        if ($Body) {
            $params.Body = $Body
        }
        
        $response = Invoke-RestMethod @params
        Write-Host "  PASS" -ForegroundColor Green
        $script:passed++
        return $response
    }
    catch {
        Write-Host "  FAIL: $($_.Exception.Message)" -ForegroundColor Red
        $script:failed++
        return $null
    }
    finally {
        Write-Host ""
    }
}

# Variables
$email = "test$(Get-Random)@example.com"
$password = "SecurePassword123!"
$token = $null
$userId = $null
$categoryId = $null
$postId = $null
$commentId = $null

# AUTH TESTS
Write-Host "1. AUTHENTICATION ENDPOINTS" -ForegroundColor Magenta
Write-Host "----------------------------" -ForegroundColor Magenta
Write-Host ""

# Register
$registerBody = @{
    email = $email
    firstName = "Test"
    lastName = "User"
    password = $password
    bio = "Test bio"
} | ConvertTo-Json

$registerResult = Test-Endpoint -Method "POST" -Url "$baseUrl/auth/register" -Description "Register new user" -Body $registerBody
if ($registerResult) {
    $userId = $registerResult.id
}

# Login
$loginBody = @{
    email = $email
    password = $password
} | ConvertTo-Json

$loginResult = Test-Endpoint -Method "POST" -Url "$baseUrl/auth/login" -Description "Login user" -Body $loginBody
if ($loginResult) {
    $token = $loginResult.access_token
}

$authHeaders = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $token"
}

# USER TESTS
Write-Host "2. USER ENDPOINTS" -ForegroundColor Magenta
Write-Host "----------------------------" -ForegroundColor Magenta
Write-Host ""

Test-Endpoint -Method "GET" -Url "$baseUrl/users" -Description "Get all users"
Test-Endpoint -Method "GET" -Url "$baseUrl/users/$userId" -Description "Get user by ID"

$updateUserBody = @{
    firstName = "Updated"
    lastName = "Name"
} | ConvertTo-Json

Test-Endpoint -Method "PUT" -Url "$baseUrl/users/$userId" -Description "Update user" -Headers $authHeaders -Body $updateUserBody

# CATEGORY TESTS
Write-Host "3. CATEGORY ENDPOINTS" -ForegroundColor Magenta
Write-Host "----------------------------" -ForegroundColor Magenta
Write-Host ""

$createCategoryBody = @{
    name = "Technology"
    description = "Tech articles"
    slug = "technology"
} | ConvertTo-Json

$categoryResult = Test-Endpoint -Method "POST" -Url "$baseUrl/categories" -Description "Create category" -Body $createCategoryBody
if ($categoryResult) {
    $categoryId = $categoryResult.id
}

Test-Endpoint -Method "GET" -Url "$baseUrl/categories" -Description "Get all categories"
Test-Endpoint -Method "GET" -Url "$baseUrl/categories/$categoryId" -Description "Get category by ID"

$updateCategoryBody = @{
    description = "Updated description"
} | ConvertTo-Json

Test-Endpoint -Method "PUT" -Url "$baseUrl/categories/$categoryId" -Description "Update category" -Headers $authHeaders -Body $updateCategoryBody

# POST TESTS
Write-Host "4. POST ENDPOINTS" -ForegroundColor Magenta
Write-Host "----------------------------" -ForegroundColor Magenta
Write-Host ""

$createPostBody = @{
    title = "Test Post"
    content = "Test content"
    summary = "Test summary"
    published = $true
    categoryId = $categoryId
} | ConvertTo-Json

$postResult = Test-Endpoint -Method "POST" -Url "$baseUrl/posts" -Description "Create post" -Headers $authHeaders -Body $createPostBody
if ($postResult) {
    $postId = $postResult.id
}

Test-Endpoint -Method "GET" -Url "$baseUrl/posts" -Description "Get all posts"
Test-Endpoint -Method "GET" -Url "$baseUrl/posts?published=true" -Description "Get published posts"
Test-Endpoint -Method "GET" -Url "$baseUrl/posts/$postId" -Description "Get post by ID"

$updatePostBody = @{
    title = "Updated Post Title"
} | ConvertTo-Json

Test-Endpoint -Method "PUT" -Url "$baseUrl/posts/$postId" -Description "Update post" -Headers $authHeaders -Body $updatePostBody

# COMMENT TESTS
Write-Host "5. COMMENT ENDPOINTS" -ForegroundColor Magenta
Write-Host "----------------------------" -ForegroundColor Magenta
Write-Host ""

$createCommentBody = @{
    content = "Test comment"
} | ConvertTo-Json

$commentResult = Test-Endpoint -Method "POST" -Url "$baseUrl/posts/$postId/comments" -Description "Create comment" -Headers $authHeaders -Body $createCommentBody
if ($commentResult) {
    $commentId = $commentResult.id
}

Test-Endpoint -Method "GET" -Url "$baseUrl/posts/$postId/comments" -Description "Get post comments"
Test-Endpoint -Method "GET" -Url "$baseUrl/comments/$commentId" -Description "Get comment by ID"

$updateCommentBody = @{
    content = "Updated comment"
} | ConvertTo-Json

Test-Endpoint -Method "PUT" -Url "$baseUrl/comments/$commentId" -Description "Update comment" -Headers $authHeaders -Body $updateCommentBody

# DELETE TESTS
Write-Host "6. DELETE ENDPOINTS" -ForegroundColor Magenta
Write-Host "----------------------------" -ForegroundColor Magenta
Write-Host ""

Test-Endpoint -Method "DELETE" -Url "$baseUrl/comments/$commentId" -Description "Delete comment" -Headers $authHeaders
Test-Endpoint -Method "DELETE" -Url "$baseUrl/posts/$postId" -Description "Delete post" -Headers $authHeaders
Test-Endpoint -Method "DELETE" -Url "$baseUrl/categories/$categoryId" -Description "Delete category" -Headers $authHeaders
Test-Endpoint -Method "DELETE" -Url "$baseUrl/users/$userId" -Description "Delete user" -Headers $authHeaders

# SUMMARY
Write-Host "========================================"
Write-Host "TEST SUMMARY"
Write-Host "========================================"
Write-Host "Passed: $passed" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor Red
Write-Host "Total:  $($passed + $failed)" -ForegroundColor White
Write-Host "========================================"
Write-Host ""
