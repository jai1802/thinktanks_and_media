cd /Users/jai/Desktop/think_tanks_media
insheet using "./data/master_panel.csv", comma clear

// encoding fixed effect variables
encode pub, gen(n_pub)
encode thinktank, gen(n_thinktank)

// encoding event variables
gen event_14 = con_lib if year==2014
replace event_14 = 0 if year != 2014

gen event_15 = con_lib if year==2015
replace event_15 = 0 if year != 2015

gen event_16 = con_lib if year==2016
replace event_16 = 0 if year != 2016

gen event_17 = con_lib if year==2017
replace event_17 = 0 if year != 2017

gen event_18 = con_lib if year==2018
replace event_18 = 0 if year != 2018

gen root_age = sqrt(age)

reghdfe num_cites age expenses event_14 event_15 event_17 event_18, absorb(i.year#i.n_pub i.n_thinktank)

