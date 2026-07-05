INDICAVENCEDOR proc
    push ax
    push bx
    push cx
    push dx
    push di
    push si

    mov ax, 0b800h
    mov es, ax

    ; 1. vamos obter o offset da primeira casa
    ; linha -> 11ª
    ; coluna -> 39ª 
    ; offset = linha * 160 + coluna * 2

    xor di, di
    xor ah, ah
    mov al, 38
    shl al, 1
    add di, ax

    mov al, 10
    mov ah, 160
    mul ah
    add di, ax ; agora DI tem o offset da primeira casa

    ; 2. obter a cor do vencedor
    cmp VENCEDOR, 1
    jne venc2
    mov dl, es:[1] ; cor do vencedor
    jmp comecar

venc2:
    mov dl, es:[3841] ; agora dl tem a cor do vencedor
    
comecar:
    or dl, 10000000b ; agora dl esta piscando

    mov cx, 3
    xor si, si ; index do vetor LINHAVENCEDORA

ext_loop:
    push cx
    mov cx, 3

iterar_colunas:
    mov al, LINHAVENCEDORA[si]
    cmp al, 1
    jne prox_iteracao
    
    ; vamos por a maiuscula
    mov bl, es:[di]
    sub bl, 32
    mov es:[di], bl
    
    mov es:[di + 1], dl ; vamos por a piscar

prox_iteracao:
    inc si
    add di, 2
    loop iterar_colunas

    ; se chegamos aqui, ja iteramos 3 colunas
    pop cx
    add di, 154
    loop ext_loop
    
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax

    ret
INDICAVENCEDOR endp