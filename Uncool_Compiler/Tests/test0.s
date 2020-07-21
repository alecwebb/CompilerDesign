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
	movl $42, %ebx
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl %ebx, %esi
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

