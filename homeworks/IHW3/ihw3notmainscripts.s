.macro input (%x)
	j first_try
er_name:la a0 errname
 	li a7 4
 	ecall
first_try:
	la a0 input_nof
	li a7 4
	ecall
    	la	a0 file_name
    	li      a1 NAME_SIZE
    	li      a7 8
    	ecall
    	li t4 '\n'
    	la t5	file_name
	loop:
    	lb t6  (t5)
    	beq t4	t6 replace
    	addi t5 t5 1
    	b loop
    	replace:
 	sb zero (t5)
 	li a7 1024   
 	la a0 file_name   
 	li a1 0      
 	ecall         
 	li s1 -1	
 	beq a0 s1 er_name	
 	mv %x a0
.end_macro


.macro hello 
	la a0 welcome
	li a7 4
	ecall
.end_macro
