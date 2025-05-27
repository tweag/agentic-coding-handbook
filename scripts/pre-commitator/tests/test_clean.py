#!/usr/bin/env python3
"""
Clean test file with no issues to verify pre-commitator allows good code.
"""
import json
import os
from typing import Any, Dict, List, Optional


def calculate_sum(numbers: List[int]) -> int:
    """Calculate sum of a list of numbers."""
    return sum(numbers)


def get_user_data(user_id: str) -> Optional[Dict[str, Any]]:
    """Safely get user data from a hypothetical database."""
    # This is a mock function
    users = {
        "user1": {"name": "John", "role": "admin"},
        "user2": {"name": "Jane", "role": "user"},
    }

    # Safe lookup with get (returns None if not found)
    return users.get(user_id)


def process_file(filename: str) -> Dict[str, Any]:
    """Process a file safely."""
    try:
        with open(filename, "r") as f:
            content = f.read()
            # Parse JSON safely
            result = json.loads(content)
            return result
    except (FileNotFoundError, json.JSONDecodeError) as e:
        # Proper error handling
        print(f"Error processing file: {e}")
        return {}


def main() -> None:
    """Main function."""
    # Simple list processing
    numbers = [1, 2, 3, 4, 5]
    total = calculate_sum(numbers)
    print(f"Sum: {total}")

    # Safe user lookup
    user = get_user_data("user1")
    if user:
        print(f"Found user: {user['name']}")

    # No security issues, correct typing, proper error handling


if __name__ == "__main__":
    main()
