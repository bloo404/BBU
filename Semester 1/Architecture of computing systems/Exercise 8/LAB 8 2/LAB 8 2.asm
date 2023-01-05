bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    
    fileName db "homework.txt", 0
    accesType db "w", 0
    
    fileDescriptor dd -1
    
    text db "acesta este un text suport pentru tema", 0 ;0c2s4a
    len equ $-text
    
    wordFormat db "%c", 0
    decFormat db "%d", 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword accesType
        push dword fileName
        call [fopen] ; opening the file
        add esp, 4 * 2 ; cleaning the register
        
        mov [fileDescriptor], eax ; memorizing in filedescriptor the location of the file
        
        cmp eax, 0 ; verifying if we have something in the memory
        je final ; jump to final if we don t have anything
        
        mov esi, 0 ; index for the text
        mov ecx, len ; the length of the text
        again:
            test esi, 1 ; verifying if it is even or odd
            jnz printChar ; print the character if odd
            
            cmp byte[text+esi], 20h ; verifying if it s space
            je printChar ; prints the space if it s space
            
            pushad ; memorizing the registers
            push esi
            push dword decFormat ; pushing the decimal format to print into the txt file
            push dword [fileDescriptor] ; remembers the location where to print the number
            call [fprintf] ; print the data
            add esp, 4*3 ; cleans esp of the parameters that we used
            popad ; we re free from the registers in the stack
            
            jmp over_printChar ; doesn t print a character if we printed the value of the position
            
            printChar:
            mov bl, [text+esi] ; we remember the charachter into BL
            mov eax, 0 ; cleaning eax
            mov al, bl ; remembering in AL the charachter 
            pushad ; we put the register on the stack
            push eax ; push the charachter
            push dword wordFormat ; push the charachter as a charachter (not ASCII)
            push dword [fileDescriptor] ; remembering the location where to print the number
            call [fprintf] ; prints the data
            add esp, 4*3 ; cleans 
            popad ; empties the registers in the stacl
            
            over_printChar: ; used to jump over the printing of a charachter in case it s even
            
            inc esi ; index that helps going to the next character
            
        loop again
        
        push dword [fileDescriptor] ; printing the result
        call [fclose] ; closing the file
        add esp, 4*1
        
        final:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
