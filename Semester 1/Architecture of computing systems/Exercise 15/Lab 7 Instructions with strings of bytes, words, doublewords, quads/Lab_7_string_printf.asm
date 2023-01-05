bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s dd 12345607h, 1A2B3C15h
    len_s equ $-s
    d times len_s db
    format db "Element %d: %d",0
    value dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; Given an array S of doublewords, build the array of bytes D formed from bytes of doublewords sorted as unsigned numbers in descending order.
        ; s DD 12345607h, 1A2B3C15h
        ; d DB 56h, 3Ch, 34h, 2Bh, 1Ah, 15h, 12h, 07h
        
        cld ; clear direction flag
        
        ; big step 1: order the s string (merge sort in asm)

        mov ecx, len_s  ; ecx gets the value of the len of s
        mov esi, 0      ; main index (i in cpp)
        jecxz final     ; if ecx is zero it jumps to the end
        parcurgere_elemente:
            mov edi, esi    ; edi is the index for the second loop (j in cpp)
            add edi, 1      ; edi = esi + 1
            mov ebx, len_s  ; ebx is like an auxiliar where I compute the value for ecx for the next loop
            sub ebx, edi    ; ecx should be = len_s - esi + 1 (length of the string - current step + 1)
            add ebx, 1 
            mov ecx, ebx    ; move into ecx the value from ebx (auxiliary register)
            cmp edi, len_s  ; compare edi with the len of s => if we exceeded the length we must go to the end
            jg end_of_the_elements ; jecxz not necessary because of the comparison we do between the edi index and the len of s
            descending_order:
                mov bl, [s + esi] ; moving into registers the values of the current element and the elements after it
                mov bh, [s + edi]
                cmp bl, bh         ; compare the two registers
                jae dont_interchange ; if they are already ordered descending, we dont interchange them
                interchange:
                    mov [s + esi], bh ; since we used registers, the interchange is much easier
                    mov [s + edi], bl
                dont_interchange:
                inc edi ; increase edi (index of the elements after the current from the bigger loop)
            loop descending_order   ; repeat
            end_of_the_elements:    ; when reaching the end of the smaller loop that goes through the elements after the current element
            inc esi     ; increase esi for going to the next element
            mov eax, len_s     ; compute in eax the value needed for ecx for the loop to go well (substracting from ecx until it gets to 0 blah blah)
            sub eax, esi       ; ecx = len_s(length of elements) - esi(current index) - 1 (we increased esi with 1)
            mov ecx, eax
        loop parcurgere_elemente ; loop the loop that goes through the elements
        
        ; big step 2: now that we ordered the string s, we can add all elements into d
        
        mov ecx, len_s  ; initialize ecx with the len of s
        mov esi, 0      ; initialize the 2 indexes with 0
        mov edi, 0    
        jecxz final     ; if s doesn t have anything, we end it all
        adaugare_elemente_in_d: 
            mov al, [s + esi]     ;   we cannot do mov [d+edi],[s+esi] so we use al
            mov [d + edi],al
            inc esi ; increase both indexes
            inc edi
        loop adaugare_elemente_in_d ; loop while we have remaining elements
        
        mov ecx, len_s
        mov edi, 0
        jecxz final
        print_elements:
            mov eax, [d + edi]
            push eax
            push dword edi
            push dword format
            call [printf]
            add esp, 4*2
            inc edi
        loop print_elements
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
