bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 0
    b dw 0
    sum dd 0
    message_a db "A = ", 0
    message_b db "B = ", 0
    format db "%d", 0
    message_final db "The sum in base 10: %d", 0
    message_final_hexa db "The sum in base 16 is: %x", 0

; our code starts here
segment code use32 class=code
    start:
        ; Read two numbers a and b (in base 10) from the keyboard and calculate a + b. Display the result in base 16
        ; Since the requirements didn't mention if it's signed or unsigned, I worked on signed numbers
        
        ; printing message for A
        push  dword message_a
        call  [printf]
        add  esp,4

        ; reading A
        push dword a
        push dword format
        call [scanf]
        add esp, 4*2
        
        ; printing message for B
        push  dword message_b
        call  [printf]
        add  esp,4

        ; reading B
        push dword b
        push dword format
        call [scanf]
        add esp, 4*2

        ; moving a into ax
        mov ax, [a]
        cwde ; converting the word into a double
        mov ebx, eax ; ebx now has a

        ; moving b into ax
        mov ax, [b]
        cwde ; converting to eax
        
        add eax, ebx ; eax has the sum of the two
        mov [sum], eax
        
        ; printing the result
        push  eax              
        push  dword message_final_hexa
        call  [printf]
        add  esp,4*2

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
