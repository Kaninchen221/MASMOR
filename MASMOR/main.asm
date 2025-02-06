
; Enables instructions 80386 and 80387 processors instructions
.386

; flat - 32bit memory model
; stdcall - language type
.model flat, stdcall

; Define size of the stack in bytes
.stack 4096

; Includes
;INCLUDE windows.inc
INCLUDE kernel32.inc
INCLUDE user32.inc

MR_WriteConsole MACRO handle, message, message_size
	invoke WriteConsole, std_output_handle, OFFSET message, message_size, 0, 0
ENDM

.data

	std_output_handle DWORD ?

	hello_message byte "MASMOR Start!", 13, 10
	hello_message_size DWORD $ - hello_message

.code
main proc

	; STD OUTPUT HANDLE
	invoke GetStdHandle, -11 ; -11 is STD_OUTPUT_HANDLE
	mov std_output_handle, EAX

	MR_WriteConsole std_output_handle, hello_message, hello_message_size

	invoke ExitProcess, EAX

main endp

; Marks the end of a module and sets the program entry point to main
end main