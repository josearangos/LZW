# En el registro $a0 se retorna el indice del diccionario dado una cadena 
# $a0 retorna 0 si no encuenta índice

.macro search(%word, %indexFile)
.data
	word: 	.ascii %word
	space: 	.asciiz "*"
.text
	lw $t2, word
	addi $t1, $zero, 0
	move $t0,%indexFile
	Loop:
      		lb $a0,0($t0)
      		beqz $a0, index_not_found
      		addi $t7,$a0,0
      		beq $t7,10,comparador	
      		addi $t0, $t0, 1
      		addi $t1, $t1, 1  
      		    		
      		

		
      		
      		#beq $a0, $t2, return_index
      		
		#li $v0,1
		#syscall
				
		j Loop
		j exit

	comparador:
		beq $t7, 13, Loop
		beqz $t7,exit
		lb $a0,0($t0)
		addi $t7,$a0,0
		addi $t0, $t0, 1
		
		
		li $v0, 11
		syscall
		li $v0, 4
		la $a0, space
		syscall
		
		j comparador
		
			
	return_index:
		move $a0, $t1
		li $v0,1
		syscall
		j exit
		
	index_not_found:
		move $a0, $zero
		li $v0,1
		syscall
		
	exit:	
.end_macro 
