/**
 * @file Demo TypeScript file to demonstrate TypeScript validation
 * This file showcases basic TypeScript features and potential issues
 * that ESLint with TypeScript support would detect
 */

// Basic types
const appName: string = 'Pre-Commitator';
const version: number = 1.0;
const isEnabled: boolean = true;

// Interface definition
interface ValidationResult {
  success: boolean;
  errors: string[];
  warnings: string[];
}

// Function with type annotations
function validateCode(filePath: string, options?: { strict: boolean }): ValidationResult {
  // Implementation would go here
  // This is just a demo function
  const result: ValidationResult = {
    success: true,
    errors: [],
    warnings: []
  };

  // Potential security issue - would be caught by ESLint
  // eval('console.log("Hello")');

  return result;
}

// Enum example
enum ValidationLevel {
  Basic = 'basic',
  Standard = 'standard',
  Strict = 'strict'
}

// Class with TypeScript features
class TypeScriptValidator {
  private filePath: string;
  private level: ValidationLevel;

  constructor(filePath: string, level: ValidationLevel = ValidationLevel.Standard) {
    this.filePath = filePath;
    this.level = level;
  }

  public validate(): ValidationResult {
    console.log(`Validating ${this.filePath} with ${this.level} level`);
    return validateCode(this.filePath, { strict: this.level === ValidationLevel.Strict });
  }
}

// Usage example
const validator = new TypeScriptValidator('src/main.ts');
const result = validator.validate();

console.log(`Validation ${result.success ? 'succeeded' : 'failed'}`);
