.data
	out_resume_inp: .asciz "Enter number of elements in array (between 1 and 10): "
	ask_for_input_pt_1: .asciz "Enter element "
	ask_for_input_pt_2: .asciz " of array: "
	try_again: .asciz "Wrong input, try again: "
	
	out_hi: .asciz "Welcome to my program! Hope you'll enjoy using it!\n"
	output_main: .asciz "Here's your new array B:\n"
	
	sep: .asciz "--------\n"
	.align 2
	array: .space 40
	array_B: .space 40
.globl out_resume_inp ask_for_input_pt_1 ask_for_input_pt_2 try_again output_main
.include "ihw1fillarr.s" 
.include "ihw1cntsum.s"
.text
	la a0, out_hi
	li a7, 4
	ecall
	la t0 array
	la t4 array
	enter_array(t0, t4) #Ввод элементов массива с клавиатуры (параметр первый - массив, параметр второй - указатель на конец массива)
	la t5 array_B
	la t3 array_B
	task24(t0, t4, t5, t3) #Замена местами элементов
	la a0 output_main
        li a7 4
        ecall
	output(t5 t3) #Вывод суммы на экран
        
        
