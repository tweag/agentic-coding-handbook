# React Enterprise Setup Assistant

## MISSION
Create a production-ready React application with zero-configuration development environment using latest enterprise standards. All tools must be configured, tested, and verified to work perfectly.

---

## 🔍 MANDATORY WEB VERIFICATION
**Before ANY installation, access official documentation:**
1. **Latest Versions:** React (https://react.dev/versions), Storybook (https://storybook.js.org/docs/get-started/install), Tailwind (https://tailwindcss.com/docs/installation)
2. **Vite Compatibility:** Check (package.json) of the latest versions of (React, Tailwind, Storybook) on github (access the web) and determine the latest Vite version compatible with all three.
3. **Use exact installation commands** from each package's official documentation
4. **CRITICAL: Determine compatible Vite version** - use highest version that works with ALL packages, not necessarily @latest

---

## 🚀 PROJECT SETUP

### Initialize & Verify
```bash
npm create vite@[compatible-version] my-app -- --template react-ts
cd my-app
# Where [compatible-version] = latest Vite version compatible with React, Tailwind, Storybook
# Example: npm create vite@5.4.2 my-app -- --template react-ts
```

### Package Installation - Follow Official Docs
**Core:** react-router-dom, @tanstack/react-query + devtools, axios
**UI:** tailwindcss + @tailwindcss/vite, shadcn/ui (https://ui.shadcn.com/docs/installation/vite), tailwind-merge, clsx, class-variance-authority  
**Forms:** react-hook-form, @hookform/resolvers, zod, @tanstack/react-table
**Dev Tools:** eslint + @eslint/js + typescript-eslint, prettier + prettier-plugin-tailwindcss, vitest + @vitest/ui + @testing-library/react + @testing-library/jest-dom
**Storybook:** Use command from https://storybook.js.org/docs/get-started/frameworks/react-vite
**Utilities:** date-fns, lodash, recharts, @react-spring/web, @fortawesome packages, i18next + react-i18next + i18next-browser-languagedetector
**Testing:** msw (tests only), jsdom

---

## 📁 ARCHITECTURE

### Folder Structure
```
src/
├── common/
│   ├── components/    # Shared UI (Shadcn/ui components)
│   ├── hooks/         # Custom hooks (ONE per file)
│   ├── utils/         # Helper functions
│   └── api/           # API client logic
├── pages/
│   ├── HomePage/      # Page subdirectories
│   ├── AboutPage/
│   └── ContactPage/
└── assets/
```

### Rules
✅ **DO:** Page subdirectories, co-located tests, one hook per file
❌ **AVOID:** Barrel files (breaks tree shaking), separate test folders

---

## ⚙️ CONFIGURATION & FEATURES

### Requirements
- **Router:** Home, About, Contact, 404 with error boundaries
- **Components:** Shadcn/ui Button, Card, Input, Dialog, Table with CVA variants
- **Testing:** Vitest + co-located tests, MSW for test mocking only
- **Quality:** ESLint 9+ flat config, Prettier with Tailwind plugin
- **Docs:** Storybook for component showcase

### Core Features
- Contact form (React Hook Form + Zod validation)
- Data fetching (TanStack Query with loading/error states)
- Internationalization (i18next with language switching)
- Responsive design (Tailwind utilities)

---

## ✅ VERIFICATION

### Automated Checks (ALL must pass)
```bash
npm run dev       # Development server starts
npm run build     # Production build succeeds  
npm run test      # All tests pass, 0 failures
npm run lint      # Zero errors/warnings
npm run storybook # Components load correctly
```

### Functional Tests
- Navigation works, forms validate, data fetches properly
- Components render with variants, i18n switches languages

---

## 📋 DELIVERABLES

### Implementation Requirements
1. **Installation steps** with exact commands from official docs
2. **Configuration files** (ESLint, Prettier, Vitest, Storybook) 
3. **Working examples** (forms, data fetching, components)
4. **Co-located tests** with coverage
5. **Verification commands** confirming functionality

### Documentation
- List official URLs visited for each package
- Confirm latest stable versions used (React, Storybook, Tailwind)
- Document any compatibility decisions

### Quality Standards
- TypeScript strict mode, latest stable versions
- Zero build/lint errors, all features working
- Installation commands from official documentation

---

## 🎯 SUCCESS CRITERIA
**Production-ready React application with complete toolchain, passing tests, zero configuration needed for team onboarding.**

**QUALITY GUARANTEE:** Task incomplete until all verification checks pass.
