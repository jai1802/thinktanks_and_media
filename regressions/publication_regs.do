cd /Users/jai/Desktop/think_tanks_media
insheet using "../data/panels/master_panel.csv", comma clear

// encoding fixed effect variables
encode pub, gen(n_pub)
encode thinktank, gen(n_thinktank)

// log expenses
gen log_exp = log(1+expenses)

// generating sqrt(age)
gen root_age = sqrt(age)

// encoding conservative + libertarian event variables
gen event_14 = cons_lib if year==2014
replace event_14 = 0 if year != 2014

gen event_15 = cons_lib if year==2015
replace event_15 = 0 if year != 2015

gen event_16 = cons_lib if year==2016
replace event_16 = 0 if year != 2016

gen event_17 = cons_lib if year==2017
replace event_17 = 0 if year != 2017

gen event_18 = cons_lib if year==2018
replace event_18 = 0 if year != 2018




// qui eststo: reghdfe num_cites event_14 event_15 event_17 event_18 if pub=="NYT", absorb(i.year#i.n_pub i.n_thinktank) vce(robust)
// qui estadd local control "No", replace
// qui estadd local cons_treat "Yes", replace
// qui estadd local libs_treat "Yes", replace
//
// qui eststo: reghdfe num_cites event_14 event_15 event_17 event_18 if pub=="WP", absorb(i.year#i.n_pub i.n_thinktank) vce(robust)
// qui estadd local control "No", replace
// qui estadd local cons_treat "Yes", replace
// qui estadd local libs_treat "Yes", replace
//
// qui eststo: reghdfe num_cites event_14 event_15 event_17 event_18 if pub=="WSJ", absorb(i.year#i.n_pub i.n_thinktank) vce(robust)
// qui estadd local control "No", replace
// qui estadd local cons_treat "Yes", replace
// qui estadd local libs_treat "Yes", replace

qui eststo: reghdfe num_cites root_age log_exp event_14 event_15 event_17 event_18 if pub=="NYT", absorb(i.year i.n_thinktank) vce(robust)
qui estadd local control "Yes", replace
qui estadd local cons_treat "Yes", replace
qui estadd local libs_treat "Yes", replace

qui eststo: reghdfe num_cites root_age log_exp event_14 event_15 event_17 event_18 if pub=="WP", absorb(i.year i.n_thinktank) vce(robust)
qui estadd local control "Yes", replace
qui estadd local cons_treat "Yes", replace
qui estadd local libs_treat "Yes", replace

qui eststo: reghdfe num_cites root_age log_exp event_14 event_15 event_17 event_18 if pub=="WSJ", absorb(i.year i.n_thinktank) vce(robust)
qui estadd local control "Yes", replace
qui estadd local cons_treat "Yes", replace
qui estadd local libs_treat "Yes", replace


local pattern prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})

esttab est1 est2 est3 using "./regressions/Publication Regs.tex", replace booktabs substitute(\_ _) ///
	se(5) ar2 nomtitles mgroups("Number of Citations", pattern(1) `pattern') scalar(F) ///
	star(* 0.1 ** 0.05 *** 0.001) label s(control cons_treat libs_treat F N, ///
		label("Controls" "Conservative Treatment" "Libertarian Treatment" "F-stat" "N")) ///
	keep(root_age log_exp event_14 event_15 event_17 event_18) ///
	coeflabels(root_age "$\sqrt{Age}$" log_exp "\small $\ln(1+Expenses)$" event_14 "\large $\gamma_{2014}$" event_15 "\large $\gamma_{2015}$" event_17 ///
		"\large $\gamma_{2017}$" event_18 "\large $\gamma_{2018}$") ///
	prehead(`"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}"' ///
		`"\setlength\tabcolsep{17pt}"' ///
		`"\begin{tabular}{@{\extracolsep{7pt}}lcccc}"' ///
		`"\toprule"') ///
	postfoot( `"\bottomrule"' ///
		`"\end{tabular}"')
	