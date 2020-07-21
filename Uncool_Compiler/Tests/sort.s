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
	.size	a, 40
a:
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.data
	.align 4
	.type	i, @object
	.size	i, 4
i:	.long	0
	.data
	.align 4
	.type	current, @object
	.size	current, 4
current:	.long	0
	.data
	.align 4
	.type	smallest, @object
	.size	smallest, 4
smallest:	.long	0
	.data
	.align 4
	.type	l, @object
	.size	l, 4
l:	.long	0
	.data
	.align 4
	.type	num_elems, @object
	.size	num_elems, 4
num_elems:	.long	0
	.text
	.globl print_array_start
	.type print_array_start,@function
print_array_start:
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
	movl $0, %ebx
	movl %ebx,i(%rip)
L0:
	movl i(%rip),%r10d
	movl 0(%rsp), %r11d
	cmp %r11d, %r10d
	setl %al
	movzbl %al, %r10d
	cmp $0,%r10d
	je L1
	movl i(%rip),%r11d
	movl a(,%r11,4),%r11d
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
	movl i(%rip),%r12d
	movl $1, %r13d
	addl %r13d, %r12d
	movl %r12d,i(%rip)
	jmp L0
L1:
	movl %r12d, %eax
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
	.globl get_array_start
	.type get_array_start,@function
get_array_start:
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
	movl $0, %ebx
	movl %ebx,i(%rip)
L2:
	movl i(%rip),%r10d
	movl 0(%rsp), %r11d
	cmp %r11d, %r10d
	setl %al
	movzbl %al, %r10d
	cmp $0,%r10d
	je L3
	movl i(%rip),%r11d
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
	movl .INPUT(%rip),%r12d
	movl %r12d, a(,%r11d,4)
	movl i(%rip),%r11d
	movl $1, %r13d
	addl %r13d, %r11d
	movl %r11d,i(%rip)
	jmp L2
L3:
	movl %r11d, %eax
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
	.globl smallest_index_start
	.type smallest_index_start,@function
smallest_index_start:
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
	movl %ebx,current(%rip)
L4:
	movl 0(%rsp), %r10d
	movl 4(%rsp), %r11d
	cmp %r11d, %r10d
	setl %al
	movzbl %al, %r10d
	cmp $0,%r10d
	je L5
	movl current(%rip),%r11d
	movl a(,%r11,4),%r11d
	movl 0(%rsp), %r12d
	movl a(,%r12,4),%r12d
	cmp %r12d, %r11d
	setg %al
	movzbl %al, %r11d
	cmp $0,%r11d
	je L6
	movl 0(%rsp), %r12d
	movl %r12d, %r11d
	jmp L7
L6:
	movl current(%rip),%r12d
	movl %r12d, %r11d
L7:
	movl %r11d,current(%rip)
	movl 0(%rsp), %r12d
	movl $1, %r13d
	addl %r13d, %r12d
	movl %r12d, 0(%rsp)
	jmp L4
L5:
	movl current(%rip),%ebx
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
	.globl swap_start
	.type swap_start,@function
swap_start:
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
	movl a(,%rbx,4),%ebx
	movl %ebx,l(%rip)
	movl 0(%rsp), %r10d
	movl 4(%rsp), %r11d
	movl a(,%r11,4),%r11d
	movl %r11d, a(,%r10d,4)
	movl 4(%rsp), %ebx
	movl l(%rip),%r10d
	movl %r10d, a(,%ebx,4)
	movl %r10d, %eax
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
	.globl sort_start
	.type sort_start,@function
sort_start:
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
	movl $0, %ebx
	movl %ebx,i(%rip)
L8:
	movl i(%rip),%r10d
	movl 0(%rsp), %r11d
	cmp %r11d, %r10d
	setl %al
	movzbl %al, %r10d
	cmp $0,%r10d
	je L9
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl i(%rip),%r11d
	movl %r11d, %edi
	movl 0(%rsp), %r11d
	movl %r11d, %esi
	call smallest_index_start
	movq 64(%rsp),%rdi 
	movq 72(%rsp),%rsi 
	movq 80(%rsp),%rdx 
	movq 88(%rsp),%rcx 
	movq 96(%rsp),%r8 
	movq 104(%rsp),%r9 
	movq 112(%rsp),%r10 
	movq 120(%rsp),%r11
	movl %eax, %r11d
	movl %r11d,smallest(%rip)
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl smallest(%rip),%r12d
	movl %r12d, %edi
	movl i(%rip),%r12d
	movl %r12d, %esi
	call swap_start
	movq 64(%rsp),%rdi 
	movq 72(%rsp),%rsi 
	movq 80(%rsp),%rdx 
	movq 88(%rsp),%rcx 
	movq 96(%rsp),%r8 
	movq 104(%rsp),%r9 
	movq 112(%rsp),%r10 
	movq 120(%rsp),%r11
	movl %eax, %r12d
	movl i(%rip),%r11d
	movl $1, %r13d
	addl %r13d, %r11d
	movl %r11d,i(%rip)
	jmp L8
L9:
	movl %r11d, %eax
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
.SS1:	.string	"Number of elements (up to 10)?"
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
	movl %r10d,num_elems(%rip)
	movl num_elems(%rip),%ebx
	movl $10, %r11d
	cmp %r11d, %ebx
	setg %al
	movzbl %al, %ebx
	cmp $0,%ebx
	je L10
	movl $10, %r11d
	movl %r11d, %ebx
	jmp L11
L10:
	movl num_elems(%rip),%r11d
	movl %r11d, %ebx
L11:
	movl %ebx,num_elems(%rip)
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl num_elems(%rip),%r10d
	movl %r10d, %edi
	call get_array_start
	movq 64(%rsp),%rdi 
	movq 72(%rsp),%rsi 
	movq 80(%rsp),%rdx 
	movq 88(%rsp),%rcx 
	movq 96(%rsp),%r8 
	movq 104(%rsp),%r9 
	movq 112(%rsp),%r10 
	movq 120(%rsp),%r11
	movl %eax, %r10d
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl num_elems(%rip),%ebx
	movl %ebx, %edi
	call sort_start
	movq 64(%rsp),%rdi 
	movq 72(%rsp),%rsi 
	movq 80(%rsp),%rdx 
	movq 88(%rsp),%rcx 
	movq 96(%rsp),%r8 
	movq 104(%rsp),%r9 
	movq 112(%rsp),%r10 
	movq 120(%rsp),%r11
	movl %eax, %ebx
	movq %rdi, 64(%rsp) 
	movq %rsi, 72(%rsp) 
	movq %rdx, 80(%rsp) 
	movq %rcx, 88(%rsp) 
	movq %r8, 96(%rsp) 
	movq %r9, 104(%rsp) 
	movq %r10, 112(%rsp) 
	movq %r11, 120(%rsp)
	movl num_elems(%rip),%r10d
	movl %r10d, %edi
	call print_array_start
	movq 64(%rsp),%rdi 
	movq 72(%rsp),%rsi 
	movq 80(%rsp),%rdx 
	movq 88(%rsp),%rcx 
	movq 96(%rsp),%r8 
	movq 104(%rsp),%r9 
	movq 112(%rsp),%r10 
	movq 120(%rsp),%r11
	movl %eax, %r10d
	movl %r10d, %eax
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

