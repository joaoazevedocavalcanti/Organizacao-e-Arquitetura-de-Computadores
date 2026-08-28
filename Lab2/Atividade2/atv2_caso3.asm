	lw x10, a
    lw x11, b
    lw x12, m           

    blt x11, x12, condicional

    sub x12, x10, x11   
    sw x12, m
    halt

condicional:
    add x12, x10, x11 
    sw x12, m
    halt

a: .word 0x19    
b: .word 0xc     
m: .word 0x0
