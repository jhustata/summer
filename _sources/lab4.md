# Lab 4

## Part 1

Write a .do file which imports [transplants.dta](transplants.dta) and performs the data management/exploratory data analysis tasks described below using the slides we have discussed in class. Your .do file (lab4_lastname.do) and must create a log file (lab4_lastname.log). This file will contain your answers for both part 1 and part 2 of today's lab. Your .do file should follow conventions for .do file structure described in class. Do **not** submit your log files as part of the assignment.    
    
1. Create a new variable called `ctr_volume` that contains the transplant center volume (total number of transplants performed in each transplant center). The transplant center can be identified by `ctr_id`.     
    
2. Use `summarize, detail` to show the distribution of `ctr_volume`. For question 2, you should analyze one observation per center, not one observation per transplant recipient. (<u>Hint</u>: Tagging can help with this)  

3. Generate a variable called `unknown` which is a 1 for all patients whose cause of end-stage renal disease (ESRD) is unknown/uncertain/blank (`extended_dgn` = "ESRD UNKNOWN ETIOLOGY", "ESRD OF UNCERTAIN ETIOLOGY", etc.) and a zero for all other patients. Display the following sentence:

```stata
xxx of 2000 patients (yy.y%) have an unknown cause of ESRD.
```
Except fill in the correct numbers.   

4. How many patients died within six months of their transplant (died==1 and transplant date falls ≤ 180 days before end date)? Display the following sentence:

```stata
xxx of 2000 patients (yy.y%) died within 6 months of their transplant date.
```

Except fill in the correct numbers.      
    
5. For each blood type, what is the mean waiting time for a transplant? (variable: `wait_yrs`) What is the median waiting time for a transplant? Use `egen`, `tagging`, and `list` to display the blood type, mean wait time, and median wait time of each blood type so that only one record is displayed per blood type. 

Lab 4 Part 2

6. Create a variable called `over50` which is a 1 for any recipient age >50 and 0 for everyone else. Draw a survival curve stratified by over50.     

7. Is the difference in post-transplant survival by over50 statistically significant (p>0.05)? Write one of the following sentences:

```stata
There is a statistically significant difference in survival by age category (p<0.05)
```

or

```stata
There is no statistically significant difference in survival by age category (p=0.x)
```

8. Run a Cox regression on over50 (command `stcox over50`). Print this sentence:

```stata
Hazard ratio: x.xx (95% CI y.yy-z.zz) 
```

Except fill in the correct values.



