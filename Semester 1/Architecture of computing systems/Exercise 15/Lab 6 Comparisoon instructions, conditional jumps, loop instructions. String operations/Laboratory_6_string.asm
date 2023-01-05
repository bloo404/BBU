bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    A db '2','1','3','3','4','2','6'
    lenA equ $-A
    B db '4','5','7','6','2','1'
    lenB equ $-B
    R resw 1
    
; our code starts here
segment code use32 class=code
    start:
        ; Two byte strings A and B are given. 
        ; Obtain the string R by concatenating the elements of B in reverse order and the odd elements of A.
        ; Example:
        ; A: 2, 1, 3, 3, 4, 2, 6
        ; B: 4, 5, 7, 6, 2, 1
        ; R: 1, 2, 6, 7, 5, 4, 1, 3, 3
        
        mov ecx, lenB ; we put the len of B into ecx
        mov esi, 0 ; we use esi as an index when putting into R
        mov edi, lenB - 1 ; we use edi to go through B's elements
        
        jecxz computeA ; if ecx is 0 it means we will jump to solving the part of A (lenB = 0)
        
        computeB:
            mov al, [B + edi]           ; AL takes B + offset where the element is located (from last to first)
            mov [R + esi], al           ; R takes the result from AL (we couldn't move from an address to another, we needed a register)
            inc esi                     ; increase esi (index of R)
            dec edi                     ; decrease edi (index of B)
        loop computeB                   ; loop, ecx <- ecx-1 
        
        mov esi, 0 ; index of A
        mov edi, lenB ; index of R (how many charachters it had from B)
        mov ecx, lenA ; len of A (how many charachters we go through)
        
        jecxz final ; if ecx is 0 it means we will jump to the end (lenA = 0)
        
        computeA:
            mov al, [A + esi]           ; al <- A + offset where the element is located (from first to last)
            sub al, '0'                 ; substracting the ascii code of '0' => the actual number ('0' = 30)
            test al, 01h                ; operate an `and` on the first bit to change the parity flag, the `and` doesn't affect the operand
            jp not_odd                  ; if parity flag = 1 => it is not odd (parity on, e PAR, PARity = true, PARity flag)
            jnp if_odd ; for my mental sanity to see the jump, if parity flag = 0 (PARity = false)
            if_odd: ; only if odd
                mov [R + edi], al       ; put the value into R + index
                inc edi                 ; increase the index of R
            not_odd:
                inc esi  ; both cases do inc esi
        loop computeA                   ; loop, ecx <- ecx-1
        
        final: ; end of program
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
