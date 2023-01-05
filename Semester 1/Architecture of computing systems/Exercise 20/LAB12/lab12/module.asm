bits 32

global _dublu 

segment data public data use32

segment code public code use32

; Read from file numbers.txt a string of numbers. Build a string D wich contains the readen numbers doubled and in reverse order that they were read. Display the string on the screen.
;     Ex: s: 12, 2, 4, 5, 0, 7 => 14, 0, 10, 8, 4, 24

_dublu:
    push EBP ; we create a stack frame (push the ebp register on the stack so we can use ebp here)
    mov EBP, ESP 
    mov EAX, [EBP+8]
    mov BX, 2
    mul BX          ; we compute the double
                    ; EAX has the returned value
    mov ESP, EBP   ; we used EBP instead of ESP so we need to update ESP
    pop EBP ; we put into EBP the inital address so it remains the same as in the beginning of the program
    ret
