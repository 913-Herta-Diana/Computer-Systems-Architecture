bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 4
    b db 1
    c db 7
    d dw 9
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al,[a] 
        mov bl,100
        mul bl ;ax=al*bl=400
        add ax,[d];ax=ax+d=409
        add ax,5;ax=414
        mov bx,ax;bx=414
        mov al,[b];al=b=1
        mov cl,75;cl=75
        mul cl;ax=al*cl=75*1=> ax=75
        sub bx,ax;bx=bx-ax=414-75=>bx=339
        mov cl,[c];cl=c=6
        mov al,5; al=5
        sub cl,al;cl=cl-al => cl=7-5=2
        mov ax,bx;ax=339
        div cl ;al=ax/c;
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
