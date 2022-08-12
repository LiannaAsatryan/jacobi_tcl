#!usr/bin/tclsh

#this function writes the given data in the given file
proc write_data { file_name output_data } {
        set fp [open $file_name w+]
        puts $fp $output_data
        close $fp
}
#this function reads data from the given file and returns that
proc read_data { file_name } {
        set fp [open $file_name]
        set file_data [read $fp]
        close $fp
        return $file_data
}


#this function deletes the generated files
proc clean_files {} {
        file delete -force "output.txt"
        file delete -force "result.txt"
}


#this function reads the matrix from the given file and returns it
proc read_matrix { input_file } {
        set input [open $input_file r]
	#set rows [gets $input]
	while { [gets $input line] >= 0 } {
    		lappend matrix [split $line " "]
	}
	close $input
	return $matrix
}

#this function checks whether all the inputs in the input_file are real numbers
#if they are, the function returns true, and returns false otherwise
proc check_input {} {
        set m [read_matrix "input.txt"]
	if {![string is int [lindex $m 0]]} {
		return false
	}
	set rows [lindex $m 0]
	for {set i 1} {$i < $rows} {incr i} {
		for {set j 0} {$j < $rows} {incr j} {
			if {![string is double [lindex $m $i $j]]} {
				return false
			}
                }
	}
        return true
}

#this method checks if the given matrix is diagonally dominant
proc diag_dominant { matrix } {
	set rows [lindex $matrix 0]
	for {set i 1} {$i <= $rows} {incr i} {
            set sum  0.0
            for {set j 0} {$j < $rows} {incr j} {
		set sum [expr $sum + [expr abs([lindex $matrix $i $j])]]
            }
	    set sum [expr $sum - [expr abs([lindex $matrix $i [expr $i - 1]])]]
            if { [expr abs([lindex $matrix $i [expr $i - 1]])] <= $sum } {
                return false
            }
        }
	return true
}
    

#this function returns true if there are more than <n> digits after the point in the <num>
proc precision { num n } {
        set p 1
        for {set i 0} {$i<$n} {incr i} {
                set p [expr {$p*10}]
        }
        #p=10^n
        set d [expr {$num * $p }]
        if { [expr {abs($d)}] > [expr {abs(int($d))}] } {
                return true
        } else { return false }
}



#this function corrects the numeric data so that we don't have num.0
#and if the number of digits after the point are more than 4(in this case)
#the function sets its precision to 4
proc correct_data { res } {
        #to avoid the num.0 case
        if { $res == [expr int($res)]} { return [expr int($res)]}
        #setting the precision if it is necessary
        if { [precision $res 5] } {
                return [format {%.5f} $res]
        }
        return $res
}

proc correct_list { list_name } {
	for {set i 0} {$i < [llength $list_name]} {incr i} {
                lset list_name $i [correct_data [lindex $list_name $i]]
        }
	return $list_name
}


proc jacobi { m } {
	set x []
    	if { ![diag_dominant $m] } {
        	return $x
    	} else {
        	set rows [lindex $m 0]
        	set cols [expr $rows + 1]
        	set previous []
		set x []
        	for {set i 0} {$i < $rows} {incr i} {
			lappend x 0
			lappend previous 0
        	}
        	set converge 0
        	while {$converge == 0} {
            		set previous  $x
            		for {set i 1} {$i <= $rows} {incr i} {
		                set sum  0
                		for {set j 0} {$j < $rows} {incr j} {
					set sum [expr $sum + 1.0 * [lindex $m $i $j] * [lindex $previous $j]]
                                }
				set sum [expr $sum - 1.0*[lindex $m $i [expr $i - 1]] * [lindex $previous [expr $i-1]]]
				lset x [expr $i - 1] [expr [expr 1.0*[lindex $m $i $rows] - $sum] / [lindex $m $i [expr $i - 1]]]
            		}
            		set converge 1
            		for {set i 0} {$i < $rows} {incr i} {
				set a [lindex $x $i]
				set b [lindex $previous $i]
            			if {[expr abs($a  - $b)] > 0.00001 } {
					set converge 0
					break
				}
            		}
        	}
        	return [correct_list $x]
	}
}	

