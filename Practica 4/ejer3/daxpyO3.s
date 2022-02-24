	.file	"daxpy.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Falta N"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
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
	jle	.L19
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movl	%eax, %ebx
	movq	%rax, %r14
	salq	$3, %rbx
	movq	%rbx, %rdi
	call	malloc@PLT
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	malloc@PLT
	xorl	%edi, %edi
	movq	%rax, %rbp
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	testl	%r14d, %r14d
	je	.L3
	leal	-1(%r14), %eax
	xorl	%r15d, %r15d
	leaq	8(,%rax,8), %r13
	movl	%eax, 12(%rsp)
	.p2align 4,,10
	.p2align 3
.L4:
	call	rand@PLT
	movl	%eax, %ebx
	call	rand@PLT
	pxor	%xmm0, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sd	%ebx, %xmm0
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%r12,%r15)
	call	rand@PLT
	movl	%eax, %ebx
	call	rand@PLT
	pxor	%xmm0, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sd	%ebx, %xmm0
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, 0(%rbp,%r15)
	addq	$8, %r15
	cmpq	%r13, %r15
	jne	.L4
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	%rbp, %rcx
	shrq	$3, %rcx
	andl	$1, %ecx
	cmpl	$1, 12(%rsp)
	jbe	.L11
	xorl	%edi, %edi
	testl	%ecx, %ecx
	je	.L6
	movsd	.LC1(%rip), %xmm0
	movl	$1, %edi
	mulsd	(%r12), %xmm0
	addsd	0(%rbp), %xmm0
	movsd	%xmm0, 0(%rbp)
.L6:
	movl	%r14d, %r9d
	movapd	.LC2(%rip), %xmm1
	subl	%ecx, %r9d
	salq	$3, %rcx
	xorl	%eax, %eax
	movl	%r9d, %r8d
	leaq	0(%rbp,%rcx), %rsi
	xorl	%edx, %edx
	shrl	%r8d
	addq	%r12, %rcx
	.p2align 4,,10
	.p2align 3
.L7:
	movupd	(%rcx,%rax), %xmm0
	addl	$1, %edx
	mulpd	%xmm1, %xmm0
	addpd	(%rsi,%rax), %xmm0
	movaps	%xmm0, (%rsi,%rax)
	addq	$16, %rax
	cmpl	%r8d, %edx
	jb	.L7
	movl	%r9d, %edx
	andl	$-2, %edx
	cmpl	%edx, %r9d
	leal	(%rdx,%rdi), %eax
	je	.L9
.L5:
	movslq	%eax, %rcx
	movsd	.LC1(%rip), %xmm0
	movsd	(%r12,%rcx,8), %xmm1
	leaq	0(%rbp,%rcx,8), %rdx
	addl	$1, %eax
	mulsd	%xmm0, %xmm1
	cmpl	%eax, %r14d
	addsd	(%rdx), %xmm1
	movsd	%xmm1, (%rdx)
	jbe	.L9
	cltq
	mulsd	(%r12,%rax,8), %xmm0
	leaq	0(%rbp,%rax,8), %rdx
	addsd	(%rdx), %xmm0
	movsd	%xmm0, (%rdx)
.L9:
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	leaq	.LC4(%rip), %rsi
	pxor	%xmm0, %xmm0
	movl	12(%rsp), %r15d
	pxor	%xmm1, %xmm1
	movl	$1, %edi
	movl	%r14d, %edx
	cvtsi2sdq	%rax, %xmm0
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	movsd	0(%rbp,%r15,8), %xmm2
	cvtsi2sdq	%rax, %xmm1
	movl	$3, %eax
	divsd	.LC3(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	0(%rbp), %xmm1
	call	__printf_chk@PLT
	xorl	%eax, %eax
	movq	56(%rsp), %rdi
	xorq	%fs:40, %rdi
	jne	.L20
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
	call	clock_gettime@PLT
	movl	$-1, 12(%rsp)
	jmp	.L9
.L11:
	xorl	%eax, %eax
	jmp	.L5
.L20:
	call	__stack_chk_fail@PLT
.L19:
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
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC2:
	.long	0
	.long	1077346304
	.long	0
	.long	1077346304
	.section	.rodata.cst8
	.align 8
.LC3:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
