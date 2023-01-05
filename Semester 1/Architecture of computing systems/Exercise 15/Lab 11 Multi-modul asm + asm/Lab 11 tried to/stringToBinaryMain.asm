bits  32
global  start

extern  printf, exit
import  printf msvcrt.dll
import  exit msvcrt.dll

;extern stringToBinary

; A string containing n binary representations on 8 bits is given as a character string.
; Obtain the string containing the numbers corresponding to the given binary representations.
; Example:
; Given: '10100111b', '01100011b', '110b', '101011b'
; Obtain: 10100111b, 01100011b, 110b, 101011b

segment  data use32 class=data
    a db '10100111b', '01100011b', '110b', '101011b'
    len_a equ $-a ; length of a
    new_number db 0b
    sum_of_new_number_digits dd 0b
    numbers_array resb len_a
    
segment  code use32 class=code
start:
    mov ecx, len_a
    jecxz finetti
    mov esi, 0
    mov edi, 0
    mov eax, 0
    conversion:
        mov al, byte [a + edi] ; takes charachter by charachter
        inc edi ; increase location address index
        sub al, 30h ; substract 30 so we remain with the value
        comparison:
            cmp al, 1h ; compare al with 1
            ja b    ; if above it s b
            je one ; if equal it s 1
            jb zero ; if below it s 0
        ; B CASE
        ; if our character is B then we would want for the number to be added to the list and reset the value of this called number
        b:
            mov bl, byte [new_number] ; ebx takes the value of the new number
            mov byte [numbers_array + eax], bl ; adding to the location is now possible
            add eax, 1 ; increase the index
            mov byte [new_number], 0 ; clear the new number
            jmp neither ; jump to the end of the loop tasks
        ; 1 CASE
        ; if our character is 1 then it means we have to 
        one:
            mov [new_number + esi], al
            shl byte [new_number + esi], 1
            mov al, byte [a + edi]
            sub al, 30h
            
            cmp al, 1h ; compare al with 1
            ja b    ; if above it s b
      
            add byte [new_number + esi], al
            inc esi
            inc edi
            jmp neither
        zero:
            jmp neither
        neither:
    loop conversion

	finetti:

    push 0
	call [exit]