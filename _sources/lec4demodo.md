```stata

quietly {
     use transplants, clear

//generate relevant variables
     gen hypertensive=dx==4
     gen college=inlist(rec_education, 4, 5)
     gen male=gender==0
	 
	 
	 //label variables
	 label var age "Age, y"
	 label var male "Male"
	 label var bmi "BMI, kg/m2"
	 label var college "College Education"
	 
	 	 
     capture program drop table_fancy
     program define table_fancy
        syntax varlist [if] 

		//output to excel
		putexcel set demo_lab.xlsx, replace
        putexcel A1=("Regression table (Question 6)")
		local row=2
		
		//row1: output to Stata display
        noisily di "Regression table (Question 6)"

        quietly logistic hypertensive `varlist' `if'
        foreach v of varlist `varlist' {
           quietly lincom `v'
	 
	 //row2-5
	 //display macro
	       local D %3.1f
		   
	 //extended macros
	       local `v'_lab: variable label `v'
	       local `v'_or: di _col(30) `D' r(estimate)
	       local `v'_95ci: di `D' r(lb)
	       local `v'_ub: di `D' r(ub)
	 
	 //rows2-5: output to Stata display
	      noisily di "``v'_lab'        ``v'_or' (``v'_lb' - ``v'_ub')"
	
	
	//updated extended macro for OR
	//local `v'_or: di `D' r(estimate)
	
	 //rows2-5: export to Excel
	 quietly putexcel A`row'=("``v'_lab'") ///
	          B`row'=("``v'_or' (``v'_lb' - ``v'_ub')")
	

	
	//update row
	local row=`row' +1
	 
        }
	 end
}


table_fancy age bmi college male




```