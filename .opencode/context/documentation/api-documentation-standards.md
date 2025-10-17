# API Documentation Standards

Best practices for creating comprehensive, developer-friendly API documentation using OpenAPI/Swagger.

## OpenAPI Specification Standards

### OpenAPI 3.1 Structure
**ALWAYS** follow this structure:
```yaml
openapi: 3.1.0
info:
  title: My API
  version: 1.0.0
  description: Clear, concise API description
  contact:
    name: API Support
    email: api@example.com
  license:
    name: MIT
    url: https://opensource.org/licenses/MIT

servers:
  - url: https://api.example.com/v1
    description: Production server
  - url: https://staging-api.example.com/v1
    description: Staging server

paths:
  /users:
    get:
      summary: List users
      description: Retrieve a paginated list of users
      operationId: listUsers
      tags: [Users]
      parameters: [...]
      responses: [...]
      
components:
  schemas: [...]
  securitySchemes: [...]
```

### Schema Definitions
**CREATE** reusable schemas:
```yaml
components:
  schemas:
    User:
      type: object
      required:
        - id
        - email
        - name
      properties:
        id:
          type: string
          format: uuid
          description: Unique user identifier
          example: "550e8400-e29b-41d4-a716-446655440000"
        email:
          type: string
          format: email
          description: User's email address
          example: "user@example.com"
        name:
          type: string
          minLength: 1
          maxLength: 100
          description: User's full name
          example: "John Doe"
        role:
          type: string
          enum: [user, admin, moderator]
          default: user
          description: User's role in the system
        created_at:
          type: string
          format: date-time
          description: Account creation timestamp
          example: "2024-10-17T20:30:00Z"
```

### Endpoint Documentation
**DOCUMENT** every endpoint completely:
```yaml
paths:
  /users:
    post:
      summary: Create user
      description: |
        Create a new user account. Email must be unique.
        
        **Rate Limit**: 100 requests per hour
        
        **Scopes Required**: `users:write`
      operationId: createUser
      tags: [Users]
      security:
        - bearerAuth: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateUserRequest'
            examples:
              basic:
                summary: Basic user
                value:
                  email: "user@example.com"
                  name: "John Doe"
              admin:
                summary: Admin user
                value:
                  email: "admin@example.com"
                  name: "Jane Admin"
                  role: "admin"
      responses:
        '201':
          description: User created successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
              example:
                id: "550e8400-e29b-41d4-a716-446655440000"
                email: "user@example.com"
                name: "John Doe"
                role: "user"
                created_at: "2024-10-17T20:30:00Z"
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
              example:
                error: "validation_error"
                message: "Invalid email format"
                field: "email"
        '409':
          description: Email already exists
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
        '401':
          $ref: '#/components/responses/UnauthorizedError'
        '429':
          $ref: '#/components/responses/RateLimitError'
```

### Authentication Documentation
**DOCUMENT** all security schemes:
```yaml
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
      description: |
        JWT token obtained from /auth/token endpoint.
        
        **Format**: `Authorization: Bearer YOUR_TOKEN`
        
        **Expiration**: 1 hour
        
        **Refresh**: Use /auth/refresh endpoint before expiration
    
    apiKey:
      type: apiKey
      in: header
      name: X-API-Key
      description: |
        API key for server-to-server authentication.
        
        **Obtain**: Generate from dashboard at https://dashboard.example.com
        
        **Format**: `X-API-Key: your_api_key_here`
        
        **Rate Limits**: 10,000 requests per hour
```

## Code Examples Standards

### Multi-Language Examples
**PROVIDE** examples in multiple languages:

#### JavaScript/TypeScript
```javascript
// Using fetch (Node.js 18+ or browser)
const response = await fetch('https://api.example.com/v1/users', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${token}`
  },
  body: JSON.stringify({
    email: 'user@example.com',
    name: 'John Doe'
  })
});

if (!response.ok) {
  const error = await response.json();
  throw new Error(`API error: ${error.message}`);
}

const user = await response.json();
console.log('Created user:', user.id);

// Using axios
import axios from 'axios';

try {
  const { data } = await axios.post(
    'https://api.example.com/v1/users',
    {
      email: 'user@example.com',
      name: 'John Doe'
    },
    {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    }
  );
  console.log('Created user:', data.id);
} catch (error) {
  if (error.response) {
    console.error('API error:', error.response.data.message);
  } else {
    console.error('Network error:', error.message);
  }
}
```

#### Python
```python
import requests

