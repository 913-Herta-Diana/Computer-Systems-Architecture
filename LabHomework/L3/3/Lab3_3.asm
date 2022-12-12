bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;2/(a+b*c-9)+e-d
segment data use32 class=data
    ; ...
    a db 4
    b db 2
    c db 3
    d dd 4
    e dq 5
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov bx,2;bx=2
        mov al,[b];al=b
        mul byte[c] ;ax=al*c=b*c
        add al,[a] ;b*c+a
        sub al,9;al=b*c+a-9
        mov cl,al ;cl=al=b*c+a-9
        mov ax,bx
        div cl ;ax=quotient=2/(b*c+1-9) word
        mov dx,0;unsigned conversion from ax to dx:ax=2/(b*c+1-9) double word
        mov bx,word[d]
        mov cx,word[d+2]
        sub ax,bx
        sbb dx,cx
        push dx
        push ax
        pop eax; eax=2/(b*c+1-9)-d double word *problems with the quadword
        mov edx,0
        add eax,dword[e]
        adc edx,dword[e+4] ;edx:eax=2/(a+b*c-9)+e-d
        
        
        
        ; exit(0)
        push dword 0      ; push the parameter for exit onto the stack
        call[exit]       ; call exit to terminate the program
