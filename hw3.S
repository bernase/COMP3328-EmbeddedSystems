.intel_syntax noprefix
.text

.global mymul
#rdi -> z, rsi -> a, rdx(rdx) -> b
mymul:
	push r12
	push r13
	push r14
	push r15

	#rcx -> b
	mov rcx, rdx

	#a[0]*b[0] = rax*rcx then z[0]=rax
	mov rax, QWORD PTR [rsi+8*0]
	mul QWORD PTR [rcx+8*0]
	mov QWORD PTR [rdi+8*0], rax
	mov r12, rdx
	#a[1]*b[0] = rax*rcx then r13=rax, r14=rdx
	mov rax, QWORD PTR [rsi+8*1]
	mul QWORD PTR [rcx+8*0]
	mov r13, rax
	mov r11, rdx
	#a[0]*b[1] = rax*rcx then r15=rax, r10=rdx
	mov rax, QWORD PTR [rsi+8*0]
	mul QWORD PTR [rcx+8*1]
	mov r15, rax
	mov r10, rdx
	#r12+r13+r15 = z[1] + r14(elde)
	add r13, r12
	adc r14, 0
	add r13, r15
	adc r14, 0
	mov QWORD PTR [rdi+8*1], r13

	#a[2]*b[0] = rax*rcx then r12=rax, r13=rdx
	mov rax, QWORD PTR [rsi+8*2]
	mul QWORD PTR [rcx+8*0]
	mov r12, rax
	mov r13, rdx
	#r11+r12+r10 = z[2] + elde
	add r11, r12
	adc rdx, 0
	add rax, r10
	adc rdx, 0
	mov QWORD PTR [rdi+8*2], rax

	#a[1]*b[1] = rax*rcx then r15=rax, r11=rdx
	mov rax, QWORD PTR [rsi+8*1]
	mul QWORD PTR [rcx+8*1]
	mov r15, rax
	mov r11, rdx
	#a[0]*b[2] = rax*rcx then r11=rax, r1=rdx
	mov rax, QWORD PTR [rsi+8*0]
	mul QWORD PTR [rcx+8*2]
	mov r11, rax
	mov r10, rdx
	#z[2] + ----- = z[2] + elde


	#a[3]*b[0] = rax*rcx then r13=rax, r14=rdx
	mov rax, QWORD PTR [rsi+8*1]
	mul QWORD PTR [rcx+8*0]
	mov r13, rax
	mov r14, rdx
	#a[2]*b[1] = rax*rcx then r13=rax, r14=rdx
	mov rax, QWORD PTR [rsi+8*0]
	mul QWORD PTR [rcx+8*1]
	mov r15, rax
	mov r10, rdx
	#a[1]*b[2] = rax*rcx then r13=rax, r14=rdx
	mov rax, QWORD PTR [rsi+8*0]
	mul QWORD PTR [rcx+8*1]
	mov r15, rax
	mov r10, rdx
	#a[0]*b[3] = rax*rcx then r13=rax, r14=rdx
	mov rax, QWORD PTR [rsi+8*0]
	mul QWORD PTR [rcx+8*1]
	mov r15, rax
	mov r10, rdx
	#z[3]

	#a[3]*b[1] = rax*rcx then r13=rax, r14=rdx
	mov rax, QWORD PTR [rsi+8*0]
	mul QWORD PTR [rcx+8*1]
	mov r15, rax
	mov r10, rdx
	#a[2]*b[2] = rax*rcx then r13=rax, r14=rdx
	mov rax, QWORD PTR [rsi+8*0]
	mul QWORD PTR [rcx+8*1]
	mov r15, rax
	mov r10, rdx
	#a[1]*b[3] = rax*rcx then r13=rax, r14=rdx
	mov rax, QWORD PTR [rsi+8*0]
	mul QWORD PTR [rcx+8*1]
	mov r15, rax
	mov r10, rdx
	#z[4]

	#a[3]*b[2] = rax*rcx then r13=rax, r14=rdx
	mov rax,QWORD PTR [rsi+8*0]
	mul QWORD PTR [rcx+8*1]
	mov r15, rax
	mov r10, rdx
	#a[2]*b[3] = rax*rcx then r13=rax, r14=rdx
	mov rax, QWORD PTR [rsi+8*0]
	mul QWORD PTR [rcx+8*1]
	mov r15, rax
	mov r10, rdx
	#z[5]

	#a[3]*b[3] = rax*rcx then r13=rax, r14=rdx
	mov rax, QWORD PTR [rsi+8*0]
	mul QWORD PTR [rcx+8*1]
	mov r15, rax
	mov r10, rdx
	#z[6]
	#z[7]

	mov rax, QWORD PTR [rsi+8*1]
	mul QWORD PTR [rcx+8*1]


	mov QWORD PTR [rdi+8*3], rdx

	pop r15
	pop r14
	pop r13
	pop r12


	ret



