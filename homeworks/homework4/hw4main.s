.data 
	place_for_num: .word 0
	max_word: .word 2147483647
	out_hi: .asciz "Welcome to my program!\n"
	res: .asciz "The result of "
	res_pt_2: .asciz "! is "
	res_mv_ptr: .asciz "\n"
	overflow: .asciz "We've reached overflow!\nResult is: "
.text
	la a0 out_hi
	li a7 4
	ecall
	addi t6 t6 1
	addi t4 t4 1
	lw s2, max_word
	loop_fact:
		addi t6, t6, 1
		mul t4 t4 t6
		sub t2 s2 t4
		la a0 res
		li a7 4
		ecall
		mv a0 t6
		li a7 1
		ecall
		la a0 res_pt_2
		li a7 4
		ecall
		mv a0 t4
		li a7 1
		ecall
		la a0 res_mv_ptr
		li a7 4
		ecall
		blt t4 t2 loop_fact
	la a0 overflow
	li a7 4
	ecall
	addi t6 t6 -1
	sw t4 place_for_num t5
	mv a0 t6
	li a7 1
	ecall
		
