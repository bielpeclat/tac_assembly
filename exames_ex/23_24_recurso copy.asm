; segunda tentativa

getData proc

    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push bp

    ; al -> linha
    ; ah -> coluna
    ; cl -> tamanho
    ; si -> digitos
    ; di -> outros

    ; registos livres: BX e DX

    ; settar a memoria de video
    mov bx, 0b800h
    mov es, bx

    ; salvar as colunas iniciais
    mov dl, al ; linha
    mov dh, ah ; coluna

    ; obter offset inicial
    ; offset = (linha * 160) + (coluna * 2)
    shl ah, 1
    mov bh, ah ; bh tem o offset das colunas

    xor ah, ah
    mov bl, 160
    mul bl ; ax contem o offset das linhas

    mov bl, bh
    xor bh, bh
    add ax, bx ; agora ax tem o offset total

    mov bp, ax ; agora bp tem o offset inicial

    mov bl, cl ; bl tem 9 guardado
    xor ch, ch

ext_loop:
    push cx
    mov cl, bl

iterar_colunas:
    mov al, es:[bp]
    cmp al, ' '
    je prox_iteracao

    cmp al, '0'
    jb add_outros

    cmp al, '9'
    ja add_outros

    mov [si], al
    inc si
    jmp prox_iteracao

add_outros:
    mov [di], al
    inc di

prox_iteracao:
    add bp, 2
    loop iterar_colunas

    ; se chegou aqui, ja iterou 7 colunas
    pop cx

    mov al, 160
    mov bh, bl
    shl bh, 1
    xor ah, ah
    sub al, bh
    add bp, ax ; (offset de 1 linha - o q ja foi andado)
    loop ext_loop

fim_reg:
    pop bp
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax

    ret
getData endp