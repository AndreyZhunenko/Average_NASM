result_print:
    mov     bx, 0
    mov     ecx, 10
    
    my_share:
        mov     edx, 0
        div     ecx
        push    edx
        inc     bx
        test    eax, eax
        jnz     my_share
        
    my_convert:
        pop     eax
        add     eax, '0'
        mov     [count], eax
        mov     edx, 1
        mov     ecx, count
        mov     ebx, 1
        mov     eax, 4
        int     0x80
        dec     bx
        cmp     bx, 0
        jg      my_convert
    ret

section .text

global _start

_start:
    mov     bx, 0
    mov     al, 0
    
summa_alements_x:
    mov     al, [x + ebx]
    add     [summa_items], al
    add     bx, 4
    cmp     bx, len_array
    jl      summa_alements_x

    mov     al, [summa_items]
    mov     bx, 4
    mul     bx
    
    mov     edx, 0
    mov     ecx, len_array
    div     ecx
    add     [average_x], al
    
    mov     bx, 0
    mov     al, 0
    mov     [summa_items], al

summa_alements_y:
    mov     al, [y + ebx]
    add     [summa_items], al
    add     bx, 4
    cmp     bx, len_array
    jl      summa_alements_y

    mov     al, [summa_items]
    mov     bx, 4
    mul     bx
    
    mov     edx, 0
    mov     ecx, len_array
    div     ecx
    mov     [average_y], al
    
    mov     bx, 0
    mov     al, 0
    mov     [summa_items], al
    
    
    mov     bl, [average_y]
    sub     [average_x], bl
    mov     al, [average_x]
    jg      Exit_programm
    
Exit_programm:
    mov     edx, len_my_string
    mov     ecx, my_string
    mov     ebx, 1
    mov     eax, 4
    int 0x80
    mov     edx, len
    mov     ecx, msg
    mov     ebx, 1
    mov     eax, 4
    int 0x80
    call result_print
    mov     eax, 1
    int 0x80

section .data
    summa_items  dd 0
    average_x    dd 0
    average_y    dd 0
    x dd 5, 3, 2, 6, 1, 7, 4
    len_array equ $-x
    y dd 0, 10, 1, 9, 2, 8, 5
    msg db  "-"
    len equ $ - msg
    count dd 0
    my_string db "Arithmetic mean for the difference of 2 arrays: "
    len_my_string equ $- my_string