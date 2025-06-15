```stata

capture log close
log using lecture02.log, replace text

//This log file contains most of the examples used in Lecture 2 of
//Stata Programming and Data Management, along with additional explanations
//and examples.

//commented out "version 12" because I want to use some Stata 15 features
//version 12 //I'm using Stata 18, but some students may have earlier versions
clear all //clear all data from memory
macro drop _all //clear all macros in memory
set more off   //give output all at once (not one screenful at a time)
set linesize 80 //maximum allowed width for output

//open up transplants.dta
use transplants, clear

//a very brief overview of statistical commands

//chi2
tab dx gender, row
tab dx gender, row chi2

//exact
tab abo gender in 1/100, row
tab abo gender in 1/100, row exact

//t test, 2 sample unpaired by group
ttest age, by(prev)

//t test, 2 sample unpaired - comparing two variables
ttest don_wgt_kg==rec_wgt_kg, unpaired

//t test, 2 sample paired
ttest don_wgt_kg==rec_wgt_kg

//linear regression
regress rec_wgt_kg rec_hgt

regress rec_wgt rec_hgt age gender

//logistic regression
logit rec_work age
logit rec_work age gender 
logistic rec_work age
logistic rec_work age gender 


//review.
sum age   //get summary data for age variable
disp "variable" _col(20) "mean"
disp "age" _col(20) r(mean)  //display mean age obtained from sum command

//what else is available?
return list
disp r(N)   //# records with nonmissing age
disp %4.3f r(mean)  //mean
disp %4.3f r(var)  //variance
disp %4.3f r(sd)  //standard dev. Square root of variance
disp r(min)  //minimum
disp r(max)  //maximum
disp r(sum) //sum of all values for age

sum age if abo==1 //summarize age for a subset of data
return list  //everything is different; we're looking at patients with abo==1
disp r(N)   //Now we see a much smaller number of records
disp %4.3f r(mean)  //mean is different
disp %4.3f r(var)  //variance is different
//etc

//if we do sum, detail we get more returned data
return list
disp r(skewness)  //skewness
disp r(p50)  //median
disp r(p25)  //first quartile
disp r(p75)  //third quartile

//another example of sum, detail, from the slides
sum bmi, detail
disp "median: " _col(12) r(p50)
disp "IQR: " _col(12) r(p25) "-" r(p75)
disp "kurtosis: " _col(12) r(kurtosis)

//more examples of r-class commands. 
count if age < 45   //counts # patients with age < 45
disp r(N) " young patients"

tab race abo, chi2   //2-way table of ethnicity and ABO blood type
//with chi-square test
disp "p-value: " r(p) //display p value of chi2 test

sum age
assert inrange(r(mean), 45, 55) //assert that mean age is between 40 and 50.
//so if mean age is 47, then we keep going. If mean age is 39, then there will
//be an error and the script will stop.

tab race abo, chi2
assert r(p) < 0.05 //check that there is a statistically significant 
//relationship between race and abo, per chi2 test

sum age
disp "Mean: " r(mean) " years"  //display mean age, in a sentence

sum age
disp "Mean: " %4.0f r(mean) " years" //dispay, formatted. 
//output: Mean: 50 years 
//the "0" of "%4.0f" means "display zero digits after the decimal point"
//the "4" doesn't mean much - it just has to be any number higher than "0"
//so %4.2f or %6.2f or %9.2f would display "50.40 years"

//ereturn
regress bmi gender age
ereturn list

//log likelihood
disp e(ll)

regress //"replay" the regression; show results again without re-computing

//show the betas (regression coefficients)
disp _b[gender]
disp _b[age]
disp _b[_cons]

//show several betas together
disp "estimated BMI: " %3.2f _b[_cons] " + " %3.2f _b[age] ///
    "*age (+ " _b[gender] " if male)" 

//NOTE: for logistic regression, the beta is the *LOG of the odds ratio.
//So to see the odds ratio you'd say "disp exp(_b[gender])"
//same thing for Cox (exponentiate to obtain hazard ratio), etc.

//more examples of the exp() function to exponentiate
disp exp(0)  //returns 1
disp exp(1)  //returns 0

//show the regression results again
regress

//standard error matrix
disp _se[gender]
disp _se[age]

//t statistic
disp _b[gender]/_se[gender]
disp _b[age]/_se[age]

//Absolute value of t-statistic:
disp abs(_b[gender]/_se[gender]) //function "abs" returns absolute value

//a few more examples with "abs"
disp abs(5)
disp abs(-4)
disp abs(0)

//residual degrees of freedom from regression
//(necessary for obtaining p value of t statistic)
disp e(df_r)

regress
//p value
//returns p value of t statistic abs(beta/se) with e(df_r) degrees of freedom
//see "help ttail" for details
di 2*ttail(e(df_r), abs(_b[gender]/_se[gender]))

//NOTE: for logistic regression or Cox regression, instead of using a 
//t statistic you use a Z statistic (normal distribution)
//which would be this:
//di 2*(1-normal(abs(_b[gender]/_se[gender])))

regress
//lower and upper bound of confidence interval
disp _b[gender] + _se[gender]*invttail(e(df_r), 0.975)
disp _b[gender] + _se[gender]*invttail(e(df_r), 0.025)

//NOTE: for logistic, Cox, etc. you would again use the normal distribution,
//not the t distribution, to obtain confidence intervals. 
//And again you would exponentiate to obtain OR/HR etc
//example: disp exp(_b[age]+invnormal(0.025)*_se[age]) //lower bound
//example: disp exp(_b[age]+invnormal(0.975)*_se[age]) //upper bound

//Stata 15.1: an easier way to do confidence intervals and p values
if c(version) >= 15.09 {
    regress bmi age
    lincom age
    disp r(p)
    disp r(lb) " - " r(ub)

    logit rec_work age prev
    lincom prev
    disp r(p)
    //the coefficient is the log odds ratio, 
    //so let's see the 95% CI of the odds ratio
    disp exp(r(lb)) " - " exp(r(ub))
}

//creturn examples. This information isn't as useful as return/ereturn
//but it might come in handy

disp c(current_date)
disp c(os)
disp c(pi)
creturn list

//local macros
//there's also such a thing as a *global* macro 
//but let's worry about those later
local a = 4  //set macro a equal to 4
disp `a'   //display the value of macro a

