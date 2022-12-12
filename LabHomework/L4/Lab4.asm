bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
segment data use32 class=data
    a dw 0111011101010111b
    b dw 1001101110111110b
    c dd 0

;Given the words A and B, compute the doubleword C as follows:
;the bits 0-3 of C are the same as the bits 5-8 of B
;the bits 4-8 of C are the same as the bits 0-4 of A
;the bits 9-15 of C are the same as the bits 6-12 of A
;the bits 16-31 of C are the same as the bits of B
segment code use32 class=code
    start:
        ;a
        mov bx,0
        mov ax,[b] ;isolating the bits 10-12
        and ax,0000000111100000b; we only take 5-8 bits of B
        mov cl,5
        ror ax,5
        or bx,ax
        ;b
        mov ax,[a]
        and ax,0000000000011111b
        mov cl,4
        rol ax,cl
        or bx,ax
        ;c
        mov ax,[a]
        and ax,0001111111000000b
        mov cl,6
        rol ax,cl
        or bx,ax
        ;d
        
        mov ax, [b]
        mov dx, 0
        push dx
        push ax
        pop eax; 
        rol eax, 16
        or ebx, eax
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
