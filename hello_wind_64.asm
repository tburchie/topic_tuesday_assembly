section .data
    hello db "Hello, World!", 0      ; Null-terminated string
    hello_len equ $ - hello          ; Length of string
    handle dq 0                      ; Console handle storage

section .text
    global main
    extern GetStdHandle, WriteConsoleA, ExitProcess

main:
    ; Get the handle to the console output
    mov ecx, -11                      ; STD_OUTPUT_HANDLE = -11
    call GetStdHandle
    mov [handle], rax                  ; Store console handle

    ; Write "Hello, World!" to the console
    mov rcx, [handle]                  ; Console handle
    mov rdx, hello                      ; Pointer to string
    mov r8, hello_len                   ; String length
    mov r9, 0                           ; Unused, must be NULL
    sub rsp, 32                         ; Shadow space for Windows API calls
    call WriteConsoleA
    add rsp, 32                         ; Restore stack

    ; Exit the process
    xor ecx, ecx                        ; Exit code = 0
    call ExitProcess
