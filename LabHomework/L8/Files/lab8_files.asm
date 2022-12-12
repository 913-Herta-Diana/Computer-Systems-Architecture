bits 32 

global start        

extern exit, fopen, fread, printf, fclose
import exit msvcrt.dll   
import fopen msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll

;A text file is given. Read the content of the file, count the number of consonants and display the result on the screen. The name of text file is defined in the data segment.


segment data use32 class=data
    output_format db "The number of consonants is: %u", 0
    input_file_name db "input.txt", 0
    acces_mode db "r", 0
    file_descriptor resd 1
    consonant_character_counter dd 0
    
    max_length equ 100
    actual_length resd 1
    input_text resb max_length
   
segment code use32 class=code
    start:
        
    ;fopen(input_file_name, acces_mode)
        push acces_mode
        push input_file_name
        call [fopen]
        add esp, 4 * 2 
        mov dword[file_descriptor], eax 
        cmp eax, 0
        je end_program
        
    ;fread(input_text, 1, max_length, file_descriptor)
        push dword[file_descriptor]
        push max_length
        push 1
        push input_text
        call [fread]
        add esp, 4 * 4
        mov dword[actual_length], eax
    
    ;we must count how many consonants we have in the string input_text
   
        mov ecx, dword[actual_length]
        mov esi, input_text
        cld
        for_every_character_in_the_input:
            lodsb
            ;we must check if the byte stored in al is a consonant
            cmp al, 'a'
            je is_vowel
            cmp al, 'e'
            je is_vowel
            cmp al, 'i'
            je is_vowel
            cmp al, 'o'
            je is_vowel
            cmp al, 'u'
            je is_vowel
            jmp is_consonant
            
            is_consonant:
                inc dword[consonant_character_counter]
                
             is_vowel:
        loop for_every_character_in_the_input
    
    ;printf("The number of consonants is: %u", consonant_character_counter)
        push dword[consonant_character_counter]
        push output_format
        call [printf]
        add esp, 4 * 2
    
    ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4 * 1
        
    end_program:
    push    dword 0
    call    [exit]