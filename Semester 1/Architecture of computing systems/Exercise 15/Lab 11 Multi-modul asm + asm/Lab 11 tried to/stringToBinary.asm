bits 32                         

; A string containing n binary representations on 8 bits is given as a character string.
; Obtain the string containing the numbers corresponding to the given binary representations.
; Example:
; Given: '10100111b', '01100011b', '110b', '101011b'
; Obtain: 10100111b, 01100011b, 110b, 101011b

global stringToBinary

;stringToBinary(char): char
;                    - 1 parameter C: 1 charachter
;                    - transforms charachter into a numbers
;                    - return 4 bits (AL)
;                    - modifies ...? to do

;MMCfactorial(int):int
;                - 1 parameter N:integer
;                - calculates factorial of N
;                - return value in EAX: integer 
;                - uses/modifies eax, ecx, edx 

contor resb 0
const dd 1

stringToBinary:
      mov esi, [esp + 4];given
      mov edi, [esp + 8];obt
      mov ecx, [esp + 12]
      
      ret 4*3
