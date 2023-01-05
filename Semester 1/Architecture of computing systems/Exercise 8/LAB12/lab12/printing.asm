bits 32
extern _printf
global _printer
segment data public data use32
	format db "%d ", 0
segment code public code use32
_printer:
	push ebp ; remembering the location of ebp on stack
	mov ebp,esp ; remembering the index in the array in ebp
    mov eax, [ebp+8]
    push dword eax
	push dword format	
	call _printf ; printing the number
	add esp, 4*2 ; cleaning the stack
	pop ebp ; putting the ebp value back in it s register
    ret