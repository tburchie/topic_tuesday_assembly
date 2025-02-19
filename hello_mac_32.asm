section .data
    hello db "Hello, World!", 0xA  ; Message with newline
    hello_len equ $ - hello        ; Message length

section .text
    global start                   ; macOS requires 'start' as entry point
    extern _exit                    ; Mac uses _exit instead of sys_exit

start:
    ; sys_write (syscall number 4 on macOS)
    mov eax, 0x2000004              ; Mac syscall number for write
    mov ebx, 1                      ; File descriptor 1 (stdout)
    mov ecx, hello                  ; Pointer to string
    mov edx, hello_len              ; Message length
    int 0x80                        ; Call kernel

    ; sys_exit (syscall number 1 on macOS)
    mov eax, 0x2000001              ; Mac syscall number for exit
    xor ebx, ebx                    ; Exit status 0
    int 0x80                        ; Call kernel
