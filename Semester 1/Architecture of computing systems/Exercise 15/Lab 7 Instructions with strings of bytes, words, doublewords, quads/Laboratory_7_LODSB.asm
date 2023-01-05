bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s dd 12345607h, 1A2B3C15h
    len_s equ $-s
    d times len_s db

; our code starts here
segment code use32 class=code
    start:
        cld
        mov ecx, len_s
        mov esi, s
        parcurgere:
            mov edi, s + 1
            ordonare:
            ; stuff to do because i didn t see the PROPER REQUIREMENTS
            loop ordonare
        loop parcurgere
        
        
        cld
        mov ecx, len_s/4
        mov esi, s
        mov edi, d
        put_the_string_into_d:
            movsd
        loop put_the_string_into_d
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
