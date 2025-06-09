#!/usr/bin/env python3
"""
Demo file to showcase quality validation.
This file contains some code quality issues that will be detected.
"""
import os
import pickle
import random
import subprocess


def insecure_function(user_input):
    """
    This function intentionally has critical security issues.
    """
    # CRITICAL SECURITY ISSUE: Using eval with user input
    result = eval(user_input)  # This will be flagged as HIGH risk

    # CRITICAL SECURITY ISSUE: Using pickle with untrusted data
    with open("data.pickle", "wb") as f:
        pickle.dump(user_input, f)

    # Fixed security issue: No shell=True
    subprocess.check_output(["echo", user_input])

    return result


def complex_function(a, b, c, d, e, f):  # Too many parameters
    """
    This function is too complex and will be flagged.
    """
    result = 0

    # Cyclomatic complexity will be too high
    if a > 0:
        result += a
        if b > 0:
            result += b
            if c > 0:
                result += c
                if d > 0:
                    result += d
                    if e > 0:
                        result += e
                        if f > 0:
                            result += f
                        else:
                            result -= f
                    else:
                        result -= e
                else:
                    result -= d
            else:
                result -= c
        else:
            result -= b
    else:
        result -= a

    # More complex conditions to increase complexity
    if a > b and b > c and c > d and d > e and e > f:
        result *= 2
    elif a < b and b < c and c < d and d < e and e < f:
        result *= 3

    return result


def run_command(command):
    """
    This function has been fixed to avoid shell=True.
    """
    # Fixed: Using a list of arguments instead of shell=True
    if isinstance(command, str):
        command_args = command.split()
    else:
        command_args = command

    return subprocess.check_output(command_args, shell=False)


def main():
    """
    Main function to run demo.
    """
    # Call the insecure function
    print(insecure_function("2 + 2"))

    # Call the complex function
    print(complex_function(1, 2, 3, 4, 5, 6))

    # Call the command function
    print(run_command("ls"))

    # Unused variable
    unused_var = "This variable is never used"


if __name__ == "__main__":
    main()
