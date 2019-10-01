#Include macros


.include "readFileMacro.asm"
.include "searchMacro.asm"
.include "createFile.asm"
.include "addToFile.asm"
.data

 filePath: .asciiz "frase.txt"

.text

# $s0: TXT file descriptor
# $s1: DICTIONARY file descriptor
# $s2: OUTPUT_ENCODE file descriptor
# $s3: DICTIONARY index
# $s4: 1 if char. 0 if EOF

main:
	readFile("newDictionary.txt",20000)
	
	#sll $t0,$t0,2
	#add $t2,$t0,$v0
	
	   
	search("l", $v0)
	#createFile("diccionarioBase.txt","newDictionary.txt", 2000)
	#addToFile("newDictionary.txt", "pepone",6)
	
	
	
