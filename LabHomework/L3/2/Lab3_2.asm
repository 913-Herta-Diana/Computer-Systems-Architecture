bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
; (c+b)-a-(d+d) in signed
segment data use32 class=data
    ; ...
    a db 3
    b dw 2
    c dd 4
    d dq 1

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        
        mov ax,[b]
        cwde ;eax=b double word
        add eax,[c] ;eax=c+b
        mov ebx,eax;ebx=c+b
        mov al,[a]
        cbw
        cwde ;eax=a
        sub ebx,eax
        mov eax,ebx ;eax=c+b-a
        cdq
        ; edx:eax=c+b-a
        mov ebx,dword[d]
        mov ecx,dword[d+4]
        add ebx,ebx 
        adc ecx,ecx ;d+d in ecx:ebx
        
        sub eax,ebx
        sbb edx,ecx; quadword????
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
