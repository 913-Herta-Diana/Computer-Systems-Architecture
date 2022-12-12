bits 32

global start        

extern exit
import exit msvcrt.dll

; 2. An array of words is given. Write an asm program in order to obtain an array of doublewords,
; where each doubleword will contain each nibble unpacked on a byte (each nibble will be preceded by a 0 digit),
; arranged in an ascending order within the doubleword. 
; Example:
; s1: 1432h, 8675h, 0ADBCh, ...
; s2: 01020304h,  05060708h, 0A0B0C0Dh, ...

segment data use32 class=data
    s1 dw 1432h, 8675h, 0ADBCh
    len_s1 equ ($-s1)/2
    s2 times len_s1 dd -1
    tmp_len equ 4
    tmp times tmp_len db 2

segment code use32 class=code
    start:
        ; set up the registers
        cld
        mov esi, s1
        mov edi, s2
        mov ecx, len_s1
        
        xor eax, eax
        xor edx, edx
    
        ; 1. for each word in the string s1
        step_1:
            lodsw
            
            push dword esi      ; save the registers
            push dword edi
            push dword ecx
            
            jmp step_2

          back_2:
            jmp step_3
            
          back_3:
            jmp step_4

          store:
            pop dword ecx       ; restore the registers
            pop dword edi
            pop dword esi
            stosd
        loop step_1
        
        jmp end_prog
        
        ; 2. extract the hex digits from each word
        step_2:
            mov edi, tmp
            mov ecx, tmp_len
            mov dx, 1111000000000000b   ; set the mask
          .loop:
            push dword eax
            and ax, dx                  ; isolate the leftmost digit
            
            shr ax, 12                  ; move to AL
            stosb                       ; store it in the string temp
            
            pop dword eax               ; restore the word in AX
            shl ax, 4                   ; move to next digit
          loop step_2.loop
        jmp back_2
        
        ; 3. arrange the extracted digits in ascending order
        step_3:
            ; not implemented
        jmp back_3
        
        ; 4. create a doubleword from extracted digits
        step_4:
            xor eax, eax
            mov esi, tmp
            mov ecx, tmp_len

          .loop:
            shl eax, 8
            lodsb
          loop step_4.loop
          
          jmp store
          
        end_prog:

        ; exit(0)
        push dword 0      ; push the parameter for exit onto the stack
        call [exit]       ; call exit to terminate the program
