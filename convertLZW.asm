#Include macros


.include "readFileMacro.asm"
.include "searchMacro.asm"
.include "createFile.asm"
.include "addToFile.asm"
.data
	
	filePath: 		.asciiz "frase.txt"
	ask_dic_Str: 		.ascii "Ingrese el nombre del archivo TXT correspondiente al diccionario (max 15 chars): "
	file_not_found: 	.asciiz "Error: file not found"
	dic_file_name: 		.space 15

.text

# $s0: TXT file descriptor
# $s1: DICTIONARY file descriptor
# $s2: OUTPUT_ENCODE file descriptor
# $s3: DICTIONARY index
# $s4: 1 if char. 0 if EOF

main:

	readFile("newDictionary.txt",20000)	
	   
	search("pepone", $v0)
	#createFile("diccionarioBase.txt","newDictionary.txt", 2000)
	#addToFile("newDictionary.txt", "pepone",6)
	
	
	
