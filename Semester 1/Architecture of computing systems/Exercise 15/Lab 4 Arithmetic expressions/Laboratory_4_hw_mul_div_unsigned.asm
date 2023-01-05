bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a,b,c - byte; e - doubleword; x - qword
    a db 16 ; 10h
    b db 35 ; 23h
    c db 69 ; 45h
    e dd 43981 ; 0abcdh
    x dq 12345678h
   

; our code starts here
segment code use32 class=code
    start:
        ; x - ( a * b * 25 + c * 3 )/( a + b ) + e
        
        ; a * b * 25
        mov al, [a] ; al = a
        mov bl, [b] ; bl = b
        mul bl ; ax = a * b         560
        mov bx, 25 ; bx = 25
        mul bx ; dx:ax = a * b * 25        14 000
        
        ; a * b * 25
        push dx
        push ax
        pop ebx ; ebx = a * b * 25        14 000
        
        ; c * 3
        mov al, [c] ; al = c
        mov cl, 3 ; cl = 3
        mul cl ; ax = c * 3 

        ; ( a * b * 25 + c * 3 )
        mov cx, ax ; cx = c * 3
        mov eax, 0 ; eax = 0
        mov ax, cx ; ax = c * 3
        add ebx, eax ; ebx = ( a * b * 25 + c * 3 )
        
        ; a + b
        mov al, [a]
        mov cl, [b]
        add al, cl ; al = a + b       51

        mov ecx, 0
        mov cl, al ; cx = a + b converted to word (for division, we divide doubleword to word)

        mov eax, 0 ; we re gonna need eax later when subtracting
        push ebx
        pop ax
        pop dx ; dx:ax = ( a * b * 25 + c * 3 )

        ; ( a * b * 25 + c * 3 )/(a + b)
        div cx ; ax = ( a * b * 25 + c * 3 )/(a + b) (quotient), dx = remainder of it        278 r 29
         
        ; -( a * b * 25 + c * 3 )/(a + b) + e
        mov ecx, [e] ; ecx = e (doubleword)
        sub ecx, eax ; ecx = e - ( a * b * 25 + c * 3 )/(a + b)    43 703
        
        mov edx, [x + 4]
        mov eax, [x + 0] ; edx:eax = x
        
        ; x - ( a * b * 25 + c * 3 )/(a + b) + e
        add eax, ecx 
        adc edx, 0 ; add with carry
        
        ; result is a quad into edx:eax       305 463 599
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
