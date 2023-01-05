; A string containing n binary representations on 8 bits is given as a character string.
; Obtain the string containing the numbers corresponding to the given binary representations.
; Example:
; Given: '10100111b', '01100011b', '110b', '101011b'
; Obtain: 10100111b, 01100011b, 110b, 101011b

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
extern convertor
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db '10100111b', '01100011b', '110b', '101011b'
    len_a equ $-a
    solution times len_a db 0
    format_number db "%x",0
    format_b db "b",0
    comma db "b, ",0
    
; our code starts here
segment code use32 class=code
    start:
        mov ecx, len_a
        jecxz middle ; jump short so i created a middle point 
        mov esi, 0 ; index for a
        mov edi, 0 ; index for solution
        calculate: ; calculates from 1 as a char to a hexa number or remains the same if it s b
            mov ebx, 0
            mov bl, [a + esi]
            push ecx
            push ebx
            call convertor
            pop ecx
            mov [solution + edi], bl
            inc esi
            inc edi    
        loop calculate
        jmp no_middle

        middle:
        jecxz final

        no_middle:
        mov ecx, edi 
        mov edi, 0
        
        printing:
            mov eax, 0
            mov al, byte [solution + edi]
            cmp al, 1h
            jbe if_number ; verifies if number
            ja b2_with_comma
            if_number: ; if numbers it prints the hexa digit
                pushad
                push eax
                push dword format_number
                call [printf]
                add esp, 4*2
                jmp neither
            b2_with_comma: ; if b 
                cmp ecx, 1 ; verifies if it s the last one
                je b2_without_comma ; if it s the last, goes to without comma
                pushad
               ; push dword format_b
                push dword comma ; puts comma + b here
                call [printf]
                add esp, 4
                jmp neither
            b2_without_comma:
                pushad
                push dword format_b ; just b
                call [printf]
                add esp, 4
            neither:
            popad
            inc edi
        loop printing
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
