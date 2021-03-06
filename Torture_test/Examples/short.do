/*
MarkDoc Torture Test 001 : Main Features Test
---------------------------------------------

Author: 		E. F. Haghish
				Institute for Medical Biometry and Statistics (IMBI)
				University of Freiburg
				http://haghish.com/stat
				@haghish
		
Requirements:	Install MarkDoc, Weaver, and Statax packages
				Install Pandoc and Wkhtmltopdf
				If you wish to produce PDF Slides, install a complete LaTeX 
*/

capture erase example.docx

set scheme s1manual 
set linesize 80
cap qui log c

qui log using example, replace smcl


/***
MarkDoc Feature Test
====================

This document attempts to check the main features of MarkDoc, for a broad 
assessment of the package before every new release. 
***/

sysuse auto, clear
/***
Text styling check
------------------

_this is Italic_.
__this is bold__.
___this is Italic and Bold___.
`this text line should be in monospace font`.

Variable check
--------------

Figure 1 shows the distribution of the __Price__ variable, followed by a 
regression analysis. 
***/

histogram price
img, title("Figure 1. The histogram of the price variable")
regress price mpg
//OFF
mat A = r(table)
scalar p1   = A[4,1]
//ON
txt "As the output demonstrates, the average price of cars is " pmean " and "	///
	"the standard deviation is " psd ". The summary of the __price__ and "		///
	"__mpg__ variables is given in Table 1. " 									///
	"Moreover, the regression analysis reveals the coefficient of the __mpg__ " ///
	"variable to be " coe1 " with a P-value of " p1 ", which is significant."
 

//OFF
qui summarize price 
	scalar pnum  = r(N)
	scalar pmean = r(mean)
	scalar psd   = r(sd)
qui summarize mpg	
//ON

tbl ("__variable__", "__Observations__", "__Mean__", "__SD__" \					///
	"__Price__", pnum, pmean,   psd \											///
	"__Mpg__",   r(N), r(mean), r(sd) ), 										///
	title("_Table 1_. Summary of the price and mpg variables")

	
qui log c
markdoc example, install replace export(docx) 									///
title("MarkDoc Main Features Test") author("E. F. Haghish") 					///
affiliation("IMBI, University of Freiburg") summary("This document presents "	///
"the main features of [MarkDoc package], a multi-purpose package for creating "	///
"dynamic PDF slides and analysis reports in many formats such as __pdf__, "		///
"__docx__, __html__, __latex__, and __epub__. The package supports many "		///
"features and recognizes three markup languages, which are Markdown, HTML, "	///
"and LaTeX." ) 
	
