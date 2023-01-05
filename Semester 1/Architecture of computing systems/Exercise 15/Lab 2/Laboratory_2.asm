; COMPLEX EXAMPLE

; Write a program in the assembly language that computes the following arithmetic expression, considering the following data types for the variables:
; a - byte, b - word
; (b / a * 2 + 10) * b - b * 15;
; ex. 1: a = 10; b = 40; Result: (40 / 10 * 2 + 10) * 40 - 40 * 15 = 18 * 40 - 1600 = 720 - 600 = 120
; ex. 2: a = 100; b = 50; Result: (50 / 100 * 2 + 10) * 50 - 50 * 15 = 12 * 50 - 750 = 600 - 750 = - 150

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
        ; Small example
            ;a db 64
            ;b db 4
    a db 10
    b dw 40
        
; our code starts here
segment code use32 class=code
    start:
        ; Small example
            ;mov ax, 4
            ;mul byte [a] ; because a is a memory location, we have to specify how much are we taking from a
        
        ; b/a
        mov ax, [b]
        div byte [a] ; AL = AX/a = b/a    AH = AX%b
        
        ; b/a*2
        mov bl, 2
        mul bl ; bl*al => ax, ah is lost
        
        ; b/a*2 + 10
        add ax, 10
        
        ; (b/a*2+10)*b
        mul word [b] ; => dx:ax
        mov bx, dx
        mov cx, ax   ; => bx:cx = (b/a*2+10)*b
        
        ; we re gonna move from bx:cx into EBX so we can substract from them
        ; we re gonna use the stack
        push bx ; => stack: bx...
        push cx ; => stack: bx cx ...
        pop ebx ; => eax=bx:cx, stack: ...
        
        ; b*15
        mov ax, 15
        mul word [b] ; => DX:AX = 15*b
        ; we re using stack as before
        push dx
        push ax
        pop eax
        
        ; (b/a*2+10)*b - b*15
        sub ebx,eax ; => the result is in ebx
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
