#!usr/bin/tclsh


#the main function cleans the generated files,
#checks the accurance of the input_file,
#if everything is ok, it calls the solving function,
#otherwise writes the message in the golden and output files
proc main {} {
        source "jacobi_functions.tcl"
        clean_files
        if {[check_input]} {
        	set m [read_matrix "input.txt"]
        	if {[llength [jacobi $m]] == 0 } {
                	write_data "output.txt" "no dominant"
        	} else {
                	write_data "output.txt" [jacobi $m]
        	}
        } else {
                set answer "wrong input"
                write_data "output.txt" $answer
                write_data "result.txt" $answer
        }
}

main

