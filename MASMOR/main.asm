

; Include libs
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

; Protos
ExitProcess PROTO
SetConsoleTitleW PROTO
text proto

.data
	sum qword 0

	console_title word "M", "A", "S", "M", "O", "R", 0

	ucount byte 16
	scount sbyte -8

	flags byte ?

	val1 word 1
	val2 word 2

	arrayB byte 10h, 20h, 30h, 40h, 50h

	arrayW word 1, 2, 3, 4, 5

	sub_dest dword 30000h
	sub_source dword 10000h

	negate_result sdword -8

	r_val sdword ?
	x_val sdword 26
	y_val sdword 30
	z_val sdword 40

.code

	main proc

		; movzx copy content from the source operand and zero-extend the bits to the destination operand
		; unsigned int
		movzx rcx, ucount

		; movsx is working like movzx but instead of zero-extend it's copying the highest bit of the source operand
		movsx rcx, scount

		; Copy the low byte of the eflags register into the ah register
		lahf
		mov flags, ah

		; Copy the saved flags to the eflags register
		mov ah, 0 ; First set the flags to 0
		sahf
		
		; Restore the flags
		mov ah, flags
		sahf

		; Exchange the contents of two operands
		xchg ah, al

		; xchg does not support two memory operands
		;xchg val1, val2 ; invalid

		; direct-offset operand
		mov al, arrayB
		mov al, [arrayB+1]
		mov al, [arrayB+2]

		; We always need to jump by using the size in bytes of a one element
		mov ax, arrayW
		mov ax, [arrayW+2]
		mov ax, [arrayW+4]

		; Subtraction
		;sub sub_dest, sub_source ; The destiny operand must be reg
		mov eax, sub_dest
		sub eax, sub_source
		mov sub_dest, eax

		; Negate (both reg and memmory operand are valid)
		mov eax, 1
		neg eax
		neg negate_result

		; Arithmetic expression (-r_val + (y_val - z_val))
		mov eax, x_val
		neg eax
		mov ebx, y_val
		sub ebx, z_val
		add eax, ebx
		mov r_val, eax

		; OV - Overflow Flag
		; UP - Direction Flag
		; EI - Interrupt Flag
		; PL - Sign Flag
		; ZR - Zero Flag
		; AC - Auciliary Flag
		; PE - Parity Flag
		; CY - Carry Flag

		; Zero, Carry and Auxiliary Carry
		; ZR - Zero Flag
		; We are using x64 so the 'ZF' reg is 'ZR'
		mov ecx, 1
		sub ecx, 1 ; ecx = 0, ZR = 1
		mov eax, 0FFFFFFFFh
		inc eax ; eax = 0, ZR = 1
		inc eax ; eax = 1, ZR = 0
		dec eax ; eax = 0, ZR = 1

		; Carry Flag
		; CY - Carry Flag
		mov al, 0FFh
		add al, 1 ; AL = 00, CY = 1

		mov ax, 00FFh
		add ax, 1 ; AX = 0100h, CY = 0

		; Substraction also set the CY
		mov al, 1
		sub al, 2 ; AL = 0FFh, CY = 1
		sub al, 1 ; AL = 0FFh, CY = 0

		mov ecx, 0
		call ExitProcess

	main endp

end