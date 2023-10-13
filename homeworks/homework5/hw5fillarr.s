.macro enter_array(%x, %y) # макрос для ввода значений массива с клавиатуры (базируется на моем же решении 3-ей задачи)
	li s1 1
	li s6 10
	li s3 4
	
	j ask_for_resume
ask_for_resume_again: la a0 try_again
	li a7 4
	ecall
	j input_num
ask_for_resume:	la a0 out_resume_inp
	li a7 4
	ecall
input_num:	
	li a7 5
	ecall
	mv t6 a0
	bgt t6 s6, ask_for_resume_again
	blt t6 s1, ask_for_resume_again
	mul t6 t6 s3
	add %y %y t6
	
add_element: addi t3, t3, 1
	la a0, ask_for_input_pt_1
	li a7,4 
	ecall
	mv a0 t3
	li a7 1
	ecall
	la a0, ask_for_input_pt_2
	li a7,4 
	ecall
	li a7 5
	ecall
	mv t2 a0
	sw t2 (%x)
	addi %x %x 4
	bltu %x %y add_element
step_after_inp:	la a0 sep 
	li a7 4
	ecall
	la t0 array
	addi s2 s2 2
.end_macro
