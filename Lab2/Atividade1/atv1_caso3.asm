lw x10, a
lw x11, b
add x12, x0, x10

blt x11, x12, condicional
sw x12, m
halt

condicional:	
	add x12, x10, x11
	sw x12, m
	halt 

a: .word 0x19
b: .word 0xc
m: .word 0x0	
