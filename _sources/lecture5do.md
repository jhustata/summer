```stata
clear all
capture log close
log using lecture5, replace text

//commands corresponding to lecture 5 of the Summer Epi Stata class

set more off


//histograms
use transplants, clear


//basic histogram (density histogram)
hist bmi

//specify that each bar of the histogram covers an interval of two units
hist bmi, width(2)

//specify age interval of two years, and start the graph at age 0
hist bmi, width(2) start(0)

//specify that we want ten bars
hist bmi, bin(10)

//specify that we want a *fraction* histogram (height of 0.1=10% of all values)
hist rec_wgt_kg, fraction width(2)

hist rec_wgt_kg, fraction width(10)

//a *percent* histogram (height of 10 = 10% of all values)
hist rec_wgt_kg, percent width(2)
hist rec_wgt_kg, percent width(10)

//a *frequency* histogram (height = # of records represented by one bar)
hist rec_wgt_kg, freq width(2)
hist rec_wgt_kg, freq width(10)

//illustrating hist, discrete discrete
hist dx //each bar is < 1 diagnosis - histogram looks weird
hist dx, discrete //1 bar per diagnosis



//scatter plots
use donors, clear
graph twoway scatter don_wgt don_hgt

//abbreviation
twoway scatter don_wgt don_hgt
tw sc don_wgt don_hgt


//line plots
use transplants, clear
bys age: egen mean_ecd = mean(don_ecd)
egen age_tag = tag(age)
	
//just need one observation for each age
graph twoway line mean_ecd age if age_tag==1

//The following code makes the dataset tx_yr.dta
//remove the comment braces to run the code and create tx_yr.dta

use transplants, clear
gen int yr = year(transplant_date)
gen byte n=1
rename gender female
rename don_ecd ecd
gen over70 = (age>70)
gen unknown_disease  = dx==9
gen hypertensive = dx==4
gen diabetes = dx==2
gen not_working = cond(rec_work == 0,1,0)
collapse (sum) not_working n hypertensive unknown_disease diabetes ecd female rec_hcv_antibody over70 , by(yr)
gen int male=n-female
gen int scd = n-ecd
gen total= n 
lab var total "Total Num. of Recipients"
lab var not_working "Num. Unemployed Recipients"
lab var yr "Transplant Year"
lab var rec_hcv "Number HCV+ Recipients"
lab var over70 "Number Recips. Over 70 Years Old" 
save tx_yr, replace

use tx_yr.dta, clear
desc

//show various kinds of graph in their simplest form
graph twoway line n yr  //line graph
graph twoway connected n yr  //connected graph
graph twoway area n yr  //area graph
graph twoway bar n yr  //bar graph
graph twoway scatter ecd scd  //scatter plot
graph twoway function y=x^2+2  //function

//range() option for function
graph twoway function y=x^2+2, range (1 10)  //function
graph twoway function y=x^2+2, range(yr)

//graphing more than one Y variable
graph twoway line ecd scd yr
graph twoway line n ecd scd yr
graph twoway area ecd scd yr //ecd area is hidden by scd area
graph twoway area scd ecd yr //now ecd area shows, since it's drawn second
graph twoway bar  scd ecd yr 

//overlaying several plots
graph twoway line n yr || connected male female yr

//another way of writing the same thing, using /// to continue the same
//command on two lines
graph twoway line n yr || ///
    connected male female yr

//overlay observed data with linear regression fit
regress n yr
graph twoway line n yr ///
  || function y=_b[_cons]+_b[yr]*x, range(yr)


//illustrate that you can combine lots of plots in one graph
graph twoway line female yr ///
  || line male yr ///
  || line scd yr ///
  || line ecd yr ///
  || line n yr

//of course, you could make the same graph with
//graph twoway line female male scd ecd n yr

//xscale/yscale
graph twoway line n yr, yscale(range(0)) //range of Y axis includes zero
graph twoway line n yr, yscale(range(0 400)) //Y axis range includes 0 and 400

//specify ranges for both X and Y axes
graph twoway line n yr, xscale(range(2018)) 

graph twoway line female yr, yscale(log) //write Y axis on a log scale
graph twoway line female yr, xscale(reverse) //reverse the X axis - mirror image
graph twoway line female yr, xscale(off) yscale(off) //suppress axes entirely

//combining several scale options
//this graph doesn't look great. For the variables that we're using for this
//exercise, the default Stata axes look pretty good. But this illustrates
//that you can combine as many scale options as you want.
graph twoway line ecd yr, xscale(off) yscale(log range(1) reverse)

//graph label options
//Pick "approximately four" nice values based on axis range
graph twoway line n yr, yscale(range(0)) ylabel(#4)

//label minimum and maximum values
graph twoway line n yr, yscale(range(0)) ylabel(minmax)

//start at 0, and go in increments of 10 up to 110
graph twoway line n yr, yscale(range(0)) ylabel(0(50)250)

//add "ticks" (small vertical line) every unlabeled year in X axis
graph twoway line n yr, yscale(range(0)) ylabel(0(50)250) xtick(2006(1)2015)

//axis titles
//DDKT = deceased donor kidney transplant
graph twoway line n yr, xtitle("Calendar year") ytitle("DDKT") ylabel(0(50)250)


//graph titles
graph twoway line n yr, title("Transplants per year") ylabel(0(50)250)

//title and subtitle
graph twoway line n yr, title("Transplants per year") ylabel(0(50)250) ///
    subtitle("2006-2015") 

//note and caption options
graph twoway line n yr, title("title") subtitle("subtitle") ///
  note("note") caption("caption")
  
  
//legend options
//put the legend inside the graph
graph twoway line male female yr, legend(ring(0)) 

//put the legend inside the graph, in upper-left corner ("eleven o'clock")
graph twoway line male female yr, legend(ring(0) pos(11)) 

//put the legend inside the graph, in lower-right corner ("five o'clock")
graph twoway line male female yr, legend(ring(0) pos(5)) 

//put the legend at 5:00 - change Y range so it fits
graph twoway line male female yr, legend(ring(0) pos(5)) yscale(range(0))

//put the different legend "keys" in one column
graph twoway line male female yr, legend(ring(0) pos(5) cols(1)) 

//change the order of the "keys"
//in this case, you just could do "twoway line female male yr"
//but order() is really handy when you have complicated graphs containing
//multiple types of plot
graph twoway line male female yr, legend(ring(0) pos(5)  order(2 1)) 
graph twoway line male female yr, legend(ring(0) pos(5) cols(1) order(2 1)) 

//print the legend for males but not females
// ("order") suppresses legend for anything that's not included)
graph twoway line male female yr, legend(ring(0) pos(5) cols(1) order(1)) 

//legend labels
graph twoway line male female yr, ///
    legend(ring(0) pos(5) cols(1) label(1 "Men") label(2 "Women"))

//force legend to print (when it normally wouldn't)
graph twoway line n yr, legend(on)

//force legend *NOT* to print (when it normally would)
graph twoway line male female yr, legend(off)

//line options
twoway line n yr, xline(2007)
twoway line n yr, yline(200)

//text option
//add the text "policy change" at y=300 x=2007 on the graph
twoway line n yr, xline(2007) text(200 2007 "Policy change")

twoway line n yr, ylabel(0(50)250) text(225 2014 "Local peak in 2014")

//twoway line options
//sort
//first, we have to *UN*sort

sort n
list, clean noobs

//display unsorted graph
twoway line n yr, ylabel(0(100)400)

//now display the graph with the line drawn properly
twoway line n yr, ylabel(0(100)400) sort 

//options for drawing the line: line color
twoway line  scd ecd yr, lcolor(green yellow) ylabel(0(50)200) sort

//line thickness
twoway line scd ecd  yr, lwidth(thick thick) sort
//valid thicknesses are:
//vvthin vthin thin medthin medium medthick thick vthick vvthick vvvthick 


//line pattern
twoway line scd ecd yr, lpattern(solid dash) sort
//valid patterns are:
//solid dash dot dash_dot shortdash shortdash_dot longdash longdash_dot blank 

//scatter plot options
use transplants.dta, clear
keep if peak_pra <= 10
graph twoway scatter peak_pra age

//add jitter (random noise)
graph twoway scatter peak_pra age, jitter(2)

graph twoway scatter bmi age if gender==0, mcolor(orange) ///
 || scatter bmi age if gender==1, mcolor(black)

//marker symbol
graph twoway scatter bmi age if gender==0, msymbol(D) ///
    || scatter bmi age if gender==1, msymbol(+)

//marker size
graph twoway scatter bmi age if gender==0, msize(small) ///
    || scatter bmi age if gender==1, msize(large)
//valid sizes:
// tiny vsmall small medsmall medium medlarge large vlarge huge 

//graph bar
use transplants.dta,clear
graph bar (mean) bmi ,over(race) 
graph bar (mean) bmi ,over(race, label(angle(45)))
graph bar (mean) bmi age ,over(race, label(angle(45)))
graph bar (median) bmi age ,over(race, label(angle(45)))


//graph box
graph box bmi age,over(rec_education,label(angle(45)))
graph box bmi,over(prev_ki) over(rec_hcv)

//create label so that it shows up on graph
label define prev_ki_label 0 "First time KT" 1 "Previous KT"
label values prev_ki prev_ki_label
graph box age,over(prev_ki) over(rec_hcv) b1title(Recipient HCV and Previous KT)

//saving a graph as a Stata .gph file
graph save bmi_plot.gph, replace

//exporting a graph to .PNG (for putting in a document)
graph export bmi_plot.png, replace
graph export bmi_plot.png, replace width(2400) //saves with more pixels





log close

```