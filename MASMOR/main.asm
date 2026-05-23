

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

		mov ecx, 0
		call ExitProcess

	main endp

end