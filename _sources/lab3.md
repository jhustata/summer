# Lab 3

## Part 1

Write a .do file which imports [transplants.dta](transplants.dta) and performs the data management/exploratory data analysis tasks. Your .do file (lab3_lastname.do) must create a log file (lab3_lastname.log). This file will contain only <u>code</u> and some annotation, but <u>no answers</u> (we will get these on our machines when we run your script). Do **not** submit your log files as part of the assignment. 

1. Perform a $\chi^2$ test to test the association between recipient work-status (`rec_work`) and gender (`gender`). Using conditional `if` and `else` statements, make Stata print:

```stata
Question 1: Working for income is associated with gender, p = x.xxx
```

If the p-value is less than 0.05, or make Stata print: 

```stata
Question 1: Working for income is NOT associated with gender, p=x.xx
```

If the p-value is greater than 0.05.

2. From lab 2: Create a variable called hypertensive which is 1 for transplant recipients who have ESRD secondary to hypertension (`dx==4`) and 0 for everyone else. Create another variable called college which is 1 for recipients with any college, an associate's/bachelor's degree or a graduate degree and 0 for recipients who have no education, grade school education, or high school/GED.  Create a variable called male which is 1 for male recipients and 0 for female recipients. 

Run a logistic regression of hypertensive on age, BMI, college, and male gender (logistic hypertensive age bmi college male). 

Write a program called `table_loop` that is an updated version of your program called `table_q6` from Lab 2. `table_loop` should use a `foreach` loop to create the display of odds ratios, like this: 

```stata
Regression table (Question 2)

age        x.xx (x.xx - x.xx)
bmi        x.xx (x.xx - x.xx)
college    x.xx (x.xx - x.xx)
male       x.xx (x.xx - x.xx)
```

Lab 3 Part 2

3. Write a program called `table_varlist` that is an updated version of `table_loop` from question 2. `table_varlist` should incorporate `syntax varlist` and a `foreach` loop to create the display of odds ratios. So if we run:

```stata
 table_varlist age male bmi college
```

We should get the following table:

```
Regression table (Question 3)

age        x.xx (x.xx - x.xx)
male       x.xx (x.xx - x.xx)
bmi        x.xx (x.xx - x.xx)
college    x.xx (x.xx - x.xx)
```

except fill in the correct numbers.

4. Create a variable called `tall` that is 1 if the recipient’s height (`rec_hgt_cm`) is greater than or equal to the 75th percentile of height of all recipients in the dataset. (<u>Hint</u>: how can you use `summarize` and macros to generate a variable based on the mean of another variable?) `tall` should be equal to 0 for recipients with height less than the overall 75th percentile for height. Create a variable called `white` that is 1 if the recipient is white and 0 for all other races. Create a variable called `age_10y` which is age in decades (age/10). You will need to create variable labels for new variables `tall`, `white`, and `age_10y`, and you can change existing variable labels to improve readability of the table as well. 

Run a logistic regression of tall on age, weight (`rec_wgt_kg`), gender, and white race:

```stata
logistic tall age rec_wgt_kg gender white
```

Use `putexcel` to create a table in Excel that displays the odds ratios:

```stata
Variable            OR (95% CI)
___________________________________
Age (per 10y)       X.XX (X.XX-X.XX)
Weight in kg        X.XX (X.XX-X.XX)
Female Gender       X.XX (X.XX-X.XX)
White vs Non-white  X.XX (X.XX-X.XX)
```