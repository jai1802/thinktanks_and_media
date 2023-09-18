cd /Users/jai/Desktop/think_tanks_media
insheet using "../data/panels/econ_panel.csv", comma clear

// encoding fixed effect variables
encode pub, gen(n_pub)
encode thinktank, gen(n_thinktank)

// log expenses
gen log_exp = log(1+expenses)

// generating sqrt(age)
gen root_age = sqrt(age)


// encoding conservative + libertarian event variables
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

qui eststo: reghdfe num_cites root_age log_exp event_14 event_15 event_17 event_18, absorb(i.year#i.n_pub i.n_thinktank) vce(robust)
qui estadd local control "Yes", replace
qui estadd local cons_treat "Yes", replace
qui estadd local libs_treat "Yes", replace

insheet using "../data/panels/edu_panel.csv", comma clear

// encoding fixed effect variables
encode pub, gen(n_pub)
encode thinktank, gen(n_thinktank)

// log expenses
gen log_exp = log(1+expenses)

// generating sqrt(age)
gen root_age = sqrt(age)


// encoding conservative + libertarian event variables
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

qui eststo: reghdfe num_cites root_age log_exp event_14 event_15 event_17 event_18, absorb(i.year#i.n_pub i.n_thinktank) vce(robust)
qui estadd local control "Yes", replace
qui estadd local cons_treat "Yes", replace
qui estadd local libs_treat "Yes", replace


insheet using "../data/panels/health_panel.csv", comma clear

// encoding fixed effect variables
encode pub, gen(n_pub)
encode thinktank, gen(n_thinktank)

// log expenses
gen log_exp = log(1+expenses)

// generating sqrt(age)
gen root_age = sqrt(age)


// encoding conservative + libertarian event variables
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

qui eststo: reghdfe num_cites root_age log_exp event_14 event_15 event_17 event_18, absorb(i.year#i.n_pub i.n_thinktank) vce(robust)
qui estadd local control "Yes", replace
qui estadd local cons_treat "Yes", replace
qui estadd local libs_treat "Yes", replace


insheet using "../data/panels/pol_panel.csv", comma clear

// encoding fixed effect variables
encode pub, gen(n_pub)
encode thinktank, gen(n_thinktank)

// log expenses
gen log_exp = log(1+expenses)

// generating sqrt(age)
gen root_age = sqrt(age)


// encoding conservative + libertarian event variables
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


qui eststo: reghdfe num_cites root_age log_exp event_14 event_15 event_17 event_18, absorb(i.year#i.n_pub i.n_thinktank) vce(robust)
qui estadd local control "Yes", replace
qui estadd local cons_treat "Yes", replace
qui estadd local libs_treat "Yes", replace


local pattern prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})

esttab est1 est2 est3 est4 using "./regressions/Topic Regressions.tex", replace booktabs substitute(\_ _) ///
	se(5) ar2 nomtitles mgroups("Number of Citations", pattern(1) `pattern') scalar(F) ///
	eqlabels("Economics" "Education" "Health" "Politics") ///
	star(* 0.1 ** 0.05 *** 0.001) label s(control cons_treat libs_treat F N, ///
		label("Controls" "Conservative Treatment" "Libertarian Treatment" "F-stat" "N")) ///
	keep(root_age log_exp event_14 event_15 event_17 event_18) ///
	coeflabels(event_14 "\large $\gamma_{2014}$" event_15 "\large $\gamma_{2015}$" event_17 ///
		"\large $\gamma_{2017}$" event_18 "\large $\gamma_{2018}$" root_age "$\sqrt{Age}$" log_exp "\small $\ln(1+Expenses)$") ///
	prehead(`"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}"' ///
		`"\setlength\tabcolsep{17pt}"' ///
		`"\begin{tabular}{@{\extracolsep{7pt}}lcccc}"' ///
		`"\toprule"') ///
	postfoot( `"\bottomrule"' ///
		`"\end{tabular}"')


coefplot est1 est2 est3 est4, vertical drop(_cons root_age log_exp) ylin(0) rename(event_14="{&gamma}{sub:2014}" event_15="{&gamma}{sub:2015}" event_17="{&gamma}{sub:2017}" event_18="{&gamma}{sub:2018}")

