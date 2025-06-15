# Lab 1     
     
## Part 1     
               
Write Stata commands to solve the following questions. Keep them in a .txt or .docx file. In the second half of today's class you will learn how to put them in a .do file or script to run all of the commands at the same time. For now, put them in a text file and copy & paste one line at a time into Stata to get the answers.        
     
You will turn this work in together with Lab 1 Part 2.     
     
Write Stata commands to answer the following questions about the dataset [transplants.dta](transplants.dta):     
     
1. How many total patients are in the dataset? `2000`     
2. The variable `dx` represents diagnosis and `age` represents patient age. How many patients were between the ages of 50 and 60 and had diabetes as their primary diagnosis at the time of transplant? `29`     
3. The variable `wait_yrs` represents the amount of time a patient spent on the transplant waitlist prior to transplant. How many patients waited longer than 5 years for a transplant? `214`     
4. What is the age, race (variable: `race`), and Hepatitis C status (variable: `rec_hcv_antibody`) of patient with ID=493?  `75/white/negative`      
5. What are the mean ages at transplant for male and female recipients? (<u>Hint</u>: consider `tab`, `sum`) (Variable: `gender` 0=Male, 1 = Female). `50.96; 49.52`       
     
## Part 2
     
6. Generate a variable called `age_categories` that is 0 for children (ages<18), 1 for adults (18-60), and 2 for senior citizens (>60). What is the mean number of years patients spent on the waitlist in each age group? (<u>Hint</u>: consider `tab`, `sum`)  `0.71y; 2.48y; 2.27y`      
7. Type the command describe to see a list of all variables. Which ones don’t have a variable label? Write code to give a variable label to all variables that don’t yet have one. Then run describe again to show the labeled variables.  `Any description is fine`       
8. Variable `abo` represents blood type and is coded as 1=A, 2=B, 3=AB, 4=O. Variable `prev` represents whether the patient has had a previous transplant and is coded 0=No, 1=Yes. Create a value label for `prev`. Put the command `tab abo prev` in your script, to produce the following output (with xxxx filled in):     

```stata
. tab abo prev 

           |    Prev Kidney Tx
       abo |         No       Yes |     Total
-----------+----------------------+----------
       1=A |       613        107 |       720 
       2=B |       226         23 |       249 
      3=AB |       104         12 |       116 
       4=O |       800        115 |       915 
-----------+----------------------+----------
     Total |     1,743        257 |     2,000

.
```

9. Generate a new variable called bmi_whocat, representing WHO categories of BMI. BMI category should have the following values: missing if BMI is missing; 1 (labeled "underweight") if BMI<18.5; 2 (labeled "normal") if BMI is 18.5-25; 3 (labeled "overweight") if BMI is 25.1-30; 4 (labeled "obese") if BMI is 30.1=40. 

```stata

. tab bmi_whocat

 bmi_whocat |      Freq.     Percent        Cum.
------------+-----------------------------------
underweight |         51        2.77        2.77
     normal |        629       34.13       36.90
 overweight |        632       34.29       71.19
      obese |        531       28.81      100.00
------------+-----------------------------------
      Total |      1,843      100.00

.
```

10. List the ID and age of every patient who is older than 80. List them in order with the oldest patient first.

```stata
. gsort -age

. list fake_id age if age>80, clean noobs

       1535    85  
       1636    84  
       1592    84  
        736    82  
       1527    82  
        911    82  
        647    81  
       1061    81  
       1435    81   

.

```

```stata
qui {
   *10 pts per q; 100 max
   cls
   use transplants, clear //10pts   
   noi count //q1, 10pts     
   noi count if inrange(age,50,60)&dx==2 //q2, 10pts 
   noi count if inrange(wait_yrs,5,100) //q3, 10pts
   noi list age race rec_hcv_antibody if fake_id==493 //q4, 10pts
   if 5 {  
       egen sum_age = mean(age), by(gender) //4pts
       egen tag_gender = tag(gender) //3pts
       noi list sum_age if tag_gender //3pts
   }
   if 6 {  
	   g age_categories=0 if inrange(age,0,17) //3pts, alternative1
	   replace age_categories=1 if inrange(age,18,60) //2pts
	   replace age_categories=2 if inrange(age,61,100) //2pts
	   noi tab age_categories, sum(wait_yrs) //3pts
	   egen mean_wait_yrs = mean(wait_yrs), by(age_categories) //alternative2
	   forval i=1/3 {
          noi di mean_wait_yrs[`i'] //order different; starts with 1, ends with 0
	   }
	   
   }
   if 7 {  
   	   desc //1pt
	   lab var fake_id "Unique ID" //1pt
	   lab var ctr_id "Center ID" //1pt 
	   lab var end_date "End Date" //1pt
	   lab var died "Died" //1pt 
	   lab var tx_failed "Transplant Failed" //1pt
	   lab var wait_yrs "Years on the waiting list" //1pt
	   lab var gender "Gender" //1pt
	   noi desc //2pt
   }
   if 8 {  
       label define Prev 0 "No" 1 "Yes" //3pts 
   	   label values prev Prev //4pts
	   noi tab abo prev //3pts
   }
   if 9 {  
	   g bmi_whocat=1 if inrange(bmi,0,18.5) //2pt
	   replace bmi_whocat=2 if inrange(bmi,18.5,25) //1pt
	   replace bmi_whocat=3 if inrange(bmi,25.1,30) //1pt
	   replace bmi_whocat=4 if inrange(bmi,30.1,100) //1pt
	   label define Bmi_whocat 1 "underweight" 2 "normal" ///
	      3 "overweight" 4 "obese" //2pt
	   label values bmi_whocat Bmi_whocat //2pt
       noi tab abo prev //1pt
   }
   if 10 {
	   gsort -age //5pts: 1 for age; 1 for -; 1 for sort; 2 gsort  
	   noi list fake_id age if age>80, clean noobs 
	   //5pts: 2 for list; 1 for fake_id; 1 for age; 1 for if age>80
   }
}

 
```