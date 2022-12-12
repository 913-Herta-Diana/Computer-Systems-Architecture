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
    s db '+', '4', '2', 'a', '@', '3', '$', '*' ; declare the string of bytes
    l1 equ $-s ; compute the length of the string in l
    p db '!','@','#','$','%','^','&','*'
    l2 equ $-p-l1
	d times 1 db 0 ; reserve l bytes for the destination string and initialize it
    
    
; Given a character string S, obtain the string D containing all special characters (!@#$%^&*) of the string S.

segment code use32 class=code
    start:
        ; ...
        mov ecx,l1
        mov esi,0
        mov edi,0
        mov ebx,0
        jecxz Sfarsit
        Repeta:    
            push ecx
            mov al,[s+esi]
            mov edi,0
            mov ecx,l2
            equal:
                mov bl,[p+edi]
                cmp al,bl
                je mutare
                jmp urmatorul
                mutare:
                    mov [d+ebx],bl
                    inc ebx
                    jmp Sari  
                urmatorul:
                inc edi
            cmp edi,l2
            je Sari
            loop equal
        Sari:
        pop ecx
        loop Repeta
        Sfarsit:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
