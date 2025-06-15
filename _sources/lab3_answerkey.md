# Lab 3

## Part 1

Write a .do file which imports [transplants.txt](https://raw.githubusercontent.com/jhustata/livre/main/transplants.txt) and performs the data management/exploratory data analysis tasks described below using the slides we have discussed in class. Your .do file (lab3_lastname.do) must create a log file (lab3_lastname.log). This file will contain your answers for both part 1 and part 2 of today's lab. Your .do file should follow conventions for .do file structure described in class. Do **not** submit your log files as part of the assignment. 

1. Perform a $\chi^2$ test to test the association between recipient work-status (`rec_work`) and gender (`gender`). Using conditional `if` and `else` statements, make Stata print:

```stata
Question 1: Working for income is associated with gender, p = x.xxx
```

If the p-value is less than 0.05, or make Stata print: 

```stata
Question 1: Working for income is NOT associated with gender, p=x.xx
```

If the p-value is greater than 0.05.

`Question 1: working for income is associated w gender, p=0.002`

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

except fill in the correct numbers.

```stata
age           1.01  (1.00-1.02)
bmi           1.02  (1.00-1.04)
college       0.91  (0.72-1.14)
male          1.21  (0.96-1.53)
```

`OR`

```stata
age           1.01  (1.00-1.02)
bmi           1.02  (1.00-1.04)
college       0.81  (0.60-1.08)
male          1.21  (0.95-1.53)
```

`Check that script uses a loop`

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

`See above. Make sure vars aren't hard-coded in the program`

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
Age (per 10y)       0.95 (0.85-1.01)
Weight in kg        1.06 (1.05-1.07)
Female Gender       0.05 (0.03-0.08)
White vs Non-white  1.57 (1.22-2.02)
```

```stata
if 0 {
	1. This is just a very general guide
	2. Any solution with correct output is fine
	3. Remove 1pt per mistake (e.g. includes file path on their computer)
}

cls
capture log close  
log using lab3.log, replace //2pt
use transplants, clear //2pt

tab rec_work gender, chi2 //2pt
local p = r(p) //2pt

if `p' < 0.05 { //2pt
    disp "Question 1: working for income is associated w gender, p=" %4.3f `p' //2pt
}
else { //2pt
    disp "Question 1: working for income is not associated w gender, p=" ///
    %3.2f `p' //2pt
}

//q2
assert !missing(dx)
gen byte hypertensive = dx==4 //2pt
gen byte male = gender==0 //2pt
gen byte college = inrange(rec_edu, 3, 5) if !missing(rec_edu) //2pt
gen byte college2 = inrange(rec_edu, 4, 5) if !missing(rec_edu) //2pt 
gen age_10y = age/10 //2pt
tab rec_edu college //2pt

capture program drop table_loop //2pt
program define table_loop //2pt
    foreach v of varlist age bmi college male { //2pt
        disp "`v'" _col(15) %3.2f exp(_b[`v']) ///
            "  (" %3.2f exp(_b[`v'] + invnormal(0.025)*_se[`v']) "-" ///
                  %3.2f exp(_b[`v'] + invnormal(0.975)*_se[`v']) ")" //2pt
    }
end //2pt

logistic hypertensive age bmi college male //2pt
table_loop //2pt

//q3, 
capture program drop table_varlist //2pt
program define table_varlist //2pt
    syntax varlist //2pt
    foreach v of varlist `varlist' {
        disp "`v'" _col(15) %3.2f exp(_b[`v']) ///
            "  (" %3.2f exp(_b[`v'] + invnormal(0.025)*_se[`v']) "-" ///
                  %3.2f exp(_b[`v'] + invnormal(0.975)*_se[`v']) ")" //2pt
    }
end //2pt

//q4: 

sum rec_hgt_cm,det //2pt
gen tall = 1 if rec_hgt_cm>=r(p75) //2pt
replace tall =0 if tall==. //2pt
replace tall = . if rec_hgt_cm ==. //2pt
gen white = race==1 //2pt


lab var age_10y "Age (per 10y)" //1pt
lab var gender "Female Gender" //1pt
lab var white "White vs Non-white" //1pt
lab var rec_wgt "Weight in kg" //1pt

putexcel set lab3_test.xlsx, modify //3pt
putexcel A1=("Variable") B1=("OR") C1=("95% CI") //15pt
logistic tall age_10y rec_wgt_kg gender white //1pt
local row = 2 //1pt
foreach v of varlist age_10y rec_wgt_kg gender white { //2pt
    local varlabel: variable label `v' //2pt
    local beta: disp %3.2f exp(_b[`v']) //2pt
	local limits: disp %3.2f exp(_b[`v']+invnormal(0.025)*_se[`v']) "-" ///
	%3.2f exp(_b[`v']+invnormal(0.975)*_se[`v']) //1pt
	putexcel A`row'=("`varlabel'") B`row'=("`beta'") C`row'=("`limits'") //3pt
    local row = `row' + 1 //2pt
}

log close //2pt


```