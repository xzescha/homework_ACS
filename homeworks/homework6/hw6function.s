.macro	strcpy(%outputptr, %inputptr)
	mv a2 %inputptr
	addi a2 a2 256
loop:	lb a3 (%inputptr) #bytewise translation to another data address
	sb a3 (%outputptr)
	addi %inputptr %inputptr 1
	addi %outputptr %outputptr 1
	ble %inputptr, a2,loop 
.end_macro
