	.file	"daxpy.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Falta N"
.LC3:
	.string	"Tiempo(seg.):%11.9f\t / Tama\303\261o Vectores:N: %d, / y[0] = %f / y[N-1] = %f \n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB23:
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	decl	%edi
	jg	.L2
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	orl	$-1, %edi
	call	exit@PLT
.L2:
	movq	8(%rsi), %rdi
	xorl	%r12d, %r12d
	call	atoi@PLT
	movl	%eax, %r15d
	leaq	0(,%r15,8), %rbx
	movq	%r15, %rbp
	incq	%r15
	movq	%rbx, %rdi
	call	malloc@PLT
	movq	%rbx, %rdi
	movq	%rax, %r14
	call	malloc@PLT
	xorl	%edi, %edi
	movq	%rax, %rbx
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
.L3:
	incq	%r12
	cmpq	%r15, %r12
	je	.L10
	call	rand@PLT
	movl	%eax, %r13d
	call	rand@PLT
	cvtsi2sd	%r13d, %xmm0
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%r14,%r12,8)
	call	rand@PLT
	movl	%eax, %r13d
	call	rand@PLT
	cvtsi2sd	%r13d, %xmm0
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbx,%r12,8)
	jmp	.L3
.L10:
	leaq	8(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movsd	.LC1(%rip), %xmm1
	xorl	%eax, %eax
.L5:
	cmpl	%eax, %ebp
	jbe	.L11
	movsd	(%r14,%rax,8), %xmm0
	mulsd	%xmm1, %xmm0
	addsd	(%rbx,%rax,8), %xmm0
	movsd	%xmm0, (%rbx,%rax,8)
	incq	%rax
	jmp	.L5
.L11:
	leaq	24(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	leal	-1(%rbp), %edx
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	movsd	(%rbx,%rdx,8), %xmm2
	movl	%ebp, %edx
	cvtsi2sdq	%rax, %xmm0
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	movb	$3, %al
	divsd	.LC2(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	(%rbx), %xmm1
	call	__printf_chk@PLT
	xorl	%eax, %eax
	movq	40(%rsp), %rcx
	xorq	%fs:40, %rcx
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	addq	$56, %rsp
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
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1077346304
	.align 8
.LC2:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
