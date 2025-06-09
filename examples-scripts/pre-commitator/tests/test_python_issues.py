#!/usr/bin/env python3
"""
Test file with intentional Python issues to verify pre-commitator functionality.
"""
import json
import os
import pickle
import subprocess


def insecure_function(user_input):
    """This function contains security issues for testing purposes."""
    # Security issue 1: Using eval with user input
    result = eval(user_input)

    # Security issue 2: Using pickle with untrusted data
    with open("data.pickle", "wb") as f:
        pickle.dump(user_input, f)

    return result


def overly_complex_function(a, b, c, d, e, f):
    """This function has complexity issues for testing purposes."""
    result = 0

    # Complex nested conditionals
    if a > 0:
        if b > 0:
            if c > 0:
                if d > 0:
                    if e > 0:
                        if f > 0:
                            result = a + b + c + d + e + f
                        else:
                            result = a + b + c + d + e
                    else:
                        result = a + b + c + d
                else:
                    result = a + b + c
            else:
                result = a + b
        else:
            result = a
    else:
        result = 0

    # More conditionals to increase complexity
    if a > b and b > c and c > d and d > e and e > f:
        result *= 2
    elif a < b and b < c and c < d and d < e and e < f:
        result *= 3

    return result


def shell_injection_risk(command):
    """Function with shell injection risk."""
    # Security issue: shell=True with variable input
    return subprocess.check_output(command, shell=True)


if __name__ == "__main__":
    # Unused variable issue
    unused_variable = "This variable is never used"

    # Call the functions
    print(insecure_function("2 + 2"))
    print(overly_complex_function(1, 2, 3, 4, 5, 6))
    print(shell_injection_risk("ls -la"))
