getData proc

    push ax
    push bx
    push cx
    push dx
    push di
    push si

    ; ja temos o ES configurado para o 0b800h

    ; al -> linha
    ; ah -> coluna
    ; cl -> tamanho
    ; SI -> digitos (vetor)
    ; DI -> outros (vetor)
    ; livres: BX - DX - BP

    mov dh, ah ; salvar coluna no dh
    mov dl, al ; salvar linha do dl

    ; vamos calcular o offset inicial
    ; offset = linha * 160 + coluna * 2

    shl ah, 1 ; ah = offset da coluna
    mov bl, ah ; agora bl tem o offset da coluna

    mov bh, 160
    mul bh
    ; agora AX tem o offset das linhas

    xor bh, bh
    add ax, bx
    mov bp, ax ; agora BP tem o offset inicial

    ; LIVRES: AX e BX

    xor ch, ch
    mov bl, cl
ext_loop:
    push cx
    mov cl, bl

obter_letra:
    mov al, es:[bp]
    cmp al, ' '
    je prox_iteracao

    cmp al, '0'
    jb add_outros

    cmp al, '9'
    ja add_outros

    mov [SI], al
    inc SI
    jmp prox_iteracao

add_outros:
    mov [DI], al
    inc DI

prox_iteracao:
    add bp, 2
    loop obter_letra

    pop cx

    mov ah, bl
    shl ah, 1
    mov bh, 160
    sub bh, ah

    xor ah, ah
    mov al, bh

    add bp, ax

    loop ext_loop

fim_reg:
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax

    ret
getData endp