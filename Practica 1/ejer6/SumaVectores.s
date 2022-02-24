	.file	"SumaVectores.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"Faltan n\302\272 componentes del vector"
	.align 8
.LC3:
	.string	"/ V1[%d]+V2[%d]=V3[%d](%8.6f+%8.6f=%8.6f) /\n"
	.align 8
.LC4:
	.string	"Tiempo:%11.9f\t / Tama\303\261o Vectores:%u\t/ V1[0]+V2[0]=V3[0](%8.6f+%8.6f=%8.6f) / / V1[%d]+V2[%d]=V3[%d](%8.6f+%8.6f=%8.6f) /\n"
	.align 8
.LC5:
	.string	"Tiempo:%11.9f\t / Tama\303\261o Vectores:%u\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB41:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L27
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	cmpl	$33554432, %eax
	movl	%eax, %r14d
	ja	.L3
	cmpl	$8, %eax
	ja	.L4
	testl	%eax, %eax
	je	.L5
	pxor	%xmm1, %xmm1
	leaq	v1(%rip), %rbp
	leaq	v2(%rip), %r12
	movsd	.LC1(%rip), %xmm3
	cvtsi2sd	%eax, %xmm1
	xorl	%eax, %eax
	mulsd	%xmm3, %xmm1
	.p2align 4,,10
	.p2align 3
.L6:
	pxor	%xmm0, %xmm0
	movapd	%xmm1, %xmm2
	movapd	%xmm1, %xmm7
	cvtsi2sd	%eax, %xmm0
	mulsd	%xmm3, %xmm0
	addsd	%xmm0, %xmm2
	subsd	%xmm0, %xmm7
	movsd	%xmm2, 0(%rbp,%rax,8)
	movsd	%xmm7, (%r12,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r14d
	ja	.L6
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	leal	-1(%r14), %r13d
	call	clock_gettime@PLT
	jmp	.L16
.L4:
	xorl	%edi, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
.L15:
	leal	-1(%r14), %eax
	leaq	v1(%rip), %rbp
	leaq	v2(%rip), %r12
	xorl	%r15d, %r15d
	movq	%rax, %r13
	leaq	8(,%rax,8), %rax
	movq	%rax, 8(%rsp)
	.p2align 4,,10
	.p2align 3
.L8:
	call	rand@PLT
	movl	%eax, %ebx
	call	rand@PLT
	pxor	%xmm0, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sd	%ebx, %xmm0
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, 0(%rbp,%r15)
	call	rand@PLT
	movl	%eax, %ebx
	call	rand@PLT
	pxor	%xmm0, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sd	%ebx, %xmm0
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%r12,%r15)
	addq	$8, %r15
	cmpq	8(%rsp), %r15
	jne	.L8
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
.L16:
	movl	%r13d, %eax
	leaq	v3(%rip), %r15
	leaq	8(,%rax,8), %rdx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L9:
	movsd	0(%rbp,%rax), %xmm0
	addsd	(%r12,%rax), %xmm0
	movsd	%xmm0, (%r15,%rax)
	addq	$8, %rax
	cmpq	%rdx, %rax
	jne	.L9
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	pxor	%xmm0, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm0
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cmpl	$9, %r14d
	cvtsi2sdq	%rax, %xmm1
	divsd	.LC2(%rip), %xmm0
	addsd	%xmm1, %xmm0
	jbe	.L28
	movl	%r13d, %eax
	movsd	(%r15), %xmm3
	movsd	(%r15,%rax,8), %xmm6
	leaq	.LC4(%rip), %rsi
	movsd	(%r12,%rax,8), %xmm5
	movl	%r13d, %r9d
	movsd	0(%rbp,%rax,8), %xmm4
	movl	%r13d, %r8d
	movsd	(%r12), %xmm2
	movl	%r13d, %ecx
	movsd	0(%rbp), %xmm1
	movl	%r14d, %edx
	movl	$1, %edi
	movl	$7, %eax
	call	__printf_chk@PLT
.L12:
	xorl	%eax, %eax
	movq	56(%rsp), %rcx
	xorq	%fs:40, %rcx
	jne	.L29
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L28:
	.cfi_restore_state
	movl	%r14d, %edx
	leaq	.LC5(%rip), %rsi
	leaq	.LC3(%rip), %r14
	movl	$1, %edi
	movl	$1, %eax
	addq	$1, %r13
	xorl	%ebx, %ebx
	call	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L13:
	movsd	(%r15,%rbx,8), %xmm2
	movl	%ebx, %r8d
	movsd	(%r12,%rbx,8), %xmm1
	movl	%ebx, %ecx
	movsd	0(%rbp,%rbx,8), %xmm0
	movl	%ebx, %edx
	movq	%r14, %rsi
	movl	$1, %edi
	movl	$3, %eax
	addq	$1, %rbx
	call	__printf_chk@PLT
	cmpq	%rbx, %r13
	jne	.L13
	jmp	.L12
.L3:
	xorl	%edi, %edi
	movl	$33554432, %r14d
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	jmp	.L15
.L5:
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	leaq	.LC5(%rip), %rsi
	pxor	%xmm0, %xmm0
	xorl	%edx, %edx
	pxor	%xmm1, %xmm1
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	movl	$1, %eax
	divsd	.LC2(%rip), %xmm0
	addsd	%xmm1, %xmm0
	call	__printf_chk@PLT
	jmp	.L12
.L29:
	call	__stack_chk_fail@PLT
.L27:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	orl	$-1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE41:
	.size	main, .-main
	.comm	v3,268435456,32
	.comm	v2,268435456,32
	.comm	v1,268435456,32
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	2576980378
	.long	1069128089
	.align 8
.LC2:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