# Using requests library
url = 'https://api.example.com/v1/users'
headers = {
    'Content-Type': 'application/json',
    'Authorization': f'Bearer {token}'
}
data = {
    'email': 'user@example.com',
    'name': 'John Doe'
}

try:
    response = requests.post(url, json=data, headers=headers)
    response.raise_for_status()
    user = response.json()
    print(f'Created user: {user["id"]}')
except requests.exceptions.HTTPError as e:
    error = e.response.json()
    print(f'API error: {error["message"]}')
except requests.exceptions.RequestException as e:
    print(f'Network error: {e}')
```

#### cURL
```bash
# Basic request
curl -X POST https://api.example.com/v1/users \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "email": "user@example.com",
    "name": "John Doe"
  }'

# With error handling and jq for JSON parsing
response=$(curl -s -w "\n%{http_code}" -X POST \
  https://api.example.com/v1/users \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "email": "user@example.com",
    "name": "John Doe"
  }')

body=$(echo "$response" | head -n -1)
status=$(echo "$response" | tail -n 1)

if [ $status -eq 201 ]; then
  user_id=$(echo "$body" | jq -r '.id')
  echo "Created user: $user_id"
else
  error=$(echo "$body" | jq -r '.message')
  echo "Error: $error"
  exit 1
fi
```

#### Go
```go
package main

import (
    "bytes"
    "encoding/json"
    "fmt"
    "net/http"
)

type CreateUserRequest struct {
    Email string `json:"email"`
    Name  string `json:"name"`
}

type User struct {
    ID        string `json:"id"`
    Email     string `json:"email"`
    Name      string `json:"name"`
    Role      string `json:"role"`
    CreatedAt string `json:"created_at"`
}

func createUser(token string) (*User, error) {
    url := "https://api.example.com/v1/users"
    
    payload := CreateUserRequest{
        Email: "user@example.com",
        Name:  "John Doe",
    }
    
    jsonData, err := json.Marshal(payload)
    if err != nil {
        return nil, fmt.Errorf("marshal error: %w", err)
    }
    
    req, err := http.NewRequest("POST", url, bytes.NewBuffer(jsonData))
    if err != nil {
        return nil, fmt.Errorf("request creation error: %w", err)
    }
    
    req.Header.Set("Content-Type", "application/json")
    req.Header.Set("Authorization", "Bearer "+token)
    
    client := &http.Client{}
    resp, err := client.Do(req)
    if err != nil {
        return nil, fmt.Errorf("request error: %w", err)
    }
    defer resp.Body.Close()
    
    if resp.StatusCode != http.StatusCreated {
        var apiError struct {
            Message string `json:"message"`
        }
        json.NewDecoder(resp.Body).Decode(&apiError)
        return nil, fmt.Errorf("API error: %s", apiError.Message)
    }
    
    var user User
    if err := json.NewDecoder(resp.Body).Decode(&user); err != nil {
        return nil, fmt.Errorf("decode error: %w", err)
    }
    
    return &user, nil
}
```

## Error Documentation Standards

### Error Response Format
**STANDARDIZE** error responses:
```yaml
components:
  schemas:
    Error:
      type: object
      required:
        - error
        - message
      properties:
        error:
          type: string
          description: Machine-readable error code
          example: "validation_error"
        message:
          type: string
          description: Human-readable error message
          example: "Invalid email format"
        field:
          type: string
          description: Field that caused the error (for validation errors)
          example: "email"
        details:
          type: object
          description: Additional error context
        request_id:
          type: string
          description: Request ID for support
          example: "req_1234567890"
```

### Error Catalog
**DOCUMENT** all error codes:

```markdown
## Error Codes

### Authentication Errors (401)

#### `invalid_token`
**Message**: "Authentication token is invalid or expired"

**Cause**: JWT token is malformed, expired, or revoked

**Solution**:
1. Verify token format is correct
2. Check token expiration time
3. Obtain a new token from /auth/token
4. Ensure token is not revoked

