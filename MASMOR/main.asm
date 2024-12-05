
; Enables instructions 80386 and 80387 processors instructions
.386

; flat - 32bit memory model
; stdcall - language type
.model flat, stdcall

; Define size of the stack in bytes
.stack 4096

; Includes
INCLUDE kernel32.inc

.data

	std_output_handle DWORD ?
	message byte "Hello World!", 13, 10
	message_size DWORD $ - message
	bytes_written DWORD ?

.code
main proc

	invoke GetStdHandle, -11 ; -11 is STD_OUTPUT_HANDLE
	mov std_output_handle, EAX

	invoke WriteConsole, std_output_handle, OFFSET message, message_size, 0, 0

	invoke ExitProcess, EAX ; EAX is storing the return value from the last invoke

main endp

; Marks the end of a module and sets the program entry point to main
end main