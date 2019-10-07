.include "readFileMacro.asm"
.include "createFile.asm"
.include "addToFile.asm"
.include "getIndex.asm"
.include "conc_WK.asm"

.data
	
	filePath: 			.asciiz "frase.txt"
	ask_dic_Str: 			.ascii "Ingrese el nombre del archivo TXT correspondiente al diccionario (max 15 chars): "
	msg_file_not_found: 		.asciiz "Error: file not found"
	msg_space_exceeded: 		.asciiz "Espacio para almacenar en el diccionario excedido"
.align 2
	W:				.space 4	# $t6
	K:				.space 4	# $s7
	WK:				.space 4	# $s4

.text
	createFile("diccionarioBase.txt", "newDictionary.txt", 2000)		#se copia el diccionario base en un nuevo diccionario sobre el que se trabajará
	la $s4, WK								#dirección del espacio reservada para la concatenación
	readFile("frase.txt",20000)						#se lee la frase TXT
	beq $t1, -1, file_not_found						#si no se encuentra el archivo, mensaje de error
        move $t9, $v0								#en $t9 se guarda el indice del archivo
        la $s7, 0($t9)								#cargamos la direccion en K, es decir $s7
        readFile("newDictionary.txt",20000)					#se lee el nuevo diccionario
        beq $t1, -1, file_not_found
        move $t1, $v0
        la $t6, W								#direccion del espacio reservado para W
        la $s7, K								#direccion del espacio reservado para K

loop:
	la $t6, W
        la $s7, K
	lb $t5, 0($t6)								#se carga un caracter de W
	lb $t5, 0($t9)								#se carga un caracter de K
	beqz $t5, end_loop							#si no hay caracteres por leer de la frase sale del ciclo
	sb $t5, 0($s7)								#guarda el caracter en el esapcio reservado de K
	conc_WK($t6, $s7, $s4)							#concatena W con K
	
	addi $t9, $t9, 1							#avanza por la frase
next_loop:
	la $s4, WK								#se carga la dirección de WK
	
	getIndex($s4, $t1)							#se obtiene el indice de WK
	la $t6, W								#dirección de W
	la $s7, K								#dirección de K
	lw $s4, 0($s4)								#word de WK
	bne $t4, -1, W_append							#si se encuentra el indice de WK va a W_append (label)
	getIndex($t6, $t1)							#obtiene el indice de W
	
	la $t6, W
	la $s7, K
	lw $s7, 0($s7)
	sw $zero, 0($t6)
	sw $s7, 0($t6)
	la $t6, W
	la $s7, K
	la $s4, WK
	addToFile("newDictionary.txt", $s4 ,4)					#añade la nueva palabra al diccionario
	readFile("newDictionary.txt",20000)					#lee nuevamente el nuevo diccionario
        beq $t1, -1, file_not_found
        move $t1, $v0
        la $t6, W
	move $a0, $t4
	li $v0, 1
	syscall
	
	li $a0 ' '								#se añade un espacio para su visualización
	li $v0, 11
	syscall
	sw $zero, 0($s4)							#se resetea WK con 0
	j loop									#salto al loop

###	
W_append:
	sw $s4, 0($t6)								#se guarda lo que había en WK en W
	la $s4, WK
	sw $zero, 0($s4)							#se resetea WK con 0
	j loop
###

end_loop:
	getIndex($t6, $t1)							#se obtiene el indice de W al finalizar
	move $a0, $t4
	li $v0, 1
	syscall
	
	la $t6, W
	la $s7, K  
	j exit

#MENSAJES VARIADOS

space_exceeded:
	la $a0, msg_space_exceeded
	li $v0, 4
	j exit
file_not_found:
	la $a0, msg_file_not_found
	li $v0, 4
	syscall
exit:
	li $v0, 10
	syscall
