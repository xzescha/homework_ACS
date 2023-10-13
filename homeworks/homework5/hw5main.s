.data
	out_resume_inp: .asciz "Enter number of elements in array (between 1 and 10): "
	ask_for_input_pt_1: .asciz "Enter element "
	ask_for_input_pt_2: .asciz " of array: "
	try_again: .asciz "Wrong input, try again: "
	
	out_hi: .asciz "Welcome to my program! Hope you'll enjoy using it!\n"
	output_main: .asciz "Here's your result:\n"
	out_sum: .asciz "- Sum of elements in array: "
	out_cnt_ev: .asciz "- Number of even elements: "
	out_cnt_odd: .asciz "- Number of odd elements: "
	
	sep: .asciz "--------\n"
	.align 2
	array: .space 40
.globl out_resume_inp ask_for_input_pt_1 ask_for_input_pt_2 try_again output_main
.include "hw5fillarr.s" 
.include "hw5cntsum.s"
.text
	la a0, out_hi
	li a7, 4
	ecall
	la t0 array
	la t4 array
	enter_array(t0, t4) #Ввод элементов массива с клавиатуры (параметр первый - массив, параметр второй - указатель на конец массива)
	cnt_sum(t0, t4) #Подсчет суммы эл-в массива (параметр первый - массив, параметр второй - указатель на конец массива)
	la a0 output_main
        li a7 4
        ecall
	output(t1) #Вывод суммы на экран
        
        
