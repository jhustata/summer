# Lab 1     
     
## Part 1     
     
Write Stata commands to solve the following questions. Keep them in a .txt or .docx file. In the second half of today's class you will learn how to put them in a .do file or script to run all of the commands at the same time. For now, put them in a text file and copy & paste one line at a time into Stata to get the answers.        
     
You will turn this work in together with Lab 1 Part 2.     
     
Write Stata commands to answer the following questions about the dataset [transplants.dta](transplants.dta):     
     
1. How many total patients are in the dataset?      
2. The variable `dx` represents diagnosis and `age` represents patient age. How many patients were between the ages of 50 and 60 and had diabetes as their primary diagnosis at the time of transplant?     
3. The variable `wait_yrs` represents the amount of time a patient spent on the transplant waitlist prior to transplant. How many patients waited longer than 5 years for a transplant?      
4. What is the age, race (variable: `race`), and Hepatitis C status (variable: `rec_hcv_antibody`) of patient with ID=493?  
5. What are the mean ages at transplant for male and female recipients? (<u>Hint</u>: consider `tab`, `sum`) (Variable: `gender` 0=Male, 1 = Female).        
     
## Part 2
     
6. Generate a variable called `age_categories` that is 0 for children (ages<18), 1 for adults (18-60), and 2 for senior citizens (>60). What is the mean number of years patients spent on the waitlist in each age group? (<u>Hint</u>: consider `tab`, `sum`)  
7. Type the command describe to see a list of all variables. Which ones don’t have a variable label? Write code to give a variable label to all variables that don’t yet have one. Then run describe again to show the labeled variables.
8. Variable `abo` represents blood type and is coded as 1=A, 2=B, 3=AB, 4=O. Variable `prev` represents whether the patient has had a previous transplant and is coded 0=No, 1=Yes. Create a value label for `prev`. Put the command `tab abo prev` in your script, to produce the following output (with XXX filled in):     

```stata
. tab abo prev 

           |    Prev Kidney Tx
       abo |         No       Yes |     Total
-----------+----------------------+----------
       1=A |       XXX        XXX |       XXX 
       2=B |       XXX        XXX |       XXX 
      3=AB |       XXX        XXX |       XXX 
       4=O |       XXX        XXX |       XXX 
-----------+----------------------+----------
     Total |       XXX        XXX |       XXX

.
```

9. Generate a new variable called bmi_whocat, representing WHO categories of BMI. BMI category should have the following values: missing if BMI is missing; 1 (labeled "underweight") if BMI<18.5; 2 (labeled "normal") if BMI is 18.5-25; 3 (labeled "overweight") if BMI is 25.1-30; 4 (labeled "obese") if BMI is 30.1=40. Put the command `tab bmi_whocat` in your script, to produce the following output (with XXX filled in):     

```stata

. tab bmi_whocat

 bmi_whocat |      Freq.     Percent        Cum.
------------+-----------------------------------
underweight |        XXX       XX.XX      XX.XX
     normal |        XXX       XX.XX      XX.XX
 overweight |        XXX       XX.XX      XX.XX
      obese |        XXX       XX.XX      XX.XX
------------+-----------------------------------
      Total |      XXX      XX.XX

.
```

10. List the ID and age of every patient who is older than 80. List them in order with the oldest patient first.

```stata

       XXXX    XX 
       XXXX    XX  
       XXXX    XX  
       XXXX    XX  
       XXXX    XX 

```