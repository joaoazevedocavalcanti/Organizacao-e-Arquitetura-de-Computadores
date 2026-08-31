    addi x11, x0, 1      
    addi x12, x0, 32    

    sb x11, 1029(x0)     

esperando_apertar:
    lb x10, 1026(x0)       
	andi x10, x10, 0x1   
    beq x10, x0, esperando_apertar 

esperando_soltar:
    lb x10, 1026(x0)         
	andi x10, x10, 0x1   
    bne x10, x0, esperando_soltar 

avanca_led:
    slli x11, x11, 1     
    sb x11, 1029(x0)     

    beq x11, x12, fim    
    jal x0, esperando_apertar

fim:
    jal x0, fim          
