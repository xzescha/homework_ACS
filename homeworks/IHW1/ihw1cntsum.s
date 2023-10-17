.macro save_indices (%arr_1, %end_of_arr, %end_of_arr_2)
loop:	
	addi %end_of_arr %end_of_arr -4
	sw %end_of_arr (%end_of_arr_2)
	addi %end_of_arr_2 %end_of_arr_2 4		#Making B-array with pointers to values of A-array
	bgt %end_of_arr %arr_1 loop
	lw ra (sp)
	addi sp sp 4
.end_macro
