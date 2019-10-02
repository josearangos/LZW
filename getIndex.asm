# $s1: Dirección de %word
# $s2: Dirección de $t5
# $s3: Se usa para mantener $s1 sin modificar
# $t0: Auxiliar para añadir Spacebar
# $t2: Auxiliar para tomar solo 4 bytes
# $t3: Caracter en $s1
# $t4: Contador de caracteres en %word
# $t5: Dirección de %indexFile
# $t7: Palabra en la dirección $t5
# $t8: Palabra en la dirección $s1

#RETORNOO: $t4-$a0

.macro  getIndex(%word,%indexFile)
.data
.align 0
	#word:                   	.asciiz %word
	message:			.asciiz "Indice no  encontrado"
	messageD:        		.asciiz "Índice encontrado"
	
.text
	addi $t2, $zero, 4
	move $t5, %indexFile
	move $s1, %word	
 	#la $s1, word
 	#lw $t8, 0($s1)
 	lw $t8, 0($s1)
 	addi $t4, $zero, 0
 	lb $t3, 0($s1)
 	move $s3, $s1
 	
contador:
	beqz $t3, fillSpace
	beqz $t2, fillSpace
	subi $t2, $t2, 1
 	addi $t4, $t4,1
 	addi $s1,$s1,1
 	lb $t3,0($s1)
 	j contador
 	
fillSpace:
 	beq $t4,4, next
 	li   $t0 ' '
        sb   $t0 0($s1)
        addi $s1 $s1 1
 	addi $t4,$t4,1
 	j fillSpace
 	
next:
	lw $t8, 0($s3)
 	la $s2, ($t5)  					 					 	
 	lw $t7, 0($s2) 	
 	addi $t4, $zero, 0
 	
loop: 	
 	lb $t7, 0($s2)
 	beqz $t7, no_iguales
 	lw $t7, 0($s2)
 	beq $t8, $t7, iguales
 	addi $t4, $t4, 1
 	addi $s2, $s2, 4
 	lw $t7, 0($s2)
 	j loop	
	 	 	  
iguales: 
	addi $t4, $t4, 1 
	j exit
	
no_iguales:
	addi $t4, $zero, -1
	j exit
	
exit:             
	move $a0, $t4  
	li $v0, 1
	syscall
	
.end_macro 