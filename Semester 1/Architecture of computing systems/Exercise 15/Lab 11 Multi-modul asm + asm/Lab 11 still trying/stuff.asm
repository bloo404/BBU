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
     temporary_sum db 0
     solution resb 1 times len_a
    
; our code starts here
segment code use32 class=code
    start:
        mov ecx, [a]
        jecxz final
        mov esi, 0
        mov edi, 0
        compute_number:
            mov bl, [a + esi]
            sub bl, 30h
            ; daca numarul e 1 sau 0 adaugam la suma, in caz contrar, se adauga numarul la sir si se reinitializeaza
            cmp bl, 1
            jbe zero_one
            ja b
            zero_one:
                mov al, [temporary_sum]
                mov dh, 2
                mul dh
                add ax, [a + esi]
                inc esi
                jmp lup
            b:
               mov edx, [temporary_sum]
               mov [solution+edi], edx
               inc edi
            lup:
        loop compute_number
    
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
