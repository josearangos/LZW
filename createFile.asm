.macro createFile(%dictBase, %newDict, %dictBaseSize)
  
  .data
  dictBase_file:	.asciiz %dictBase
  newDict_file:		.asciiz %newDict

 .align 2
input_buffer:	.space %dictBaseSize

  .text
  add $t5,  $zero,%dictBaseSize
  
  # Open (for reading) a file
	li $v0, 13		# System call for open file
	la $a0, dictBase_file		# Input file name
	li $a1, 0		# Open for reading (flag = 0)
	li $a2, 0		# Mode is ignored
	syscall			# Open a file (file descriptor returned in $v0)
	move $s0, $v0		# Copy file descriptor
	
  # Open (for writing) a file that does not exist
	li $v0, 13		# System call for open file
	la $a0, newDict_file	# Output file name
	li $a1, 9		# Open for writing and appending (flag = 9)
	li $a2, 0		# Mode is ignored
	syscall			# Open a file (file descriptor returned in $v0)
	move $s1, $v0		# Copy file descriptor
	
 # Read from previously opened file
	li $v0, 14		# System call for reading from file
	move $a0, $s0		# File descriptor
	la $a1, input_buffer	# Address of input buffer
	add $a2, $t5,$zero		# Maximum number of characters to read
	syscall			# Read from file
	move $t1, $v0		# Copy number of characters read

 # Copy the file loaded in memory into the output file

	li $v0, 15		# System call for write to a file
	move $a0, $s1		# Restore file descriptor (open for writing)
	la $a1, input_buffer	# Address of buffer from which to write
	move $a2, $t1		# Number of characters to write
	syscall
	
# Close the files

	li   $v0, 16       # system call for close file
	move $a0, $s1      # file descriptor to close
	syscall            # close file
				
		
.end_macro 
