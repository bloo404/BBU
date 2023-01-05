bits 32 

global valoare      
; Valoare:
;          - 2 parametri, AL, BL
;          - Al: rezultatul
;          - BL: caracterul (numarul) curent
valoare:
        mov eax, [esp + 4] ; after the return value
        mov ebx, [esp + 8] ; after the return value & ax
        mov dl, 2 ; 2 into dl
        mul dl ; we will still use aL because the multiplication cannot exceed 255 since the given numbers are on max 8 bits
        add al, bl
        ret 4*2