# NestJS Enterprise Backend Assistant

## MISSION
Create a production-ready NestJS backend application with hexagonal/clean architecture using latest enterprise standards. All tools must be configured, tested, and verified to work perfectly with zero-configuration deployment.

---

## 🔍 MANDATORY WEB VERIFICATION
**Before ANY installation, access official documentation:**
1. **Latest Versions:** NestJS (https://docs.nestjs.com), TypeORM (https://typeorm.io), Prisma (https://www.prisma.io/docs), Swagger (https://docs.nestjs.com/openapi/introduction)
2. **Node.js Compatibility:** Check package.json of latest NestJS, TypeORM, Prisma, and JWT packages on GitHub to determine compatible Node.js version
3. **Use exact installation commands** from each package's official documentation
4. **CRITICAL: Determine compatible versions** - use highest versions that work with ALL packages, not necessarily @latest

---

## 🚀 PROJECT SETUP

### Initialize & Verify
```bash
npm i -g @nestjs/cli@latest
nest new my-backend-api --package-manager npm
cd my-backend-api
# Verify Node.js version compatibility with all planned packages
```

### Package Installation - Follow Official Docs
**Core Framework:** @nestjs/common, @nestjs/core, @nestjs/platform-express, @nestjs/config, @nestjs/mapped-types
**Database:** @nestjs/typeorm + typeorm + pg (PostgreSQL) OR prisma + @prisma/client + @nestjs/prisma
**Authentication:** @nestjs/jwt, @nestjs/passport, passport-jwt, passport-local, bcrypt, @types/bcrypt
**Validation:** class-validator, class-transformer, @nestjs/throttler
**Documentation:** @nestjs/swagger, swagger-ui-express
**Security:** helmet, @nestjs/throttler, cookie-parser, express-rate-limit
**Testing:** @nestjs/testing, supertest, @types/supertest
**Dev Tools:** eslint, prettier, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, jest
**Utilities:** lodash, @types/lodash, uuid, @types/uuid, moment

---

## 📁 HEXAGONAL ARCHITECTURE

### Folder Structure
```
src/
├── common/
│   ├── decorators/     # Custom decorators (roles, public, etc.)
│   ├── filters/        # Exception filters
│   ├── guards/         # Auth, roles, throttle guards
│   ├── interceptors/   # Logging, transform interceptors
│   ├── pipes/          # Validation pipes
│   └── types/          # Shared interfaces & types
├── config/
│   ├── database.config.ts    # DB configuration
│   ├── jwt.config.ts         # JWT settings
│   └── app.config.ts         # App-wide config
├── modules/
│   ├── auth/
│   │   ├── domain/
│   │   │   ├── entities/     # User, Token entities
│   │   │   ├── repositories/ # Auth repository interfaces
│   │   │   └── services/     # Domain business logic
│   │   ├── application/
│   │   │   ├── dto/          # Request/Response DTOs
│   │   │   ├── use-cases/    # Application services
│   │   │   └── commands/     # CQRS commands (optional)
│   │   ├── infrastructure/
│   │   │   ├── repositories/ # TypeORM/Prisma implementations
│   │   │   ├── adapters/     # External service adapters
│   │   │   └── persistence/  # Database schemas
│   │   └── presentation/
│   │       ├── controllers/  # REST controllers
│   │       └── guards/       # Module-specific guards
│   └── users/
│       ├── domain/
│       ├── application/
│       ├── infrastructure/
│       └── presentation/
├── shared/
│   ├── database/       # DB connection, migrations
│   ├── interfaces/     # Global interfaces
│   └── utils/          # Helper functions
└── main.ts
```

### Architecture Rules
✅ **DO:** Layer separation, dependency injection, interface-based repositories
❌ **AVOID:** Direct database calls in controllers, business logic in DTOs

---

## ⚙️ CONFIGURATION & FEATURES

### Core Modules Required
- **Authentication:** JWT strategy, login/register, password reset, email verification
- **Authorization:** Role-based access control (RBAC), guards, decorators
- **Users:** CRUD operations, profile management, soft delete
- **Health:** Health check endpoint with database connectivity
- **Documentation:** Swagger with authentication schemas

### Database Integration
- **TypeORM Setup:** Entities, repositories, migrations, seeds
- **Prisma Alternative:** Schema, client generation, migrations
- **Connection:** Database pooling, transaction support
- **Validation:** Entity-level validation with class-validator

### Security Implementation
- **JWT:** Access/refresh token mechanism
- **Password:** Bcrypt hashing with salt rounds
- **Rate Limiting:** API throttling configuration
- **Headers:** Helmet security middleware
- **CORS:** Cross-origin configuration
- **Validation:** Request/response validation pipes

---

## ✅ VERIFICATION

### Automated Checks (ALL must pass)
```bash
npm run start:dev     # Development server starts on port 3000
npm run build         # Production build succeeds
npm run test          # Unit tests pass, 0 failures
npm run test:e2e      # E2E tests pass, 0 failures
npm run lint          # Zero ESLint errors/warnings
npm run format        # Prettier formatting check
```

### API Endpoint Tests
```bash
# Health check responds
curl http://localhost:3000/health

# Swagger documentation loads
curl http://localhost:3000/api

# Authentication endpoints work
POST /auth/register
POST /auth/login
GET /auth/profile (with JWT)
```

### Database Verification
```bash
# Migrations run successfully
npm run migration:run

# Seeds execute without errors  
npm run seed:run

# Database connection established
# Check application logs for connection success
```

---

## 📋 DELIVERABLES

### Implementation Requirements
1. **Installation steps** with exact commands from official NestJS docs
2. **Complete auth module** (domain, application, infrastructure, presentation layers)
3. **User management** with CRUD operations and validation
4. **Database setup** with entities/models, migrations, and seeds
5. **Security configuration** (JWT, RBAC, rate limiting, CORS)
6. **API documentation** with Swagger decorators and examples
7. **Global middleware** (exception filters, validation pipes, interceptors)
8. **Docker configuration** (Dockerfile + docker-compose.yml with PostgreSQL)
9. **Environment configuration** (.env files for dev/staging/prod)
10. **Testing setup** (unit tests, e2e tests, test database)

### Configuration Files
- **TypeScript:** tsconfig.json with strict mode
- **ESLint:** .eslintrc.js with NestJS rules
- **Prettier:** .prettierrc with consistent formatting
- **Jest:** jest.config.js for testing
- **Docker:** Multi-stage Dockerfile optimized for production

### Code Examples
- **JWT Authentication:** Complete login/register flow
- **RBAC System:** Role decorators and guards
- **Repository Pattern:** Generic base repository with TypeORM/Prisma
- **Exception Handling:** Global filters with structured error responses
- **Validation:** DTO classes with class-validator decorators

---

## 🎯 SUCCESS CRITERIA
**Production-ready NestJS backend with hexagonal architecture, comprehensive authentication, database integration, API documentation, and Docker deployment - ready for immediate team collaboration.**

### Quality Standards
- TypeScript strict mode enabled
- Zero build/lint/test errors
- All security best practices implemented
- Complete API documentation
- Database properly configured with migrations
- Docker containers start successfully
- All endpoints secured and validated

**QUALITY GUARANTEE:** Task incomplete until all verification checks pass and API endpoints respond correctly with proper authentication.
