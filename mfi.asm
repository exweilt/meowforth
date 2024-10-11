section .data
HelloStr: db "Hello, world!", 10

section .text
    global _start

_start:
    
    mov rax, 1
    mov rdi, 1
    mov rsi, HelloStr
    mov rdx, 14

    syscall
    

    ; Syscall exit
    mov rax, 60
    xor rdi, rdi
    syscall