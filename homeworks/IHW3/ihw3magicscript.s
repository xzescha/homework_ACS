.macro do_magic(%x, %y)
    la a0 script_running
    li a1 2
    li a7 55
    ecall
    la a0 ascii_art
    li a7 4
    ecall
    	# Reading file into heap
    li a7, 9
    li a0, TEXT_SIZE
    addi a0 a0 1	
    ecall		
    mv 	s3, a0	
    mv 	s5, a0	
    li	s4, TEXT_SIZE	
    mv	s6, zero	
read_loop:    
    li a7, 63       
    mv a0, s0       
    mv a1, s5   	
    li a2, TEXT_SIZE 	
    ecall     
	# Checking reading success
    beq	a0 s1 er_read	
    mv s2 a0       	
    add s6, s6, s2	
    bne	s2 s4 end_loop
    	# Exending buffer
    li a7, 9
    li a0, TEXT_SIZE
    addi a0 a0 1	
    ecall		
    add	s5 s5 s2
    b read_loop		
end_loop:
    	#Closing file
    li   a7, 57  
    mv   a0, s0  
    ecall        
    mv	t0 s3	
    add t0 t0 s6	
    mv s5 s3
    	#Working on each word of file: Firstly reading it into one buffer, then swap it.
loopword:
    li s6 ' '
    la s4 strbuf
    sb s6 (s4)
    addi s4 s4 1
loopmain:
    lb a2 (t0)
    bgt s5 t0 resume
    addi t0 t0 -1
    beq a2 s6 resume
    sb a2 (s4)
    addi s4 s4 1
    b loopmain
resume: 
    la s2 strbuf2
    	#Writing word into output file
resumeloop:
    la s3 strbuf
    lb t1 (s4)
    addi s4 s4 -1
    sb t1 (s2)
    addi s2 s2 1
    bne s3 s4 resumeloop
    la s3 strbuf2  
    sub s6 s2 s3
    li   a7, 64       		
    mv   a0, %y			
    mv   a1, s3  			
    mv   a2, s6    			
    ecall             		
    mv t1 zero
    la s4 strbuf 
    la s3 strbuf2
loop2:    	
    sb t1 (s4)
    sb t1 (s2)
    addi s2 s2 -1
    addi s4 s4 1
    bne s3 s2 loop2
    blt s5 t0 loopword
    la a0 success
    li a1 1
    li a7 55
    ecall
    j end
er_read:
    la	a0 errread
    li	a7 4
    ecall
    li	a7 10
    ecall
    end:
.end_macro
