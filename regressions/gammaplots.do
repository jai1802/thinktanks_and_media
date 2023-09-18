cd /Users/jai/Desktop/think_tanks_media
insheet using "../data/panels/master_panel.csv", comma clear

// encoding fixed effect variables
encode pub, gen(n_pub)
encode thinktank, gen(n_thinktank)

// log expenses
gen log_exp = log(1+expenses)

// generating sqrt(age)
gen root_age = sqrt(age)

// encoding conservative event variables
gen event_14 = conservative if year==2014
replace event_14 = 0 if year != 2014

gen event_15 = conservative if year==2015
replace event_15 = 0 if year != 2015

gen event_16 = conservative if year==2016
replace event_16 = 0 if year != 2016

gen event_17 = conservative if year==2017
replace event_17 = 0 if year != 2017

gen event_18 = conservative if year==2018
replace event_18 = 0 if year != 2018

qui eststo: reghdfe num_cites event_14 event_15 event_17 event_18, absorb(i.year#i.n_pub i.n_thinktank) vce(robust)
qui estadd local control "No", replace
qui estadd local cons_treat "Yes", replace
qui estadd local libs_treat "No", replace

qui eststo: reghdfe num_cites root_age log_exp event_14 event_15 event_17 event_18, absorb(i.year#i.n_pub i.n_thinktank) vce(robust)
qui estadd local control "Yes", replace
qui estadd local cons_treat "Yes", replace
qui estadd local libs_treat "No", replace



// encoding conservative + libertarian event variables
replace event_14 = cons_lib if year==2014
replace event_14 = 0 if year != 2014

replace event_15 = cons_lib if year==2015
replace event_15 = 0 if year != 2015

replace event_16 = cons_lib if year==2016
replace event_16 = 0 if year != 2016

replace event_17 = cons_lib if year==2017
replace event_17 = 0 if year != 2017

replace event_18 = cons_lib if year==2018
replace event_18 = 0 if year != 2018




qui eststo: reghdfe num_cites event_14 event_15 event_17 event_18, absorb(i.year#i.n_pub i.n_thinktank) vce(robust)
qui estadd local control "No", replace
qui estadd local cons_treat "Yes", replace
qui estadd local libs_treat "Yes", replace

qui eststo: reghdfe num_cites root_age log_exp event_14 event_15 event_17 event_18, absorb(i.year#i.n_pub i.n_thinktank) vce(robust)
qui estadd local control "Yes", replace
qui estadd local cons_treat "Yes", replace
qui estadd local libs_treat "Yes", replace


coefplot est2 est4, vertical drop(_cons root_age log_exp) ylin(0) rename(event_14="{&gamma}{sub:2014}" event_15="{&gamma}{sub:2015}" event_17="{&gamma}{sub:2017}" event_18="{&gamma}{sub:2018}")
