#Include macros


.include "readFileMacro.asm"
.include "searchMacro.asm"
.include "createFile.asm"
.include "addToFile.asm"
.include "getIndex.asm"


.data
	
	filePath: 		.asciiz "frase.txt"
	ask_dic_Str: 		.ascii "Ingrese el nombre del archivo TXT correspondiente al diccionario (max 15 chars): "
	file_not_found: 	.asciiz "Error: file not found"
	.align 0
	dic_file_name: 		.space 15
	#dictionary:		.byte 97,98,99,100,101,102,103,104,105
	newDictionary:          .space 100
	
	word:                   .asciiz "abcr"
	#message:	.asciiz "Índice no  encontrado"
	messageD:        .asciiz "Índice ENCONTRADO"
	null:           .byte 32

.text


main:

	#la $t6, newDictionary # T6 ESTE EL APUNTADOR DONDE INICIA EL NUEVO DICIONARIO


	readFile("frase.txt",20000)	
        
        addi $a0, $v0,$zero # i = 0                  
        lw $a1, 0($a0)	    #file(i)
loop:                       
	
	getIndex("a",$v0)
	
	#search("pepone", $v0)
	#createFile("diccionarioBase.txt","newDictionary.txt", 2000)
	#addToFile("newDictionary.txt", "pep ",4)
