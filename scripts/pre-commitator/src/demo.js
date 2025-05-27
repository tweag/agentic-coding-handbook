/**
 * Demo JavaScript file to showcase quality validation.
 * This file contains some code quality issues that will be detected.
 */

// SECURITY-CRITICAL: Insecure use of eval with user input
function insecureFunction(userInput) {
  // SECURITY-CRITICAL: Using eval with user input
  const result = eval(userInput);  // ESLint security plugin will flag this

  // SECURITY-CRITICAL: Insecure direct object references
  const users = {
    'admin': { role: 'admin', data: 'sensitive' },
    'user': { role: 'user', data: 'public' }
  };

  return users[userInput]; // Object injection vulnerability
}

// This function is too complex
function complexFunction(a, b, c, d, e, f) {
  let result = 0;

  // Cyclomatic complexity will be too high
  if (a > 0) {
    result += a;
    if (b > 0) {
      result += b;
      if (c > 0) {
        result += c;
        if (d > 0) {
          result += d;
          if (e > 0) {
            result += e;
            if (f > 0) {
              result += f;
            } else {
              result -= f;
            }
          } else {
            result -= e;
          }
        } else {
          result -= d;
        }
      } else {
        result -= c;
      }
    } else {
      result -= b;
    }
  } else {
    result -= a;
  }

  return result;
}

// Insecure file operations
function readUserFile(fileName) {
  const fs = require('fs');

  // Security issue: Path traversal vulnerability
  return fs.readFileSync(fileName);  // ESLint security plugin will flag this
}

// Main function
function main() {
  // Call the insecure function
  console.log(insecureFunction('2 + 2'));

  // Call the complex function
  console.log(complexFunction(1, 2, 3, 4, 5, 6));

  // Call the file function
  console.log(readUserFile('data.txt'));

  // Unused variable
  const unusedVar = 'This variable is never used';
}

main();
