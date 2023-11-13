.data
	welcome_text: .asciz "===========================================================\n=Hello! Welcome to my program! Hope you'll enjoy using it.=\n===========================================================\n\n"
	input_req:    .asciz "Please, enter string you want to copy. INPUT: "
	output_pt1:   .asciz "Your input string is stored at address: "
	output_pt2:   .asciz "\nAnd copied string contains: "
	output_pt3:   .asciz "At address: "
	output_str:   .asciz 
	.space 256
	input_str:    .asciz 
	.space 256
.text
	.include "hw6function.s" # strcpy function
	la a0 welcome_text
	li a7 4
	ecall
	la a0 input_req
	li a7 4
	ecall
	la a0 input_str
	li a1 256	# making an input
	li a7 8
	ecall
	la a4 output_str 
	strcpy(a4, a0)
	la a0 output_pt1
	li a7 4
	ecall
	la a0 input_str
	li a7 1
	ecall
	la a0 output_pt2
	li a7 4
	ecall
	la a0 output_str #making an output
	li a7 4
	ecall
	la a0 output_pt3
	li a7 4
	ecall
	la a0 output_str
	li a7 1
	ecall
