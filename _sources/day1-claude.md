# Day 1: Overview, Commands, and Syntax

## Pre-Class Survey

Before beginning our exploration of Stata, we conducted an entry survey to assess the class composition and individual needs. This survey helps instructors tailor the curriculum to match student backgrounds and technical requirements.

### Technical Setup Assessment

Students were asked to identify their computing environment:

**1. Stata Access Method (June 19-23, 2023)**
- Locally on laptop
- Remotely on desktop or terminal

**2. Operating System**
- MacOSX
- Unix  
- Windows

**3. Statistical Software Experience Level (0-5 scale)**
- **0 - No Experience:** No prior experience with Stata or other statistical software (SAS, R, Python)
- **1 - Basic Knowledge:** General understanding of basic commands but requires assistance
- **2 - Novice User:** Familiar with basic commands, can import data and perform basic cleaning, needs guidance for complex analyses
- **3 - Competent User:** Proficient in data exploration, descriptive statistics, basic inference (t-tests, chi-square), and regression
- **4 - Advanced User:** Can perform multivariable regression and understands various statistical modeling techniques
- **5 - Expert User:** Can write custom programs, macros, ado-files in Stata, or expert in other statistical software with minimal Stata experience

---

## 1.1 Overview

*"Ceci n'est pas une crabe"* - This is not a crab

Understanding Stata requires distinguishing between two fundamental perspectives:

### System vs. User Framework

**System Perspective:**
- **Native Components:** Core Stata application, support files, and built-in `.ado` files
  - Example: `which help` returns `/Applications/Stata/ado/base/h/help.ado`
- **Third-party Components:** External `.ado` files from the community
  - Example: `which table1_afecdvi` returns `/Applications/Stata/ado/base/t/table1_afecdvi.ado`
- **User-created Components:** Your custom `.ado` files and programs
  - Uninstalled programs return: `command table1_afecdv not found as either built-in or ado-file`

**User Perspective:**
- **Known Users:** Instructors, teaching assistants, students, collaborators
- **Unknown Users:** Future users of your code requiring empathy, sharing, and care in code design

### Key Principles for Code Development

