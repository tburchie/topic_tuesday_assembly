section .data
    hello db "Hello, World!", 0xA  ; Message with newline
    hello_len equ $ - hello        ; Calculate message length

section .text
    global start                   ; macOS requires 'start' as entry point
    extern _exit                    ; Reference to exit function

start:
    ; sys_write (macOS syscall number 4)
    mov rax, 0x2000004              ; syscall number for write
    mov rdi, 1                      ; file descriptor 1 (stdout)
    mov rsi, hello                  ; pointer to string
    mov rdx, hello_len              ; message length
    syscall                         ; invoke syscall

    ; sys_exit (macOS syscall number 1)
    mov rax, 0x2000001              ; syscall number for exit
    xor rdi, rdi                    ; exit code 0
    syscall                         ; invoke syscall
