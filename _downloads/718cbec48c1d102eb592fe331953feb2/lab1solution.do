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

 