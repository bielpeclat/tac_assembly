INDICAVENCEDOR proc

    push ax 
    push bx
    push cx
    push dx
    push di
    push si
    push es
    push bp

    mov ax, 0b800h
    mov es, ax

    cmp VENCEDOR, 1
    jne cor2

    ; cor1 do vencedor
    ; vamos guardar a cor em dl
    mov di, 1
    mov bl, es:[di] 
    jmp blinkar

cor2:
    ; offset = linha * 160 + coluna * 2
    ; offset = 24*160 = 3840 + 1
    mov di, 3841
    mov bl, es:[di]
    jmp blinkar

blinkar:
    ; dl tem a cor do vencedor
    or bl, 10000000b

    ; agora podemos comecar a percorrer a grid 3x3
    mov si, 0 ; si e o indice para o vetor de 9 posicoes (da grid 3x3)
    mov cx, 10 ; cx = linha
    mov dx, 38 ; dx = coluna

ler_vetor:
    mov al, LINHAVENCEDORA[si]
    cmp al, 1
    jne prox_quad

    ; se for 1, vamos calcular o offset para obter a celula
    mov al, 160
    mul cl
    ; agora ax = offset das linhas
    mov di, dx
    shl di, 1
    add ax, di
    mov di, ax ; agora di tem o offset

    ; por maiuscula
    mov al, es:[di]
    sub al, 32
    mov es:[di], al ; ja esta maiuscula

    mov es:[di+1], bl ; metemos a piscar


prox_quad:
    inc si ; vetor de 9 posicoes
    inc dx ; pulamos 1 coluna
    cmp dx, 41 ; limite maximo de 3 colunas
    jne ler_vetor
    mov dx, 38
    inc cx
    cmp cx, 13
    jne ler_vetor ; ja lemos 9 posicoes

    jmp fim_9

fim_9:
    pop bp
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax

    ret
INDICAVENCEDOR endp