The system is simply "Stata" (not "STATA" - it's not an acronym). When developing code, consider your dual role as both user and system contributor. This requires:

- **Empathy:** Anticipating user needs
- **Sharing:** Making code accessible (e.g., GitHub)
- **Care:** Creating user-friendly, well-annotated code

### Installation Environments

**Local Installation:**
- MacOSX
- Unix
- Windows

**Remote Access:**
- Desktop (Windows)
- Cluster (Unix/Terminal)

---

## 1.2 Commands

### Stata Interface Elements

**Menu System** (for local installations):
```
file | edit | view | data | graphics | statistics | user | window | help
```

**Window Shortcuts:**
- Command: ⌘1
- Results: ⌘2  
- History: ⌘3
- Variables: ⌘4
- Properties: ⌘5
- Graph: ⌘6
- Viewer: ⌘7
- Editor: ⌘8
- Do-file: ⌘9
- Manager: ⌘10

### Understanding Commands

A **command** is the first valid word in any Stata instruction. Commands have visual indicators:
- **Native commands:** Rendered in blue (built-in Stata commands)
- **Third-party commands:** Appear in white/black (require installation warnings for collaborators)

### Basic Data Import Example

```stata
webuse lifeexp, clear
```

```stata
. webuse lifeexp, clear
(Life expectancy, 1998)

. 
```

### Exploring Data Structure

```stata
display c(N)
display c(k)
describe
```

```stata
. display c(N)
68

. display c(k)
6

. describe

Contains data from https://www.stata-press.com/data/r18/lifeexp.dta
Observations:            68                  Life expectancy, 1998
Variables:                6                  26 Mar 2022 09:40
(_dta has notes)

Variable      Storage   Display    Value
name            type    format     label      Variable label

region          byte    %16.0g     region     Region
country         str28   %28s                  Country
popgrowth       float   %9.0g               * Avg. annual % growth
lexp            byte    %9.0g               * Life expectancy at birth
gnppc           float   %9.0g               * GNP per capita
safewater       byte    %9.0g               * Safe water
* indicated variables have notes

Sorted by:
. 
```

### Understanding Display Command

The `display` command shows strings and scalar expressions. Using `help display` reveals:

```
[P] display -- Display strings and values of scalar expressions
```

Output values have two key properties:
- **Name:** (e.g., `c(N)` and `c(k)`)
- **Content:** (number of observations and variables)

These are **system-defined macros** (user-defined macros covered tomorrow).

### Data Visualization Example

```stata
webuse lifeexp, clear
encode country, gen(Country)
twoway scatter lexp Country, xscale(off)
graph export lexp_bycountry.png, replace
```

```stata
. webuse lifeexp, clear
(Life expectancy, 1998)

. encode country, gen(Country)

. twoway scatter lexp Country, xscale(off)

. graph export lexp_bycountry.png, replace
file /Users/d/Desktop/lexp_bycountry.png saved as PNG format

. 
```

---

## 1.3 Syntax

### Standalone vs. Context-Dependent Commands

Some commands work independently:
```stata
chelp
pwd
```

Most commands require additional syntax for functionality.

### Data Generation and Analysis Example

```stata
clear 
set obs 1000
generate bmi=rnormal(28,5)
histogram bmi, normal
graph export bmi.png, replace 
```

```stata
. clear 

. set obs 1000
Number of observations (_N) was 0, now 1,000.

. generate bmi=rnormal(28,5)

. histogram bmi, normal
(bin=29, start=13.457429, width=.99248317)

. graph export bmi.png, replace 
file /Users/d/Desktop/bmi.png saved as PNG format

. 
end of do-file

. 
```

### Syntax Components Breakdown

In this example:
- `clear`: Command (standalone)
- `set obs 1000`: Command + syntax (creates empty dataset with 1000 observations)
- `generate bmi=rnormal(28,5)`: Command + syntax (creates variable from normal distribution, μ=28, σ=5)
- `histogram bmi, normal`: Command + syntax (creates histogram with normal overlay)
- `graph export bmi.png, replace`: Command + syntax (saves figure as PNG)

### Command Recognition and Error Handling

Valid commands appear colored (blue/purple). Unrecognized commands trigger errors:

```stata
myfirstprogram
```

```stata
. myfirstprogram
command myfirstprogram is unrecognized
r(199);

. 
```

### Visual Cues for Command Types

- **Blue/Purple:** Native Stata commands
- **White/Black:** Third-party programs or syntax elements
- **Error messages:** Unrecognized commands

---

## Input and Output Framework

### Input Types
- **Menu-driven:** GUI interactions (output commands to results window)
- **Do files:** Stata scripts with command sequences
- **Ado files:** Stata programs for specific tasks

### Output Categories

**String Output:**
- Text: `str49` = string of 49 characters including spaces
  - Example: "The median age in this population is 40 years old"
- URL: `https://www.stata-press.com/data/r8`
- Filepath: `/users/d/desktop`

**Numeric Output (by range):**

*Integer types:*
- `byte`: -127 to 100
- `int`: -32,767 to 32,740  
- `long`: ±2 billion

*Decimal types:*
- `float`: ±10³⁸ billion
- `double`: ±10³⁰⁷ billion

---

## Learning Objectives Summary

By the end of today's session, students should understand:

1. **System-User Framework:** Distinguishing between Stata components and user roles
2. **Command Structure:** Recognizing native vs. third-party commands
3. **Basic Syntax:** Understanding command-syntax relationships
4. **Data Types:** String and numeric output categories
5. **Error Recognition:** Identifying and troubleshooting unrecognized commands

**Tomorrow's Preview:** User-defined macros and writing your first Stata program
**Wednesday's Preview:** Adding syntax requirements and user-defined input
