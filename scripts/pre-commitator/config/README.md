# Configuration Files

This directory contains configuration files used by Pre-Commitator to customize its behavior.

## Available Configuration Files

### settings.yaml

General settings for Pre-Commitator:

```yaml
database:
  host: localhost
  port: 5432
  name: test_db

logging:
  level: INFO
  format: '%(asctime)s - %(levelname)s - %(message)s'
```

## Other Configuration Files

These files are located in the root directory:

### .pre-commit-config.yaml

Configures which pre-commit hooks are executed and how they behave. This is the main configuration file for customizing which checks are run.

### .bandit.yml

Configuration for Bandit security scanner:

```yaml
# Skip these tests
skips:
  - B101 # assert used
  - B404 # subprocess without shell=True
```

### .eslintrc.json

Configuration for ESLint JavaScript linter:

```json
{
  "extends": [
    "eslint:recommended",
    "plugin:security/recommended"
  ],
  "plugins": [
    "security"
  ]
}
```

## Customizing Configuration

To customize Pre-Commitator's behavior:

1. Edit the appropriate configuration file
2. Test your changes with `./run_quality_check.sh --all`
3. Commit the changes to version control

For more detailed information, see the [SETUP.md](../SETUP.md) file.
