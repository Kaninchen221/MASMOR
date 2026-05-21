COMMENT *
Program purpose: Learning
Author: Pawel Krolik
*

STD_OUTPUT_HANDLE_VALUE = -11

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

	std_output_handle dword ?

	console_title byte "MASMOR", 0

	hello_message byte "MASMOR Start!", 13, 10
	hello_message_size dword $ - hello_message

	test_message byte "TEST_MESSAGE "
		byte "and there is another line", 13, 10

	; It should be always divided by the size of an one element, single char is one byte so we divide the size by 1
	; $ is the current location counter, returns the offset to current program statement
	test_message_size dword ($ - test_message) / 1

	; Allocate 20 bytes ~ uninitialized
	dup_test byte 20 dup(?)

	main_loop_counter dword 0

	; Binary coded decimal with valid initialization value
	tbyte_test TBYTE 800000000000001234h

	; Floats (real4, real8, real10)
	real_test real4 -1.2

.code

MR_test proc
	mov EAX, test_message_size
	MR_WriteConsole test_message, EAX
	mov EAX, 1
	ret
MR_test endp

main proc

	; STD OUTPUT HANDLE
	invoke GetStdHandle, STD_OUTPUT_HANDLE_VALUE ; -11 is STD_OUTPUT_HANDLE
	mov std_output_handle, EAX

	MR_WriteConsole hello_message, hello_message_size

	invoke SetConsoleTitle, OFFSET console_title

	main_loop:
		; Print a message in the console
		;MR_WriteConsole test_message, test_message_size
		; Invoke a function
		invoke MR_test
		inc main_loop_counter

		mov eax, 0
		inc eax

		.if main_loop_counter < 10
			jmp main_loop
		.endif

	invoke ExitProcess, EAX

main endp

; Marks the end of a module and sets the program entry point to main
end main