/**
 * Test file with TypeScript issues for demonstrating ESLint and TypeScript checks
 */

// Type issues
const id: number = '123'; // Type mismatch error

// Interface definition
interface User {
  id: number;
  name: string;
  role: string;
}

// Missing properties from interface
const userWithMissingProps: User = {
  id: 1,
  name: 'Admin User'
  // role is missing
};

// Unused parameters
function processUser(user: User, options: { log: boolean }): void {
  console.log(`Processing user: ${user.name}`);
  // options is never used
}

// Security issue: eval with expression (would be caught by ESLint)
function executeCode(code: string): any {
  return eval(code);
}

// Implicit any type
function getProperty(obj, prop) {
  return obj[prop];
}

// Function with potential null issues
function getUserName(user: User | null): string {
  // Potential null reference issue
  return user.name;
}

// Test function with various issues
function runTests(): void {
  const admin: User = {
    id: 1,
    name: 'Admin',
    role: 'administrator'
  };

  const userInput = 'console.log(\'Hello\')';

  executeCode(userInput);
  processUser(admin, { log: true });

  // Null reference issue
  const nullUser: User | null = null;
  getUserName(nullUser);
}

export {
  User,
  processUser,
  executeCode,
  getProperty,
  getUserName,
  runTests
};
