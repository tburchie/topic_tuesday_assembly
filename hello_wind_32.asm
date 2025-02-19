section .data
    hello db "Hello, World!", 0     ; Null-terminated string
    hello_len equ $ - hello         ; Calculate string length
    bytes_written dd 0              ; Storage for bytes written
    handle dd 0                     ; Storage for console handle

section .text
    global _main
    extern _GetStdHandle@4, _WriteConsoleA@20, _ExitProcess@4

_main:
    ; Get handle to the console output
    push -11                         ; STD_OUTPUT_HANDLE (-11)
    call _GetStdHandle@4              ; Call GetStdHandle
    mov [handle], eax                 ; Store the console handle

    ; Write "Hello, World!" to console
    push 0                            ; NULL (reserved, must be 0)
    push bytes_written                ; Pointer to store bytes written
    push hello_len                     ; String length
    push hello                         ; Pointer to string
    push dword [handle]                ; Console handle
    call _WriteConsoleA@20             ; Call WriteConsoleA

    ; Exit process
    push 0                            ; Exit code = 0
    call _ExitProcess@4                ; Call ExitProcess
