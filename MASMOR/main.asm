
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

MR_WriteConsole MACRO message, message_size
	invoke WriteConsole, std_output_handle, OFFSET message, message_size, 0, 0
ENDM

.data

	std_output_handle DWORD ?

	console_title byte "MASMOR", 0

	hello_message byte "MASMOR Start!", 13, 10
	hello_message_size DWORD $ - hello_message

	test_message byte "TEST_MESSAGE", 13, 10
	test_message_size DWORD $ - test_message

.code

MR_test proc
	mov EAX, test_message_size
	MR_WriteConsole test_message, EAX
	mov EAX, 1
	ret
MR_test endp

main proc

	; STD OUTPUT HANDLE
	invoke GetStdHandle, -11 ; -11 is STD_OUTPUT_HANDLE
	mov std_output_handle, EAX

	MR_WriteConsole hello_message, hello_message_size

	invoke SetConsoleTitle, OFFSET console_title

	main_loop:
		; Print a message in the console
		;MR_WriteConsole test_message, test_message_size
		; Invoke a function
		invoke MR_test
		jmp main_loop

	invoke ExitProcess, EAX

main endp

; Marks the end of a module and sets the program entry point to main
end main