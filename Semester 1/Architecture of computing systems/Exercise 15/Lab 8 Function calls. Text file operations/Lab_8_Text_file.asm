bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit 
extern fclose
extern strlen
extern fprintf      
extern fopen        ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import strlen msvcrt.dll
import fprintf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    text db "a*a a%&^%&^$& 23t47896q4sdjfasi", 0
    len equ $-text
    file_name db "fisier.txt", 0
    access_mode db "w", 0
    format db "%s", 0
    file_descriptor dd -1

; our code starts here
segment code use32 class=code
    start:
        ; A file name and a text (defined in the data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Replace all the special characters from the given text with the character 'X'. Create a file with the given name and write the generated text to file.
        
        ; creating and opening the file
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2

        ; store the file descriptor
        mov [file_descriptor], eax
        cmp eax, 0
        je the_end
        
        ; changing the charachters that are special charachter into X
        mov esi, 0 ; text initial address
        mov ecx, len ; length of text
        sub ecx, 2 ; substracting the ending point of the file (our 0)
        cld ; clear direction flag
        
        jecxz the_end
        again:
            mov al, [text + esi] ; AL = current byte
            cmp al, '0'
            jb caracter_special ; if al <0
            cmp al, '9'
            jbe nu_caracter_special ; if al >=0 and <=9
            cmp al,'A'
            jb caracter_special ; if al >9 and al<A
            cmp al,'Z'
            jbe nu_caracter_special ; if al>=A & al<=Z
            cmp al,'a'
            jb caracter_special ; if al>Z & al<a
            cmp al,'z'
            jbe nu_caracter_special ; if al>=a & al<=z
            ; otherwise it s a special charachter
            caracter_special:
                mov al, 'X'
                mov [text + esi],al
            nu_caracter_special:
                inc esi
        loop again
        
        ; put text into the file
        push dword text
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2
        
        ; closing the file
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        the_end:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
