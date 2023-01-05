bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start
 
; declare external functions needed by our program
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
 
segment data use32 class=data

    a dd 0
    a_format db "%x", 0
    
    b dd 0
    b_format db "%x", 0
    
    k equ 2
    
    a_equal db "a = ", 0
    b_equal db "b = ", 0
    
    sol_difference db "difference = %x (h)", 0
    
    sol_sum db "sum = %x (h)    ", 0
 
segment code use32 class=code
start:
    ; Read two doublewords a and b in base 16 from the keyboard. Display the sum of the low parts of the two numbers and the difference between the high parts of the two numbers in base 16 Example:
    ; a = 0010 1A35h
    ; b = 0002 3219h
    ; sum = 4C4Eh
    ; difference = Eh
 
    push dword a_equal     ; get the value of a
    call [printf]     ; print a = 
    add esp, 4 * 1 ; clear

    ; read a from keyboard
    push a
    push a_format
    call [scanf]
    add esp, 4 * 2
 
    push dword b_equal    ; get the value of b
    call [printf]     ; print b = 
    add esp, 4 * 1 ; clear
 
    ; read b from keyboard
    push b
    push b_format
    call [scanf]
    add esp, 4 * 2 ;  clear
 
    mov eax, 0 ; clearing the register
    mov ax, [a] ; it will take only the low part (little endian)
    mov bx, [b] ; only the low part
    add ax, bx ; adding the two values
 
    push eax ; pushing the result
    push dword sol_sum ; sol_sum remembers the result of the sum
    call [printf] ; prints the sum
    add esp, 4 * 2 ; clear
 
    mov eax, 0 ; clear
    mov ax, [a + 2] ; 
    mov bx, [b + 2] ;
    sub ax, bx ; substracting bx of ax
 
    push eax ; pushing the result
    push dword sol_difference ; pushing the solution
    call [printf] ; printing the solution
    add esp, 4 * 2 ; clear
 
    push dword 0
    call [exit]
