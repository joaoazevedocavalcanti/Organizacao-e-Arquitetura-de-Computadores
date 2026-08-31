    addi x11, x0, 1026       
    addi x12, x0, 1031       
    addi x13, x0, 1         
    addi x14, x0, 0         

    sb x13, 0(x11)

espera_pressionar:
    lb x10, 1032(x0)         
    beq x10, x14, espera_pressionar  

espera_soltar:
    lb x10, 1032(x0)         
    bne x10, x14, espera_soltar      

    sb x14, 0(x11)           
    addi x11, x11, 1         

    blt x12, x11, fim        
    sb x13, 0(x11)           
    jal x0, espera_pressionar

fim:
    halt
