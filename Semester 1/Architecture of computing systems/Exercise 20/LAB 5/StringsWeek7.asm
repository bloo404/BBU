; Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the even elements of A.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db  2, 1, 3, 3, 4, 2, 6
    la equ $-a
    
    b db 4, 5, 7, 6, 2, 1
    lb equ $-b
    
    r resb la+lb

; our code starts here
segment code use32 class=code
    start:
        mov edi, 0 ; initialize string address index for r

        mov ecx, lb ; loop lb times
        jecxz second_array ; jump to the second array if ecx is 0
        
        mov esi, 0 ; initialize string address index for b
        first_loop:
            mov ebx, lb
            sub ebx, 1
            sub ebx, esi ; calculate the current index of b backwards (=length minus current index)
            
            mov al, [b+ebx] ; save the current value in al
            mov [r+edi], al ; add the value to the r array
            inc edi ; increment edi to the next index
            
            inc esi ; increment esi to the next index
        loop first_loop
        
        
        
        second_array:
        mov ecx, la ; loop la times
        jecxz end_program ; jump to the end if ecx is 0
        
        mov esi, 0 ; initialize string address index for b
        second_loop:
            mov al, [a+esi] ; move the current value from the second string to al
            test al, 1 ; check if the lowest bit of al is set
            jnz end_second_loop ; if al is odd jump to the end_second_loop label (ZF=0)
            
            mov [r+edi], al ; add the value to the r array
            inc edi ; increment edi to the next index
            
            end_second_loop:
            inc esi ; increment esi to the next index
        loop second_loop
        
        end_program:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
