clear all
//directory where the CSV files are located
cd "C:\Users\UseR\Documents\Stata_test"

// Loop over all admin data files
forvalues i = 1/3 {
    local adminfile "admin data `i'.csv"
    local admindata "admin`i'.dta"
    
    // Import and convert admin data
    import delimited "`adminfile'", clear
	
	// Remove id duplicate
    duplicates drop id, force
    save "`admindata'", replace
}
//Merging data
use "data.dta"
merge m:1 id using "admin1.dta", nogenerate
merge m:1 id using "admin2.dta", nogenerate
merge m:1 id using "admin3.dta"

// Save merged data
save merged_data.dta, replace


//Table of total number of completed surveys by each enumerator
collapse (sum) survey_complete, by(enum)
list enum survey_complete, sepby(enum)

//average and median values of time spent surveying, considering only completed surveys
clear all
use merged_data.dta
destring survey_complete, replace
destring survey_complete, generate(survey_complete_numeric)
keep if survey_complete == 1
tabstat surveytime, statistics(mean median)



//time spend for each completed survey
	clear all
	// dataset_name with the actual name of the dataset
	use merged_data.dta
	destring survey_complete, replace
	destring survey_complete, generate(survey_complete_numeric)

	// sort the data by surveyid and surveytime
	sort surveyid surveytime

	// keep only the observations where surveycomplete is "Yes"
	keep if survey_complete == 1

	// collapse the data by surveyid and surveytime
	collapse (first) surveytime, by(surveyid)

	// print the results
	list


// new variable for missing data
	use merged_data.dta, clear
	// Step 1: Generate a new variable counting missing data per id
	gen missing_count = .
	foreach var of varlist rscore_admin income_admin age_admin {
		replace missing_count = missing_count + missing(`var')
	}

	//Show the results in a table
	list missing_count rscore_admin income_admin age_admin



//survey item nobody answered
use merged_data.dta, clear

foreach var of varlist _all { // loop over all variables in the dataset
    qui sum `var' // compute summary statistics for the variable
    if r(N) == r(sum) { // check if number of non-missing values equals the number of observations
        di "Variable `var' has all missing values."
    }
}

//removing personally identifiable information (PII)
use merged_data.dta, clear
egen enum_id = seq(), from(1)
replace enum = string(enum_id)
save merged_data.dta, replace

//new variable called female & assignning the 0-1 values according to sex
//This section has variable data type issue
use merged_data.dta, clear
generate female_str= ""
replace female_str = "1" if sex == "Female"
replace female_str = "0" if sex != "Female"
list

//check all the remaining variables 
//is there any other variable that you think should be cleaned?
//Yes, in the age variable, some entries are seem the birthyear instead of age 
use merged_data.dta, clear
gen new_age = 0
replace new_age = age if age <= 100 & age > 0
replace new_age = 2023 - age if age <= 2023 & age > 100
replace age = new_age
save merged_data.dta, replace
