.include "readFileMacro.asm"
.include "createFile.asm"
.include "getIndex.asm"

# $t0: NO SE USA AQUI -> GetIndex
# $t1: Dirección del diccionario TXT
# $t2: NO SE USA AQUI -> GetIndex
# $t3: 
# $t4: INTOCABLE, Es el retorno de GetIndex
# $t5: NO SE USA AQUI -> GetIndex
# $t6: W
# $t7: -> GetIndex
# $t8: -> GetIndex
# $t9: Dirección de la frase TXT

# $s0: Caracteres de WK -> createFile, readFile
# $s1: Contador de palabras en WK
# $s2: -> GetIndex$
# $s3: -> GetIndex
# $s4: Dirección del espacio reservado para la concatenación de la palabra
# $s5: address de byte 32
# $s6: Dirección de newDictionary
# $s7: K

# Registro para W, concatenarlo con K y seguir con añadir a newDictionary
# Usar GetIndex con el espacio reservado y sumarle 27 al resultado
# Añadr parametro a GetIndex para saber  se imprime o no

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
	#createFile("diccionarioBase.txt", "temporalDictionary.txt", 2000)
	la $s6, new_dictionary
	la $s4, WK
	readFile("frase.txt",20000)
	beq $t1, -1, file_not_found
        move $t9, $v0
        la $s7, 0($t9)
        readFile("diccionarioBase.txt",20000)
        beq $t1, -1, file_not_found
        move $t1, $v0

loop:
	lb $s7, 0($t9)			#Caracter de frase en la posicion t9 (Esto es K)
	beqz $s7, end_loop
        sb $s7, 0($s4)
	la $s7, 0($t9)
	addi $t9, $t9, 1		#Direccion Frase TXT
	addi $s4, $s4, 1

next_loop:
	la $s4, WK
	getIndex($s4, $t1)
	la $t6, W
	la $s7, K
	move $s4, $s1
	bne $t4, -1, W_append
	la $s4, WK
        lb $t6, 0($s7)
        la $t6, 0($s7)
	getIndex($t6, $t1)
	lb $t6, 0($s7)
	move $a0, $t4
	li $v0, 1
	syscall
	j append_to_dictionary
	
	j loop
	
	#addToFile("newDictionary.txt", $t3 ,4)
###	
W_append:
	la $s4, WK
	
W_append_cont:
	lb $t5, 0($t6)
	beqz $t5, pos
	beq $t5, 32, pos
	beq $t6, 4, pos
	sb $t5, 0($s4)
	addi $s4, $s4, 1
	addi $t6, $t6, 1
	j W_append_cont

pos:
	lb $t5, 0($s4)
	beq $t5, 32, K_append
	addi $s4, $s4, 1
	j pos

K_append:
	lb $t5, 0($s7)
	beqz $t5, end_append
	beq $t5, 32, end_append
	beq $s7, 4, end_append
	sb $s7, 0($s4)
	addi $s4, $s4, 1
	addi $s7, $s7, 1
	j K_append

end_append:
	la $t6, W
	la $s7, K
	move $s1, $s4
	#la $s4, WK
        j loop	
###	
	
append_to_dictionary:
	la $t6, W
	la $s7, K  
	
W_append_to_dic:
	lb $t5, 0($t6)
	beqz $t5, K_append_to_dic
	beq $t6, 4, K_append_to_dic
	sb $t5, 0($s6)
	addi $s6, $s6, 1
	addi $t6, $t6, 1
	j W_append

K_append_to_dic:
	lb $t5, 0($s7)
	beqz $t5, end_append_to_dic
	beq $s7, 4, end_append_to_dic
	sb $s7, 0($s6)
	addi $s6, $s6, 1
	addi $s7, $s7, 1
	j K_append

end_append_to_dic:
	la $t6, W
	la $s7, K    
	move $s1, $s4
        j loop
        
	#search("pepone", $v0)
	#createFile("diccionarioBase.txt","newDictionary.txt", 2000)
	#addToFile("newDictionary.txt", "pep ",4)

end_loop:
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
