```stata
capture log close _all
capture cmdlog close
log using lecture01.log, replace text

//This log file contains most of the examples used in Lecture 1 of
//Stata Programming and Data Management, along with additional explanations
//and examples.

version 12 //I'm using Stata 16, but some students may have earlier versions
clear all //clear all data from memory
macro drop _all //clear all macros in memory
set more off   //give output all at once (not one screenful at a time)
set linesize 80 //maximum allowed width for output
 
//logging
//remember "log using lecture01.txt, replace" above
// ", replace" = if the file exists, overwrite it

//getting help
//usually you won't have this in your .do file
//instead you would type "help [command]" interactively
//these examples use "chelp" and "man" which displays the help in the Stata
//output window instead of popping up a new window
chelp generate
man generate
man legend option //show help for the legend option

//some help files are not for a specific command - just general info
man language 

//do some stuff
display "hello everybody"
use transplants, clear
summarize wait_yrs age 
tab rec_hcv
regress wait_yrs age rec_hcv


//loading a data file into memory
use transplants.dta

//clear the memory before loading the file. NOTE: Stata can only have one
//dataset at a time in memory. If you have changed the data since loading
//it, then "use transplants.dta" will fail unless you specify the "clear" 
//option.
use transplants.dta, clear

//load only records from females (gender=1)
use transplants if pretx_cmv==1

//load only the first fifty records
use transplants in 1/50

//load only certain variables
use age gender rec_hcv_antibody wait_yrs fake_id using transplants

//more examples.
use age dx using transplants  //only age and diagnosis
use transplants in 1/50, clear //only the first 50 records
use transplants in 44  //only the 44th record
use transplants if rec_work==1 //only records of patients who work for an income
use a* p* using transplants in 1/100 //all variables that the name starts
// with A or P. Only the first 100 rows.

//load the entire dataset now
use transplants, clear

//describe command
describe //describe all the variables
describe, simple  //just list all the variable names

//don't list variable names. list some summary info about the file
describe, short   

describe a*   //only variables that name starts with A
describe using transplants.dta  //describe transplants.dta without loading 
// data into memory

rename age a_very_long_variable_name
describe  //note that the long name gets truncated

describe, fullnames //now the long name can be read

//here's an interesting one. Make a dataset of variables!
//lists the position order, name, type, and other information
describe, replace clear

use transplants, clear

codebook //list codebook info: type, mean, range, etc
codebook rec_education rec_work abo  //do it for only a few variables
codebook a* e*, compact //compact format
codebook, problems   //ask Stata to identify problems with the dataset
//codebook, problems is a good check, but don't let it substitute for your 
//judgment

list  //print all the data in memory
list prev_ki wait_yrs if race==7  //list two variables  
//(previous KT & time on waitlist) for records that have race variable equal to 7

list *date in 1/10 //list all variables that the name ends with "date". List
//only the first ten observations.

//by default, "list" draws these weird ASCII boxes around the data. Also
//it lists a record # for each record. 
//list, clean" gets rid of the boxes. "list, noobs" gets rid of record #s.
list dx in 1/10, clean noobs

//usually, before displaying anything, list goes through the data to try
//to determine how much width to give each variable for the display.
//list, fast skips all that - handy for very large datasets
list age, fast

//Count. 
count  //display a count of all the records in memory
count if rec_work==1   //display a count of records with "race" equal to 1
count if rec_work != 1  //records with race *not* equal to 1
count if bmi<20 | bmi > 35  //records with BMI less than 20 or greater than 35
count if bmi>25 & bmi < 30  //records with BMI greater than 25 and less than 30
count if !(age>18)    //count if not (age>18) - records with age 18 and under

count if inrange(wait_yrs, 4, 6) //records w BMI of 20, 25, or anything in between
count if !inlist(gender, 0, 1)  //gender equals either zero or 1
count if !inlist(age, 20, 30, 40, 50)  //age is 20 or 30 etc

//Note: this line of code (commented out) does *NOT* work.
//you're not allowed to have a space between "inrange" and the parenthesis.
//count if inrange (bmi,20,25) //error!


//Tabulate/tab.
tab abo  //1-way frequency table of variable "abo"
tab abo rec_hcv  //2-way table of "abo" and "rec_hcv"
tab rec_hcv, sum(age) //display mean, SD and frequency of age, by gender
tab dx gender if age<40 //2-way table. Only for patients under age 40

//more examples
tab dx gender, row //display row percentages
tab dx gender, col nofreq //column percentages. Also, *don't* display frequency
tab dx gender, col nofreq chi2 //add a chi-squared test

//summarize/sum

sum //summarize all variables
sum age wait_yrs  //summarize only two variables
sum age wait_yrs, detail //give more detailed summary

//missingness.
//if data is not available for a record - maybe it wasn't obtained, maybe 
//it was recorded improperly, whatever - a variable can be set to a
// *missing value* for that record.
//one weird quirk of Stata is that a missing value is considered greater
//than any finite number value.

count if bmi > 30  //so this is "BMI > 30, or missing BMI"
count if bmi > 1000 //this is "BMI > 1000, or missing"
tab bmi if bmi > 1000  // *tab* command does not display missing values
tab bmi if bmi > 1000, missing  //Now tab displays missing values
count if bmi == .  //the dot represents a missing value.
//however, you have to be careful because there are actually several different
//missing values. All of these are valid missing values: 
//    .    .a   .b    .c   .d                etc.
//maybe you could set .a to mean "missing, patient was not asked"
//.b could mean "missing, patient did not know"
//.c could mean "missing, data has not been entered yet"
//etc.

count if bmi == .a    //checking for a different missing value
count if missing(bmi)  //this one counts _all_ missing values

//generate / gen.
//create new variable age_lastyear. Calculate it as current age minus 1
gen age_lastyear=age-1 

//create new variable any_college. Set to 1 if rec_education >= 3, 0 otherwise
gen any_college=(rec_educ>=3)


//create new variable youngman. Set to 1 if age<40 and gender is 0;
//otherwise set to 0 
gen youngman=(age<40)&(gender==0)

//more examples
gen byte thin=(bmi<22) //1 if BMI < 22, 0 otherwise

//if patient is female, age_f is the same as age. Otherwise it's missing
gen age_f = age if gender==1

//one way to make a spline. "age>40" evaluates to 1 for patients over 
//age 40 and zero for everyone else. So for patients who are, say, 37,
//this evaluates to 0*-3 which is zero. For patients who are age 59,
//it evaluates to 1*(59-40) = 1*19 = 19.
gen age_spline=(age>40)*(age-40)

//_n
gen new_id = _n  //new_id = current record number
gen total_records = _N  //total_records = count of records in the dataset
//(same for all patients)

//ranges from near zero for first record, to 1 for the last record
gen percentile = 100*_n/_N 


//sort and gsort. They are the same, except that with sort you can only
//sort an ascending order (e.g. A-Z or 1-10) whereas gsort allows you to 
//sort in either ascending or *descending* order (e.g. Z-A or 10-1)

sort age //sort on age
sort age dx //sort first on age, then diagnosis

//reverse sort on age, then gender, then reverse sort on ethnicity category
gsort -age dx -race 


//drop most variables from the database. Keep only age, gender, BMI, 
//fake_id, and any variable whose name starts with e
keep age gender bmi fake_id e*

drop end_date //get rid of variable end_date

//reload original dataset
use transplants, clear

//using "keep" and "drop" to drop records instead of variables
keep in 1/100  //keep only the first 100 records
drop if wait_yrs < 1  //drop everyone who was on waitlist for less than 1 year
keep if prev_ki==1  //keep only those with previous kidney transplant
drop if age<18 & abo==2 //drop people age<18 with blood type B

//reload original dataset
use transplants, clear

//replace: change the value of a variable
replace prev=0  //prev now equals zero for all records
replace wait_yrs=5 if wait_yrs>5  //wait_years now equals 5 if it was > 5
replace gender=gender+1  //gender was 0 or 1; now it's 1 or 2

//change BMI to missing if it's out of range
replace bmi = . if !inrange(bmi, 18,40) 

//rename: rename a variable. Pretty straightforward
rename age age_at_transplant
rename gender female

//reverse the above "rename"
rename female gender 

//recode
recode rec_education (3 4 5 = 9) //any record with rec_education of 3, 4, or 5 changes to 9

recode dx (1=1) (2=2) (*=9) //any dx value other than 1 or 2 gets changed to 9

//create new variable male. Any record that has gender=0, male=1 and vice versa
recode gender (0=1) (1=0), gen(male)




//erase data in memory
clear

//reload
use transplants

//leaving "save newfile" commented out. Will cause an error if "newfile" exists
//save newfile

//overwrite "newfile" if it exists
save newfile, replace

save, replace //overwrite the current filename. Usually, you don't want to
//do this in a .do file. You should keep the old file that was the source for
//your data manipulation.

//if you have Stata 11 or 12, save in Stata 10 format

//commented out because it may not work if you're running Stata 10
//saveold transplants_stata10


//insheet.
//these are all commented out because I didn't actually create all these
//text files.
/*

import delimited textfile.txt
import delimited text2.txt, clear
import delimited text3.txt, delim(" ")
import delimited text4.txt, delim(tab)
import delimited text5.txt, varnames(1)
import delimited text6.txt, varnames(nonames)

import delimited using textfile.txt //pull in data from a text file.
//Stata tries to make a reasonable guess as to what character is the
// *delimiter* separating columns within a row.

//import, but clear the memory first. If there's unsaved data in memory, and 
//you run import delimited, you'll get an error
import delimited using text2.txt, clear

//tell Stata that the delimiter is a comma
import delimited using text3.txt, delimiter(",")

//tell Stata the delimiter is a tab
import delimited using text4.txt, delimiter(tab) 

import delimited using text5.txt, delimiter (" ")  //delimiter is a space

//first row contains variable names, not data
import delimited using text5.txt, varnames(1)

//first row contains data, not variable names
import delimited using text5.txt, nonames

//here are other commands for importing data.
//we won't go over these in detail; see the help file for each command,
//, or type "help import"
infile
infix
import excel using file.xlsx
import sasxport using file.sas7bdat
import odbc
*/

//display / disp
display "hi there"  //print "hi there"
disp 4+7  //print "11"
sum wait_yrs  //summarize age

/* 
print this:
variable            mean
*/
disp "Variable" _col(20) "mean" 

/*
print this:
Wait time          [mean wait_yrs obtained from "sum" command above]
*/
disp "Wait time" _col(20) r(mean)

//capture. Run a command, but if there's an error, don't display the error

capture sum nonexistent_variable //no output, since this variable does not exist
capture disp 4+3   //displays 7
capture disp 4+    //no output, since there would be an error

//assert
//if all ages are < 100, nothing happens. If any age is >= 100, Stata gives
//an error and halts the script
assert age < 100 if !missing(age)
//assert age < 50  //commented out. However, if we ran this, we'd get an error
assert end_date >= transplant_date
assert inlist(gender, 0, 1)

//also commented out.
//either one of these statements is useful. Since what's being asserted is 
//false, then the script will halt here if we uncomment one of these lines.
//assert 2 < 1
//assert 0

//quietly
//run a command, but suppress output
quietly sum wait_yrs  //silently computes summary for wait_yrs
disp "Mean wait time: " r(mean)  //we can display mean wait time calculated by "sum wait_yrs"

//using "quietly" on several commands at once. Suppress all output.
quietly {
    sum bmi
    replace bmi = . if bmi > r(mean)*3
}

//Comments
sum age   //here are my comments explaining what this command does

/*
Here is a multiline comment
See? It's still a comment
*/

sum age, detail /*multiline comments can just be on one line */

* If the asterisk is the first character, the line is a comment

//line continuation
// type /// and two lines are run as a single command
describe age rec_hcv pretx_cmv ///
    don_ecd


recode race ///
    (1=1) ///
    (2=2) ///
    (4 5 6 7 9 = 9)

//labels
describe dx //user has no idea what variable "dx" means
label var dx "kidney disease diagnosis" //assign a label to the variable
describe dx  //now we can see the description

use transplants, clear
//making value labels.


tab gender //output is confusing; is "1" male or female?

label define g_label 0 "0=Male" ///
    1 "1=Female" 

//tell Stata to label values for variable "race" with label "eth_label"
label values gender g_label
//NOTE: the data for "race" does not change, just the display

tab gender //much better
tab gender, nolabel //don't show label

//recode+labels
recode race (1=0 "Cauc") ///
            (2=1 "AA") ///
            (4=2 "Hisp/Latino") ///
            (5/9=3 "Other"), /// Discuss this with Sam
            gen(race_cat)
tab race_cat

//preserve and restore
sum age //mean = 50 years
preserve //like setting a bookmark
drop if age < 50
sum age //mean = 61 years
restore //it's as if everything after the line "preserve" didn't happen
sum age //mean = 50 years

log close _all

//exit command. Within a .do file, it doesn't close Stata. It just stops 
//running the .do file
exit

sum age
So you see, the "sum age" command won't get run, since it's after "exit"
Also, what I'm typing here isn't commented out, but since it comes after "exit",
Stata doesn't process it

```