#Include macros


.include "readFileMacro.asm"

.data
	
	filePath: 		.asciiz "frase.txt"
	ask_dic_Str: 		.ascii "Ingrese el nombre del archivo TXT correspondiente al diccionario (max 15 chars): "
	file_not_found: 	.asciiz "Error: file not found"
	.align 0
	dic_file_name: 		.space 15
	#dictionary:		.byte 97,98,99,100,101,102,103,104,105

	
	word:                   .asciiz "abcr"
	message:	.asciiz "Índice no  encontrado"
	messageD:        .asciiz "Índice ENCONTRADO"
	null:           .asciiz " "

.text



# $s0: TXT file descriptor
# $s1: DICTIONARY file descriptor
# $s2: OUTPUT_ENCODE file descriptor
# $s3: DICTIONARY index
# $s4: 1 if char. 0 if EOF

main:
	readFile("diccionarioBase.txt",20000)		
 	la $s1,word
 	
 	#Para cargar cadena del dicionario 
 	lw $t8,0($s1) 		
 	lw $t7, 0($v0) 	
 	bne $t8, $t7, 	NoIguales
 	la $a0, messageD    
	li $v0, 4
	syscall
	j exit 	
 	 	  
       NoIguales: 
       		la $a0, message    
		li $v0, 4
		syscall
	exit:              