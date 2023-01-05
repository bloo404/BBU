; A string containing n binary representations on 8 bits is given as a character string.
; Obtain the string containing the numbers corresponding to the given binary representations.
; Example:
; Given: '10100111b', '01100011b', '110b', '101011b'
; Obtain: 10100111b, 01100011b, 110b, 101011b

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db '10100111b', '01100011b', '110b', '101011b'
    len_a equ $-a
    solution times len_a db 0
    sum db 0
    format db "%b",0
    
; our code starts here
segment code use32 class=code
    start:
        mov ecx, len_a
        jecxz final
        
        mov esi, 0 ; index for a
        mov edi, 0 ; index for solution
        
        calculate:
            mov bl, [a + esi]
            sub bl, 30h
            cmp bl, 1h
            jbe zero_or_one
            ja b ; for my mental health
            b:
                mov dl, byte [sum]
                mov [solution + edi], dl
                mov byte [sum], 0
                inc edi
                jmp neither
            zero_or_one:
                mov al, byte [sum] ; putting the sum somewhere
                mov dl, 2 ; 2 into dl
                mul dl ; multiplying al with 2, even if the result is in ax, it doesn t exceed 8 bits
                mov byte [sum], al
                add byte [sum], bl
                jmp neither ; for my mental health
            neither:
                inc esi
        loop calculate
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
