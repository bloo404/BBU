bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    A dw 1111_0110_1011_0111b ; 111_0      11-14 A
    B dw 0011_1101_1100_0000b ; 100_000    1-6 B
    C resd 1
    
;   AND 1 1 0    OR 1 1 1 1  XOR 1 0 1 1        NOT 1 1 0
;   ---------     ----------    -----------    ----------
;     1 1 1 0       1 1 1 1      1 1 0 1            0 0 1
;     0 1 0 0       0 1 1 0      0 1 1 0

; our code starts here
segment code use32 class=code
    start:
        ; Given the words A and B, compute the doubleword C as follows:
        ; the bits 0-2 of C have the value 0
        ; the bits 3-5 of C have the value 1
        ; the bits 6-9 of C are the same as the bits 11-14 of A
        ; the bits 10-15 of C are the same as the bits 1-6 of B
        ; the bits 16-31 of C have the value 1
        
        mov ecx, 1111_1111_1111_1111_1111_1111_1111_1111b 
                    ; ECX will remember our C of 32 bits       
                    ; ECX is now 1111 1111 1111 1111 1111 1111 1111 1111 b
                    ; ECX = -1 FFFF FFFFF
                    
        and cl, 1111_1000b 
                    ; ECX = 1111 1111 1111 1111 1111 1111 1111 1000 b
                    ; we did this in order to solve the first 6 bits
                    ; the bits 0-2 of C have the value 0
                    ; the bits 3-5 of C have the value 1
                    ; ECX = -8 FFFF FFF8
        ror ecx, 6 
                ; ECX = 1110 0011 1111 1111 1111 1111 1111 1111 b
                ; we did this so we can keep them in the left while we play with A & B (working on CX/CL)
                ; ECX = E3FF FFFF - signed!!!
                
        ; working with A
        mov AX, [A] ; AX = A now (F6B7)
        ror AX, 11 ; now the last 4 bits of AX are actually what we need into ECX (D6FE)
        or AX, 1111_1111_1111_0000b ; to keep only the last 4 pure and to not intervene in the 'and' operation (FFFE)
        and cx, ax ; now the 4 bits we needed from ax are in cx (E3FF FFFE)
        
        ror ECX, 4 ; rotate again so we can keep the bits from A (FFFF FFFF EE3F FFFF)
        
        ; working with B
        mov ax, [B] ; AX = B now (3DC0)
        ror ax, 1 ; we rotate what was in AX so we can keep only 1-6 bits from B (without the position 0 one) (1EE0)
        or AX, 1111_1111_1100_0000b ; isolating the last 6 bits and making the rest 1s to not influence ECX (FFE0)
        and cx, ax ; last 6 bits are now in the right position (EE3F FFE0)
        
        ; rotating back
        rol ECX, 10 ; roll back the 10 bits we rotated initially / we also could ror and it s the same thing, but we d rotate more
                ; specifically if we ror we would have to ror ecx, 22 until we get back to the initial position 
                ; (32-10 we have to rotate now)
        mov [C], ECX ; add the solution to the C address (FFFF 83B8)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
