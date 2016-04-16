/*
Created by Richard Ball
This version:  2015-09-21
Written for Stata 14--SE, 64-bit, for Windows
*/


***********************************
*INDIVIDUAL-LEVEL ANALYSIS DATA
***********************************
clear
set more off
use "..\Analysis Data\individual-analysis.dta"

*NUMBER OF RESPONDENTS IN EACH COUNTRY
tab countryname

*VARIABLE: satis

	*Frequency table:
	tab satis
	
	*Relative frequency chart:
	quietly tab satis, gen(sat_)
	graph bar sat_*
	drop sat_*

*VARIABLE: age

	*Summary statistics:
	tabstat age, stat(mean sd min p25 p50 p75 max)
	
	*Histogram:
	histogram age, percent



***********************************
*COUNTRY-LEVEL ANALYSIS DATA
***********************************
clear
set more off
use "..\Analysis Data\country-analysis.dta"

*VARIABLE: cm_satis

	*Summary statistics:
	tabstat cm_satis, stat(mean sd min p25 p50 p75 max)
	
	*Histogram:
	histogram cm_satis,  percent bin(3)

*VARIABLE: exp

	*Summary statistics:
	tabstat exp, stat(mean sd min p25 p50 p75 max)
	
	*Histogram:
	histogram exp,  percent bin(4)


*VARIABLE: inc

	*Summary statistics:
	tabstat inc, stat(mean sd min p25 p50 p75 max)
	
	*Histogram:
	histogram inc,  percent bin(4)





