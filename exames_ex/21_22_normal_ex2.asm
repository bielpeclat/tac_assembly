VERIFICA_DIAGONAL proc
    push ax
    push bx
    push cx
    push dx

    mov ax, 0b800h
    mov es, ax

    ; ah -> linha
    ; al -> coluna
    ; si -> vetor palavra, termina com '$'
    ; livres: BX, CX, DX

    ; vamos obter o offset
    ; offset = (linha * 160) + (coluna * 2)

    mov bl, al
    shl bl, 1
    xor bh, bh
    mov di, bx ; agora di ja tem o offset das colunas

    mov al, ah
    xor ah, ah
    mov bl, 160
    mul bl
    add di, ax ; agora di tem o offset da primeira letra

    mov bp, di ; offset grid
    mov bx, si ; vetor palavra


    ; vamos verificar a posicao que nos foi dada
    mov al, [si]
    cmp al, es:[di]
    jne nao_encontrado

    ; salvar as posicoes iniciais
    inc si
    mov bp, di ; offset grid
    mov bx, si ; vetor palavra

    mov cx, 4

nova_direcao:
    mov di, bp
    mov si, bx

obter_letra:
    mov al, [si]
    cmp al, '$'
    je encontrado

    cmp cx, 4
    je cima_dir

    cmp cx, 3
    je baixo_dir

    cmp cx, 2
    je baixo_esq
    
    cmp cx, 1
    je cima_esq

cima_dir:
    sub di, 158
    jmp compara_letra

compara_letra:
    cmp al, es:[di]
    jne 


nao_encontrado:
    mov ah, 0
    jmp fim_reg

encontrado:
    mov ah, 1

fim_reg:
    pop dx
    pop cx
    pop bx
    pop ax

    ret
VERIFICA_DIAGONAL endp