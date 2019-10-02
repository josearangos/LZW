#Include macros
.macro  getIndex(%word,%indexFile)


.data	
	filePath: 		.asciiz "frase.txt"
	ask_dic_Str: 		.ascii "Ingrese el nombre del archivo TXT correspondiente al diccionario (max 15 chars): "
	file_not_found: 	.asciiz "Error: file not found"
	.align 0
	dic_file_name: 		.space 15
	word:                   .asciiz %word
	message:	.asciiz "Indice no  encontrado"
	messageD:        .asciiz "Índice ENCONTRADO"
	null:           .byte 32
	
	
.text



# $s0: TXT file descriptor
# $s1: DICTIONARY file descriptor
# $s2: OUTPUT_ENCODE file descriptor
# $s3: DICTIONARY index
# $s4: 1 if char. 0 if EOF

main:

	move $t5,%indexFile
	#readFile("diccionarioBase.txt",20000)		
	
 	#Cargamos la palabra a buscar en $t8
 	la $s1,word
 	
 	lw $t8,0($s1) 
 	
 	addi $t4, $zero,0
 	lb $t3,0($s1)
 	
 	move $s3, $s1
 contador:
 	   beqz  $t3,returnCont
 	   addi $t4, $t4,1
 	   addi $s1,$s1,1
 	   lb $t3,0($s1)
 	   j contador
 	   
 returnCont:
 	li $v0,1
 	move $a0,$t4
 fillSpace:	
 	lb $s4,null
 	beq $t4,4, next
 	li   $t0 ' '
        sb   $t0 0($s1)
        addi $s1 $s1 1
        
 	addi $t4,$t4,1
 	j fillSpace		
next:
	lw $t8, 0($s3)
 	
 	 la $s2, ($t5)
 	#Para cargar cadena del dicionario 
 	
 	#Palabra pocision inicial del dicionario  a    					 					
 
 	
 	lw $t7, 0($s2) 	
 	addi $t4, $zero, 0
 Loop: 	
 	lb $t7, 0($s2)
 	beqz $t7, no_iguales
 	lw $t7, 0($s2)
 	beq $t8, $t7, Iguales
 	addi $t4, $t4, 1
 	addi $s2, $s2, 4
 	lw $t7, 0($s2)
 	j Loop	
	 	 	  
       Iguales: 
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

