.macro readFile(%PATH,%SIZE)
.data

	file_in:	.asciiz %PATH	# Reemplace esta cadena con el nombre del archivo que desea abrir para ser leï¿½do
	sentence:	.byte 0x0D, 0x0A, 0x0D, 0x0A	# 0x0D: Ascii para retorno de carro. 0x0A: Ascii para salto de lï¿½nea
	sentence_cont:	.asciiz "This is the new ending line"

.align 2
	input_buffer:	.space %SIZE

.text

	# Open (for reading) a file
	li $v0, 13		# System call for open file
	la $a0, file_in		# Input file name
	li $a1, 0		# Open for reading (flag = 0)
	li $a2, 0		# Mode is ignored
	syscall			# Open a file (file descriptor returned in $v0)
	move $s0, $v0		# Copy file descriptor

	# Read from previously opened file
	li $v0, 14		# System call for reading from file
	move $a0, $s0		# File descriptor
	la $a1, input_buffer	# Address of input buffer
	li $a2, %SIZE		# Maximum number of characters to read
	syscall			# Read from file
	move $t1, $v0		# Copy number of characters read
	
		# Close the files
  	li   $v0, 16       # system call for close file
	move $a0, $s0      # file descriptor to close
	syscall            # close file
	
	
	#retorna en v0 el indice donde incia el archivo del archivo y finaliza la ejecució
	la $v0,($a1)
	
	#lb $s6,1($a1)
	#beq $s6,111,Exit	
	#addi $s4,$zero,79 # Comparar con numero decimales.
	
.end_macro 
