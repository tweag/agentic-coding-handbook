/**
 * Test file with intentional JavaScript issues to verify pre-commitator functionality.
 */

// Security issue: Use of eval with user input
function insecureEval(userInput) {
  const result = eval(userInput);
  return result;
}

// Security issue: Object injection vulnerability
function insecureObjectAccess(userInput) {
  const data = {
    admin: { access: 'full', role: 'administrator' },
    user: { access: 'limited', role: 'standard' }
  };

  // Direct use of user input as property name
  return data[userInput];
}

// Complexity issue: Overly complex function
function complexFunction(a, b, c, d, e, f) {
  let result = 0;

  // Complex nested conditionals
  if (a > 0) {
    if (b > 0) {
      if (c > 0) {
        if (d > 0) {
          if (e > 0) {
            if (f > 0) {
              result = a + b + c + d + e + f;
            } else {
              result = a + b + c + d + e;
            }
          } else {
            result = a + b + c + d;
          }
        } else {
          result = a + b + c;
        }
      } else {
        result = a + b;
      }
    } else {
      result = a;
    }
  } else {
    result = 0;
  }

  // More conditionals to increase complexity
  if (a > b && b > c && c > d && d > e && e > f) {
    result *= 2;
  } else if (a < b && b < c && c < d && d < e && e < f) {
    result *= 3;
  }

  return result;
}

// Insecure file operations
function insecureFileAccess(fileName) {
  const fs = require('fs');

  // Security issue: Path traversal vulnerability
  return fs.readFileSync(fileName);
}

// Run the functions
console.log(insecureEval('2 + 2'));
console.log(insecureObjectAccess('admin'));
console.log(complexFunction(1, 2, 3, 4, 5, 6));

// Unused variable
const unusedVariable = 'This variable is never used';
