/*
 ============================================================================
 Name        : lab04.S
 Author      : 18070001027 - Melek Berna Serit
 Description : lab04 in assembly
 ============================================================================
 */
 .intel_syntax noprefix

.data
	number_format:
		.string "%d "
	char_format:
		.string "%c"
	operations:
		.string "(2455+233)*(268*(23+988))"
	numbers:
		.skip 1000

.text

.global main
main:
	lea rdi, [operations]
	call extract_numbers

ret

#rdi -> address of operations
#rax -> number of numbers placed to the array
.global extract_numbers
extract_numbers:
	mov rcx, rdi
	xor r10, r10
	outerloop:
		mov r10b, BYTE PTR [rcx]
		cmp r10b, 0
		je outerloopdone

		mov rdi ,r10
		# lea rsi, [char_format]
		# call print

		# '('
		cmp rdi, 40
		je outerloopFake
		# '+'
		cmp rdi, 43
		je preAdd
		# ')'
		cmp rdi, 41
		je calculate
		# '[sayi]' 
		push rdi
		mov r11, rdi
		cmp r11, 48
		jge realnumber

		inc rcx
		jmp outerloop
	#buraya geri don
	outerloopdone:
		mov rax, rsi




outerloopFake:
	inc rcx
	jmp outerloop

#carpma islemini ascii koduyla carptigim icin dogru calismiyor
realnumber:
	mov rdx, rdi
	pop rdi
	mov rax, rdi
	mov r8, 10
	mul r8
	add rax, rdx
	mov rdi, rax
	push rdi
	inc rcx
	jmp outerloop

#I push it to the stack bc i use it in 'calculate' while deciding between '+' and '*'/'x'
preAdd:
	push rdi
	inc rcx
	jmp outerloop

calculate:
	mov rdx, rdi
	pop rdi
	cmp rdi, 43
	je adder
	cmp rdi, 42
	je mult

adder:
	pop rdi
	add rdi, rdx
	push rdi
	inc rcx
	jmp outerloop

mult:
	pop rdi
	mov r9, rdi
	mov rax, rdx
	mul r9
	mov rdi, rax
	push rdi
	inc rcx
	jmp outerloop

ret
