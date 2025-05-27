"""Sample package for pre-commit testing."""


def calculate_stats(data):
    """Calculate basic statistics."""
    return {"mean": sum(data) / len(data), "min": min(data), "max": max(data)}
