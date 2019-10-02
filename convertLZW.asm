.include "readFileMacro.asm"
.include "createFile.asm"
.include "addToFile.asm"
.include "getIndex.asm"

# $t4: numero del indice
# $v0: inidice de archivos

.data
	
	filePath: 			.asciiz "frase.txt"
	ask_dic_Str: 			.ascii "Ingrese el nombre del archivo TXT correspondiente al diccionario (max 15 chars): "
	file_not_found: 		.asciiz "Error: file not found"
.align 0
	dic_file_name: 			.space 15

.text
	readFile("frase.txt",20000)
        move $t0, $v0
        #lw $t3, 0($t0)
        la $t3, 0($t0)        
        
        readFile("newDictionary.txt",20000)
        move $t0, $v0
#loop:
	beqz $t3, end_loop
	getIndex($t3, $t0)
	
	
end_loop:		
	#search("pepone", $v0)
	#createFile("diccionarioBase.txt","newDictionary.txt", 2000)
	#addToFile("newDictionary.txt", "pep ",4)
