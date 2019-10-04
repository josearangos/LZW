.include "readFileMacro.asm"
.include "createFile.asm"
.include "addToFile.asm"
.include "getIndex.asm"
.include "conc_WK.asm"

# $t0: NO SE USA AQUI -> GetIndex
# $t1: Direcci�n del diccionario TXT
# $t2: NO SE USA AQUI -> GetIndex
# $t3: 
# $t4: INTOCABLE, Es el retorno de GetIndex
# $t5: NO SE USA AQUI -> GetIndex
# $t6: W
# $t7: -> GetIndex
# $t8: -> GetIndex
# $t9: Direcci�n de la frase TXT

# $s0: Caracteres de WK -> createFile, readFile
# $s1: Contador de palabras en WK
# $s2: -> GetIndex$
# $s3: -> GetIndex
# $s4: Direcci�n del espacio reservado para la concatenaci�n de la palabra
# $s5: address de byte 32
# $s6: Direcci�n de newDictionary
# $s7: K

# Registro para W, concatenarlo con K y seguir con a�adir a newDictionary
# Usar GetIndex con el espacio reservado y sumarle 27 al resultado
# A�adr parametro a GetIndex para saber  se imprime o no

.data
	
	filePath: 			.asciiz "frase.txt"
	ask_dic_Str: 			.ascii "Ingrese el nombre del archivo TXT correspondiente al diccionario (max 15 chars): "
	msg_file_not_found: 		.asciiz "Error: file not found"
	msg_space_exceeded: 		.asciiz "Espacio para almacenar en el diccionario excedido"
.align 2
	W:				.space 4	# $t6
	K:				.space 4	# $s7
	WK:				.space 4	# $s4
	test:				.byte 31
	new_dictionary:                 .space 15000

.text
	createFile("diccionarioBase.txt", "newDictionary.txt", 2000)
	la $s6, new_dictionary
	la $s4, WK
	readFile("frase.txt",20000)
	beq $t1, -1, file_not_found
        move $t9, $v0
        la $s7, 0($t9)
        readFile("newDictionary.txt",20000)
        beq $t1, -1, file_not_found
        move $t1, $v0
        la $t6, W
        la $s7, K

loop:
	lb $t5, 0($t6)			# W
	lb $t5, 0($t9)			#Caracter de frase en la posicion t9 (Esto es K)
	beqz $t5, end_loop
	sb $t5, 0($s7)			#Se guarda en el espacio para K
	#move $s4, $zero
	conc_WK($t6, $s7, $s4)
	
	addi $t9, $t9, 1	#Direccion Frase TXT
	#addi $s4, $s4, 1	#AUMENTA WK INDEX

next_loop:
	la $s4, WK
	#lb $s4, 0($s4)	##
	
	getIndex($s4, $t1)
	la $t6, W
	la $s7, K
	#move $s4, $s3
	lw $s4, 0($s4)
	bne $t4, -1, W_append
        #lb $t6, 0($s7)
        #move $t6, $s7
        
        #lb $t6, 0($t6)
        #move $t6, $t6
	getIndex($t6, $t1)
	
	la $t6, W
	la $s7, K
	lw $s7, 0($s7)
	sw $s7, 0($t6)
	la $s7, K
	la $s4, WK
	addToFile("newDictionary.txt", $s4 ,4)
	readFile("newDictionary.txt",20000)
        beq $t1, -1, file_not_found
        move $t1, $v0
	la $t6, W
	move $a0, $t4
	li $v0, 1
	syscall
	li $a0 ' '
	li $v0, 11
	syscall
	sw $zero, 0($s4)
	j loop
	
	#j loop
	
	#addToFile("newDictionary.txt", $t3 ,4)
###	
W_append:
	sw $s4, 0($t6)
	la $s4, WK
	sw $zero, 0($s4)
	j loop
###
	#search("pepone", $v0)
	#createFile("diccionarioBase.txt","newDictionary.txt", 2000)
	#addToFile("newDictionary.txt", "pep ",4)

end_loop:
	getIndex($t6, $t1)
	move $a0, $t4
	li $v0, 1
	syscall
	
	la $t6, W
	la $s7, K  
	j exit

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
