---

# 🔧 Lab 1 Part 2: Syntax Crash Notes

You **will be expected** to do all of this *in a `.do` file* — not just copy/paste into the console. These are mini-programming tasks. Here's your cheat sheet:

---

### 6️⃣ Categorize by Age, Summarize Wait Time

```stata
gen age_categories = .
replace age_categories = 0 if age < 18
replace age_categories = 1 if inrange(age, 18, 60)
replace age_categories = 2 if age > 60
tab age_categories, sum(wait_yrs)
```

---

### 7️⃣ Label Variables with No Label

```stata
describe
// manually check vars without labels
label variable <varname> "Descriptive label"
describe
```

---

### 8️⃣ Add Labels + Crosstab ABO × PREV

```stata
label define prevlbl 0 "No" 1 "Yes"
label values prev prevlbl
tab abo prev
```

---

### 9️⃣ WHO BMI Categories

```stata
gen bmi_whocat = .
replace bmi_whocat = 1 if bmi < 18.5
replace bmi_whocat = 2 if bmi >= 18.5 & bmi <= 25
replace bmi_whocat = 3 if bmi > 25 & bmi <= 30
replace bmi_whocat = 4 if bmi > 30 & bmi <= 40
label define bmilbl 1 "underweight" 2 "normal" 3 "overweight" 4 "obese"
label values bmi_whocat bmilbl
tab bmi_whocat
```

---

### 🔟 List Eldest Patients Over 80

```stata
list id age if age > 80, sort(age -age)
```

---

### Final Tip:

**Run everything from your `.do` file** using:

```stata
do lab1_part2.do
```

Get clean output. Comment your code. Organize it by question. You'll thank yourself later.

