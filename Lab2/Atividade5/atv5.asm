addi x11, x0, 0x2A

loop:	
	beq x11, x10, fim
	lb x10, 1025(x0) 
	sb x10, 1024(x0)
	beq x0, x0, loop

fim:
halt

