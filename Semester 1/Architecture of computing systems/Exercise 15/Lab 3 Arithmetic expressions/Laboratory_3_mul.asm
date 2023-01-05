; (a*2)+2*(b-3)-d-2*c

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 30
    b db 26 
    c db 40 
    d dw 260
    
    ; result: -234

; our code starts here
segment code use32 class=code
    start:
    
    ; (a*2)+2*(b-3)-d-2*c
    
        ; a*2
        mov al, [a] ; al = a
        mov bl, 2 ; bl=2
        mul bl ; ax = a*2
        
        ; b-3
        mov bl, [b] ; bl = b
        sub bl, 3h ; bl = b-3
        
        ; 2*(b-3)
        mov cx, ax ; we move a*2 into cx
        mov ax, 0 ; clean the register
        mov al, 2 ; put the value of 2 into ax
        mul bl ; ax = 2*(b-3)
        
        ; the sum of the two 
        ; (a*2)+2*(b-3)
        add cx, ax ; cx=(a*2)+2*(b-3)
        
        ; 2*c
        mov ax, 0 ; clean the register and put 2 into it
        mov al, 2 ; al=2
        mov bl, [c] ; cl=c
        mul bl ; now ax=c*2
        
        ; (a*2)+2*(b-3)-d
        mov dx, [d] ; dx=d
        sub cx,dx ; cx=(a*2)+2*(b-3)-d
        
        ; (a*2)+2*(b-3)-d-2*c
        sub cx, ax ; cx=(a*2)+2*(b-3)-d-2*c
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
