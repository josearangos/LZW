# En el registro $a0 se retorna el indice del diccionario dado una cadena 
# $a0 retorna 0 si no encuenta índice

# $t3: CARACTER DEL DICCIONARIO QUE VA ITERANDO
# $t2: CONTIENE EL CARACTER PARAMETRO
# $t1: CONTADOR PARA EL ÍNDICE
# $t0: APUNTADOR DEL INDEX FILE, EL CUAL VA ITERANDO

.macro searchChar(%indexFile)
.data
	space: 	.asciiz "*"
.text
	
	addi $t1, $zero, 0
	move $t0, %indexFile
	loop:
      		lb $t3, 0($t0)
      		beqz $t3, index_not_found 
      		addi $t0, $t0, 1
      		beq $t3, 13, loop			# CARACTER PARA RETORNO DE CARRO
      		beq $t3, 10, loop			# CARACTER PARA SALTO DE LINEA
      		addi $t1, $t1, 1    		      		    		      		
      		beq $t3, $t2, return_index
      		j loop
			
	return_index:
		move $a0, $t1
		li $v0, 1
		syscall
		j exit
		
	index_not_found:
		move $a0, $zero
		li $v0, 1
		syscall
		
	exit:	
.end_macro 


.macro search(%word, %indexFile)
.data
	word: 		.ascii %word
	message:	.asciiz "Índice no encontrado"
.text
	move $t0, %indexFile
	la $t2, word				#BUSCA UN CARACTER
	lb $t2, 1($t2)				#BUSCA UN CARACTER ---> COLOCAR 0 AL ACABAR _PRUEBA_
	addi $t0, $t0, 24		#PARA PRUEBAS --BORRAR--
	loop:
		searchChar($t0)
		beqz $t3, index_not_found
		j exit
	index_not_found:
		la $a0, message
		li $v0, 4
		syscall
	exit:
.end_macro 