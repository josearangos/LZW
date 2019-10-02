.include "readFileMacro.asm"
.include "createFile.asm"
.include "addToFile.asm"
.include "getIndex.asm"

# $t4: numero del indice
# $v0: inidice de archivos

# $t3: se guardará la palabra
# $t2: wk
# $t6: luego de leer se usa para contar caracteres de word
# $t7: auxiliar para guardar $t3

.data
	
	filePath: 			.asciiz "frase.txt"
	ask_dic_Str: 			.ascii "Ingrese el nombre del archivo TXT correspondiente al diccionario (max 15 chars): "
	file_not_found: 		.asciiz "Error: file not found"
.align 0
	dic_file_name: 			.space 15

.text
#	createFile("diccionarioBase.txt", "newDictionary.txt", 2000)

	addi $t6, $zero, 0
	readFile("frase.txt",20000)
        move $t9, $v0
        #lw $t3, 0($t0)
        #lb $t3, 0($t9)
        #beqz $t3, end_loop
        addi $t6, $t6, 1
        la $t3, 0($t9)

        readFile("newDictionary.txt",20000)
        move $t1, $v0
	
loop:
	lb $t3, 0($t9)
	beqz $t3, end_loop
	la $t3, 0($t9)
	bne $t6, 4, add_zero_to_word

	#beqz $t3, end_loop
	getIndex($t3, $t1)
	addi $t9, $t9, 1
	j loop
	#bne $t4, -1, concat_next_char
	
	#move $a0, $t4  		#IMPRIMIR CODIGO W
	#li $v0, 1
	#syscall
	
	
	#addToFile("newDictionary.txt", $t3 ,4)
	
	
concat_next_char:
		


add_zero_to_word:
	beq $t6, 4, loop
	addi $t6, $t6, 1
	addi $t3, $t3 1
        move $t5, $zero
        sb   $t5, 0($t3)
        
        j add_zero_to_word
	#search("pepone", $v0)
	#createFile("diccionarioBase.txt","newDictionary.txt", 2000)
	#addToFile("newDictionary.txt", "pep ",4)

end_loop:
	move $t7, $zero				#liberamos $t7