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

    mov bp, di ; memoria de video
    mov bx, si ; vetor palavra

    mov cx, 1

comparar:
    mov al, es:[di]
    cmp al, '$'
    je encontrou

    cmp al, [si]
    

prox_iteracao:


encontrou:


fim_reg:
    pop dx
    pop cx
    pop bx
    pop ax

    ret
VERIFICA_DIAGONAL endp