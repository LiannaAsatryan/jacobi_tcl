#!usr/bin/tclsh

proc test {golden_data} {
        set m [read_matrix "input.txt"]
	if {[llength [jacobi $m]] == 0 } {
		write_data "output.txt" "no dominant"
	} else {
		write_data "output.txt" [jacobi $m]
	}
	set similiar  [expr {[jacobi $m] == $golden_data}]
        if {$similiar == 1} {
        	write_data "result.txt" "test passed"
        } else { write_data "result.txt" "test not passed" }
}


#the main function cleans the generated files,
#checks the accurance of the input_file,
#if everything is ok, it calls the testing function,
#otherwise writes the message in the golden and output files
proc main {} {
        source "jacobi_functions.tcl"
        clean_files
        if {[check_input]} {
                set golden_data [read_data "golden.txt"]
		set golden_data [split $golden_data "\n"]
                test [lindex $golden_data 0]
        } else {
                set answer "wrong input"
                write_data "output.txt" $answer
                write_data "result.txt" $answer
        }
}

main

