/*
Created by Richard Ball
This version:  2015-09-21
Written for Stata 14--SE, 64-bit, for Windows
*/


clear
set more off

*OPEN THE IMPORTABLE PEW DATA
use "..\Importable Data\importable-pew.dta"

*KEEP ONLY THE VARIABLES THAT WILL BE USED FOR 
*THIS STUDY
keep country q2 q74

*GIVE THE VARIABLES NICER NAMES AND LABELS
rename q2 satis
label variable satis "Satisfaction (self-report; scale of 0-10)"

rename q74 age
label variable age "Age (in years)"


*FOR VARIABLES satis AND age
*RECODE "DON'T KNOW" AS "." 
*AND RECODE "REFUSED" AS ".a"

/*
To see how missing values and refusals are coded for satis
	tab satis
	tab satis, nolabel
*/

recode satis 11=. 12=.a

/*
To see how missing values and refusals are coded for age
	tab age
	tab age, nolabel
*/

recode age 98=. 99=.a


*DROP OBSERVATIONS FOR ALL INDIVIDUALS FOR WHOM 
*THE VALUE OF THE VARIABLE satis IS MISSING OR REFUSED
drop if satis>=.

*DROP OBSERVATIONS FOR ALL INDIVIDUALS WHO ARE 
*LESS THAN 21 OR MORE THAN 70 YEARS OF AGE
*OR FOR WHOM THE VALUE OF THE VARIABLE age IS MISSING

*To drop observations where the value of age is either
*greater than 70, or missing or refused
drop if age>70

*To drop observations where the value of age is less than 21
drop if age<21


*KEEP DATA ONLY FOR COUNTRIES WITH AT LEAST 900 OBSERVATIONS
*REMAINING IN THE SAMPLE AFTER REMOVAL OF INDIVIDUALS WITH 
*MISSING OR REFUSED VALUES OF satis 0R age, AS WELL AS REMOVAL
*OF INDIVIDUALS UNDER 21 OR OVER 70 YEARS OF AGE

*First, generate a variable called country_n that, for each
*individual, equals the total number of observations that remain 
*in the sample representing individuals from her/his own country

bysort country: gen country_n=_N

*Then drop all individuals for whom country_n is less than 900
drop if country_n<900

*The variable country_n is no longer needed, so drop it
drop country_n


*FOR THE VARIABLE country, THE VALUE LABEL FOR THE USA (country=40)
*is "us".  CHANGE THAT VALUE LABEL TO "US" (just to be consistent with 
*value labels for other countries, which are capitalized)
label define COUNTRY 40 US, modify
label value country COUNTRY


*IN SOME OF THE ANALYSIS I WILL WANT TO USE BOTH AGE AND
*THE SQUARE OF AGE.  SO GENERATE A NEW VARIABLE age2 EQUAL
*TO THE SQUARE OF AGE.
gen age2=age^2


*SAVE THE MODIFIED DATA SET 
*WITH THE NAME pew.dta
save "pew.dta", replace
