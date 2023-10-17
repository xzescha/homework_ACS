.data
	array: .space 40
	array_b: .space 40
	out_start: .asciz "Hello, check out my program!\n"
	out_cnt_elems: .asciz "Enter number of elements in array (between 1 and 10): "
	out_num_el: .asciz "Enter next element of array: "
	output_final: .asciz "_________\nHere's your result: \n"
	tester_ask: .asciz "Do you want to see the test results (0-no/every other num - yes):"
							#Test values:
	test1: .word 1 2 3 4 5 6 7 8 9 10		#№1
	res1: .word 10 9 8 7 6 5 4 3 2 1		
	test2: .word 1					#№2
	res2: .word 1
	test3: .word 1 2 3 4 5				#№3
	res3: .word 5 4 3 2 1
	test4: .word -1 2				#№4
	res4: .word 2 -1
	arr2: .space 40
	ok: .asciz "Everything is ok!\n"
	bruh: .asciz "Something went wrong...\n"
	.globl out_cnt_elems, out_num_el, output_final, ok, bruh, error
.text
	.include "ihw1fillarr.s"
	.include "ihw1cntsum.s"
	.include "tester.s"
	j end
testfield:	li t6 40		#Autotester
	sw ra (sp)
	addi sp sp -4
	test_num(test1, res1, t6)
	sw ra (sp)
	addi sp sp -4
	save_indices(t1,t2,t4)
	sw ra (sp)
	addi sp sp -4
	tester(t3,t4,t5)
	li t6 4
	sw ra (sp)
	addi sp sp -4
	test_num(test2, res2, t6)
	sw ra (sp)
	addi sp sp -4
	save_indices(t1,t2,t4)
	sw ra (sp)
	addi sp sp -4
	tester(t3,t4,t5)
	li t6 20
	sw ra (sp)
	addi sp sp -4
	test_num(test3, res3, t6)
	sw ra (sp)
	addi sp sp -4
	save_indices(t1,t2,t4)
	sw ra (sp)
	addi sp sp -4
	tester(t3,t4,t5)
	li t6 8
	sw ra (sp)
	addi sp sp -4
	test_num(test4, res4, t6)
	sw ra (sp)
	addi sp sp -4
	save_indices(t1,t2,t4)
	sw ra (sp)
	addi sp sp -4
	tester(t3,t4,t5)
	j done
	error:	la a0 bruh
	li a7 4
	ecall
	j end
	done:	la a0 ok
	li a7 4
	ecall
	j prog_start
	end: 
	la a0 out_start
	li a7 4
	ecall
	la a0 tester_ask
	li a7 4
	ecall 
	li a7 5
	ecall
	bnez a0 testfield
prog_start:	la t1 array			#Beginning of the real program
	mv t2 t1
	sw ra (sp)
	addi sp sp -4
	len_arr(t2)				#Entering the length of array
	sw ra (sp)
	addi sp sp -4
	fill_arr_a(t1,t2)			#Filling the array from keyboard
	la t1 array
	la t3 array_b
	la t4 array_b
	sw ra (sp)
	addi sp sp -4
	save_indices(t1, t2, t4)		#Making the B-array (with indices)
	sw ra (sp)
	addi sp sp -4
	output(t3, t4)				#Output