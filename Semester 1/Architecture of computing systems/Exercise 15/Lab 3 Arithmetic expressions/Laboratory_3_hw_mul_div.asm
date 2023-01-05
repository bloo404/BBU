; f*(e-2)/[3*(d-5)]

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 100
    b db 132
    c db 124
    d db 125
    e dw 260
    f dw 300
    g dw 350
    h dw 400

; our code starts here
segment code use32 class=code
    start:
        ; f*(e-2)/[3*(d-5)] = 215
        
        ; e-2
        mov ax, [e] ; ax = e
        mov bx, 2 ; bx = 2
        sub ax, bx ; ax=e-2 (258)
        mov bx, 0 ; cleaning the register
        
        ; d-5
        mov cl, [d] ; cl = d
        mov bl, 5 ; bl = 5
        sub cl, bl ; cl=d-5 (120)
        mov bl, 0 ; cleaning the register
        
        ; 3*(d-5)
        mov bx, ax ; temporarily moving e-2 somewhere
        mov ax, 0 ; cleaning ax to be used for multiplication
        mov al, 3 ; al = 3
        mul cl ; ax = 3*(d-5)
        mov cx, ax ; cx = 3*(d-5)
        mov ax, bx ; ax = e-2 
        mov bx, cx ; bx = 3*(d-5) (360)
        mov cx, 0 ; cleaning the register
                
        ; f*(e-2)
        mov cx, [f] ; cx = f
        mul cx ; dx:ax = f*(e-2) (77 400)
        
        ; f*(e-2)/[3*(d-5)] (215)
        div bx ; ax = dx:ax / bx   , dx has the rest   
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
