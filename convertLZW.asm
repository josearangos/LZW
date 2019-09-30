#Include macros


.include "readFileMacro.asm"


.data

 filePath: .asciiz "frase.txt"

.text
      main:

      	   readFile("dicionarioBase.txt",20000)
      	   lb $a0,0($v0) # en $V0 viene el inicio del texto leeido
	   li $v0,1
	   syscall   
	   
	   #beq $s6,111,1Exit	
	   #addi $s4,$zero,79 # Comparar con numero decimales.
	   


