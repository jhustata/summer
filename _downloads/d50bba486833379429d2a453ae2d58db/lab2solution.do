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
