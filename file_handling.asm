# ACyLab
# Demo for lab
# File handling in MIPS
# Not the smartest program but very illustrative

# Este programa abre un archivo de texto plano, lo lee, copia su contenido en otro archivo de salida y al final le agrega una frase

.data
file_in:	.asciiz "frase.txt"	# Reemplace esta cadena con el nombre del archivo que desea abrir para ser le�do
file_out:	.asciiz "salida.txt"	# Este es el nombre del archivo de salida
					# Ambos archivos residen en la misma carpeta de MARS
sentence:	.byte 0x0D, 0x0A, 0x0D, 0x0A	# 0x0D: Ascii para retorno de carro. 0x0A: Ascii para salto de l�nea
sentence_cont:	.asciiz "This is the new ending line"

.align 2
input_buffer:	.space 20000

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
	li $a2, 20000		# Maximum number of characters to read
	syscall			# Read from file
	move $t1, $v0		# Copy number of characters read
	
	#LlAMAR EL ALGORITMO QUE CREA EL NUEVO DICIONARIO
	lb $s6,1($a1)
	beq $s6,111,Exit	
	addi $s4,$zero,79 # Comparar con numero decimales.
	
	
	
	
	
	


	

			
Exit:   li   $v0, 10	# System call for exit
	syscall
