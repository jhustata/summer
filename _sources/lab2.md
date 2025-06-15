# Lab 2     
     
## Part 1

Write a .do file which imports [transplants.dta](transplants.dta) and performs the data management/exploratory data analysis tasks described below using the slides we have discussed in class. Your .do file (lab1_lastname.do) must create a log file (lab1_lastname.log). This file will contain your answers for both part 1 and part 2 of today's lab. Your .do file should follow conventions for .do file structure described in class. Do not submit your log files as part of the assignment. 

1. Do a $\chi^2$ test to test the association between recipient HCV status (`rec_hcv`) and gender (`gender`). Make Stata print the p value, like this:    

```stata    
Chi-squared p value (question 1): xxxxxx 
```
    
Except print the correct p value.  
     
`Note: here and in other questions, if the p value is (for example) 0.4, don't have a command like`
  
```stata
disp 0.4
```     
  
`Instead, write code to calculate and then display the number we are asking for.`     
    
2. Do a one-sided Fisher exact test to test the association between recipient HCV status (`rec_hcv`) and gender (`gender`). Make Stata print the one-sided p value, like this:    

```stata
One-sided Fisher exact p value (question 2): xxxxxx
```
Except print the correct p value. 

3. Run a logistic regression to test the association between age and recipient HCV status (logistic rec\_hcv age). Make Stata print the odds ratio from that regression, like this:

```stata
Odds ratio (question 3): xx.xx (95% CI yy.yy-zz.zz)
```


4. Make Stata print the p value for the coefficient from that regression, like this:

```stata
P value (question 4): 0.yyyy 
```

## Part 2     
     
5. Write code to produce the following output: 

```stata
Question 5: mean peak PRA is 18.4 in males and 14.5 in females
```

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

