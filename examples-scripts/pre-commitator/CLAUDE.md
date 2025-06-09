# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

- Install: `pip install pre-commit && pre-commit install`
- Run pre-commit: `pre-commit run` (staged files) or `pre-commit run --all-files`
- Run tests: `./run_tests.sh` (all) or `./run_quality_check.sh tests/test_file.py` (single)
- Quality check: `./run_quality_check.sh` (staged) or `./run_quality_check.sh --all` (all files)
- Lint Python: `black src/` (auto-formats Python code)
- Lint JS/TS: `npx eslint src/**/*.{js,ts,tsx}` or `npm run lint` (all) or `npm run lint:ts` (TS only)
- TypeScript check: `./run_ts_check.sh` (single file) or `npx tsc --noEmit` or `npm run typecheck` (all)
- Security scan: `bandit -r src/ --configfile=.bandit.yml`
- Code metrics: `lizard -l 5 .` (measures complexity)
- NPM scripts: `npm run check` (staged files) or `npm run check:all` (all files)

## Style Guidelines

- **Python**:
  - Follow Black formatting (line length 88)
  - Type annotations required
  - Complexity limits: CCN<10, function length<100, args<5
  - PEP 8 style guide with isort for imports

- **JavaScript/TypeScript**:
  - Follow security rules in .eslintrc.json
  - Utilize security plugins and TypeScript-specific rules
  - Single quotes for strings, semicolons required
  - 2-space indentation
  - Strict null checks and noImplicitAny enabled

- **General**:
  - YAML validation required
  - No trailing whitespace
  - Files must end with newline
  - Run security checks (Bandit, Horusec, Semgrep)
  - Avoid hardcoded secrets
  - Error messages must be clear for both humans and AI
