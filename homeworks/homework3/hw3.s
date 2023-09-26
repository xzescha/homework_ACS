.data
	out_hi: .asciz "Welcome to my program! Hope you'll enjoy using it!\n"
	ask_for_input_pt_1: .asciz "Enter element "
	ask_for_input_pt_2: .asciz " of array: "
	output_main: .asciz "Here's your result:\n"
	out_sum: .asciz "- Sum of elements in array: "
	out_cnt_ev: .asciz "- Number of even elements: "
	out_cnt_odd: .asciz "- Number of odd elements: "
	out_resume_inp: .asciz "Enter number of elements in array (between 1 and 10): "
	try_again: .asciz "Wrong input, try again: "
	y: .asciz "y"
	n: .asciz "n"
	sep: .asciz "--------\n"
	.align 2
	array: .space 40
.text
	la a0, out_hi
	li a7, 4
	ecall
	la t0 array
	la t4 array
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
	add t4 t4 t6
	
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
	sw t2 (t0)
	addi t0 t0 4
	bltu t0 t4 add_element
step_after_inp:	la a0 sep 
	li a7 4
	ecall
	la t0 array
	addi s2 s2 2
	
work_with_array:
	lw a1 (t0)
	add t1 t1 a1
	div a3 a1 s2
	mul a3 s2 a3
	neg a3 a3
	add a6 a1 a3
	beqz a6 cnt_chet
	addi s5 s5 1
	j next_step
cnt_chet: addi s4, s4, 1
next_step: addi    t0 t0 4
        blt     t0 t4 work_with_array
        la a0 output_main
        li a7 4
        ecall
        la a0 out_sum
        li a7 4
        ecall
        mv a0 t1
        li a7 1
        ecall
        li a7 11
        li a0 10
        ecall
        
        la a0 out_cnt_ev
        li a7 4
        ecall
        mv a0 s4
        li a7 1
        ecall
        li a7 11
        li a0 10
        ecall
        
        la a0 out_cnt_odd
        li a7 4
        ecall
        mv a0 s5
        li a7 1
        ecall
        li a7 11
        li a0 10
        ecall
