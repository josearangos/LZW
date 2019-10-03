.include "readFileMacro.asm"
.include "createFile.asm"
.include "getIndex.asm"

# $s4: Direccion del espacio reservado para la concatenación de la palabra

# Registro para W, concatenarlo con K y seguir con añadir a newDictionary
# Usar GetIndex con el espacio reservado y sumarle 27 al resultado
# Añadr parametro a GetIndex para saber  se imprime o no

.data
	
	filePath: 			.asciiz "frase.txt"
	ask_dic_Str: 			.ascii "Ingrese el nombre del archivo TXT correspondiente al diccionario (max 15 chars): "
	msg_file_not_found: 		.asciiz "Error: file not found"
	msg_space_exceeded: 		.asciiz "Espacio para almacenar en el diccionario excedido"
.align 0
	dic_file_name: 			.space 15
	word_temporal:			.space 4
	test:				.byte 32
	newDictionary:                  .space 15000

.text
	#createFile("diccionarioBase.txt", "temporalDictionary.txt", 2000)
	la $s4, word_temporal
	la $s6, newDictionary
	move $s0, $s4			
	addi $s1, $zero, 0
	
	addi $t7, $zero, 0		#posicion inicial para insertar en el nuevo diccionario

	addi $t6, $zero, 0
	readFile("frase.txt",20000)
        move $t9, $v0
        #lw $t3, 0($t0)
        #lb $t3, 0($t9)
        #beqz $t3, end_loop
        addi $t6, $t6, 1
        la $t3, 0($t9)

        readFile("diccionarioBase.txt",20000)
        beq $t1, -1, file_not_found
        move $t1, $v0
	
loop:
	lb $t3, 0($t9)			#Caracter de frase en la posicion t9 (Esto es K)
        sw $t3, 0($s4)
        addi $s4, $s4, 4
	beqz $t3, end_loop
	la $t3, 0($t9)
	#bne $t6, 4, add_zero_to_word

#next_loop:
	

	la $s4, word_temporal
	bne $t4, -1, word_count
	addi $t9, $t9, 1
	getIndex($s4, $t1)
	j append_to_dictionary
	
	j loop
	
	#move $a0, $t4  		#IMPRIMIR CODIGO W
	#li $v0, 1
	#syscall
	
	
	#addToFile("newDictionary.txt", $t3 ,4)
	
word_count:				#REVISAR (contar caracteres)
	lb $s0, 0($s0)
	beqz $s0, concat_next_char
	beq $s1, 4, space_exceeded
	
	addi $s1, $s1, 1		# contador de palabras en concat_next_char
	j word_count
	

concat_next_char:			#Concatena en palabra temporal
	lb $t3, 0($t9)
	sw $t3, 0($s4)
	la $t3, 0($t9) 			#Se restaura a su estado anterior
	addi $s4, $s4, 1
	addi $t9, $t9, 1
	j loop
	
append_to_dictionary:
	#beq $t6, 4, next_loop
	la $s5, test
	lb $s5, 0($s5)
	sw $s5, 0($s4)
	
	addi $s4, $s4, 4
	
	addi $t6, $t6, 1
	#addi $t3, $t3 1
        #move $t5, $zero
        #sb   $t5, 0($t3)
        
        j loop
        
	#search("pepone", $v0)
	#createFile("diccionarioBase.txt","newDictionary.txt", 2000)
	#addToFile("newDictionary.txt", "pep ",4)

end_loop:
	move $t7, $zero				#liberamos $t7
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