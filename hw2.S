/*
 ============================================================================
 Name        : hw2.S
 Author      : 18070001027 - Melek Berna Serit
 Description :add, multiply ve 2 digit sayilari yapmaya calisirken debug ile cok vakit kaybettim.
 Baştan postfix değil de parça parça düşündüğüm için postfix'e cevirmeye vaktim kalmadi :(
 ============================================================================
 */
.intel_syntax noprefix
#print example for ((1+91)*2):
#Stack is not empty!
#184

#.string "(1+91)" = 92 buluyor
#.string "(12*4)" = 48 buluyor
#.string "())" Stack is empty!
#.string "()" Stack is not empty!
.data
	number_format:
		.string "%d "
	char_format:
		.string "%c"
 	expression:
 		.string "((1+91)*2)"
 	postfix:
 		.skip 1000
 	msg1:
		.asciz "Stack is empty!\n"
	msg2:
		.asciz "Symbols do not correspond!\n"
	msg3:
		.asciz "Stack is not empty!\n"

.text

.global main
main:
	lea rdi, [expression]
	call extract_numbers
ret

#rdi -> address of operations
#rax -> number of numbers placed to the array
.global extract_numbers
extract_numbers:
	mov rcx, rdi
	xor r10, r10
	xor r11, r11
	xor r12, r12
	loop:
		#read char by char
		mov r10b, BYTE PTR [rcx]
		mov r12b, BYTE PTR [rcx - 1]
		cmp r10b, 0
		je checkstack
		#je loopdone

		# '('
		cmp r10, 40
		je loopBegin
		# '+'
		cmp r10, 43
		je preAddOrMul
		# *
		cmp r10, 42
		je preAddOrMul
		# ')'
		cmp r10, 41
		je calculate
		#je closingsymbol
		# '[number]'
		cmp r10, 48
		jge checkstackelement

		inc rcx
		jmp loop

	loopdone:
	#printle burda sonucu
	pop rdi
	sub rdi, 48
	mov rax, rdi
	call print

loopBegin:
	push r10
	inc rcx
	jmp loop

preAddOrMul:
	push r10
	inc rcx
	jmp loop

adder:
	pop rdi
	sub rdi, 48
	sub rdx, 48
	add rdi, rdx
	add rdi, 48
	push rdi
	inc rcx
	jmp loop

calculate:
	pop rdi
	mov rdx, rdi
	pop rdi
	cmp rdi, 43
	je adder
	cmp rdi, 42
	je mult

mult:
	pop rdi
	sub rdi, 48
	sub rdx, 48
	mov r9, rdi
	mov rax, rdx
	mul r9
	add rax, 48
	push rax
	inc rcx
	jmp loop

checkstackelement:
	push r10
	#iif([stack-1] > 48) then realnumber
	#yani stackin bi onceki elemani sayi ise yolla realnumbera
	cmp r12, 48
	jge realnumber
	#eelse
	inc rcx
	jmp loop

realnumber:
	#switch from the ascii value to decimal by sub 48
	mov r11, r10
	pop r10
	sub r12, 48
	mov rax, r12
	mov r8, 10
	mul r8
	#rax = rax * 10
	sub r11, 48
	add rax, r11
	add rax, 48
	pop r10
	mov r10, rax
	push r10

	inc rcx
	jmp loop

#closingsymbol:
#	cmp r10, r12
#	je error1
#	jmp calculate

checkstack:
	cmp rcx, 0
	je loopdone
	jne error3


#bunu call print'e cevir
error1:
	push rax
	push rcx
	lea rdi, [msg1]
	mov rsi, rax
	xor rax, rax
	call printf
	pop rcx
	pop rax
	jmp exit

error2:
	push    rax
    push    rcx
    lea     rdi, [msg2]
    mov     rsi, rax
    xor     rax, rax
    call    printf
    pop     rcx
    pop     rax
	jmp exit

error3:
	push    rax
    push    rcx
    lea     rdi, [msg3]
    mov     rsi, rax
    xor     rax, rax
    call    printf
    pop     rcx
    pop     rax
	jmp loopdone

exit:
	ret

# rdi ->data to be printed
# rsi ->print format
.global print
print:
	#prologue
	push rax
	push rcx

	#body
	mov rax, rdi
	mov rcx, rsi
	lea rdi, [number_format]
	mov rsi, rax
	xor rax, rax
	call printf

	#epilogue
	pop rcx
	pop rax

ret

