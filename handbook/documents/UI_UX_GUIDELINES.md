# Detailed Style Guide for AI

## Overview

This document provides comprehensive guidelines for interpreting and implementing the MedAI Report analyzer app design created in Figma. It is a reference for AI agents to understand the design system, component behaviors, and user experience patterns.

This resource should be used in conjunction with the original Figma file where the app was designed and the business requirements. These materials will help guide the Agent in the app development process.

> **Note:** AI should soon be able to interpret Figma prototypes, drastically improving AI's capacity to analyze a project and build the product.

---

## Design Philosophy

### Core Principles

- **Patient Empowerment:** Design that helps patients understand and take control of their health  
- **Plain Language First:** Complex medical terms explained in simple, understandable language  
- **Anxiety Reduction:** Calming visual design that reduces medical anxiety and fear  
- **Educational Focus:** Every interaction is an opportunity to educate and inform patients  

### Target Users

- **Primary:** Patients seeking to understand their medical reports  
- **Secondary:** Caregivers and family members assisting patients  
- **Tertiary:** Healthcare professionals reviewing patient understanding  

---

## Interpreting UI Components

### Navigational Menu

**Purpose:** Allow the user to access different pages in the app  
**Elements:**

- 1 featured button (blue centered CTA) → Triggers the upload file flow  
- 4 secondary buttons:  
  - **Home** – Takes the user back to the home screen  
  - **Reports** – Displays all uploaded and analyzed files  
  - **AI Chat** – Opens chat modal to ask AI about anything  
  - **Account** – Access all user data  

---

### Home Screen

**Purpose:** Welcome the user and display the latest uploaded reports (if any)  
**Elements:**

- Welcome message  
- 3 Latest Reports (includes date and categories)  
- Floating main menu with icon buttons (Home, Reports, Upload, AI Chat, Account Details)  
- Overall screen padding: `32, 20, 20, 20`  

---

### Login Screen

**Purpose:** User authentication and registration  
**Elements:**

- Initial animation (animated Splash screen with beating heart)  
- Input fields: `286px × 48px`  
- Medium buttons: `60px` height  
- Login card: `350px × 709.5px`  
- Card padding: `32px`  
- Scroll element activates when content exceeds card height  

---

### AI Chat

**Purpose:** Assist the user with questions  
**Elements:**

- Initial popup: `350px × 160px`  
- Secondary popup: `350px × 610px`  
- Size increases by 100px on Y-axis after user input  
- Full-screen Chat Module (expandable)  
- General padding: `20px`  

---

### Upload Modal

**Purpose:** Allow report upload for AI interpretation  
**Elements:**

- Blue background card: centered, `100px` from top, `350px × 527px`  
- Internal dashed box: centered, `310px × 411px`, Y-position `184px`  

---

### Processing Screen

**Purpose:** Show animation during AI analysis  
**Elements:**

- Central rotating animated orb  

**Error Conditions:**

- Unable to extract meaningful data  
- Other processing problems  
- Display error message and allow retry or new upload  

---

### Results Analysis

**Purpose:** Present AI-interpreted and original report content  
**Elements:**

- **Tabs:**  
  1. **AI Insights:** Interpreted document content ordered by severity  
  2. **Original Report:** Raw content as in uploaded file  

- **Buttons:**  
  - **Discard:** Deletes file, returns to upload screen (bottom sheet confirmation)  
  - **New Upload:** Starts new upload, replaces current one (bottom sheet confirmation)  

**Value Display Logic:**

- First: **Flagged Values** (collapsible)  
  - **High (Critical):** Well outside reference ranges  
  - **Low (Moderately Concerning):** Just over/under acceptable zones  
- Second: **Normal Values** (collapsible)  
  - Shown when no flagged values exist  

**Info Boxes:**

- Red warning box for critical values  
- Info box when AI lacks enough info to interpret  

---

### Results Page

**Purpose:** Store all uploaded and uploading files  
**Elements:**

- **Category icons** – quick recognition  
- **Bookmark button** – add/remove bookmarks  
- **Sort**  
- **Filter:** Category-only  
  - Filter chips appear above when active  
