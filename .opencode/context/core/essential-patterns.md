# Essential Patterns - Core Knowledge Base

## Error Handling Pattern

**ALWAYS** handle errors gracefully:

```typescript
try {
  const result = await riskyOperation();
  return { success: true, data: result };
} catch (error) {
  console.error('Operation failed:', error);
  return { success: false, error: error.message };
}
```

## Input Validation Pattern

**ALWAYS** validate input data:

```typescript
function validateInput(input: any): { valid: boolean; errors?: string[] } {
  const errors: string[] = [];

  if (!input) errors.push('Input is required');
  if (typeof input !== 'string') errors.push('Input must be a string');
  if (input.length < 3) errors.push('Input must be at least 3 characters');

  return {
    valid: errors.length === 0,
    errors: errors.length > 0 ? errors : undefined
  };
}
```

## Logging Pattern

**USE** consistent logging levels:

```typescript
console.debug('Processing request:', requestId);
console.info('User authenticated:', userId);
console.warn('Rate limit approaching for user:', userId);
console.error('Database connection failed:', error);
```

## Security Pattern

**NEVER** expose sensitive information:

```typescript
// ❌ BAD
return { error: 'Internal server error: ' + error.message };

// ✅ GOOD
return { error: 'An unexpected error occurred. Please try again.' };
```

## Type Safety Pattern

**ALWAYS** use strong typing:

```typescript
interface Result<T, E = Error> {
  success: boolean;
  data?: T;
  error?: E;
}

function execute<T>(fn: () => Promise<T>): Promise<Result<T>> {
  try {
    const data = await fn();
    return { success: true, data };
  } catch (error) {
    return { success: false, error: error as Error };
  }
}
```

## Async/Await Pattern

**USE** async/await over callbacks:

```typescript
// ✅ GOOD
async function processData() {
  try {
    const data = await fetchData();
    const processed = await transform(data);
    await save(processed);
  } catch (error) {
    handleError(error);
  }
}
```

## SOLID Principles Quick Reference

- **Single Responsibility**: One reason to change
- **Open/Closed**: Open for extension, closed for modification
- **Liskov Substitution**: Subtypes must be substitutable
- **Interface Segregation**: Many specific interfaces over general ones
- **Dependency Inversion**: Depend on abstractions, not concretions
