.include "readFileMacro.asm"
.include "addToFile.asm"
.include "getValue.asm"

.data
	Index: 				.space 4
	msg_file_not_found: 		.asciiz "Error: file not found"
	msg_space_exceeded: 		.asciiz "Espacio para almacenar en el diccionario excedido"
.align 2
.text
	la $t2, Index
	
	readFile("codigo.txt",20000)
	beq $t1, -1, file_not_found
        move $t9, $v0
        
        readFile("newDictionary.txt",20000)
        beq $t1, -1, file_not_found
        move $t1, $v0
 	addi $t5, $zero, 0
 	la $t2, Index
 	
loop:
	lb $t0, 0($t9)
	beq $t0, 32, contador_entero
	addi $t5, $t5, 1
	sb $t0, 0($t2)

	addi $t2, $t2, 1
	addi $t9, $t9, 1
		
	#lw $t3, ($t2)
	j loop
	
contador_entero:
	la $t2, Index
	lb $t3, 0($t2)
	beq $t5, 3, sumar_centenas
	beq $t5, 2, sumar_decenas
	beq $t5, 1, sumar_unidades

sumar_centenas:
	beq $t3, 48, pre_dec
	addi $t6, $t6, 100
	subi $t3, $t3, 1
	j sumar_centenas

pre_dec:
	addi $t2, $t2, 1
	lb $t3, 0($t2)
	
sumar_decenas:
	beq $t3, 48, pre_uni
	addi $t6, $t6, 10
	subi $t3, $t3, 1
	j sumar_decenas

pre_uni:
	addi $t2, $t2, 1
	lb $t3, 0($t2)

sumar_unidades:
	beq $t3, 48, next_loop
	addi $t6, $t6, 1
	subi $t3, $t3, 1
	j sumar_unidades

	

next_loop:	
	getValue($t6, $t1)
	move $a2, $t7
	beqz $t4, end_loop
	
	la $a0 ($a2)
	li $v0, 11
	syscall
	
	add $t5, $zero, 0
	add $t6, $zero, 0
	addi $t9, $t9, 1
	la $t2, Index
	sw $zero, 0($t2)
	j loop
	
end_loop:
	j exit
	
file_not_found:
	la $a0, msg_file_not_found
	li $v0, 4
	syscall

exit:
	li $v0, 10
	syscall