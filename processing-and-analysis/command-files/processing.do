/*
Created by Richard Ball
This version:  2015-09-21
Written for Stata 14--SE, 64-bit, for Windows
*/


clear
set more off


*OPEN THE IMPORTABLE PEW DATA
use "pew.dta"


*MERGE IN THE WDI DATA
merge m:1 country using "wdi.dta"

/*Check that all the observations matched
when you did the merge

tab _merge
*/

*since the observations all match, drop _merge
drop _merge


*SAVE THE INDIVIDUAL-LEVEL DATA WITH THE NAME individual-analysis.dta
save "..\Analysis Data\individual-analysis.dta", replace


*CREATE A COUNTRY-LEVEL DATA SET 
*WITH COUNTRIES IDENTIFIED BY countryname AND country 
*INCLUDING THE VARIABLES satis exp AND inc
*IN WHICH

	*THE VALUE OF satis IS EQUAL TO THE MEAN VALUE
	*FOR ALL INDIVIDUALS IN THE COUNTRY
	
	*THE VALUES OF exp AND inc ARE THE VALUES
	*OF THESE VARIABLES FOR THE COUNTRY IN THE YEAR 2002
	
collapse country satis exp inc, by(countryname)


*CHANGE THE NAME OF THE VARIABLES satis TO cm_satis
*TO INDICATE THAT IN THE COUNTRY-LEVEL
*DATA SET IT REPRESENTS THE COUNTRY MEAN (cm) OF satis
rename satis cm_satis


*GIVE THE VARIABLES NICER LABELS
label variable countryname Country
label variable country "Country ID"
label variable cm_satis "Country Mean Satisfaction"
label variable exp "Gov. cons., % of GDP"
label variable inc "GDP per capita (current [2002] $ US)"
 

*SAVE THE COUNTRY-LEVEL DATA WITH THE NAME country-analysis.dta
save "..\Analysis Data\country-analysis.dta", replace

erase pew.dta
erase wdi.dta
