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
extern valoare
extern deciToBinary
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db '10100111b', '01100011b', '110b', '101011b'
  ;  a db '110b'
    len_a equ $-a
    solution times len_a db 0
    sum db 0
    format db "%d",0
    ; format db "%b",0 APPARENTLY B DOES NOT EXIST, LOVELY
    comma db ", ",0
    
; our code starts here
segment code use32 class=code
    start:
        mov ecx, len_a
        jecxz middle ; jump short so i created a middle point 
        mov esi, 0 ; index for a
        mov edi, 0 ; index for solution
        calculate:
            mov ebx, 0
            mov bl, [a + esi]
            sub bl, 30h
            cmp bl, 1h ; bl is computed here
            jbe zero_or_one
            ja b ; for my mental health
            b:
                mov dl, byte [sum]
                mov [solution + edi], dl
                mov byte [sum], 0
                inc edi
                jmp neither
            zero_or_one:
                mov ax, 0
                mov al, byte [sum] ; putting the sum somewhere ;1) iau parametru de pe stiva 2) grija la registri
                push ebx
                push eax
;                mov dl, 2 ; 2 into dl
;                mul dl ; multiplying al with 2, even if the result is in ax, it doesn t exceed 8 bits
;                mov byte [sum], al
;                add byte [sum], bl    
                call valoare
                mov byte [sum], al
                jmp neither ; for my mental health
            neither:
                inc esi
        loop calculate
        jmp no_middle

        middle:
        jecxz final

        no_middle:
        mov ecx, edi 
        mov edi, 0
        
        ; PRINTING THAT WAS FOR %b THAT DOES NOT EXIST <33333333333
;        printing:        
;            mov eax, 0
;            mov al, byte [solution + edi]
;            pushad
;;            push ecx 
;            push dword comma
;            push eax
;            push dword format
;            call [printf]
;            add esp, 4*3
;            popad
;            ;            pop ecx
;            inc edi
;        loop printing
        printing:
            mov eax, 0
            mov al, byte [solution + edi]
            pushad
            push ecx
            
            popad
            inc edi
        loop printing
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
