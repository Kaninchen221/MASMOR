
; Enables instructions 80386 and 80387 processors instructions
.386

; flat - 32bit memory model
; stdcall - language type
.model flat, stdcall

; Define size of the stack in bytes
.stack 4096

; Prototype a function with return value dword
ExitProcess proto, ExitCode:dword

.data

	sum DWORD ?

.code
main proc
	mov eax, 7
	add eax, 4
	mov sum, eax

	invoke ExitProcess, 0

main endp

; Marks the end of a module and sets the program entry point to main
end main