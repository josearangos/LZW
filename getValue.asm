#RETORNOO: $t4-$a0

.macro  getValue(%index,%indexFile)
.data
.align 2
	Contador:			.space 4
	message:			.asciiz "Valor no encontrado"
	messageD:        		.asciiz "Valor encontrado"
	
.text
	la $s1, Contador
	move $t5, %indexFile
	move $s3, %index
 	#lw $t8, 0($s3)
 	addi $t4, $zero, 0
 	
next:
	#lw $t8, 0($s3)
 	la $s2, ($t5)  					 					 	
 	lw $t7, 0($s2) 	
 	addi $t4, $zero, 0
 	
loop: 	
 	lb $t7, 0($s2)
 	beqz $t7, no_iguales
 	addi $t4, $t4, 1
 	lw $t7, 0($s2)
 	lw $t6, 0($s1)
 	beq $s3, $t4, iguales
 	addi $s2, $s2, 4
 	j loop
	 	 	  
iguales: 
	lw $t7, 0($s2)
	j exit
	
no_iguales:
	addi $t4, $zero, -1
	j exit
	
exit:             
	#move $a0, $t4
	#li $v0, 1
	#syscall
	
.end_macro 
