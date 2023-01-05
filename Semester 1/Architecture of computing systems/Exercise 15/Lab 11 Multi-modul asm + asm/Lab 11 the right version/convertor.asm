bits 32 

global convertor     
; Convertor:
;          - 1 parametru: bl (prin ebx)
;          - BL: caracterul (numarul) curent
convertor:
        mov ebx, [esp + 4] ; after the return value
        sub ebx, 30h
        cmp bl, 1
        jbe zero_or_one
        b:
            add bl, 30h
        zero_or_one:
        ret 4