.macro len_arr (%end_of_arr)
	la a0 out_cnt_elems
	li a7 4
	ecall
	li a7 5			#Input lenght of array from keyboard
	ecall
	mv a2 a0
	li a1 4
	mul a2 a2 a1
	add %end_of_arr %end_of_arr a2	 	#Making the pointer to the end of array
	lw ra (sp)
	addi sp sp 4
.end_macro

.macro fill_arr_a (%arr_1, %end_of_arr)
loop:	la a0 out_num_el
	li a7 4
	ecall
	li a7 5 		# Filling the array from keyboard (with loop)
	ecall
	sw a0 (%arr_1)	
	addi %arr_1 %arr_1 4
	blt %arr_1 %end_of_arr loop	
	lw ra (sp)
	addi sp sp 4
.end_macro

.macro output (%arr_2, %end_of_arr)
	la a0 output_final
	li a7 4
	ecall
loop:	lw a2 (%arr_2)
	lw a0 (a2)
	li a7 1
	ecall
	li a0 10
	li a7 11			#Output for the B-array  (not the pointers, but values from A-array)
	ecall
	addi %arr_2 %arr_2 4
	blt %arr_2 %end_of_arr loop
	lw ra (sp)
	addi sp sp 4
.end_macro
	