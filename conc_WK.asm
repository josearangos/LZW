.macro conc_WK(%W, %K)
.data
.align 2
	WK:		.space 4
.text
W_append:
	la $s4, WK
	
W_append_cont:
	lb $t5, 0(%W)
	beqz $t5, pos
	beq $t5, 32, pos
	beq $s1, 4, pos
	sb $t5, 0($s4)
	addi $s4, $s4, 1
	addi $s1, $s1, 1
	j W_append_cont

pos:
	move $s1, $zero
	lb $t5, 0($s4)
	beq $t5, 32, K_append
	beqz $t5, K_append
	addi $s4, $s4, 1
	j pos

K_append:
	lb $t5, 0(%K)
	beqz $t5, end_append
	beq $t5, 32, end_append
	beq $s1, 4, end_append
	sb $t5, 0($s4)
	addi $s4, $s4, 1
	addi $s1, $s1, 1
	j K_append

end_append:
	la $t6, (%W)
	la $s7, (%K)
	move $s1, $s4
	#la $s4, WK
        j loop
.end_macro 