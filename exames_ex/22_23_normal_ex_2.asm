MostrasLetras proc

    push ax
    push bx
    push cx
    push di
    push dx

    ; calcular o offset
    mov cl, ah
    xor ch, ch
    shl cx, 1 ; multiplicar por 2

    xor ah, ah
    mov dl, 160
    mul dl ; ax = al * dl

    mov di, ax
    add di, cx
    pop dx ; para ter a direcao do deslocamento

    cmp dl, 1
    je hor_esq

    cmp dl, 2
    je vert_cima

    cmp dl, 3
    je vert_baixo

hor_direita:
    mov cx, 2
    jmp escreve_loop

hor_esq:
    mov cx, -2
    jmp escreve_loop

vert_cima:
    mov cx, -160
    jmp escreve_loop

vert_baixo:
    mov cx, 160
    jmp escreve_loop

escreve_loop:
    ; cx contem o deslocamento de cada iteracao
    mov al, [bx]
    cmp al, 0
    je fim_mostra

    mov es:[di], al
    inc bx ; proxima letra
    add di, cx

    jmp escreve_loop

fim_mostra:
    pop di
    pop cx
    pop bx
    pop ax

    ret
MostrasLetras endp