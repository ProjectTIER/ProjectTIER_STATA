/*
Created by Richard Ball
This version:  2015-09-21
Written for Stata 14--SE, 64-bit, for Windows
*/


clear
set more off


*IMPORT THE IMPORTABLE PEW DATA
insheet using "..\Importable data\importable-wdi.csv", names


*DROP VARIABLE seriesname BECAUSE IT IS REDUNDANT WITH seriescode
drop seriesname


*THE UNIT OF OBSERVATION IN THE WDI SPREADSHEET
*IS "COUNTRY/SERIES"
*RESHAPE THE SPREADSHEET SO THAT THE UNIT OF OBSERVATION
*IS "COUNTRY" AND EACH VARIABLE IS A SERIES
egen var_no=group(seriescode)
drop seriescode

rename yr2002 var

reshape wide var, i(countrycode) j(var_no)

rename var1 exp 
label variable exp "Gov. cons., % of GDP"
rename var2 inc
label variable inc "GDP per capita (current [2002] $ US)"
 

*SO THAT WE CAN MERGE THIS WDI DATA WITH THE PEW DATA,
*GENERATE A VARIABLE country THAT CODES THE COUNTRIES
*IN THE SAME WAY AS THE PEW DATA.
gen country=8 if countrycode=="CHN"
replace country=17 if countrycode=="IND"
replace country=18 if countrycode=="IDN"
replace country=27 if countrycode=="PAK"
replace country=31 if countrycode=="RUS"
replace country=40 if countrycode=="USA"
replace country=45 if countrycode=="JOR"


*BECAUSE WE HAVE CREATED THE VARIABLE country, 
*WE NO LONGER NEED THE VARIABLE countrycode
*SO WE DROP IT
drop countrycode 



*SAVE THE MODIFIED DATA SET 
*WITH THE NAME WDI.dta
save "wdi.dta", replace
