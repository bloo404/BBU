; Being given a string of bytes representing a text (succession of words separated by spaces), determine which words are palindromes (meaning may be interpreted the same way in either forward or reverse direction); ex.: "cojoc", "capac" etc.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db "cojoc brinza sos capac fosila ",0
    l equ $-a
    b db " "
    b1 equ $-b
    r times l db 0
    d times l db 0
    e times l db 0
segment code use32 class=code
    start:
       mov ecx,l ; ecx <- length of a
       mov esi,a ; esi <- adress of a 
       mov edi,r ; edi <- adress of r, r is where we separate words
       mov ebp,e ; ebp <- adress of e, where we will have the resulted words
       cld ; clear direction flag
       jecxz final ; if the length is 0 => a doesn t have words => we skip the loops
       mov ebx,0 ; ebx <- 0 (we want to have the length of every word 0 in the beginning)
    Repeta:
    ; gets the characters of the word
         lodsb ; in AL we put the octet of the <DS:ESI> address
         cmp al,[b] ; if the rest is 0, we repeat the loop otherwise we go to space
         jng space ; jumps to space if the value is not greater than space
         stosb ; we store the octet of AL into <ES:EDI>
         inc ebx ; we increase ebx
    loop Repeta

    space :
    ; moves the word so we can verify only that specific word
        mov esp,esi ; we put the address we re at in a(esi), in esp
        mov edx,ecx ; in edx we put the actual ecx to use it later
        mov ecx,ebx ; we put the length of the word in ecx
        mov esi,r ; we put the length of r in esi
        add esi,ebx 
        dec esi ; decrease esi by one to create de inverse word
        mov edi,d ; we put the address of d into edi
        std ; set direction flag to 1 df=1
        jecxz verificare ; if ecx=0 we jump to the verify function
        Repeta2:
           std ; set direction flag to 1 df=1
           lodsb ; in AL we put the octet of the <DS:ESI> address
           cld ; clear direction flag
           stosb ; we write the inverse of the string into d
        loop Repeta2 

      verificare:
      ; we verify if a word is palindrome
        mov ecx,ebx ; we put into ecx the length of the word
        mov ebx,0 ; ebx <- 0
        mov esi,r ; we put the address of r into esi, in r we have the original word
        cld
        jecxz palindrome
       Repeta3:
            lodsb
            cmp al,[d+ebx]; we verify charachter by charachter if the words are equal
            jne nuPali ; if we find a wrong letter we jump to nuPali
            inc ebx ; we increment ebx
      loop Repeta3
      
      palindrome :
        mov ecx,ebx ; we put in ecx the length of the word
        mov esi,r ; we put into esi the address of the r string
        mov edi,ebp ; we move into edi the address of the new string where we will remember the palindrome words
        cld ; df=0
        jecxz pali
        Repeta4:
            lodsb
            stosb ; we move the word into e
        loop Repeta4 
        
    pali : 
    ; if the word is palindrome
        mov ebp,edi
        inc ebp ; we remember the index of e into ebp (where we last were at)
        mov esi,esp ; we remember the index of a into esi (where we last were at)
        mov edi,r ; we put the address of r into edi
        mov ebx,0 ; ebx <- 0
        mov ecx,edx ; we reinitialise the ecx
       
        loop Repeta ; we repeat again so we can go to the next word
       
        
    nuPali:
    ; if the word is not palindrome
        mov esi,esp ; we move into esi where we last were in a
        mov edi,r ; we put the address of r into edi
        mov ebx,0 ; ebx <- 0
        mov ecx,edx ; we reinitialize the ecx
       
        loop Repeta ; we repeat again for the next word
    
    final:
        push dword 0  
        call [exit]
