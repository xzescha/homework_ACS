.data
	outstrt: .asciz "Come and check out my program!\n"
	outarg1: .asciz "Enter divisible: "
	outarg2: .asciz "Enter delimeter: "
	outerr: .asciz "Wrong input, try again pls >_<\n"
	outresmin: .asciz "Here's your result: quotient: -"
	outresplu: .asciz "Here's your result: quotient: "
	outresrem: .asciz ", remainder: "
	ln: .asciz "\n"
.text
	la a0, outstrt #вывод приветствия
	li 	a7, 4
        ecall
	
	la a0, outarg1 
	li 	a7, 4
        ecall
        
        li	a7, 5 #ввод делимого
        ecall
        mv t0 a0
        
        la a0, ln
	li 	a7, 4
        ecall
        j input_del
input_del_err:       la a0, outerr #Вывод сообщения об ошибке
	li a7, 4
	ecall 
input_del:	la a0, outarg2 #Ввод делителя
	li 	a7, 4
        ecall
	li	a7, 5
        ecall
        
        mv t1 a0
        beqz  t1, input_del_err
        
        li s0 0
        
        li s1 0	
        #Регистры t0 и t1 отвечают за входные данные (делимое и делитель), регистры s0 и s1 (это счетчик итераций)
        mv a4, t0
        mv a6 t1
        mv a3 t0
abs1:	neg a6 a6 #модуль первого числа
	bltz a6, abs1
abs2:	neg a3 a3 #модуль второго числа
	bltz a3, abs2
        bgt a6 a3 next_step_plu
loop:	# цикл деления с остатком 
	blez t0, check_del_plu
	bgtz t1, same_sig
	j diff_sig
check_del_plu: bltz t1, same_sig #Проверка на деление двух положительных чисел
	j diff_sig
	
same_sig:	#одинаковые знаки делимого и делителя
		sub a4 a4 t1
		addi s1 s1 1
	bgtz t0, bigg_zer
less_zer:	bge t1 a4 loop #оба меньше нуля
		j next_step_plu
bigg_zer:	ble t1 a4 loop #оба больше нуля
		j next_step_plu
diff_sig:	add a4 a4 t1 #разные знаки делимого и делителя
		addi s1 s1 1
		bge t0, t1, bigger1st
		j bigger2nd
bigger1st:	ble t1 a4 loop #если первое больше
		j next_step_min
bigger2nd:	bge t1 a4 loop #если второе больше
		j next_step_min

next_step_plu:        li a7 10 #Вывод для положительного результата деления
        
        mv t3 a0
        la a0, outresplu 
	li a7, 4
	
        ecall
        j the_end
next_step_min: #Вывод для отрицательного результата деления
	li a5 2
	sub s1 s1 a5
	sub a4 a4 t1
	sub a4 a4 t1
	mv t3 a0
        la a0, outresmin 
	li a7, 4
        ecall
the_end:        mv a0 t3 #вывод остатка и конец программы
        li      a7 1       
        add t0 t0 t1 
        mv a0 s1
        li      a7 1
        ecall
        la a0, outresrem
        li a7, 4
        ecall
        mv a0 a4
        li      a7 1
        ecall