**Example**:
```javascript
// Check token expiration before use
const tokenPayload = JSON.parse(atob(token.split('.')[1]));
if (tokenPayload.exp * 1000 < Date.now()) {
  // Token expired, refresh it
  token = await refreshToken();
}
```

#### `missing_token`
**Message**: "Authentication token is required"

**Cause**: No Authorization header provided

**Solution**: Include Bearer token in Authorization header

**Example**:
```javascript
headers: {
  'Authorization': `Bearer ${token}`
}
```

### Validation Errors (400)

#### `validation_error`
**Message**: Varies by field

**Cause**: Request data fails validation rules

**Solution**: Check the `field` property for specific validation issue

**Common Validations**:
- `email`: Must be valid email format (user@domain.com)
- `name`: 1-100 characters, alphanumeric
- `password`: Minimum 8 characters, must include number

### Rate Limit Errors (429)

#### `rate_limit_exceeded`
**Message**: "API rate limit exceeded"

**Cause**: Too many requests in time window

**Solution**:
1. Check `X-RateLimit-Reset` header for reset time
2. Implement exponential backoff
3. Reduce request frequency
4. Consider upgrading plan for higher limits

**Headers**:
- `X-RateLimit-Limit`: 100
- `X-RateLimit-Remaining`: 0
- `X-RateLimit-Reset`: 1697582400 (Unix timestamp)

**Example**:
```javascript
if (response.status === 429) {
  const resetTime = response.headers.get('X-RateLimit-Reset');
  const waitTime = (resetTime * 1000) - Date.now();
  await sleep(waitTime);
  // Retry request
}
```
```

## Integration Guide Template

**STRUCTURE** integration guides consistently:

```markdown
# API Integration Guide

## Overview
Brief description of what the API does and key features.

**Base URL**: `https://api.example.com/v1`  
**Authentication**: Bearer tokens (JWT)  
**Rate Limits**: 100 requests/minute  
**Response Format**: JSON

## Quick Start (< 5 minutes)

### 1. Get API Credentials
1. Sign up at https://dashboard.example.com
2. Create a new application
3. Copy your API key

### 2. Make Your First Request
```bash
curl https://api.example.com/v1/users \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### 3. Handle the Response
```json
{
  "data": [...],
  "pagination": {...}
}
```

## Authentication

### Obtaining Tokens
[Complete auth flow documentation]

### Token Management
[Refresh, revocation, security best practices]

## Common Use Cases

### Creating a User
[Complete example with code]

### Listing Resources with Pagination
[Pagination pattern example]

### Handling Webhooks
[Webhook setup and verification]

## Best Practices

### Error Handling
- Always check response status codes
- Implement retry logic with exponential backoff
- Log request IDs for debugging

### Rate Limiting
- Monitor rate limit headers
- Implement token bucket algorithm
- Cache responses when possible

### Security
- Never log or expose API keys
- Use HTTPS for all requests
- Rotate keys regularly
- Validate webhook signatures

## Troubleshooting

### Common Issues
[Frequently encountered problems with solutions]

### Debug Mode
[How to enable detailed error responses]

### Support
- API Status: https://status.example.com
- Support Email: api-support@example.com
- Discord: https://discord.gg/example
```

## API Changelog Template

**MAINTAIN** clear changelog:

```markdown
# API Changelog

## Version 2.0.0 (2024-10-17)

### 🚨 Breaking Changes
- **Authentication**: Migrated from API keys to JWT tokens
  - **Migration Guide**: [JWT Migration](#jwt-migration)
  - **Timeline**: API keys deprecated on 2024-12-01
  
- **Endpoints**: Renamed `/api/v1/accounts` to `/api/v1/users`
  - **Old**: `GET /api/v1/accounts`
  - **New**: `GET /api/v1/users`
  - **Migration**: Update all endpoint URLs

### ✨ New Features
- Added webhook event subscriptions
- Support for batch operations
- GraphQL endpoint (beta)

### 🔧 Improvements
- Reduced average response time by 40%
- Added request tracing headers
- Improved error messages

### 🐛 Bug Fixes
- Fixed pagination on large datasets
- Corrected timezone handling in date fields

### 📚 Documentation
- Added Go code examples
- Updated authentication guide
- New webhook integration tutorial

## Version 1.5.0 (2024-09-15)
[Previous version notes...]
```

Always prioritize developer experience, completeness, and ease of integration in API documentation.
