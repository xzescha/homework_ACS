.data
	out_hi: .asciz "Welcome to my program! Hope you'll enjoy using it!\n"
	ask_for_input_pt_1: .asciz "Enter element "
	ask_for_input_pt_2: .asciz " of array: "
	out_resume_inp: .asciz "Enter number of elements in array (between 1 and 10): "
	out_final: .asciz "Here's your result for task 1: \n Array B: \n"
	try_again: .asciz "Wrong input, try again: "
	sep: .asciz "--------\n"
	.align 2
	array: .space 40
	array_B: .space 40
.text
	la a0, out_hi
	li a7, 4
	ecall
	la t0 array
	la t4 array
	la t5 array_B
	la a6 array_B
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
task_1: 
	lw a1 (t0)
	add t1 t1 a1
	blez t1, next_step
add_to_arr: 
	sw t1 (a6)
	addi a6 a6 4
next_step:
	addi    t0 t0 4
        bltu     t0 t4 task_1
        la a0 out_final
        li a7 4
        ecall
out:        li a7 1

        lw a0 (t5)         # Выведем очередной элемент массива

        ecall

        li a7 11           # Выведем перевод строки

        li      a0 10

        ecall

        addi    t5 t5 4

        blt t5 a6 out
        li      a7 10           # Останов

        ecall
	