# React + Vite Bootstrap (Production Standard)
**Search web for latest 2025 versions, then create production-ready React + Vite project with industry-standard architecture.**
## Setup
```bash
npm create vite@latest my-app -- --template react-ts
cd my-app
```
## Install Production Stack
**CRITICAL: Access official documentation for each package to get current installation commands.**
**Required Packages:**
- **Core**: react-router-dom, @tanstack/react-query + devtools, axios
- **Forms**: react-hook-form, @hookform/resolvers, zod, @tanstack/react-table
- **UI & Styling**: tailwindcss, @tailwindcss/vite, tailwind-merge, clsx, class-variance-authority
- **Icons**: @fortawesome/react-fontawesome, @fortawesome/free-solid-svg-icons, @fortawesome/fontawesome-svg-core
- **Utilities**: dayjs, lodash, recharts, @react-spring/web
- **i18n**: i18next, react-i18next, i18next-browser-languagedetector
- **Dev Tools**: eslint, @eslint/js, typescript-eslint, prettier, prettier-plugin-tailwindcss
- **Testing**: vitest, @vitest/ui, @testing-library/react, @testing-library/jest-dom
- **Development**: storybook, msw, jsdom
## Structure & Config
- **Folders**: `src/common/{components,hooks,utils,api}`, `src/pages/`, `src/assets/`
- **Routes**: Home, About, Contact, 404 with React Router
- **Design System**: Create placeholder components (Button, Card, Input, Modal) with CVA variants
- **Config**: ESLint flat config, Prettier with Tailwind plugin, Storybook setup
- **Features**: Forms (RHF+Zod), data fetching (TanStack Query), i18n, tables
## Verify Success
✅ `npm run dev` + `npm run build` + `npm run test` + `npm run storybook` work  
✅ `npm run lint` passes (0 warnings)  
✅ Navigation, forms, data fetching functional  
✅ Design system components render with variants in Storybook
**Result**: Complete production-standard React app ready for enterprise development.