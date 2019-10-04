.macro addToFile(%fileName, %word, %wordSize)
  
.data
  fileName:		.asciiz %fileName	# Este es el nombre del archivo de salida

.align 2

.text
  
  add $t6,  $zero,%wordSize
  
  # Open (for writing) a file that does not exist
	li $v0, 13		# System call for open file
	la $a0, fileName	# Output file name
	li $a1, 9		# Open for writing and appending (flag = 9)
	li $a2, 0		# Mode is ignored
	syscall			# Open a file (file descriptor returned in $v0)
	move $s1, $v0		# Copy file descriptor

  # Write to file just opened
	li $v0, 15		# System call for write to a file
	move $a0, $s1		# Restore file descriptor (open for writing)
	move $a1, %word		# Address of buffer from which to write
	add $a2, $t6,$zero	# Number of characters to write
	syscall
		
	#move $a0, %word
	#li $v0,4
	#syscall
	
 # Close the file

	li   $v0, 16       # system call for close file
	move $a0, $s1      # file descriptor to close
	syscall            # close file
				
		
.end_macro 