- **Tabs:**  
  - **All / Bookmarked** – further filter reports  

---

### Account Settings

**Purpose:** Display user account details  
**Elements:**

- First name input  
- Last name input  
- Save changes button  

---

### Empty States

**Purpose:** Inform user of missing content  
**Elements:**

- **Icons** – affordance  
- **Message** – context explanation  
- **Actions** – suggestions of what user can do  

**Where:**

- Home page – No reports  
- Reports page – No reports in list or after filtering  

---

## Color System

### Primary Palette

- **Stable Blue:** `#435FF0` – Primary actions, trust  
- **Grey Radial Gradient:** `#FAFAFF` (83%) → `#F9FCFF` (100%) – Background  
- **Light Grey:** `#FAFAFF` – Card backgrounds, highlights  
- **Dark Gray:** `#313E4C` – Text color  
- **Accent Pink:** `#FD7BF4` – Alternative highlight  

### Semantic Colors

| Color Name                     | Light Mode       | Dark Mode Alternative | Usage                              |
|-------------------------------|------------------|------------------------|-------------------------------------|
| Reassuring Green              | `#AEEABF`         | `#36A656`              | Normal values, good news           |
| Gentle Orange                 | `#FEAD7F`         | —                      | Recommendations, watch values      |
| Alarming Red                 | `#AF1B3F`         | `#FF9CB4`              | Critical alerts                    |

### Usage Guidelines

- Minimum contrast ratio: **4.5:1**
- Pair colors with plain-language text
- Consider accessibility for elderly and visually impaired users  

---

## Typography

### Font Hierarchy

- **Primary:** Inter  
  *(Fallbacks: `-apple-system`, `BlinkMacSystemFont`, `'Segoe UI'`)*  
- **Secondary:** Merriweather  
  *(Fallbacks: `'Georgia'`, `'Times New Roman'`)*  

### Text Styles

#### Titles

| Style | Font    | Size | Weight | Line Height |
|-------|---------|------|--------|-------------|
| H1    | Inter   | 28px | 600    | normal      |
| H2    | Inter   | 22px | 600    | normal      |
| H3    | Inter   | 18px | 600    | normal      |
| H4    | Inter   | 16px | 600    | normal      |
| H5    | Inter   | 13px | 600    | normal      |

#### Label Text

| Style | Font    | Size | Weight | Line Height |
|-------|---------|------|--------|-------------|
| L1    | Inter   | 18px | 600    | 1           |
| L2    | Inter   | 16px | 600    | normal      |
| L3    | Inter   | 14px | 600    | 1.43        |
| L4    | Inter   | 13px | 600    | normal      |
| L5    | Inter   | 12px | 600    | normal      |

#### Body Text

| Style | Font    | Size | Weight | Line Height |
|-------|---------|------|--------|-------------|
| B1    | Inter   | 16px | 400    | normal      |
| B2    | Inter   | 14px | 400    | 1.57        |
| B3    | Inter   | 13px | 400    | 1.54        |
| B4    | Inter   | 12px | 400    | 1.58        |

#### Accent Text

| Style | Font        | Size | Weight | Line Height |
|-------|-------------|------|--------|-------------|
| G1    | Merriweather| 17px | 400    | normal      |
| G2    | Merriweather| 14px | 400    | 1.71        |

---

## Buttons

### Primary Button

- Background: `#435FF0`  
- Text: White  
- Padding: `12px 32px`  

### Secondary Button

- Background: none  
- Text: `#435FF0`  
- Padding: `12px 32px`  
- Border Radius: `1px`  
- Border Color: `#435FF0`  

---

## Text Fields

### Light Mode

- Border: `1px solid #838B94`  
- Padding: `13px 16px`  
- Background: none  

### Dark Mode

- Border: `1px solid #ABBCCD`  
- Padding: `13px 16px`  
- Background: none  

---

## Icons

- General usage: `24px`  
- Secondary menu buttons: `28px`  
- Upload button: `32px`  
