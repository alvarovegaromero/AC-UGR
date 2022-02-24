	.file	"daxpy.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Falta N"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"Tiempo(seg.):%11.9f\t / Tama\303\261o Vectores:N: %d, / y[0] = %f / y[N-1] = %f \n"
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
	jle	.L13
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movl	%eax, %ebx
	movq	%rax, %r14
	movq	%rax, 8(%rsp)
	salq	$3, %rbx
	movq	%rbx, %rdi
	call	malloc@PLT
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	malloc@PLT
	xorl	%edi, %edi
	movq	%rax, %r13
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	testl	%r14d, %r14d
	je	.L3
	movl	%r14d, %eax
	xorl	%ebx, %ebx
	subl	$1, %eax
	leaq	8(,%rax,8), %r15
	movq	%rax, %r14
	.p2align 4,,10
	.p2align 3
.L4:
	call	rand@PLT
	movl	%eax, %ebp
	call	rand@PLT
	pxor	%xmm0, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sd	%ebp, %xmm0
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%r12,%rbx)
	call	rand@PLT
	movl	%eax, %ebp
	call	rand@PLT
	pxor	%xmm0, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sd	%ebp, %xmm0
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, 0(%r13,%rbx)
	addq	$8, %rbx
	cmpq	%rbx, %r15
	jne	.L4
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movsd	.LC1(%rip), %xmm1
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L5:
	movsd	(%r12,%rax), %xmm0
	mulsd	%xmm1, %xmm0
	addsd	0(%r13,%rax), %xmm0
	movsd	%xmm0, 0(%r13,%rax)
	addq	$8, %rax
	cmpq	%rax, %rbx
	jne	.L5
.L6:
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	leaq	.LC3(%rip), %rsi
	pxor	%xmm0, %xmm0
	movl	8(%rsp), %edx
	pxor	%xmm1, %xmm1
	movl	$1, %edi
	movsd	0(%r13,%r14,8), %xmm2
	cvtsi2sdq	%rax, %xmm0
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	movl	$3, %eax
	divsd	.LC2(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	0(%r13), %xmm1
	call	__printf_chk@PLT
	xorl	%eax, %eax
	movq	56(%rsp), %rcx
	xorq	%fs:40, %rcx
	jne	.L14
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
.L3:
	.cfi_restore_state
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	movl	$4294967295, %r14d
	call	clock_gettime@PLT
	jmp	.L6
.L14:
	call	__stack_chk_fail@PLT
.L13:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	orl	$-1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE41:
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
