section .data
    greeting_text: db "MeowForth Interpreter", 10, 10
    greeting_text_len equ $ - greeting_text
    MAX_WORD_LENGTH equ 63


section .bss
    read_word: resb MAX_WORD_LENGTH


section .text
    global _start

_start:
;     ; Align the stack to 16bytes
;     mov rax, rsp
;     and rax, 0xF
;     jz Aligned
;     sub rsp, 8
; Aligned:

    mov rax, greeting_text
    mov rbx, greeting_text_len
    call Print

    ; Main interpreter loop
Main_Loop:
    ; Try Scan Word
    mov rax, read_word
    mov rbx, MAX_WORD_LENGTH
    call ReadWord

    ; get its Len
    sub rax, 1

    ; Print the word
    mov rbx, rax
    mov rax, read_word
    call Print

    jmp Main_Loop

End_of_Program:
    jmp Exit
    
    
; Sub-routines defined below

; Print
; 1st[rax] argument: char*
; 2nd[rbx] argument: size_t
Print:
    mov rsi, rax
    mov rdx, rbx
    mov rax, 1
    mov rdi, 1
    syscall
    ret

; ReadWord
; 1st[rax] argument: char* dest
; 2nd[rbx] argument: size_t max_len
ReadWord:
    mov rsi, rax
    mov rdx, rbx
    mov rdi, 0 ; stdin
    mov rax, 0
    syscall
    ret

; Calculate Word Length by CR
; 1st[rax] argument: char* dest
; 2nd[rbx] argument: size_t max_len
; Returns [rax] length in chars
; mutates RCX, RDX
Get_Word_Len:
    mov rcx, 0
_Get_Word_Len_While:
    cmp rcx, rbx
    jae _Get_Word_Len_End
    mov rdx, [rax+rcx]
    cmp rdx, 10
    je _Get_Word_Len_End
    inc rcx
    jmp _Get_Word_Len_While
_Get_Word_Len_End:
    mov rax, rcx
    ret

Exit:
    ; Syscall exit
    mov rax, 60
    xor rdi, rdi
    syscall