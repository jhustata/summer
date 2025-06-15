# Lab 2     
     
## Part 1

Write a .do file which imports [transplants.txt](https://raw.githubusercontent.com/jhustata/livre/main/transplants.txt) and performs the data management/exploratory data analysis tasks described below using the slides we have discussed in class. Your .do file (lab1_lastname.do) must create a log file (lab1_lastname.log). This file will contain your answers for both part 1 and part 2 of today's lab. Your .do file should follow conventions for .do file structure described in class. Do not submit your log files as part of the assignment. 

1. Do a $\chi^2$ test to test the association between recipient HCV status (`rec_hcv`) and gender (`gender`). Make Stata print the p value, like this:    

```stata    
Chi-squared p value (question 1): xxxxxx 
```
    
Except print the correct p value.  `0.006 (any formatting OK)`   
     
`Note: here and in other questions, if the p value is (for example) 0.4, don't have a command like`
  
```stata
disp 0.4
```     
  
`Instead, write code to calculate and then display the number we are asking for.`     
    
2. Do a one-sided Fisher exact test to test the association between recipient HCV status (`rec_hcv`) and gender (`gender`). Make Stata print the one-sided p value, like this:    

```stata
One-sided Fisher exact p value (question 2): xxxxxx
```
Except print the correct p value. `0.003 (any formatting OK)`

3. Run a logistic regression to test the association between age and recipient HCV status (logistic rec\_hcv age). Make Stata print the odds ratio from that regression, like this:

```stata
Odds ratio (question 3): xx.xx (95% CI yy.yy-zz.zz)
```

`1.02 (95% CI 1.01-1.04)`

4. Make Stata print the p value for the coefficient from that regression, like this:

```stata
P value (question 4): 0.yyyy 
```

`0.0009`

## Part 2     
     
5. Write code to produce the following output: 

```stata
Question 5: mean peak PRA is 18.4 in males and 14.5 in females
```
But fill in the correct numbers.  `10.4`, `26.4`

6. Create a variable called hypertensive which is 1 for transplant recipients who have ESRD secondary to hypertension (dx==4) and 0 for everyone else. Create another variable called college which is 1 for recipients with an associate's/bachelor's degree or a graduate degree and 0 for recipients who have no education, grade school education, or high school/GED.  Create a variable called male which is 1 for male recipients and 0 for female recipients. 

Now run a logistic regression of hypertensive on age, BMI, college, and male gender (logistic hypertensive age bmi college male). Write a program called `table_q6` that displays a table of odds ratios, like this:

```stata
Regression table (Question 6)
 
age        x.xx (x.xx - x.xx)
bmi        x.xx (x.xx - x.xx)
college    x.xx (x.xx - x.xx)
male       x.xx (x.xx - x.xx)
```

except fill in the correct numbers.

```stata
age        1.01 (1.00-1.02)
bmi        1.02 (1.00-1.04)
college    0.91 (0.72-1.14)
male       1.21 (0.96-1.53)
```
`Values might be slightly different since the def of "college" is undefined if rec_educ is "some college" or missing`

```stata
log using lab2.log, replace 
use transplants, clear //5pt, -1 pt for every error e.g. filepath, clear, etc

//Q1
quietly tab rec_hcv gender, chi2 exact //5pt 

disp "Chi-squared p value (question 1): " %4.3f r(p) //5pt

//Q2
disp "One-sided Fisher exact p value (question 2): " %4.3f r(p1_exact) //5pt

//Q3
logistic rec_hcv age //10pt
quietly lincom age //10pt
return list //10pt, but ok if they know the r() from memory
disp "Odds ratio (question 3): " /// 
    %3.2f r(estimate) " (95% CI " %3.2f r(lb) "-" %3.2f r(ub) ")" //5pt

//Q4
disp "P value (question 4): " %5.4f r(p)  //5pt

//Q5
quietly sum peak_pra if gender==0 //5pt
local m = r(mean) //5pt 
quietly sum peak_pra if gender==1 //5pt
local f = r(mean) //5pt

disp "Question 5: mean peak PRA is " %2.1f `m' ///
     "  in males and " %2.1f `f' " in females" //10pt

//Q6 
gen byte hypertensive = dx==4 //1pt
gen byte college = rec_educ>=3 if !missing(rec_educ) //1pt
gen byte male = !gender //1pt
capture program drop q6 //1pt
program define q6 //1pt
    local vlist age bmi college male 
    quietly logistic hypertensive `vlist' //1pt
    foreach v of varlist `vlist' {
        quietly lincom `v' //1pt
        disp "`v'" _col(12) %3.2f r(estimate) " (" ///
            %3.2f r(lb) "-" %3.2f r(ub) ")" //1pt
    } 
end //1pt
q6 //1pt

log close

```
