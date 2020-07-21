	.section	.rodata
.LC0:
	.string "%d "
.LC1:
	.string "%s "
.LC2:
	.string "%d"
	.data
	.align	4
.INPUT:
	.long	0
	.data
	.align 4
	.type	a, @object
	.size	a, 4
a:	.long	0
	.data
	.align 4
	.type	b, @object
	.size	b, 4
b:	.long	0
	.text
	.globl looping_start
	.type looping_start,@function
looping_start:
	pushq %rbp
	movq %rsp,%rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp
	subq $128, %rsp
	movl %edi,0(%rsp)
	movl %esi,4(%rsp)
	movl %edx,8(%rsp)
	movl %ecx,12(%rsp)
	movl %r8d,16(%rsp)
	movl %r9d,20(%rsp)
	movl 0(%rsp), %ebx
	movl 4(%rsp), %r10d
	cmp %r10d, %ebx
	setg %al
	movzbl %al, %ebx
	cmp $0,%ebx
	je L0
L2:
	movl 4(%rsp), %r10d
	movl 0(%rsp), %r11d
	cmp %r11d, %r10d
	setle %al
	movzbl %al, %r10d
	cmp $0,%r10d
	je L3
	movl 4(%rsp), %r11d
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl %r11d, %esi
	movl $.LC0, %edi
	call printf
	movq 64(%rsp),%rdi 
	movq 72(%rsp),%rsi 
	movq 80(%rsp),%rdx 
	movq 88(%rsp),%rcx 
	movq 96(%rsp),%r8 
	movq 104(%rsp),%r9 
	movq 112(%rsp),%r10 
	movq 120(%rsp),%r11
	movl 4(%rsp), %r12d
	movl $1, %r13d
	addl %r13d, %r12d
	movl %r12d, 4(%rsp)
	jmp L2
L3:
	movl %r12d, %ebx
	jmp L1
L0:
L4:
	movl 0(%rsp), %r10d
	movl 4(%rsp), %r11d
	cmp %r11d, %r10d
	setle %al
	movzbl %al, %r10d
	cmp $0,%r10d
	je L5
	movl 0(%rsp), %r11d
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl %r11d, %esi
	movl $.LC0, %edi
	call printf
	movq 64(%rsp),%rdi 
	movq 72(%rsp),%rsi 
	movq 80(%rsp),%rdx 
	movq 88(%rsp),%rcx 
	movq 96(%rsp),%r8 
	movq 104(%rsp),%r9 
	movq 112(%rsp),%r10 
	movq 120(%rsp),%r11
	movl 0(%rsp), %r12d
	movl $1, %r13d
	addl %r13d, %r12d
	movl %r12d, 0(%rsp)
	jmp L4
L5:
	movl %r12d, %ebx
L1:
	movl %ebx, %eax
	addq $128, %rsp
	popq %rbp
	popq %r15 
	popq %r14 
	popq %r13 
	popq %r12 
	popq %rbx
	popq %rbp
	ret

	.text
	.globl main
	.type main,@function
main:
	pushq %rbp
	movq %rsp,%rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp
	subq $128, %rsp
	.data
.SS1:	.string	"> "
	.text
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl $.SS1, %esi
	movl $.LC1, %edi
	call printf
	movq 64(%rsp),%rdi 
	movq 72(%rsp),%rsi 
	movq 80(%rsp),%rdx 
	movq 88(%rsp),%rcx 
	movq 96(%rsp),%r8 
	movq 104(%rsp),%r9 
	movq 112(%rsp),%r10 
	movq 120(%rsp),%r11
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl $.LC2, %edi
	movl $.INPUT, %esi
	call  __isoc99_scanf
	movq 64(%rsp),%rdi 
	movq 72(%rsp),%rsi 
	movq 80(%rsp),%rdx 
	movq 88(%rsp),%rcx 
	movq 96(%rsp),%r8 
	movq 104(%rsp),%r9 
	movq 112(%rsp),%r10 
	movq 120(%rsp),%r11
	movl .INPUT(%rip),%r10d
	movl %r10d,a(%rip)
	.data
.SS2:	.string	"> "
	.text
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl $.SS2, %esi
	movl $.LC1, %edi
	call printf
	movq 64(%rsp),%rdi 
	movq 72(%rsp),%rsi 
	movq 80(%rsp),%rdx 
	movq 88(%rsp),%rcx 
	movq 96(%rsp),%r8 
	movq 104(%rsp),%r9 
	movq 112(%rsp),%r10 
	movq 120(%rsp),%r11
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl $.LC2, %edi
	movl $.INPUT, %esi
	call  __isoc99_scanf
	movq 64(%rsp),%rdi 
	movq 72(%rsp),%rsi 
	movq 80(%rsp),%rdx 
	movq 88(%rsp),%rcx 
	movq 96(%rsp),%r8 
	movq 104(%rsp),%r9 
	movq 112(%rsp),%r10 
	movq 120(%rsp),%r11
	movl .INPUT(%rip),%r10d
	movl %r10d,b(%rip)
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl a(%rip),%ebx
	movl %ebx, %edi
	movl b(%rip),%ebx
	movl %ebx, %esi
	call looping_start
	movq 64(%rsp),%rdi 
	movq 72(%rsp),%rsi 
	movq 80(%rsp),%rdx 
	movq 88(%rsp),%rcx 
	movq 96(%rsp),%r8 
	movq 104(%rsp),%r9 
	movq 112(%rsp),%r10 
	movq 120(%rsp),%r11
	movl %eax, %ebx
	movl %ebx, %eax
	addq $128, %rsp
	popq %rbp
	popq %r15 
	popq %r14 
	popq %r13 
	popq %r12 
	popq %rbx
	movl $0, %eax
	popq %rbp
	ret

