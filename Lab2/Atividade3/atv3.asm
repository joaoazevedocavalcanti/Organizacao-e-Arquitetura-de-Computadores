lw x20, g
lw x21, h
lw x22, i
lw x23, j

bne x22, x23, else

add x19, x20, x21
sw x19, f
halt

else:
	sub x19, x20, x21
	sw x19, f
	halt

