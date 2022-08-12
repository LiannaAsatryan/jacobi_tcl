#What this project does
 This project solves the given system of linear equations using jacobi method

#files
 in this directory there are following files
* input.txt __ it is the file where our matrix example is written like this
	        size
		________
               |       |
               |matrix |
               |_______|

* golden.txt __ it is the file where our correct answer is located
* jacobi_functions.tcl __ this file contains the functions which solve our main problem (jacobi and other related functions) 
* jacobi_test.tcl __ this file  contains the operation of the testing 
* main.tcl __ this file solves the main problem(without testing)
 the files that will be generated are 
*output.txt__here result-values are written
*result.txt__here test results are written(test passed or not)


#description
My project solves the system of linear equations
if the given matrix isn't STRICTLY diagonally dominant, the answer is "no dominant"
If a letter is typed in place of number, or a wrong size is typed the answer is "wrong imput"
And finally, when our system has solution the answer is written like this   "sol1 sol2 sol3 ... soln"
NOTE: in my output and golden files the solutions are written in 5



#to run the main program type in command line
 tclsh main.tcl
to clean the generated files type 
 rm output.txt


#to run the test type in command line
 tclsh jacobi_test.tcl
to clean the generated files type 
 rm output.txt result.txt
