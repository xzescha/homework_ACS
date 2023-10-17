.macro tester (%x, %x_end, %y)
	loop_checker:
	lw a6 (%x)
	lw a4 (a6)
	lw a5 (%y)
	bne a5 a4 error				#Making the sandbox for testing
	addi %y %y 4
	addi %x %x 4
	blt %x %x_end loop_checker
	lw ra (sp)
	addi sp sp 4
.end_macro 

.macro test_num (%x, %resx, %len)
	la t1 %x
	mv t2 t1
	add t2 t2 %len
	la t3 arr2
	mv t4 t3				#Testing the correctivity using the result arrays from data segment in ihwt1.s
	la t5 %resx
	lw ra (sp)
	addi sp sp 4
.end_macro