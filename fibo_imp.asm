extern printf

section .data
    fmth db "How many Fibonacci numbers to display (0-9) ", 0
    fmth_len equ $-fmth-1
    fmt db "%d ", 10, 0
section .bss
    input_text resb 0


section .text
    global main
    
main:
    mov rbp, rsp        ;for correct debugging
    push rbp            ;pointer on stack
    mov rbp, rsp
    
    call _questionOne
    call _getInput

    xor rax, rax        ;zero rax
    xor rbx, rbx        ;zero rbx
    xor rcx, rcx        ;zero rcx
    mov rax, 1          ;push first value to rax
    mov rbx, 1          ;push second value to rbx
    mov cl, [input_text]       ;retrieve input value as a counter
    sub cl, 48
    
fibo_loop:    
    ;first addition
    cmp rcx, 0          ;compare input with 0
    jz _exit            ;if rcx == 0 then jump to _exit
    add rax, rbx        ;add two first numbers
    push rax            ;store rax on stack == result of addition
    push rbx            ;store rbx on stack
    dec rcx             ;decrement counter
    push rcx            ;store new value of counter on stack
    call _printFiboA    ;call print function
    pop rcx             ;retreive data from stack
    pop rbx             ;^
    pop rax             ;^
    
    ;reverse addition
    cmp rcx, 0          ;compare input with 0
    jz _exit            ;if rcx == 0 then jump to _exit
    add rbx, rax        ;add next number to previous result
    push rax            ;store rax on stack
    push rbx            ;store rbx on stack == result of addition
    dec rcx             ;decrement counter
    push rcx            ;store new value of counter on stack
    call _printFiboB    ;call print function
    pop rcx             ;retreive data from stack
    pop rbx             ;^
    pop rax             ;^
    
    jmp fibo_loop       ;loop again
    
    
_printFiboA:
    mov rdi, fmt        ;store string format
    mov rsi, rax        ;move result to rsi
    mov rax, 0          ;stdout
    call printf         ;call c print function
    ret                 ;return from to main
    
_printFiboB:
    mov rdi, fmt        ;store string format
    mov rsi, rbx        ;move result to rsi
    mov rax, 0          ;stdout
    call printf         ;call c print function
    ret                 ;return from to main

_questionOne:
    mov rax, 1          ;write
    mov rdi, 1          ;stdout
    mov rsi, fmth       ;text to print
    mov rdx, fmth_len   ;lenght of a text
    syscall
    ret
        
_getInput:
    mov rax, 0          ;read
    mov rdi, 0          ;stdin
    mov rsi, input_text ;address of input buffer
    mov rdx, 8          ;input lenght
    syscall
    ret        
            
_exit:
    pop rbp             ;retrieve pointer
    mov rsp, rbp        ;move from base to stack pointer
    mov rax, 60         ;interrupt exit
    mov rdi, 0          ;succes exit code
    syscall             ;quit
