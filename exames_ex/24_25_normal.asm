; parte pratica -> exercicio 2. a)
PosicaoInicial proc
    push ax
    push bx

    mov ah, p_coluna
    mov al, p_linha

    dec ah
    dec al

    shl ah, 1
    xor bh, bh
    mov bl, ah

    mov ah, 160
    mul ah
    add ax, bx
    mov si, ax

    pop bx
    pop ax

    ret
PosicaoInicial endp

; parte pratica -> exercicio 2. b)
CorrigirComprimento proc

    test comprimento, 1
    jz fim_reg

    inc comprimento

fim_reg:
    ret
CorrigirComprimento endp

; parte pratica -> exercicio 2. c)
CopiaLinha proc
    push ax
    push di
    push si

    ; si aponta para o inicio da linha
    ; cx tem o numero de colunas a copiar
    ; buffer e um vetor de words

    xor di, di
    push cx

copy_left_to_buffer:
    
    mov ax, es:[si + bx]
    mov buffer[di], ax
    add di, 2
    add bx, 2


    pop cx
    pop si
    pop di
    pop ax
    ret
CopiaLinha endp

; ii.




; apenas codigo presente no ponto iii.

    push cx

copy_right_to_left:



    loop copy_right_to_left
    pop cx