local a 4 //another way to set the value of a macro
disp `a'

local a 4 + 7  //this means, set a equal to "4 + 7". 
//At this point, Stata doesn't actually compute what 4+7 is

disp `a'*2  //becomes "disp 4 + 7*2" which is the same as 4+14 which is 18

local a = 4 + 7 //the equals means, *COMPUTE* 4+7 and set a equal to the answer
disp `a'*2  //becomes "disp 11*2" which is 22


//another macro example
//we want to display the mean age for males, and the mean age for females,
//on the same line
quietly sum age if gender==0
local age_m = r(mean)  //store mean age for males in macro "age_m"
quietly sum age if gender==1
local age_f = r(mean)  //store mean age for females in macro "age_f"
disp "Mean age: " %3.1f `age_m' " (males) " %3.1f `age_f' " (females)"
//Note the use of formatting code %3.1f. 
//one digit to the right of the decimal point will be shown.

//More macro examples
local my_var age  //my_var is a macro which equals "age"
disp "Here's a summary of `my_var'"  //displays "Here's a summary of age"
sum `my_var' //sumarizes age

local my_command summarize  //my_command is a macro which equals "summarize"
//Stata sees "summarize age, detail"
`my_command' `my_var', detail

//here are some additional macros not in the slides.
//they are a bit more complex but they show how this macro thing works
local mymacro gen
sum `mymacro'der  //Stata sees "sum gender"

local macro1 ma  //macro1 is "ma"
local macro2 age gender //macro2 is "age gender"
sum ``macro1'cro2' 
//first, `macro1' becomes "ma"
//so ``macro1'cro2' becomes `macro2'
//next, `macro2' becomes "age gender"
//so "sum `macro2'" becomes "sum age gender"

//In this case, in_study defines a subpopulation of age<45 and gender==male
//and then we run several commands using this macro
//if we later decide to include females instead, 
//all we have to do is change "gender==0" to "gender==1"
//and everything will run on females instead of males
local in_study if age<45 & gender==0
sum bmi `in_study'
sum peak_pra `in_study'
regress bmi age `in_study'

//here, "confounders" refers to a set of three variables
//you can imagine that we would do several different analyses 
//treating these variables the same.
//if we change the list of confounders, we just have to change the macro
//instead of changing every command
local confounders age gender peak_pra
regress bmi wait_yrs `confounders'


//review: quietly
//run a regression. Don't print any output or error messages
quietly regress bmi age

//a "quietly block": run several commands without printing anything
quietly {
    gen over40 = (age > 40)
    count if over40 == 1
    regress bmi over40
}

drop over40
//now, let's run several commands and only print output from the last one
quietly {
    gen over40 = (age > 40)
    sum bmi if over40 == 1
    noisily di "mean BMI: " %3.1f r(mean)
}

//which command. Show whether a command is built-in, or a stata .do file
which tab
which chelp
which gen
which regress
which help
which graph

//define a program "do_something"
//first, if the program already exists in memory, delete it
//(NOTE: this is superfluous here, since line 9 says "clear all" which deletes
//all programs in memory... but it's a good idea to do "capture program drop"
//before any "program define"
capture program drop do_something

//now, define the program. All it does is display "It doesn't do much."
program define do_something  //create a program called do_something
    disp "It doesn't do much."  //here's what the program does.
end  //that's the end of the program definition

do_something

capture program drop do_something_else
program define do_something_else  //create a program called do_something
    disp "One line is not enough."
    disp "So display two lines."
end  //that's the end of the program definition

do_something_else

//now for a program that actually does something useful.
//NOTE: this would be more efficient with loops, but those come later

capture program drop table1
program define table1
    disp "Variable" _col(20) "mean (SD)" _col(40) "range"
    quietly sum age
    disp "age" _col(20) %3.2f r(mean) " (" %3.2f r(sd) ")" ///
            _col(40) %3.2f r(min) "-" %3.2f r(max)
    quietly sum wait_yrs
    disp "wait_yrs" _col(20) %3.2f r(mean) " (" %3.2f r(sd) ")" ///
            _col(40) %3.2f r(min) "-" %3.2f r(max)
    quietly sum bmi
    disp "bmi" _col(20) %3.2f r(mean) " (" %3.2f r(sd) ")" ///
            _col(40) %3.2f r(min) "-" %3.2f r(max)
end

use transplants, clear
table1

log close _all

//exit command. Within a .do file, it doesn't close Stata. It just stops 
//running the .do file
exit



```