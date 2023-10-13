.macro cnt_sum(%x, %y) # макрос подсчета суммы
work_with_array:	lw a1 (%x)
			add t1 t1 a1
			addi    %x %x 4
        		blt     %x %y work_with_array
.end_macro

.macro output(%x) #макрос вывода суммы на экран
        la a0 out_sum
        li a7 4
        ecall
        mv a0 %x
        li a7 1
        ecall
        li a7 11
        li a0 10
        ecall
.end_macro
