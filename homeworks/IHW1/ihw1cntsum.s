.macro task24(%x, %y, %z, %k) # макрос формирования массива B
work_with_array:
	li a4 2
	mv t6 s5
	mv s3 t6
	div t6 t6 a4
	mul s4 t6 a4
	sub t2 t2 s4
	li t1 0
loop:	lw a1 (%x)
	addi %x %x 4
	lw a2 (%x)
	addi %x %x 4
	sw a2 (%k)
	addi %k %k 4
	sw a1 (%k)
	addi %k %k 4
	addi t1 t1 1
	blt t1 t6 loop
	beqz t2 end
	lw a1 (%x)
	sw a1 (%k)
	addi %k %k 4
	end: 
.end_macro

.macro output(%z, %k) #макрос вывода массива B на экран
	la a0 output_main
	li a7 4
	ecall
	loop_out: 
	lw a0 (%z)
	li a7 1
	ecall
	li a7 11
        li a0 10
        ecall
	addi %z %z 4
	blt %z %k loop_out 
		
		
.end_macro
